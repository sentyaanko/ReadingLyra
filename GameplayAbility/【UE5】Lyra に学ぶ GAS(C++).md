このドキュメントは書きかけです。
TODO: 確認していたものを全部書いていたら、なんのドキュメントかわからんくなってきたので、分割等を検討する。


# 【UE5】Lyra に学ぶ GAS(C++) <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中では、`Gameplay Ability System` （以降 GAS と略します） が利用されています。  
このドキュメントは GAS 関連の C++ で実装されている機能についての解説です。  

* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [Lyra で使用している UE の機能とその拡張](#lyra-で使用している-ue-の機能とその拡張)
	- [AssetManager に関して](#assetmanager-に関して)
	- [GameFeature に関して](#gamefeature-に関して)
	- [DataRegistry に関して](#dataregistry-に関して)
- [Lyra で独自実装してている仕組み](#lyra-で独自実装してている仕組み)
	- [Enhanced Input と GameFeature](#enhanced-input-と-gamefeature)
	- [エクスペリエンス と GameFeature](#エクスペリエンス-と-gamefeature)
	- [UGameplayMessageSubsystem について](#ugameplaymessagesubsystem-について)
	- [ULyraHeroComponent で設定できる FMappableConfigPair に関して](#ulyraherocomponent-で設定できる-fmappableconfigpair-に関して)
	- [GameplayAbility の一覧](#gameplayability-の一覧)
	- [ヘルスの管理方法と関連クラスについて簡単な説明を書くよ](#ヘルスの管理方法と関連クラスについて簡単な説明を書くよ)
	- [キャラクター設定関連について簡単な説明を書くよ](#キャラクター設定関連について簡単な説明を書くよ)
	- [ULyraPawnExtensionComponent と ULyraHeroComponent の関係](#ulyrapawnextensioncomponent-と-ulyraherocomponent-の関係)
- [Inheritance Hierarchy](#inheritance-hierarchy)
- [HotfixManager 関連（エンジン側）](#hotfixmanager-関連エンジン側)
	- [UOnlineHotfixManager](#uonlinehotfixmanager)
- [HotfixManager 関連（ Lyra 側）](#hotfixmanager-関連-lyra-側)
	- [ULyraHotfixManager](#ulyrahotfixmanager)
- [DataRegistry 関連（エンジン側）](#dataregistry-関連エンジン側)
	- [UDataRegistrySubsystem](#udataregistrysubsystem)
		- [UDataRegistrySubsystem::AcquireItem()](#udataregistrysubsystemacquireitem)
- [AssetManager 関連（エンジン側）](#assetmanager-関連エンジン側)
	- [FPrimaryAssetTypeInfo](#fprimaryassettypeinfo)
- [GameFeature 関連（エンジン側）](#gamefeature-関連エンジン側)
	- [IGameFeatureStateChangeObserver](#igamefeaturestatechangeobserver)
	- [UGameFeaturesProjectPolicies](#ugamefeaturesprojectpolicies)
	- [UDefaultGameFeaturesProjectPolicies](#udefaultgamefeaturesprojectpolicies)
	- [UGameFeatureAction](#ugamefeatureaction)
	- [UGameFeatureAction_DataRegistry](#ugamefeatureaction_dataregistry)
	- [UGameFeatureAction_AddComponents](#ugamefeatureaction_addcomponents)
	- [UGameFeatureData](#ugamefeaturedata)
		- [UGameFeatureData::Actions](#ugamefeaturedataactions)
		- [UGameFeatureData::PrimaryAssetTypesToScan](#ugamefeaturedataprimaryassettypestoscan)
	- [UGameFeaturesSubsystem](#ugamefeaturessubsystem)
		- [UGameFeaturesSubsystem::AddObserver()](#ugamefeaturessubsystemaddobserver)
- [GameFeature 関連（ Lyra 側）](#gamefeature-関連-lyra-側)
	- [ULyraGameFeaturePolicy](#ulyragamefeaturepolicy)
	- [FMappableConfigPair](#fmappableconfigpair)
	- [UGameFeatureAction_WorldActionBase](#ugamefeatureaction_worldactionbase)
	- [UGameFeatureAction_AddInputBinding](#ugamefeatureaction_addinputbinding)
	- [UGameFeatureAction_AddInputContextMapping](#ugamefeatureaction_addinputcontextmapping)
	- [UGameFeatureAction_SplitscreenConfig](#ugamefeatureaction_splitscreenconfig)
	- [UGameFeatureAction_AddAbilities](#ugamefeatureaction_addabilities)
	- [UGameFeatureAction_AddInputConfig](#ugamefeatureaction_addinputconfig)
	- [UGameFeatureAction_AddWidgets](#ugamefeatureaction_addwidgets)
	- [UGameFeatureAction_AddGameplayCuePath](#ugamefeatureaction_addgameplaycuepath)
	- [UApplyFrontendPerfSettingsAction](#uapplyfrontendperfsettingsaction)
	- [ULyraGameFeature_HotfixManager](#ulyragamefeature_hotfixmanager)
	- [ULyraGameFeature_AddGameplayCuePaths](#ulyragamefeature_addgameplaycuepaths)
- [エクスペリエンス 関連（ Lyra 側）](#エクスペリエンス-関連-lyra-側)
	- [ALyraWorldSettings](#alyraworldsettings)
	- [ULyraExperienceActionSet](#ulyraexperienceactionset)
		- [ULyraExperienceActionSet::Actions](#ulyraexperienceactionsetactions)
	- [ULyraExperienceDefinition](#ulyraexperiencedefinition)
		- [ULyraExperienceDefinition::Actions](#ulyraexperiencedefinitionactions)
		- [ULyraExperienceDefinition::ActionSets](#ulyraexperiencedefinitionactionsets)
	- [ULyraExperienceManagerComponent](#ulyraexperiencemanagercomponent)
		- [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()](#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_highpriority)
		- [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()](#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded)
		- [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()](#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_lowpriority)
	- [UAsyncAction_ExperienceReady](#uasyncaction_experienceready)
		- [UAsyncAction_ExperienceReady::OnReady](#uasyncaction_experiencereadyonready)
- [Input 関連（エンジン側）](#input-関連エンジン側)
	- [UInputMappingContext](#uinputmappingcontext)
	- [UPlayerMappableInputConfig](#uplayermappableinputconfig)
- [Input 関連（ Lyra 側）](#input-関連-lyra-側)
	- [ULyraInputConfig](#ulyrainputconfig)
- [GameplayCue 関連 （エンジン側）](#gameplaycue-関連-エンジン側)
	- [UGameplayCueManager](#ugameplaycuemanager)
- [GameplayCue 関連（ Lyra 側）](#gameplaycue-関連-lyra-側)
	- [ULyraGameplayCueManager](#ulyragameplaycuemanager)
	- [AGameplayCueNotify_BurstLatent](#agameplaycuenotify_burstlatent)
- [GameplayAbility 関連（エンジン側）](#gameplayability-関連エンジン側)
	- [UGameplayAbility](#ugameplayability)
		- [UGameplayAbility::MakeOutgoingGameplayEffectSpec()](#ugameplayabilitymakeoutgoinggameplayeffectspec)
		- [UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()](#ugameplayabilityapplyabilitytagstogameplayeffectspec)
	- [FGameplayAbilitySpec](#fgameplayabilityspec)
		- [FGameplayAbilitySpec::DynamicAbilityTags](#fgameplayabilityspecdynamicabilitytags)
	- [FGameplayEffectSpec](#fgameplayeffectspec)
		- [FGameplayEffectSpec::CapturedSourceTags](#fgameplayeffectspeccapturedsourcetags)
- [GameplayAbility 関連（ Lyra 側）](#gameplayability-関連-lyra-側)
	- [ULyraGlobalAbilitySystem](#ulyraglobalabilitysystem)
	- [ULyraAbilitySystemComponent](#ulyraabilitysystemcomponent)
		- [ULyraAbilitySystemComponent::SetTagRelationshipMapping()](#ulyraabilitysystemcomponentsettagrelationshipmapping)
	- [ULyraGameplayAbility](#ulyragameplayability)
		- [ULyraGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()](#ulyragameplayabilityapplyabilitytagstogameplayeffectspec)
	- [ILyraReadyInterface](#ilyrareadyinterface)
		- [ILyraReadyInterface::IsPawnComponentReadyToInitialize()](#ilyrareadyinterfaceispawncomponentreadytoinitialize)
	- [ULyraPawnComponent](#ulyrapawncomponent)
	- [ULyraPawnExtensionComponent](#ulyrapawnextensioncomponent)
		- [ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()](#ulyrapawnextensioncomponentcheckpawnreadytoinitialize)
		- [ULyraPawnExtensionComponent::PawnData](#ulyrapawnextensioncomponentpawndata)
		- [ULyraPawnExtensionComponent::GetPawnData()](#ulyrapawnextensioncomponentgetpawndata)
		- [ULyraPawnExtensionComponent::SetPawnData()](#ulyrapawnextensioncomponentsetpawndata)
		- [ULyraPawnExtensionComponent::AbilitySystemComponent](#ulyrapawnextensioncomponentabilitysystemcomponent)
		- [ULyraPawnExtensionComponent::GetLyraAbilitySystemComponent()](#ulyrapawnextensioncomponentgetlyraabilitysystemcomponent)
		- [ULyraPawnExtensionComponent::InitializeAbilitySystem()](#ulyrapawnextensioncomponentinitializeabilitysystem)
		- [ULyraPawnExtensionComponent::UninitializeAbilitySystem()](#ulyrapawnextensioncomponentuninitializeabilitysystem)
	- [ULyraHeroComponent](#ulyraherocomponent)
		- [ULyraHeroComponent::DefaultInputConfigs](#ulyraherocomponentdefaultinputconfigs)
		- [ULyraHeroComponent::IsPawnComponentReadyToInitialize()](#ulyraherocomponentispawncomponentreadytoinitialize)
		- [ULyraHeroComponent::OnPawnReadyToInitialize()](#ulyraherocomponentonpawnreadytoinitialize)
		- [ULyraHeroComponent::InitializePlayerInput()](#ulyraherocomponentinitializeplayerinput)
		- [ULyraHeroComponent::DetermineCameraMode()](#ulyraherocomponentdeterminecameramode)
	- [ULyraAbilitySet](#ulyraabilityset)
		- [ULyraAbilitySet::GiveToAbilitySystem()](#ulyraabilitysetgivetoabilitysystem)
	- [ULyraAbilityTagRelationshipMapping](#ulyraabilitytagrelationshipmapping)
	- [ULyraGameplayAbility_FromEquipment](#ulyragameplayability_fromequipment)
	- [ULyraGameplayAbility_RangedWeapon](#ulyragameplayability_rangedweapon)
	- [ULyraGameplayAbility_Reset](#ulyragameplayability_reset)
	- [ULyraGameplayAbility_Death](#ulyragameplayability_death)
	- [ULyraGameplayAbility_Interact](#ulyragameplayability_interact)
	- [ULyraGameplayAbility_Jump](#ulyragameplayability_jump)
	- [ULyraGamePhaseAbility](#ulyragamephaseability)
	- [ULyraAttributeSet](#ulyraattributeset)
	- [ULyraHealthSet](#ulyrahealthset)
		- [ULyraHealthSet::Health](#ulyrahealthsethealth)
		- [ULyraHealthSet::MaxHealth](#ulyrahealthsetmaxhealth)
		- [ULyraHealthSet::Healing](#ulyrahealthsethealing)
		- [ULyraHealthSet::Damage](#ulyrahealthsetdamage)
	- [ULyraHealthComponent](#ulyrahealthcomponent)
- [GameplayMessage 関連（ Lyra 側）](#gameplaymessage-関連-lyra-側)
	- [UGameplayMessageSubsystem](#ugameplaymessagesubsystem)
		- [UGameplayMessageSubsystem::BroadcastMessage()](#ugameplaymessagesubsystembroadcastmessage)
	- [UAsyncAction_ListenForGameplayMessage](#uasyncaction_listenforgameplaymessage)
- [GameplayMessage Processor 関連（ Lyra 側）](#gameplaymessage-processor-関連-lyra-側)
	- [UGameplayMessageProcessor](#ugameplaymessageprocessor)
	- [UElimChainProcessor](#uelimchainprocessor)
	- [UElimStreakProcessor](#uelimstreakprocessor)
	- [UAssistProcessor](#uassistprocessor)
- [GameplayMessage MessageStruct 関連（ Lyra 側）](#gameplaymessage-messagestruct-関連-lyra-側)
	- [FLyraControlPointStatusMessage](#flyracontrolpointstatusmessage)
	- [FLyraInteractionDurationMessage](#flyrainteractiondurationmessage)
	- [FLyraNotificationMessage](#flyranotificationmessage)
		- [FLyraNotificationMessage::PayloadTag](#flyranotificationmessagepayloadtag)
	- [FLyraQuickBarActiveIndexChangedMessage](#flyraquickbaractiveindexchangedmessage)
	- [FLyraQuickBarSlotsChangedMessage](#flyraquickbarslotschangedmessage)
	- [FLyraInventoryChangeMessage](#flyrainventorychangemessage)
	- [FLyraPlayerResetMessage](#flyraplayerresetmessage)
	- [FLyraAbilitySimpleFailureMessage](#flyraabilitysimplefailuremessage)
	- [FLyraAbilityMontageFailureMessage](#flyraabilitymontagefailuremessage)
	- [FLyraVerbMessage](#flyraverbmessage)
	- [FLyraVerbMessageReplication](#flyraverbmessagereplication)
- [GameplayMessage Accolade 関連（ Lyra 側）](#gameplaymessage-accolade-関連-lyra-側)
	- [FLyraAccoladeDefinitionRow](#flyraaccoladedefinitionrow)
	- [ULyraAccoladeHostWidget](#ulyraaccoladehostwidget)
		- [ULyraAccoladeHostWidget::OnNotificationMessage()](#ulyraaccoladehostwidgetonnotificationmessage)
- [Lyra インベントリ関連](#lyra-インベントリ関連)
	- [FLyraInventoryList](#flyrainventorylist)
	- [ULyraInventoryManagerComponent](#ulyrainventorymanagercomponent)
- [Lyra Weapon 関連](#lyra-weapon-関連)
	- [ULyraWeaponStateComponent](#ulyraweaponstatecomponent)
- [Lyra キャラクター設定関連](#lyra-キャラクター設定関連)
	- [ULyraPawnData](#ulyrapawndata)
		- [ULyraPawnData::InputConfig](#ulyrapawndatainputconfig)
		- [ULyraPawnData::TagRelationshipMapping](#ulyrapawndatatagrelationshipmapping)
		- [ULyraPawnData::DefaultCameraMode](#ulyrapawndatadefaultcameramode)
		- [ULyraPawnData::AbilitySets](#ulyrapawndataabilitysets)
- [Lyra widget 関連](#lyra-widget-関連)
	- [ULyraReticleWidgetBase](#ulyrareticlewidgetbase)
	- [ULyraTaggedWidget](#ulyrataggedwidget)
	- [UCommonActivatableWidget](#ucommonactivatablewidget)
	- [ULyraActivatableWidget](#ulyraactivatablewidget)
	- [ULyraHUDLayout](#ulyrahudlayout)
	- [ULyraWeaponUserInterface](#ulyraweaponuserinterface)
	- [ULyraPerfStatContainerBase](#ulyraperfstatcontainerbase)
	- [ULyraSimulatedInputWidget](#ulyrasimulatedinputwidget)
	- [ULyraJoystickWidget](#ulyrajoystickwidget)
	- [ULyraTouchRegion](#ulyratouchregion)
- [Lyra その他](#lyra-その他)
	- [ALyraCharacter](#alyracharacter)
	- [ALyraPlayerController](#alyraplayercontroller)
	- [ALyraGameMode](#alyragamemode)
		- [ALyraGameMode::InitGame()](#alyragamemodeinitgame)
		- [ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()](#alyragamemodehandlematchassignmentifnotexpectingone)
		- [ALyraGameMode::GetPawnDataForController()](#alyragamemodegetpawndataforcontroller)
	- [ALyraGameState](#alyragamestate)
		- [ALyraGameState::MulticastMessageToClients()](#alyragamestatemulticastmessagetoclients)
		- [ALyraGameState::MulticastReliableMessageToClients()](#alyragamestatemulticastreliablemessagetoclients)
	- [ALyraPlayerState](#alyraplayerstate)
		- [ALyraPlayerState::StatTags](#alyraplayerstatestattags)
		- [ALyraPlayerState::OnExperienceLoaded()](#alyraplayerstateonexperienceloaded)
		- [ALyraPlayerState::SetPawnData()](#alyraplayerstatesetpawndata)
		- [ALyraPlayerState::ClientBroadcastMessage()](#alyraplayerstateclientbroadcastmessage)
	- [ALyraWeaponSpawner](#alyraweaponspawner)
	- [ULyraCameraMode](#ulyracameramode)
	- [ULyraCheatManager](#ulyracheatmanager)
	- [ULyraSettingsLocal](#ulyrasettingslocal)
	- [ULyraDamageLogDebuggerComponent](#ulyradamagelogdebuggercomponent)
	- [ULyraEquipmentManagerComponent](#ulyraequipmentmanagercomponent)
	- [ULyraIndicatorManagerComponent](#ulyraindicatormanagercomponent)
	- [ULyraQuickBarComponent](#ulyraquickbarcomponent)
	- [ULyraBotCreationComponent](#ulyrabotcreationcomponent)
	- [UAimAssistTargetManagerComponent](#uaimassisttargetmanagercomponent)
	- [ULyraNumberPopComponent](#ulyranumberpopcomponent)
	- [ULyraNumberPopComponent_NiagaraText](#ulyranumberpopcomponent_niagaratext)
	- [ULyraFrontendStateComponent](#ulyrafrontendstatecomponent)
	- [ULyraTeamCreationComponent](#ulyrateamcreationcomponent)
	- [ULyraPlayerSpawningManagerComponent](#ulyraplayerspawningmanagercomponent)
	- [UTDM_PlayerSpawningManagmentComponent](#utdm_playerspawningmanagmentcomponent)
	- [ULyraControllerComponent_CharacterParts](#ulyracontrollercomponent_characterparts)
- [終わりに](#終わりに)


* 既存のドキュメント



# Lyra で使用している UE の機能とその拡張

## AssetManager に関して

GameFeature と絡む部分があります。設定方法は知っておくと良いです。

* 既存のドキュメント
	* [ドクセル > 2017/11/25 > UE4のモバイル開発におけるコンテンツアップデートの話　- Chunk IDとの激闘編 - > p34]
		* 設定方法についてわかりやすい解説
	* [Unreal Engine 5.0 Documentation > プロダクション パイプラインをセットアップする > アセット管理]
		* 公式ドキュメント。
	* [(2019/08/15) Qiita > 【UE4】 Asset Managerのアセットの非同期ロード機能について その1 ( 非同期ロードの解説 & レベルの裏読み編 )]
	* [(2019/12/21) Qiita > 【UE4】 Asset Managerのアセットの非同期ロード機能について その2 ( レベルアセット以外の裏読み編 )]
		* AssetManager に関するおかずさんの記事。主な話題は非同期ロードに関してなので、参考までに。
	* [(2021/06/18) 【UE5】 プレイヤーの技などをプラグインで実装できる！　GameFeaturesプラグインの紹介]
		* **古代の谷** での解説ですが、 GameFeature に関する大まかな説明があります。
* 概要
	* アセットを非同期で読むための仕組みです。
	* `Project Settings > Game - Asset Manager` にて設定を行います。
* GameFeature との関係
	* アセットのロードで使用されます。
	* [UGameFeatureData::PrimaryAssetTypesToScan] にて `Project Settings > Game - Asset Manager` と同様の設定を行います。

## GameFeature に関して

モジュール式に機能追加を可能にするための仕組みです。

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > Game Features と Modular Gameplay]
		* 概念を学べます。
		> Game Features プラグインおよび Modular Gameplay プラグインを使って、デベロッパーはプロジェクトにスタンドアローン機能を作成することができます。  
		> これらのプラグインを使用した機能を作成すると、プロジェクトのコードベースを明確で読み取りやすい状態に維持し、  
		> さらに無関係の機能同士の予期しないインタラクションや依存関係を回避するなど、複数のメリットがあります。  
		> これは、時間の経過とともに機能セットが変化するライブ製品を開発する場合に特に重要です。  
	* [(2021/11/28) Let's Enjoy Unreal Engine > UE5 Game Featuresで簡単に依存関係なしのコンポーネントを作ってみる]
		* 使用する際の手順やサンプルがまとめられています。
	* [Youtube > Unreal Engine > Modular Game Features | Inside Unreal > 40:56]
		* Game Feature Module でアビリティの追加を行っている説明
	* [Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]
		* Game Feature Module に関する説明。
	* [ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]
		* Game Features & Modular Gameplay という題で説明があります。
		* 時間が経っている（2022/04/11 現在）ので、ドクセル内のプレゼン資料から公式ドキュメントへのリンクは無くなっているものが多いので注意です。
			* ```https://docs.unrealengine.com/5.0/ja/GameplayFeatures/``` 以下はまるごと無いですし、「Game Features」等でドキュメントを検索してもほとんどデッドリンクです。
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]
		* 古代の谷のドキュメント内での説明。
* 概要
	* 「 GameFutures プラグイン」 と 「 Modular Gameplay プラグイン」 と 「 Modular Gameplay Actors プラグイン」 を利用した、独立した機能を実装する仕組みです。
* UE で用意されているクラス
	| Class                                 | 概要                                                                                                                                                                                                                        | Lyra                                                                                                                  |
	| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
	| [IGameFeatureStateChangeObserver]     | GameFeature 切り替えなどの際の処理をオーバーライドするための基底クラス。                                                                                                                                                    |                                                                                                                       |
	| [UGameFeaturesProjectPolicies]        | GameFeature 挙動を定義するための基底クラス。<br>`Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class` でこの派生クラスを指定する。                                                | [ULyraGameFeaturePolicy] を指定している。                                                                             |
	| [UDefaultGameFeaturesProjectPolicies] | [UGameFeaturesProjectPolicies] 派生クラス。<br>GameFeature のロード時等の挙動のデフォルト実装を定義している。                                                                                                               |                                                                                                                       |
	| [UGameFeatureAction]                  | GameFeature のアクティブ時等に実行されるアクションを定義するための基底クラス。                                                                                                                                              |                                                                                                                       |
	| [UGameFeatureAction_DataRegistry]     | [UGameFeatureAction] 派生クラス。<br>[データ レジストリ] にデータを追加するアクションを定義している。<br>                                                                                                                   |                                                                                                                       |
	| [UGameFeatureAction_AddComponents]    | [UGameFeatureAction] 派生クラス。<br>任意の対象にコンポーネントを追加するアクションを定義している。                                                                                                                         |                                                                                                                       |
	| [UGameFeatureData]                    | GameFeature に関する設定。<br>[UGameFeatureAction] の配列などを保持する。                                                                                                                                                   | * `ShooterCore` ([UGameFeatureData])<br>* `TopDownArena` ([UGameFeatureData])<br>* `ShooterMaps` ([UGameFeatureData]) |
	| [UGameFeaturesSubsystem]              | GameFeature を管理するクラス。<br>[UGameFeatureData] を元に [UGameFeatureAction] の関数を呼び出す。<br>`Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class` に基づいて動作する。 |                                                                                                                       |
* Lyra で実装しているクラス
	| Class                                       | 概要                                                                                                                                                                               |
	| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
	| [ULyraGameFeaturePolicy]                    | [UDefaultGameFeaturesProjectPolicies] 派生クラス。<br>Observers に [ULyraGameFeature_HotfixManager] / [ULyraGameFeature_AddGameplayCuePaths] を追加している。                      |
	| [ULyraGameFeature_HotfixManager]            | [IGameFeatureStateChangeObserver] 派生クラス。<br>[ULyraHotfixManager] を利用している。                                                                                            |
	| [ULyraGameFeature_AddGameplayCuePaths]      | [IGameFeatureStateChangeObserver] 派生クラス。<br>GameFeatureAction に [UGameFeatureAction_AddGameplayCuePath] が含まれていた場合に [ULyraGameplayCueManager] に情報を橋渡しする。 |
	| [UApplyFrontendPerfSettingsAction]          | [UGameFeatureAction] 派生クラス。<br>パフォーマンス設定に関するアクションを定義している。                                                                                          |
	| [UGameFeatureAction_SplitscreenConfig]      | [UGameFeatureAction] 派生クラス。<br>splitscreen の無効化を行うアクションを定義している。                                                                                          |
	| [UGameFeatureAction_AddInputBinding]        | [UGameFeatureAction] 派生クラス。<br>入力バインドの追加を行うアクションを定義している。                                                                                            |
	| [UGameFeatureAction_AddInputContextMapping] | [UGameFeatureAction] 派生クラス。<br>入力マッピングコンテキストの追加を行うアクションを定義している。                                                                              |
	| [UGameFeatureAction_AddInputConfig]         | [UGameFeatureAction] 派生クラス。<br>入力設定の追加を行うアクションを定義している。                                                                                                |
	| [UGameFeatureAction_AddAbilities]           | [UGameFeatureAction] 派生クラス。<br>アビリティの追加を行うアクションを定義している。                                                                                              |
	| [UGameFeatureAction_AddWidgets]             | [UGameFeatureAction] 派生クラス。<br>widget の追加を行うアクションを定義している。                                                                                                 |
	| [UGameFeatureAction_AddGameplayCuePath]     | [UGameFeatureAction] 派生クラス。<br>GameplayCue の検索パスの追加を行うアクションを定義している。                                                                                  |
	| [ULyraExperienceActionSet]                  | エクスペリエンスで利用される GameFeatureAction のセット。                                                                                                                          |
	| [ULyraExperienceDefinition]                 | エクスペリエンスの定義。                                                                                                                                                           |


## DataRegistry に関して

アセットを読み込むための仕組みで、 GameFeature のアセット読み込みでも使用しています。

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]
		* データレジストリの概念について学べます。
	* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ >  データ レジストリのクイック スタート ガイド]
		* プラグインの導入方法やデータレジストリアセットの作成方法が書かれています。
* 概要
	* データレジストリアセットの非同期読み込みを行うための仕組み。
* UE で用意されているクラス
	* [UDataRegistrySubsystem]
		* データレジストリを扱うマネージャクラス。
	* [UGameFeatureAction_DataRegistry]
		* GameFeature と連動してデータレジストリにデータを追加するクラス。
		* 内部で [UDataRegistrySubsystem] を使用している。
* Lyra での使われ方
	* [UGameFeatureAction_DataRegistry] の使用
		* `ShooterCore` [UGameFeatureData] で `AccoladeDataRegistry` ([FLyraAccoladeDefinitionRow]) を追加しています。
	* [UDataRegistrySubsystem] の使用
		* [ULyraAccoladeHostWidget::OnNotificationMessage()] 内で [UDataRegistrySubsystem::AcquireItem()] を使用し、 `AccoladeDataRegistry` ([FLyraAccoladeDefinitionRow]) のデータを参照しています。
		* これは Accolade 発生時に使用する演出のアセットへのソフトリファレンスを取得するのに利用しています。


# Lyra で独自実装してている仕組み

## Enhanced Input と GameFeature

Lyra では、入力をモジュール式に扱うために、 Enhanced Input と GameFeature を組み合わせて利用しています。

* 既存のドキュメント
	* [【UE5】Lyra に学ぶ Enhanced Input]
		* Enhanced Input 自体についてはこちらを参照してください。
* 概要
	* GameFeatureAction を利用し、入力バインディングと入力マッピングコンテキストの追加をフィーチャーの適用時に行えるようにしています。
* Lyra で実装しているクラス
	* [UGameFeatureAction_AddInputBinding]
		* 入力バインディングの追加を行う GameFeatureAction
	* [UGameFeatureAction_AddInputContextMapping]
		* 入力マッピングコンテキストの追加を行う GameFeatureAction


## エクスペリエンス と GameFeature

Lyra ではエクスペリエンスという独自の単位で GameFeature の適用を行う仕組みを実装しています。

* 概要
	* 各レベルの WorldSettings で [ULyraExperienceDefinition] を指定することで、そのレベルで適用するエクスペリエンスを指定しています。
	* エクスペリエンスでは以下を指定できます。
		* 有効にする GameFeatrure
		* 実行する GameFeatureAction
		* Player に使用するポーン情報
* UE で用意されているクラス
	* [UGameFeatureAction]
		* GameFeature のアクティブ時等に実行されるアクションを定義するための基底クラス。
	* [UGameFeatureData]
		* GameFeature に関する設定。
	* [UGameFeaturesSubsystem]
		* GameFeature の管理を行うサブシステム。
* Lyra で実装しているクラス
	* [ULyraExperienceActionSet]
		* エクスペリエンスで利用される GameFeatureAction のセット。
		* [ULyraExperienceDefinition] から参照される。
	* [ULyraExperienceDefinition]
		* エクスペリエンスの定義。
	* [ALyraWorldSettings]
		* マップの WorldSettings で [ULyraExperienceDefinition] を指定できるように拡張した `AWorldSettings` 派生クラス。
		* この値は [ALyraGameMode] で参照される。詳しくは以下の関数を参照。
			* [ALyraGameMode::InitGame()]
			* [ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]
	* [ULyraExperienceManagerComponent]
		* [ULyraExperienceDefinition] のロード等を行うコンポーネント。
		* [ALyraGameState] に追加されている。
		* [UGameFeaturesSubsystem] の機能を利用している。
	* [ULyraGameFeaturePolicy]
		* GameFeature のロード時などの挙動を扱う。
			* HotFix に関する処理と、 GameplayCue のパスに関する処理を行うクラスをオブザーバとして登録・解除している。
		* `Project Settings` で指定されている。
		* [UGameFeaturesSubsystem] の機能を利用している。


## UGameplayMessageSubsystem について

Lyra では任意の構造体を使用してメッセージの送受信を行う仕組を実装し、送信者と受信者が互いに直接知らなくてもやり取り可能にしています。

[GASDocumentation(和訳) > 11.1.2 Community Questions] の第 4 項目より
> Q:  
> Main では、しばらくの間、 Gameplay Messages を送信するためのプラグイン（Event/Message Bus のようなもの）がありましたが、削除されてしまいました。  
> 復活させる予定はありますか？  
> Game Features/Modular Gameplay プラグインでは、汎用の Event Bus Dispatcher があると非常に便利です。  
> A:  
> GameplayMessages プラグインのことを言っているのだと思います。  
> これはおそらく、いつかは戻ってくるでしょう - API がまだ完成しておらず、作者もまだ公開するつもりはなかったようです。  
> Modular Gameplay デザインに有用であることには同意します。  
> しかし、これは私の分野ではないので、これ以上の情報はありません。  

上記はおそらくこの仕組のことだと思います。

* 概要
	* 管理クラスである [UGameplayMessageSubsystem] とリスナー用の基底クラス [UGameplayMessageProcessor] からなります。
		* [UGameplayMessageProcessor] は ActorComponent であり、 Lyra では GameState 派生クラスに追加しています。
		* widget などは [UGameplayMessageSubsystem] の機能を直接利用してリスナー登録しています。
* Lyra で実装しているクラス
	* [UGameplayMessageSubsystem]
		* 送信者から渡されたメッセージを、保持している受信者に配信するクラス。
	* [UGameplayMessageProcessor]
		* メッセージをリッスンする基底クラス。
		* 派生クラスは以下の通り
			* [UElimChainProcessor]
				* 敵の連鎖撃破を追跡するクラス。
			* [UElimStreakProcessor]
				* 敵の連続撃破を追跡するクラス。
			* [UAssistProcessor]
				* 撃破のアシストを追跡するクラス。
			* `B_AccoladeRelay` ([UGameplayMessageProcessor])
				* **称賛情報**を追跡し、サーバーからクライアントに情報を送り、他のメッセージにリレーするクラス。
				* サーバー、クライアント両方に追加されるコンポーネント。
				* サーバー側が受け取った際は同じメッセージを **Client RPC** する。
				* コスメティック処理が可能な場合（リッスンサーバー or クライアント or スタンドアロン）は別のメッセージを送信する。
					* （そのメッセージは表示クラスが監視し、受信時に表示を行う）
				* 基底クラスの機能は利用していない。
			* `B_EliminationFeedRelay` ([UGameplayMessageProcessor])
				* **ヘルスがなくなった事**を追跡し、サーバーからクライアントに情報を送り、他のメッセージにリレーするクラス。
				* サーバー、クライアント両方に追加されるコンポーネント。
				* サーバー側が受け取った際は同じメッセージを **Multicast RPC** する。
				* コスメティック処理が可能な場合（リッスンサーバー or クライアント or スタンドアロン）は別のメッセージを送信する。
					* （そのメッセージは表示クラスが監視し、受信時に表示を行う）
				* 基底クラスの機能は利用していない。
	* メッセージの送受信関連の情報
		* 詳しくは [UGameplayMessageSubsystem] の利用状況の表を参照。
		* メッセージをリッスンしているその他のクラス
			* [ULyraAccoladeHostWidget]
				* 称賛情報をリッスンする widget クラス。
			* [ULyraDamageLogDebuggerComponent]
				* ダメージ情報をリッスンするデバッグログクラス。
			* [UAsyncAction_ListenForGameplayMessage]
				* 任意のメッセージをリッスン可能な、ブループリント用の Async ノード。
		* 送信データ
			* 以下のような構造体を送信している。
				* [FLyraControlPointStatusMessage]
				* [FLyraInteractionDurationMessage]
				* [FLyraNotificationMessage]
				* [FLyraQuickBarActiveIndexChangedMessage]
				* [FLyraQuickBarSlotsChangedMessage]
				* [FLyraInventoryChangeMessage]
				* [FLyraPlayerResetMessage]
				* [FLyraAbilitySimpleFailureMessage]
				* [FLyraAbilityMontageFailureMessage]
				* [FLyraVerbMessage]
				* `Struct_UIMessaging`
				* `Message_NameplateInfo`
				* `Message_NameplateRequest`
				* `EliminationFeedMessage`
		* [FLyraVerbMessageReplication]
			* [FLyraVerbMessage] をまとめて処理するためのクラス。

## ULyraHeroComponent で設定できる FMappableConfigPair に関して

[ULyraHeroComponent] は [FMappableConfigPair] をメンバとして持っており、入力設定の初期情報を設定可能です。  
ただし、使われ方が限定的となっています。

* 概要
	* [ULyraHeroComponent::DefaultInputConfigs] は GameFeature を使用できない場合に変わりに使用する項目。
	* 使用可能であるならば [UGameFeatureAction_AddInputConfig] 経由で設定したほうがモジュール式で扱える為好ましい。
	* 詳しくは [ULyraHeroComponent::DefaultInputConfigs] を参照。
* 実際の利用状況は以下のみ。
	* `B_SimpleHeroPawn` ([ALyraCharacter])
		* 以下が設定されている。
			* `PMI_Default_Gamepad` ([UPlayerMappableInputConfig])
			* `PMI_Default_KBM` ([UPlayerMappableInputConfig])
		* このクラスは `L_DefaultEditorOverview` のプレイヤーポーンとして設定されている。
		* 開発用のマップであるため、 GameFeature を使用せずに [ULyraHeroComponent::DefaultInputConfigs] を使用しているものと思われる。


## GameplayAbility の一覧

Lyra で実装されている GameplayAbility は以下の通り。

* [ULyraGameplayAbility]
	* [ULyraGameplayAbility_Death]
		* `GA_ArenaHero_Death`
		* `GA_Hero_Death`
	* [ULyraGameplayAbility_FromEquipment]
		* `GA_Weapon_AutoReload`
		* `GA_Weapon_ReloadMagazine`
			* `GA_Weapon_Reload_Pistol`
			* `GA_Weapon_Reload_Rifle`
			* `GA_Weapon_Reload_Shotgun`
			* `GA_Weapon_Reload_NetShooter`
		* [ULyraGameplayAbility_RangedWeapon]
			* `GA_HealPickup`
			* `GA_Weapon_Fire`
				* `GA_Weapon_Fire_Pistol`
				* `GA_Weapon_Fire_Rifle`
				* `GA_Weapon_Fire_Shotgun`
				* `GA_WeaponNetShooter`
	* [ULyraGameplayAbility_Interact]
		* `GA_Interact`
	* [ULyraGameplayAbility_Jump]
		* `GA_Hero_Jump`
	* [ULyraGameplayAbility_Reset]
	* [ULyraGamePhaseAbility]
		* `Phase_Playing` (ShooterCore/TopDownArena の 2 種)
		* `Phase_PostGame` (ShooterCore/TopDownArena の 2 種)
		* `Phase_Warmup` (ShooterCore/TopDownArena の 2 種)
	* `GA_AbilityWithWidget`
		* `GA_ADS`
		* `GA_Emoto`
		* `GA_Hero_Dash`
		* `GA_Melee`
	* `GAB_ShowWidget_WhenInputPressed`
		* `GA_ToggleInventory`
		* `GA_ToggleMap`
	* `GAB_ShowWidget_WhileInputHeld`
		* `GA_ShowLeaderboard_CP`
		* `GA_ShowLeaderboard_TDM`
	* `GA_AutoRespawn`
	* `GA_DropBomb`
	* `GA_Grenade`
	* `GA_Hero_Heal`
	* `GA_Interaction_Collect`
	* `GA_QuickbarSlots`
	* `GA_SpawnEffect`
	* `GA_ToggleMarkerInWorld`

階層とクラス名を見ることで、どのような仕組みになっているのかなんとなく想像できると思います。  
詳細は別途まとめる予定です。

* 備考
	* `GA_AbilityWithWidget` と `GAB_ShowWidget_WhenInputPressed` / `GAB_ShowWidget_WhileInputHeld` の違い
		* 前者は派生クラスでもロジックの実装を行っている。
		* 後者は派生クラスはデータ専用ブループリントになっている。
		* プレフィックスの差はそのあたりが理由なのかもしれない。
	* Phase アビリティに関して
		* 前述のとおり、 ShooterCore/TopDownArena で別のアセットが同名で用意されています。


## ヘルスの管理方法と関連クラスについて簡単な説明を書くよ

TODO: このへんから

* [ULyraHealthComponent]
* [ULyraHealthSet]


## キャラクター設定関連について簡単な説明を書くよ

* [ULyraPawnData]

## ULyraPawnExtensionComponent と ULyraHeroComponent の関係

* 主に ShooterGmae でのキャラクターの GAS の制御は、 [ULyraPawnExtensionComponent] と [ULyraHeroComponent] が連携して動いています。
* その他、以下のクラスの関連しています。
	* [ILyraReadyInterface]
	* [ULyraPawnComponent]
	* [ULyraPawnExtensionComponent]
	* [ULyraHeroComponent]

関係は以下のような形。

![](images/Lyra_CharacterAndComponents.png)


[ULyraPawnExtensionComponent] / [ULyraHeroComponent] に関しては [Lyra のアビリティ > ALyraPlayerState] にて以下の記述があります。

> Lyra ではこれを ULyraHeroComponent および ULyraPawnExtensionComponent を通じて対応します。  
> これらのコンポーネントは、有効なコントローラーで所有されたときに、Abilities、Attributes、Gameplay Effects の特定セットを  
> PlayerState の AbilitySystemComponent に付与する処理を担当します。  
> これらは、ポーンが除外、所有解除、またはプレイから他の方法で削除されたときに、自動的に取り消されます。  

この 2 つのクラスの特徴は概ね以下のようになります。

|                               | [ULyraPawnExtensionComponent]                | [ULyraHeroComponent]                                 |
| ----------------------------- | -------------------------------------------- | ---------------------------------------------------- |
| 他方を参照するか              | 参照しない                                   | 参照する                                             |
| アビリティ関連の役割          | キャラクターに依らない ASC の初期化/終了関連 | キャラクターに依る、アビリティの付与、アクティブ化等 |
| 追加する Pawn                 | [ALyraCharacter]                             | `B_Hero_Default`                                     |
| コンポーネントの動作          | 追加だけでは影響を与えない                   | 追加だけで動作する                                   |
| Pawn からの利用方法           | 必要に応じてメンバ関数を呼び出す             | メンバ関数の呼び出しはしていない                     |
| 参照するクラス                | [ALyraCharacter]                             | [ULyraGameplayAbility]                               |
|                               | [ULyraHeroComponent]                         | [UGameFeatureAction_AddInputBinding]                 |
|                               | [ALyraGameMode]                              | [UGameFeatureAction_AddInputContextMapping]          |
|                               | [ALyraPlayerState]                           |                                                      |
|                               | [ULyraBotCreationComponent]                  |                                                      |
|                               | [ULyraCheatManager]                          |                                                      |
| [ALyraCharacter] を参照するか | する（ `Crouch` 関連）                       | しない                                               |

> note:  
> * キャラクターに依存する/しないでクラスを分けることで、異なる付与ルールのキャラクターを新たに追加しやすくしている。
> * 依存しない部分については [ULyraPawnExtensionComponent] で実装し [ALyraCharacter] に追加している。
> * [ALyraCharacter] を派生することで、その機能を利用できるようにしている。
> 
> 例えば、 Hero とは異なるルールのキャラクターを作りたい場合は以下のようなる。  
> * [ULyraHeroComponent] のようなクラスを別途作る
> * `B_Hero_Default` のような [ALyraCharacter] 派生 BP クラスを別途作り、上記のコンポーネントを追加する



















































----


以降はクラスの説明。


# Inheritance Hierarchy

* `UObject`
	* `UPrimaryDataAsset`
		* [UGameFeatureData]
		* [ULyraExperienceActionSet]
		* [ULyraExperienceDefinition]
		* [UPlayerMappableInputConfig]
		* [ULyraAbilitySet]
		* [ULyraPawnData]
	* `UDataAsset`
		* [UInputMappingContext]
		* [ULyraInputConfig]
		* [UGameplayCueManager]
			* [ULyraGameplayCueManager]
		* [ULyraAbilityTagRelationshipMapping]
	* `USubsystem`
		* `UDynamicSubsystem`
			* `UEngineSubsystem`
				* [UGameFeaturesSubsystem]
				* [UDataRegistrySubsystem]
		* `UWorldSubsystem`
			* [ULyraGlobalAbilitySystem]
		* `UGameInstanceSubsystem`
			* [UGameplayMessageSubsystem]
	* `UCheatManager`
		* [ULyraCheatManager]
	* `UGameUserSettings`
		* [ULyraSettingsLocal]
	* `UActorComponent`
		* `UGameFrameworkComponent`
			* `UPawnComponent`
				* [ULyraPawnComponent]
					* [ULyraPawnExtensionComponent]
					* [ULyraHeroComponent]
				* [ULyraEquipmentManagerComponent]
			* `UGameStateComponent`
				* [ULyraExperienceManagerComponent]
				* [ULyraBotCreationComponent]
				* [UAimAssistTargetManagerComponent]
				* [ULyraFrontendStateComponent]
				* [ULyraTeamCreationComponent]
				* [ULyraPlayerSpawningManagerComponent]
					* [UTDM_PlayerSpawningManagmentComponent]
			* `UControllerComponent`
				* [ULyraWeaponStateComponent]
				* [ULyraIndicatorManagerComponent]
				* [ULyraQuickBarComponent]
				* [ULyraNumberPopComponent]
					* [ULyraNumberPopComponent_NiagaraText]
				* [ULyraControllerComponent_CharacterParts]
			* [ULyraHealthComponent]
		* `UGameplayTasksComponent`
			* `UAbilitySystemComponent`
				* [ULyraAbilitySystemComponent]
		* [UGameplayMessageProcessor]
			* [UElimChainProcessor]
			* [UElimStreakProcessor]
			* [UAssistProcessor]
		* [ULyraInventoryManagerComponent]
		* [ULyraDamageLogDebuggerComponent]
	* `AActor`
		* `AInfo`
			* `AGameModeBase`
				* `AModularGameModeBase`
					* [ALyraGameMode]
			* `AGameStateBase`
				* `AModularGameStateBase`
					* [ALyraGameState]
			* `APlayerState`
				* `AModularPlayerState`
					* [ALyraPlayerState]
			* `AWorldSettings`
				* [ALyraWorldSettings]
		* `APawn`
			* `ACharacter`
				* `AModularCharacter`
					* [ALyraCharacter]
						* `Character_Default`
							* `B_HeroDefault`
								* `B_SimpleHeroPawn`
		* `AController`
			* `APlayerController`
				* `AModularPlayerController`
					* `ACommonPlayerController`
						* [ALyraPlayerController]
		* `AGameplayCueNotify_Actor`
			* [AGameplayCueNotify_BurstLatent]
		* [ALyraWeaponSpawner]
	* `UVisual`
		* `UWidget`
			* `UUserWidget`
				* `UCommonUserWidget`
					* [ULyraAccoladeHostWidget]
					* [ULyraReticleWidgetBase]
					* [ULyraTaggedWidget]
					* [UCommonActivatableWidget]
						* [ULyraActivatableWidget]
							* [ULyraHUDLayout]
					* [ULyraWeaponUserInterface]
					* [ULyraPerfStatContainerBase]
					* [ULyraSimulatedInputWidget]
						* [ULyraJoystickWidget]
						* [ULyraTouchRegion]
	* `UBlueprintAsyncActionBase`
		* `UCancellableAsyncAction`
			* [UAsyncAction_ListenForGameplayMessage]
		* [UAsyncAction_ExperienceReady]
	* [UGameFeatureAction]
		* [UGameFeatureAction_AddGameplayCuePath]
		* [UApplyFrontendPerfSettingsAction]
		* [UGameFeatureAction_DataRegistry]
		* [UGameFeatureAction_AddComponents]
		* [UGameFeatureAction_AddInputConfig]
		* [UGameFeatureAction_WorldActionBase]
			* [UGameFeatureAction_AddInputBinding]
			* [UGameFeatureAction_AddInputContextMapping]
			* [UGameFeatureAction_SplitscreenConfig]
			* [UGameFeatureAction_AddAbilities]
			* [UGameFeatureAction_AddWidgets]
	* [UOnlineHotfixManager]
		* [ULyraHotfixManager]
	* [UGameFeaturesProjectPolicies]
		* [UDefaultGameFeaturesProjectPolicies]
			* [ULyraGameFeaturePolicy]
	* [ULyraGameFeature_HotfixManager]
	* [ULyraGameFeature_AddGameplayCuePaths]
	* `UGameplayAbility`
		* [ULyraGameplayAbility]
			* [ULyraGameplayAbility_FromEquipment]
				* [ULyraGameplayAbility_RangedWeapon]
			* [ULyraGameplayAbility_Reset]
			* [ULyraGamePhaseAbility]
			* [ULyraGameplayAbility_Death]
	* `UAttributeSet`
		* [ULyraAttributeSet]
			* [ULyraHealthSet]
* `FTableRowBase`
	* [FLyraAccoladeDefinitionRow]
* `FFastArraySerializer`
	* [FLyraInventoryList]
	* [FLyraVerbMessageReplication]
* `FFastArraySerializerItem`
	* [FGameplayAbilitySpec]
* [FGameplayEffectSpec]
* [FPrimaryAssetTypeInfo]
* [FMappableConfigPair]
* [FLyraControlPointStatusMessage]
* [FLyraInteractionDurationMessage]
* [FLyraQuickBarActiveIndexChangedMessage]
* [FLyraQuickBarSlotsChangedMessage]
* [FLyraNotificationMessage]
* [FLyraInventoryChangeMessage]
* [FLyraAbilitySimpleFailureMessage]
* [FLyraAbilityMontageFailureMessage]
* [FLyraVerbMessage]
* [IGameFeatureStateChangeObserver]
* `ILoadingProcessInterface`
* [ILyraReadyInterface]



# HotfixManager 関連（エンジン側）

## UOnlineHotfixManager

> This class manages the downloading and application of hotfix data  
> Hotfix data is a set of non-executable files downloaded and applied to the game.  
> The base implementation knows how to handle INI, PAK, and locres files.  
> NOTE: Each INI/PAK file must be prefixed by the platform name they are targeted at  
> 
> ----
> Hotfix データのダウンロードと適用を管理するクラスです。  
> Hotfix データとは、ゲームにダウンロードされ適用される非実行ファイルの集合です。  
> 基本的な実装は、 INI 、 PAK 、および Locres ファイルの処理方法を知っています。  
> 注意：各 INI/PAK ファイルには、対象となるプラットフォーム名を先頭に付ける必要があります。  

* Lyra での使われ方
	* [ULyraHotfixManager] の基底クラスとして利用。


# HotfixManager 関連（ Lyra 側）

## ULyraHotfixManager

* 概要
	* Lyra 用の拡張。詳細未確認。
* 参照元
	* [ULyraGameFeature_HotfixManager]



# DataRegistry 関連（エンジン側）

## UDataRegistrySubsystem

> Singleton manager that provides synchronous and asynchronous access to data registries  
> 
> ----
> データレジストリへの同期・非同期アクセスを提供するシングルトンマネージャ  

### UDataRegistrySubsystem::AcquireItem()

> Start an async load of an item, delegate will be called on success or failure of acquire. Returns false if delegate could not be scheduled



# AssetManager 関連（エンジン側）

## FPrimaryAssetTypeInfo

> Structure with publicly exposed information about an asset type. These can be loaded out of a config file.  
> 
> ----
> アセットタイプに関する一般に公開された情報を持つ構造体。これらは設定ファイルから読み込むことができます。  

* 概要
	* AssetManager が使用する設定情報。
* 参照元
	* `Project Settings > Game - Asset Manager`
	* [UGameFeatureData::PrimaryAssetTypesToScan]


# GameFeature 関連（エンジン側）

## IGameFeatureStateChangeObserver

> This class is meant to be overridden in your game to handle game-specific reactions to game feature plugins being mounted or unmounted  
>  
> Generally you should prefer to use UGameFeatureAction instances on your game feature data asset instead of this,  
> especially if any data is involved  
>
> If you do use these, create them in your UGameFeaturesProjectPolicies subclass and register them via  
> AddObserver / RemoveObserver on UGameFeaturesSubsystem  
> 
> ----
> このクラスは、ゲーム内でオーバーライドして、 GameFeature プラグインのマウントやアンマウントに対するゲーム固有の反応を処理するためのものです。  
> 
> 一般的には、 GameFeature データアセットの UGameFeatureAction インスタンスを、この代わりに使用することをお勧めします。  
> 
> もし、これを使う場合は、UGameFeaturesProjectPolicies のサブクラスで作成し、UGameFeaturesSubsystem の AddObserver / RemoveObserver で登録します。  

* 概要
	* [UGameFeaturesSubsystem] で利用するインターフェイス。
* Lyra での使われ方
	* [ULyraGameFeature_HotfixManager] / [ULyraGameFeature_AddGameplayCuePaths] の基底クラスとして利用。


## UGameFeaturesProjectPolicies

> This class allows project-specific rules to be implemented for game feature plugins.  
> Create a subclass and choose it in Project Settings .. Game Features  
> 
> ----
> このクラスは、 GameFeature プラグインにプロジェクト固有のルールを実装することができます。  
> サブクラスを作成し、 Project Settings .. Game Features で選択します。  

* 概要
	* `Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class` でこの派生クラスを指定する。


## UDefaultGameFeaturesProjectPolicies

> This is a default implementation that immediately processes all game feature plugins the based on their BuiltInAutoRegister, 
> BuiltInAutoLoad, and BuiltInAutoActivate settings.  
>  
> It will be used if no project-specific policy is set in Project Settings .. Game Features  
> 
> ----
> これは、すべてのゲーム機能プラグインを BuiltInAutoRegister, BuiltInAutoLoad, BuiltInAutoActivate の設定に基づいて直ちに処理するデフォルトの実装です。 
> 
> Project Settings ... Game Features でプロジェクト固有のポリシーが設定されていない場合に使用されます。 


* 概要
	* GameFeature のロード時などの挙動のデフォルト実装を定義している。
* Lyra での使われ方
	* [ULyraGameFeaturePolicy] の基底クラスとして利用。


## UGameFeatureAction

> Represents an action to be taken when a game feature is activated  
> 
> ----
> GameFeature がアクティブになったときに実行されるアクションを表します。

* 概要
	* GameFeature がアクティブになったときに実行されるアクションを定義するための基底クラス。
* Lyra での使われ方
	* 以下の基底クラスとして利用。
		* [UApplyFrontendPerfSettingsAction]
		* [UGameFeatureAction_SplitscreenConfig]
		* [UGameFeatureAction_AddInputBinding]
		* [UGameFeatureAction_AddInputContextMapping]
		* [UGameFeatureAction_AddInputConfig]
		* [UGameFeatureAction_AddAbilities]
		* [UGameFeatureAction_AddWidgets]
		* [UGameFeatureAction_AddGameplayCuePath]
	* [ULyraExperienceManagerComponent] 
		* エクスペリエンスの実装手段として利用。
	* 以下のアセットで利用。
		* [UGameFeatureData::Actions]
		* [ULyraExperienceActionSet::Actions]
		* [ULyraExperienceDefinition::Actions]
	* 各アセットでの使用状況
		| Asset                                                              | [UGameFeatureAction]                        |
		| ------------------------------------------------------------------ | ------------------------------------------- |
		| `ShooterCore`<br>([UGameFeatureData])                              | [UGameFeatureAction_AddComponents]          |
		|                                                                    | [UGameFeatureAction_DataRegistry]           |
		|                                                                    | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                    | [UGameFeatureAction_AddInputConfig]         |
		| `TopDownArena`<br>([UGameFeatureData])                             | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                    | [UGameFeatureAction_AddInputConfig]         |
		| `ShooterMaps`<br>([UGameFeatureData])                              | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                    |                                             |
		| `EAS_BasicShooterAcolades`<br>([ULyraExperienceActionSet])         | [UGameFeatureAction_AddComponents]          |
		| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])                | [UGameFeatureAction_AddInputContextMapping] |
		|                                                                    | [UGameFeatureAction_AddInputBinding]        |
		|                                                                    | [UGameFeatureAction_AddAbilities]           |
		| `LAS_ShooterGame_SharedInput`<br>([ULyraExperienceActionSet])      | [UGameFeatureAction_AddInputContextMapping] |
		|                                                                    | [UGameFeatureAction_AddInputBinding]        |
		| `LAS_ShooterGame_SharedComponents`<br>([ULyraExperienceActionSet]) | [UGameFeatureAction_AddComponents]          |
		| `LAS_ShooterGame_SharedHUD`<br>([ULyraExperienceActionSet])        | [UGameFeatureAction_AddWidgets]             |
		|                                                                    |                                             |
		| `B_LyraDefaultExperience`<br>([ULyraExperienceDefinition])         | [UGameFeatureAction_AddWidgets]             |
		| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])       | [UGameFeatureAction_SplitscreenConfig]      |
		|                                                                    | [UGameFeatureAction_AddComponents]          |
		|                                                                    | [UApplyFrontendPerfSettingsAction]          |
		|                                                                    | [UGameFeatureAction_AddWidgets]             |
		| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition]) | [UGameFeatureAction_AddWidgets]             |
		|                                                                    | [UGameFeatureAction_AddAbilities]           |
		|                                                                    | [UGameFeatureAction_AddComponents]          |
		| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])       | [UGameFeatureAction_AddAbilities]           |
		|                                                                    | [UGameFeatureAction_AddComponents]          |
		|                                                                    | [UGameFeatureAction_AddWidgets]             |
		| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])       | [UGameFeatureAction_AddWidgets]             |
		|                                                                    | [UGameFeatureAction_AddAbilities]           |
		|                                                                    | [UGameFeatureAction_AddComponents]          |
		| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])        | [UGameFeatureAction_AddWidgets]             |
		|                                                                    | [UGameFeatureAction_SplitscreenConfig]      |
		|                                                                    | [UGameFeatureAction_AddComponents]          |

## UGameFeatureAction_DataRegistry

> Specifies a list of Data Registries to load and initialize with this feature  
> 
> ----

* 概要
	* [データ レジストリ] にデータを追加するアクションを定義している。
* Lyra での使われ方
	| Asset                                 | RegistriesToAdd                                          |
	| ------------------------------------- | ---------------------------------------------------------|
	| `ShooterCore`<br>([UGameFeatureData]) | `AccoladeDataRegistry`<br>([FLyraAccoladeDefinitionRow]) |




## UGameFeatureAction_AddComponents

> Adds actor<->component spawn requests to the component manager  
>  
> @see UGameFrameworkComponentManager  
> 
> ----

* 概要
	* 任意の対象にコンポーネントを追加するアクションを定義している。
* Lyra での使われ方
	| Asset                                                              | ActorClass                                      | ComponentClass                                                           | bClientComponent | bServerComponent |
	| ------------------------------------------------------------------ | ----------------------------------------------- | ------------------------------------------------------------------------ | ---------------- | ---------------- |
	| `ShooterCore`<br>([UGameFeatureData])                              | `AGameStateBase`                                | `B_EliminationFeedRelay`<br>([UGameplayMessageProcessor])                | ✔               | ✔               |
	|                                                                    | [ALyraCharacter]                                | [ULyraEquipmentManagerComponent]                                         | ✔               | ✔               |
	|                                                                    | [ALyraPlayerController]                         | [ULyraIndicatorManagerComponent]                                         | ✔               |                  |
	|                                                                    | `AController`                                   | [ULyraInventoryManagerComponent]                                         | ✔               | ✔               |
	|                                                                    | `AController`                                   | [ULyraWeaponStateComponent]                                              | ✔               | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_AimAssistTargetManager`<br>([UAimAssistTargetManagerComponent])       | ✔               |                  |
	| `EAS_BasicShooterAcolades`<br>([ULyraExperienceActionSet])         | `AGameStateBase`                                | `B_ElimChainProcessor`<br>([UElimChainProcessor])                        |                  | ✔               |
	|                                                                    | `AGameStateBase`                                | `B_ElimStreakProcessor`<br>([UElimStreakProcessor])                      |                  | ✔               |
	|                                                                    | `AGameStateBase`                                | `UAssistProcessor`                                                       |                  | ✔               |
	|                                                                    | `AGameStateBase`                                | `B_AccoladeRelay`<br>([UGameplayMessageProcessor])                       | ✔               | ✔               |
	| `LAS_ShooterGame_SharedComponents`<br>([ULyraExperienceActionSet]) | [ALyraPlayerController]                         | `B_NiagaraNumberPopComponent`<br>([ULyraNumberPopComponent_NiagaraText]) | ✔               |                  |
	|                                                                    | `AController`                                   | `B_QuickBarComponent`<br>([ULyraQuickBarComponent])                      | ✔               | ✔               |
	|                                                                    | [ALyraPlayerController]                         | `NameplateManagerComponent`<br>(`UControllerComponent`)                  | ✔               |                  |
	|                                                                    | `B_Hero_ShooterMannequin`<br>([ALyraCharacter]) | `NameplateSource`<br>(`UControllerComponent`)                            | ✔               |                  |
	| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])       | [ALyraGameState]                                | `B_LyraFrontendStateComponent`<br>([ULyraFrontendStateComponent])        | ✔               |                  |
	|                                                                    | [ALyraGameState]                                | `B_MusicManagerComponent_FE`<br>(`UActorComponent`)                      | ✔               |                  |
	| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition]) | [ALyraGameState]                                | `B_ControlPointScoring`<br>(`UGameStateComponent`)                       | ✔               | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_MusicManagerComponent_ControlPoint`<br>(`UActorComponent`)            | ✔               |                  |
	|                                                                    | [ALyraGameState]                                | `B_ShooterBotSpawner_ControlPoint`<br>([ULyraBotCreationComponent])      |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                    | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])       | [ALyraGameState]                                | `B_TeamDeathMatchScoring`<br>(`UGameStateComponent`)                     | ✔               | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_MusicManagerComponent_Elimitation`<br>(`UActorComponent`)             | ✔               |                  |
	|                                                                    | [ALyraGameState]                                | `B_ShooterBotSpawner`<br>([ULyraBotCreationComponent])                   |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                    | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])       | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                    | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState]                              | `B_PlayerUIComponent`<br>(`UPlayerStateComponent`)                       | ✔               |                  |
	|                                                                    | [ALyraGameState]                                | `B_TeamSetup_FourTeams`<br>([ULyraTeamCreationComponent])                |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TopDownArena_GameComponent_Lives`<br>(`UGameStateComponent`)          | ✔               | ✔               |
	|                                                                    | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |














































## UGameFeatureData

> Data related to a game feature, a collection of code and content that adds a separable discrete feature to the game  
> 
> ----
> GameFeature に関連するデータ。これは、ゲームに分離可能な個別の機能を追加するコードとコンテンツの集合体です。  

* 概要
	* GameFeature を設定するためのクラス。
* Lyra での使われ方
	* 以下の 3 種類を使用している。
		* `ShooterCore` ([UGameFeatureData])
		* `TopDownArena` ([UGameFeatureData])
		* `ShooterMaps` ([UGameFeatureData])


### UGameFeatureData::Actions

> List of actions to perform as this game feature is loaded/activated/deactivated/unloaded  
> 
> ----
> この GameFeature のロード/アクティブ化/非アクティブ化/アンロードに伴って実行されるアクションの一覧です。  

* 概要
	* [UGameFeatureAction] の配列。
	* この GameFeature で使用したいアクションを設定する。


### UGameFeatureData::PrimaryAssetTypesToScan

> List of asset types to scan at startup  
> 
> ----
> 起動時にスキャンするアセットタイプのリスト  

* 概要
	* [FPrimaryAssetTypeInfo] の配列。
	* この GameFeature で使用したい AssetManager への設定項目を設定する。

## UGameFeaturesSubsystem

> The manager subsystem for game features  
> 
> ----
> GameFeature の管理を行うサブシステム。

* 概要
* Lyra での使われ方
	* [ULyraGameFeaturePolicy]
	* [ULyraExperienceManagerComponent]
	* [UGameFeatureAction_WorldActionBase]
	* [UGameFeatureAction_AddWidgets]

### UGameFeaturesSubsystem::AddObserver()


# GameFeature 関連（ Lyra 側）

## ULyraGameFeaturePolicy

> Manager to keep track of the state machines that bring a game feature plugin into memory and active  
> This class discovers plugins either that are built-in and distributed with the game or are reported externally (i.e. by a web service or other endpoint)  
> 
> ----
> GameFeature プラグインをメモリに取り込み、アクティブにするためのステートマシンを追跡するためのマネージャです。  
> このクラスは、ゲームに組み込まれて配布されるプラグイン、または外部（ウェブサービスや他のエンドポイント）から通知されるプラグインを検出します。 

* 概要
	* [UDefaultGameFeaturesProjectPolicies] の派生クラス。
	* [UGameFeaturesSubsystem::AddObserver()] にて以下を登録している。
		* [ULyraGameFeature_HotfixManager]
		* [ULyraGameFeature_AddGameplayCuePaths]
	* いくつか関数をオーバーライドしているが、実装は親クラスと同じ。
	* `Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class` で指定している。


## FMappableConfigPair

> A container to organize potentially unloaded player mappable configs to their CommonUI input type  
> 
> ----


## UGameFeatureAction_WorldActionBase

> Base class for GameFeatureActions that wish to do something world specific.  
> 
> ----



## UGameFeatureAction_AddInputBinding

> Adds InputMappingContext to local players' EnhancedInput system. 
> Expects that local players are set up to use the EnhancedInput system.  
> 
> ----

* Lyra での使い方
	| Asset                                                         | InputMapping<br>([ULyraInputConfig]) |
	| ------------------------------------------------------------- | ------------------------------------ |
	| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])           | `InputData_InventoryTest`            |
	| `LAS_ShooterGame_SharedInput`<br>([ULyraExperienceActionSet]) | `InputData_ShooterGame_AddOns`       |

## UGameFeatureAction_AddInputContextMapping

> Adds InputMappingContext to local players' EnhancedInput system. 
> Expects that local players are set up to use the EnhancedInput system.  
> 
> ----

* Lyra での使い方
	| Asset                                                         | InputMapping<br>([UInputMappingContext]) | Priority |
	| ------------------------------------------------------------- | ---------------------------------------- | ---------|
	| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])           | `IMC_InventoryTest`                      | 1        |
	| `LAS_ShooterGame_SharedInput`<br>([ULyraExperienceActionSet]) | `IMC_ShooterGame_KBM`                    | 1        |

## UGameFeatureAction_SplitscreenConfig

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----
> 指定されたタイプのアクターにアビリティ（とアトリビュート）を付与する GameFeatureAction を担当する。 

> note: 上記はおそらく、 [UGameFeatureAction_AddAbilities] からのコピペで、適切なコメントではない。

* Split Screen を抑制します。
* Lyra での使い方
	| Asset                                                         | bDisableSplitscreen |
	| ------------------------------------------------------------- | ------------------- |
	| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])  | ✔                  |
	| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])   | ✔                  |

>  note:  
> `UGameViewportClient::SetForceDisableSplitscreen() ` を呼び出します。  
>> Allows game code to disable splitscreen (useful when in menus)  
>> 
>> ----
>> ゲームコードで splitscreen を無効化を可能にします（メニューの時に便利）

## UGameFeatureAction_AddAbilities

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----

* Lyra での使い方
	| Asset                                                               | ActorClass         | GrantedAbilities  | GrantedAttributes | GrantedAbilitySets<br>([ULyraAbilitySet]) |
	| ------------------------------------------------------------------- | ------------------ | ----------------- | ----------------- | ----------------------------------------- |
	| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])                 | [ALyraPlayerState] |                   |                   | `AbilitySet_InventoryTest`                |
	| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])  | [ALyraPlayerState] |                   |                   | `AbilitySet_ControlPoint`                 |
	| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState] |                   |                   | `AbilitySet_Elimination`                  |
	| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState] |                   |                   | `AbilitySet_ControlPoint`                 |


## UGameFeatureAction_AddInputConfig

> Registers a Player Mappable Input config to the Game User Settings  
>  
> Expects that local players are set up to use the EnhancedInput system.  

* Lyra での使い方
	| Asset                                  | Config<br>([UPlayerMappableInputConfig]) | Type             | DependentPlatformTraits                         |
	| ---------------------------------------| -----------------------------------------|------------------|-------------------------------------------------|
	| `ShooterCore`<br>([UGameFeatureData])  | `PMI_Default_KBM`                        | MouseAndKeyboard | `Platform.Trait.Input.SupportsMouseAndKeyboard` |
	|                                        | `PMI_Default_Gamepad`                    | Gamepad          |                                                 |
	|                                        | `PMI_ShooterDefaultConfig_KBM`           | MouseAndKeyboard | `Platform.Trait.Input.SupportsMouseAndKeyboard` |
	|                                        | `PMI_ShooterDefaultConfig_Gamepad`       | Gamepad          |                                                 |
	| `TopDownArena`<br>([UGameFeatureData]) | `PMI_Default_KBM`                        | MouseAndKeyboard |                                                 |
	|                                        | `PMI_Default_Gamepad`                    | Gamepad          |                                                 |

## UGameFeatureAction_AddWidgets

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----

* Lyra での使い方
	| Asset                                                               | LayoutClass<br>([ULyraHUDLayout])  | LayerID         | WidgetClass                                                       | SlotID                          |
	| ------------------------------------------------------------------- | ---------------------------------- | --------------- | ----------------------------------------------------------------- | ------------------------------- |
	| `LAS_ShooterGame_SharedHUD`<br>([ULyraExperienceActionSet])         | `W_ShooterHUDLayout`               | `UI.Layer.Game` | `W_EliminationFeed`<br>(`UUserWidget`)                            | `HUD.Slot.EliminationFeed`      |
	|                                                                     |                                    |                 | `W_QuickBar`<br>([ULyraTaggedWidget])                             | `HUD.Slot.Equipment`            |
	|                                                                     |                                    |                 | `W_AccoladeHostWidget`<br>([ULyraAccoladeHostWidget])             | `HUD.Slot.TopAccolades`         |
	|                                                                     |                                    |                 | `W_WeaponReticleHost`<br>([ULyraWeaponUserInterface])             | `HUD.Slot.Reticle`              |
	|                                                                     |                                    |                 | `W_PerfStatContainer_GraphOnly`<br>([ULyraPerfStatContainerBase]) | `HUD.Slot.PerfStats.Graph`      |
	|                                                                     |                                    |                 | `W_PerfStatContainer_TextOnly`<br>([ULyraPerfStatContainerBase])  | `HUD.Slot.PerfStats.Text`       |
	|                                                                     |                                    |                 | `W_OnScreenJoystick_Left`<br>([ULyraJoystickWidget])              | `HUD.Slot.LeftSideTouchInputs`  |
	|                                                                     |                                    |                 | `W_OnScreenJoystick_Right`<br>([ULyraJoystickWidget])             | `HUD.Slot.RightSideTouchInputs` |
	|                                                                     |                                    |                 | `W_FireButton`<br>(`UUserWidget`)                                 | `HUD.Slot.RightSideTouchInputs` |
	|                                                                     |                                    |                 | `W_TouchRegion_Right`<br>([ULyraTouchRegion])                     | `HUD.Slot.RightSideTouchRegion` |
	|                                                                     |                                    |                 | `W_TouchRegion_Left`<br>([ULyraTouchRegion])                      | `HUD.Slot.LeftSideTouchRegion`  |
	| `B_LyraDefaultExperience`<br>([ULyraExperienceDefinition])          | `W_DefaultHUDLayout`               |`UI.Layer.Game`  |                                                                   |                                 |
	| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])        |                                    |                 | `W_PerfStatContainer_FrontEnd`<br>([ULyraPerfStatContainerBase])  | `HUD.Slot.PerfStats.Text`       |
	| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])  |                                    |                 | `W_CPScoreWidget`<br>([ULyraTaggedWidget])                        | `HUD.Slot.TeamScore`            |
	|                                                                     |                                    |                 | `W_ControlPointStatusWidget`<br>([ULyraTaggedWidget])             | `HUD.Slot.ModeStatus`           |
	| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])        |                                    |                 | `W_ScoreWidget_Elimination`<br>([ULyraTaggedWidget])              | `HUD.Slot.TeamScore`            |
	| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])        |                                    |                 | `W_CPScoreWidge`<br>([ULyraTaggedWidget])                         | `HUD.Slot.TeamScore`            |
	|                                                                     |                                    |                 | `W_ControlPointStatusWidget`<br>([ULyraTaggedWidget])             | `HUD.Slot.ModeStatus`           |
	| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])         | `W_TopDownArenaHUDLayout`          | `UI.Layer.Game` |                                                                   |                                 |

## UGameFeatureAction_AddGameplayCuePath

> GameFeatureAction responsible for adding gameplay cue paths to the gameplay cue manager.  
>  
> @see UAbilitySystemGlobals::GameplayCueNotifyPaths  
>  
> ----

* Lyra での使い方
	| Asset                                  | DirectoryPathsToAdd                                   |
	| -------------------------------------- | ------------------------------------------------------|
	| `ShooterCore`<br>([UGameFeatureData])  | `/GameplayCues`<br>`/Weapons`<br>`/Items`             |
	| `TopDownArena`<br>([UGameFeatureData]) | `/GameplayCues`                                       |
	| `ShooterMaps`<br>([UGameFeatureData])  | `/GameplayCues`                                       |



## UApplyFrontendPerfSettingsAction

> GameFeatureAction responsible for telling the user settings to apply frontend/menu specific performance settings  
>  
> ----
> GameFeatureAction は、フロントエンド/メニュー固有のパフォーマンス設定を適用するよう、ユーザー設定に指示する役割を果たす。 

* 概要
	* 主に PIE でマルチプレイしている際に個々にパフォーマンス設定を追跡しないようにするための仕組み。
* Lyra での使い方
	| Asset                                                         |
	| ------------------------------------------------------------- |
	| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])  |


## ULyraGameFeature_HotfixManager

* 概要
	* HotFix に関する処理を行う。
	* [ULyraHotfixManager] を利用する。
	* [IGameFeatureStateChangeObserver] のインターフェイスを持つ。


## ULyraGameFeature_AddGameplayCuePaths

* 概要
	* GameFeature で [UGameFeatureAction_AddGameplayCuePath] が設定された際、 [ULyraGameplayCueManager] にパス情報を渡し、 GameplayCue 再生時の検索パスに追加する。
	* [IGameFeatureStateChangeObserver] のインターフェイスを持つ。


# エクスペリエンス 関連（ Lyra 側）

## ALyraWorldSettings

> The default world settings object, used primarily to set the default gameplay experience to use when playing on this map
> 
> ----
> デフォルトの world settings object で、主にこのマップをプレイする際に使用するデフォルトのゲームプレイエクスペリエンスを設定するために使用されます。

* 概要
	* マップにエクスペリエンスを設定できるように `AWorldSettings` を拡張したクラス。
	* `Project Settings > Engine - General Settings > Default Classes > World Settings Class` でこのクラスを指定しています。

## ULyraExperienceActionSet

> Definition of a set of actions to perform as part of entering an experience  
> 
> ----
> エクスペリエンスに入るために行う一連の動作の定義  

* [ULyraExperienceDefinition::ActionSets] で利用される。
* 以下の 5 種類
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet])
	* `LAS_InventoryTest` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedInput` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedComponents` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedHUD` ([ULyraExperienceActionSet])


### ULyraExperienceActionSet::Actions

> List of actions to perform as this experience is loaded/activated/deactivated/unloaded  
> 
> ----

* [UGameFeatureAction] の配列。


## ULyraExperienceDefinition

> Definition of an experience  
> 
> ----

* 以下の 6 種類
	* `B_LyraDefaultExperience` ([ULyraExperienceDefinition])
	* `B_LyraFrontEnd_Experience` ([ULyraExperienceDefinition])
	* `B_LyraShooterGame_ControlPoints` ([ULyraExperienceDefinition])
	* `B_ShooterGame_Elimination` ([ULyraExperienceDefinition])
	* `B_TestInventoryExperience` ([ULyraExperienceDefinition])
	* `B_TopDownArenaExperience` ([ULyraExperienceDefinition])

### ULyraExperienceDefinition::Actions

> List of actions to perform as this experience is loaded/activated/deactivated/unloaded  
> 
> ----

* [UGameFeatureAction] の配列。



### ULyraExperienceDefinition::ActionSets

> List of additional action sets to compose into this experience  
> 
> ----

* [ULyraExperienceActionSet] の配列。


## ULyraExperienceManagerComponent

* 概要
	* [ULyraExperienceDefinition] のロード等を行うコンポーネント。
	* [ALyraGameState] に追加されている。
	* [UAsyncAction_ExperienceReady] はこのクラスの機能を利用し、エクスペリエンスのロード完了を監視する。
	* ロード完了時に呼び出すデリゲートを内部に持つ。それぞれの利用箇所は以下の通り。
		* [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()]
			* [ULyraTeamCreationComponent]
			* [ULyraFrontendStateComponent]
		* [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()]
			* [UAsyncAction_ExperienceReady]
			* [ALyraGameMode]
			* [ALyraPlayerState]
		* [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()]
			* [ULyraBotCreationComponent]


### ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()
### ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()
### ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()

* 概要
	* ロード完了時に呼び出すデリゲートを登録する関数。
	* すでにロードが完了している場合は渡されたデリゲートを直ちに呼びだす。
	* 登録された場合、 `HighPriority` 、無印、 `LowPriority` の順番に呼び出される。


## UAsyncAction_ExperienceReady

> Asynchronously waits for the game state to be ready and valid and then calls the OnReady event.  
> Will call OnReady immediately if the game state is valid already.
> 
> ----
> 非同期で GameState の準備が整い、有効になるのを待ち、 OnReady イベントを呼び出します。 
> GameState がすでに有効な場合は、すぐに OnReady を呼び出します。

* 概要
	* エクスペリエンスのロードを待つ AsyncAction 。
	* widget や GameStateComponent 派生クラス等でエクスペリエンスのロードを待つ際に利用される。

### UAsyncAction_ExperienceReady::OnReady

* 概要
	* ブループリントで設定する、ロード完了時に発火するイベント。


# Input 関連（エンジン側）

## UInputMappingContext

> UInputMappingContext : A collection of key to action mappings for a specific input context
> Could be used to:
>	Store predefined controller mappings (allow switching between controller config variants). TODO: Build a system allowing redirects of UInputMappingContexts to handle this.
>	Define per-vehicle control mappings
>	Define context specific mappings (e.g. I switch from a gun (shoot action) to a grappling hook (reel in, reel out, disconnect actions).
>	Define overlay mappings to be applied on top of existing control mappings (e.g. Hero specific action mappings in a MOBA)

## UPlayerMappableInputConfig

> This represents one set of Player Mappable controller/keymappings. You can use this input config to create
> the default mappings for your player to start with in your game. It provides an easy way to get only the player
> mappable key actions, and it can be used to add multiple UInputMappingContext's at once to the player.
> 
> Populate this data asset with Input Mapping Contexts that have player bindable actions in them. 


# Input 関連（ Lyra 側）

## ULyraInputConfig

> Non-mutable data asset that contains input configuration properties.

# GameplayCue 関連 （エンジン側）

## UGameplayCueManager

> Singleton manager object that handles dispatching gameplay cues and spawning GameplayCueNotify actors as needed

# GameplayCue 関連（ Lyra 側）

## ULyraGameplayCueManager

> Game-specific manager for gameplay cues

## AGameplayCueNotify_BurstLatent

> This is an instanced gameplay cue notify for effects that are one-offs.  
> Since it is instanced, it can do latent things like time lines or delays.  
> 
> ----







# GameplayAbility 関連（エンジン側）

## UGameplayAbility

### UGameplayAbility::MakeOutgoingGameplayEffectSpec()

> Convenience method for abilities to get outgoing gameplay effect specs  
> (for example, to pass on to projectiles to apply to whoever they hit)  
> 
> ----
> アビリティがゲームプレイエフェクト Spec を外部に出すための便利な方法  
> （例えば、投射物に渡して、当たった人に適用させるなど）。  

* `GameplayEffectSpec` を作るための関数で、ブループリントにも公開されている。
* [UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()] を呼び出す。


### UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()

> Add the Ability's tags to the given GameplayEffectSpec. This is likely to be overridden per project.  
> 
> ----
> 与えられたGameplayEffectSpecに、Abilityのタグを追加します。これは、プロジェクトごとにオーバーライドされる可能性が高いです。  

* 仮想関数。
* [UGameplayAbility::MakeOutgoingGameplayEffectSpec()] から呼ばれる。
* 渡された [FGameplayEffectSpec::CapturedSourceTags] に [FGameplayAbilitySpec::DynamicAbilityTags] を追加する。


## FGameplayAbilitySpec

> An activatable ability spec, hosted on the ability system component.  
> This defines both what the ability is (what class, what level, input binding etc)  
> and also holds runtime state that must be kept outside of the ability being instanced/activated.  
> 
> ----
> アビリティシステムコンポーネントでホストされる、起動可能なアビリティ Spec です。  
> これはアビリティが何であるか(どのクラス、どのレベル、入力バインディングなど)を定義するものである。  
> また、インスタンス化/アクティブ化されたアビリティの外側に保持されなければならない実行時状態も保持します。  

### FGameplayAbilitySpec::DynamicAbilityTags

> Optional ability tags that are replicated.  
> These tags are also captured as source tags by applied gameplay effects.  
> 
> ----
> 複製されるオプションのアビリティタグ。  
> これらのタグは、適用されたゲームプレイエフェクトによってソースタグとしてもキャプチャされる。  

* Lyra での使われ方
	* **InputTag** が設定されます。

## FGameplayEffectSpec

> GameplayEffect Specification. Tells us:  
> - What UGameplayEffect (const data)
> - What Level
> - Who instigated
>  
> FGameplayEffectSpec is modifiable. We start with initial conditions and modifications be applied to it.  
> In this sense, it is stateful/mutable but it is still distinct from an FActiveGameplayEffect which in an applied instance of an FGameplayEffectSpec.  
> 
> ----
> ゲームプレイエフェクトの仕様です。説明  
> - どの UGameplayEffect (const data) か
> - どのようなレベルか
> - 誰が実行したか
>  
> FGameplayEffectSpec は変更可能である。初期状態から始まり、修正が適用される。  
> この意味で、ステートフル／ミュータブルですが、FGameplayEffectSpec を適用したインスタンスである FActiveGameplayEffect とは区別される。  


### FGameplayEffectSpec::CapturedSourceTags

> Captured Source Tags on GameplayEffectSpec creation  
> 
> ----
> GameplayEffectSpec 作成時にキャプチャされたソースタグ。  

* Lyra での使われ方
	* [FGameplayAbilitySpec::DynamicAbilityTags] に **InputTag** が設定される都合上、ここにも **InputTag** がキャプチャされる。
	* 利用されているかは未確認。

# GameplayAbility 関連（ Lyra 側）

## ULyraGlobalAbilitySystem

[Lyra のアビリティ > ULyraGlobalAbilitySystem] より  
> たとえば、Lyra の Elimination モードは、マッチのウォームアップ フェーズで、  
> グローバルに Gameplay Effect (GE_PregameLobby) を適用します。  
> これはすべてのプレイヤーに対するダメージ無効化タグを付与し、  
> マッチがまだ開始されていないことを示す UI 要素を有効にする Gameplay Cue (ゲームプレイ キュー) をトリガーします。  

> TODO:  
> ゲームプレイに影響する UI の表示を Gameplay Cue で扱っていいのだろうか…？  
> （UIの表示によりユーザーの入力を抑制しているのであれば、ゲームプレイに影響するはず？要確認）  

* TODO: 必要に応じて追記。

## ULyraAbilitySystemComponent

* TODO: ソースを見て追記事項があれば。

* [FGameplayAbilitySpec::DynamicAbilityTags] について
	* 入力アクションが発生した際、バインドされた **InputTag** をキーに [FGameplayAbilitySpec] を探す。
	* その際、 [FGameplayAbilitySpec::DynamicAbilityTags] に **InputTag** を持つかで判定している。


### ULyraAbilitySystemComponent::SetTagRelationshipMapping()





## ULyraGameplayAbility

> The base gameplay ability class used by this project.  
> 
> ----

### ULyraGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()

[UGameplayAbility::MakeOutgoingGameplayEffectSpec()]




## ILyraReadyInterface

* コンポーネントの準備状態を判定するための関数を定義したインターフェイス。
* Lyra での使われ方
	* [ULyraPawnComponent] のみが継承している。
	* この機能を利用する他のクラスは [ULyraPawnComponent] を継承している。

### ILyraReadyInterface::IsPawnComponentReadyToInitialize()

* このコンポーネントが動作する準備ができている場合は true を返す。
* ネットワークを介している場合、プロパティのレプリケーションや `Possess` の順が不定のため、それを吸収するために利用される。


## ULyraPawnComponent

> An actor component that can be used for adding custom behavior to pawns.  
> 
> ----
> ポーンにカスタム動作を追加するために使用することができるアクターコンポーネントです。  


* [ILyraReadyInterface] のインターフェイスを持つ以外は何も実装されていない。
* Pawn に所有させるコンポーネントの基底クラス。
	* Lyra の全てのポーン用コンポーネント基底クラスと使用しているわけではない。
	* 例えば以下は `UPawnComponent` から派生している。
		* [ULyraPawnComponent_CharacterParts]
		* [ULyraEquipmentManagerComponent]


## ULyraPawnExtensionComponent

> Component used to add functionality to all Pawn classes.  
> 
> ----
> すべての Pawn クラスに機能を追加するために使用されるコンポーネントです。  

* 主な役割
	* Pawn に追加された全てのコンポーネントの準備ができているかのチェック。
		* [ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]
	* Pawn 用の [ULyraAbilitySystemComponent] の Initialize / Uninitialize の処理。
		* [ULyraPawnExtensionComponent::InitializeAbilitySystem()] / [ULyraPawnExtensionComponent::UninitializeAbilitySystem()]
	* なお、この 2 つの機能はこのクラスだけでは連動していない。
		* 準備のチェックから直接アビリティシステムの初期化は呼び出されない。（デリゲート経由で外部から呼ばれる。）
		* 要は、機能を明確にするのを目的にコンポーネントを分けようと思えば分けられる。
* その他の役割
	* [ULyraPawnData] のキャッシュの保持。
		* [ULyraPawnExtensionComponent::PawnData]
	* [ULyraAbilitySystemComponent] のキャッシュの保持。
		* [ULyraPawnExtensionComponent::AbilitySystemComponent]
* 利用しているクラス
	* [ALyraCharacter] に追加されている。

### ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()

> Call this anytime the pawn needs to check if it's ready to be initialized (pawn data assigned, possessed, etc..).  
> 
> ----
> ポーンが初期化（ポーンデータの割り当て、所持など）の準備ができたかどうかを確認する必要があるときはいつでもこれを呼び出します。  

処理の流れは大まかに以下のような形。

![](images/ULyraPawnExtensionComponent_InitializeAbilitySystem.png)

* このコンポーネントが追加された Pawn の初期化のチェックを行う
* Pawn に追加されたコンポーネントを走査して、 [ILyraReadyInterface] を持つものを探す。
* 見つかった対象に対し、初期化が済んでいるかのチェックを行う。
	* [ILyraReadyInterface::IsPawnComponentReadyToInitialize()] を利用する。
	* [ILyraReadyInterface::IsPawnComponentReadyToInitialize()] はここでのみ呼び出される。
* 全て初期化が済んでいたら、登録されたデリゲートを呼び出す。

* [ILyraReadyInterface::IsPawnComponentReadyToInitialize()] を利用し実装されている。
* チェックが通ったら、登録されたデリゲートを呼び出す。


### ULyraPawnExtensionComponent::PawnData
### ULyraPawnExtensionComponent::GetPawnData()
### ULyraPawnExtensionComponent::SetPawnData()

> Pawn data used to create the pawn.  Specified from a spawn function or on a placed instance.  
> 
> ----
> ポーンの作成に使用するポーンデータです。 スポーン関数や配置されたインスタンスから指定されます。  

* 主に [ULyraHeroComponent] が使用したい際に利用される。
* 指定方法
	* プレイヤーポーンがスポーンする際に指定する
		* [ULyraPawnExtensionComponent::SetPawnData()] が呼び出され、初期化される。
	* 配置されたインスタンスで直接指定する
* 外部からの利用の際は [ULyraPawnExtensionComponent::GetPawnData()] を経由する。
	* これはテンプレート関数で、テンプレート引数は戻り値の型となっている。
	* このクラスで所持するオブジェクトは [ULyraPawnData] 派生型を想定している。
	* つまり、[ULyraPawnData] 派生型を用意して、独自のキャラクターの初期化情報を追加することを想定している。
* 自クラスからの参照
	* [ULyraPawnExtensionComponent::InitializeAbilitySystem()]
		* [ULyraPawnData::TagRelationshipMapping] をタグリレーションシップマッピング情報として [ULyraAbilitySystemComponent::SetTagRelationshipMapping()] に渡す。
* 他クラスからの参照
	* [ULyraHeroComponent::InitializePlayerInput()]
		* [ULyraPawnData::InputConfig] を入力マッピングの追加と入力アクションのバインドに使用。
	* [ULyraHeroComponent::DetermineCameraMode()]
		* [ULyraPawnData::DefaultCameraMode] をデフォルトのカメラモードとして使用。

### ULyraPawnExtensionComponent::AbilitySystemComponent
### ULyraPawnExtensionComponent::GetLyraAbilitySystemComponent()

> Pointer to the ability system component that is cached for convenience.  
> 
> ----
> 利便性のためにキャッシュされたアビリティシステムコンポーネントへのポインター。  

* [ULyraAbilitySystemComponent] の初期化/終了処理を行うためにキャッシュを所持している。
* 他クラスからの参照
	* [ALyraCharacter]
	* [ULyraHeroComponent]
		* [ULyraPawnExtensionComponent::InitializeAbilitySystem()] を呼び出されることで初期化される。
		* 初期化後は、 [ULyraAbilitySystemComponent] へのアクセスはこのキャッシュを利用する。

### ULyraPawnExtensionComponent::InitializeAbilitySystem()

> Should be called by the owning pawn to become the avatar of the ability system.  
> 
> ----
> アビリティシステムのアバターになるために、所有するポーンから呼び出される必要があります。  

* [ULyraAbilitySystemComponent] の基本的な初期化に加え、 [ULyraAbilitySystemComponent::SetTagRelationshipMapping()] の呼び出しを行っている。
	* [ULyraAbilityTagRelationshipMapping] 関連はキャラクターに依らないため、このクラス経由で扱っている。

### ULyraPawnExtensionComponent::UninitializeAbilitySystem()

> Should be called by the owning pawn when the pawn's controller changes.  
> 
> ----
> ポーンのコントローラーが変わった時に、所有するポーンから呼び出される必要があります。  

## ULyraHeroComponent

> A component used to create a player controlled pawns (characters, vehicles, etc..).  
> 
> ----
> プレイヤーが制御するポーン（キャラクター、ビークルなど）を作成するために使用されるコンポーネント。  

* 主な役割
	* 入力時のロジックの実装と Enhanced Input との関連付け。
	* [ULyraPawnExtensionComponent] のアビリティシステム関連の機能呼び出し。
	* アビリティによるカメラ情報の保持。
* 追加しているポーン
	* C++ では追加していない。
	* `B_Hero_Default` （キャラクターの BP の基底クラス） で追加している。
* [ULyraPawnExtensionComponent] との関係
	* 参照方法
		* 自身を追加している Pawn に `FindComponentByClass<ULyraPawnExtensionComponent>()` を呼び出すことで参照している。
	* 用途
		* [ULyraPawnData] を使用するとき。
		* [ULyraAbilitySystemComponent] を使用するとき。
* [ULyraPawnData] との関係
	* `InputConfig` / `DefaultCameraMode` を参照している。
* [ULyraAbilitySystemComponent] との関係
	* クラス内でキャッシュを持たない。
	* 初期化時（ [ULyraHeroComponent::OnPawnReadyToInitialize()] ）に [ALyraPlayerState] から取得し、 [ULyraPawnExtensionComponent] に設定する。
	* 以降、アクセス時は [ULyraPawnExtensionComponent] 経由で行う。
* [ALyraCharacter] との関係
	* ほぼ無い。
	* [ALyraCharacter::ToggleCrouch()] の機能を利用するときのみ参照している。
		* ただ、上記の関数は `ACharacter` の機能しか利用していないので、最悪参照なしでも実装可能。そのぐらいの関係性の低さ。

### ULyraHeroComponent::DefaultInputConfigs

> Input Configs that should be added to this player when initalizing the input.  
> NOTE: You should only add to this if you do not have a game feature plugin accessible to you.  
> If you do, then use the GameFeatureAction_AddInputConfig instead.  
> 
> ----
> 入力を初期化するときに、このプレーヤに追加されるべき入力コンフィグ。  
> 注：この設定は、 GameFeature プラグインにアクセスできない場合にのみ追加する必要があります。  
> もしあるならば、代わりに GameFeatureAction_AddInputConfig を使用してください。  

* [FMappableConfigPair] の配列を保持している。
	* この設定は [ULyraHeroComponent::InitializePlayerInput()] で読み込まれ、 [ULyraSettingsLocal] に反映される。
		* [ULyraSettingsLocal] に反映された内容は [ULyraInputComponent::AddInputMappings()] で Enhanced Input にマッピングの追加をされる。
		* 上記のコメントの通り、 Game Feature を使用しない場合にこのプロパティを設定することを想定されている。
* 利用しているクラス
	* `B_SimplePawn`

### ULyraHeroComponent::IsPawnComponentReadyToInitialize()

* 自身を所有している Pawn の Controller/PlayerState/Owner/InputComponent などの関連付け状態のチェックを行う。
* 個のコンポーネントの準備というより、自身を追加している Pawn の準備の確認を行っている。

### ULyraHeroComponent::OnPawnReadyToInitialize()

* [ULyraPawnExtensionComponent] に登録するデリゲート用の関数。
* [ULyraPawnExtensionComponent::InitializeAbilitySystem()] を呼び出す。
	* 引数の [ULyraAbilitySystemComponent] は [ALyraPlayerState] から受け取ったものを渡す。
* [ULyraHeroComponent::InitializePlayerInput()] を呼び出す。

### ULyraHeroComponent::InitializePlayerInput()

* 主に入力マッピングの追加と入力アクションのバインドを行う。
* [ULyraHeroComponent::OnPawnReadyToInitialize()] から呼ばれる。


### ULyraHeroComponent::DetermineCameraMode()

* 状況に応じたカメラモード [ULyraCameraMode] を返す。


## ULyraAbilitySet

> Non-mutable data asset used to grant gameplay abilities and gameplay effects.  
> 
> ----
> ゲームプレイアビリティおよびゲームプレイエフェクトを付与するために使用される非ミュータブルなデータアセット。  


### ULyraAbilitySet::GiveToAbilitySystem()

* 渡された [ULyraAbilitySystemComponent] の Owner が `authoritative` ならばアビリティを付与する。
	* 付与する際、 [FGameplayAbilitySpec::DynamicAbilityTags] に **InputTag** を設定する。
		* この値は、入力があった際に **InputTag** から [FGameplayAbilitySpec] を見つけるのに利用される。
		* 詳しくは [ULyraAbilitySystemComponent] 参照。


## ULyraAbilityTagRelationshipMapping

> Mapping of how ability tags block or cancel other abilities  

* GameplayAbility の GameplayTag によるブロックやキャンセルの定義をまとめた構造体。
* [ULyraAbilitySystemComponent] から利用される。



## ULyraGameplayAbility_FromEquipment

> An ability granted by and associated with an equipment instance  
> 
> ----

## ULyraGameplayAbility_RangedWeapon

> An ability granted by and associated with a ranged weapon instance  
> 
> ----


## ULyraGameplayAbility_Reset

> Gameplay ability used for handling quickly resetting the player back to initial spawn state.  
> Ability is activated automatically via the "GameplayEvent.RequestReset" ability trigger tag (server only).  
> 
> ----


## ULyraGameplayAbility_Death

> Gameplay ability used for handling death.
> Ability is activated automatically via the "GameplayEvent.Death" ability trigger tag.
> 
> ----


## ULyraGameplayAbility_Interact

> Gameplay ability used for character interacting
> 
> ----


## ULyraGameplayAbility_Jump

> Gameplay ability used for character jumping.
> 
> ----

## ULyraGamePhaseAbility

> The base gameplay ability for any ability that is used to change the active game phase.  
> 
> ----


## ULyraAttributeSet

> Base attribute set class for the project.  
> 
> ----


## ULyraHealthSet

> Class that defines attributes that are necessary for taking damage.  
> Attribute examples include: health, shields, and resistances.  
> 
> ----

### ULyraHealthSet::Health

> The current health attribute.  
> The health will be capped by the max health attribute.  
> Health is hidden from modifiers so only executions can modify it.  
> 
> ----
> 現在のヘルス属性です。  
> ヘルスは最大ヘルス属性で上限が設定されます。  
> ヘルスは modifier から隠されているので、 execution のみが修正可能です。  

### ULyraHealthSet::MaxHealth

> The current max health attribute.  
> Max health is an attribute since gameplay effects can modify it.  
> 
> ----
> 現在の最大ヘルス属性です。  
> 最大ヘルスはゲームプレイエフェクトで変更が可能なため、属性として扱われます。  

### ULyraHealthSet::Healing

> Incoming healing. This is mapped directly to +Health  
> 
> ----

* いわゆるメタ属性。

### ULyraHealthSet::Damage

> Incoming damage. This is mapped directly to -Health  
> 
> ----

> Damage is hidden from modifiers so only executions can modify it.  
> 
> ----

* いわゆるメタ属性。
* `UPROPERTY` の `Meta` にて `HideFromModifiers` が指定されている。
* そのため、 [ULyraAttributeSet::Health] と同様に modifier では変更できず execution(`UGameplayEffectExecutionCalculation` 派生クラス) のみで修正可能です。


## ULyraHealthComponent









# GameplayMessage 関連（ Lyra 側）

## UGameplayMessageSubsystem

> This system allows event raisers and listeners to register for messages without having to know about each other directly,  
> though they must agree on the format of the message (as a USTRUCT() type).  
>  
> You can get to the message router from the game instance:  
> 	UGameInstance::GetSubsystem<UGameplayMessageSubsystem>(GameInstance)  
> or directly from anything that has a route to a world:  
> 	UGameplayMessageSubsystem::Get(WorldContextObject)  
>  
> Note that call order when there are multiple listeners for the same channel is not guaranteed and can change over time!  
> 
> ----
> このシステムにより、イベント発信者と受信者は、メッセージのフォーマット（USTRUCT()型として）に合意する必要があるものの、  
> 互いのことを直接知らなくても、メッセージを登録することができるようになります。  
>  
> メッセージルーターは、ゲームインスタンスから:  
> 	UGameInstance::GetSubsystem<UGameplayMessageSubsystem>(GameInstance)  
> またはワールドへのルートを持つものから直接取得できます。  
> 	UGameplayMessageSubsystem::Get(WorldContextObject)  
>  
> 同じチャンネルに複数のリスナーがいる場合の呼び出し順は保証されておらず、  
> 時間の経過とともに変化する可能性があることに注意してください。  

* 概要
	* 受信者はこのクラスにリスナー関数を登録する。
	* 送信者はメッセージを渡し、このクラスは保持している受信者のリスナー関数を呼び出す。

利用状況は概ね以下の通り。

| Channel                                                                                                                                                                                                     | 送信者                                                                                                                                                 | 受信者                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | メッセージの型                           | 内容                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- | ---------------------------------------------------------------------------------- |
| `Ability.Grenade.Duration.Message`                                                                                                                                                                          | `GA_Grenade` ([ULyraGameplayAbility])                                                                                                                  | `W_GrenadeCooldown` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                           | [FLyraInteractionDurationMessage]        | 期間情報（グレネードのクールダウン）                                               |
| `Ability.Dash.Duration.Message`                                                                                                                                                                             | `GA_Hero_Dash` (`GA_AbilityWithWidget`)                                                                                                                | `W_DashTouchButton` (`UUserWidget`)<br>`W_DashCooldown` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                       | [FLyraInteractionDurationMessage]        | 期間情報（ダッシュのクールダウン）                                                 |
| `Ability.Interaction.Duration.Message`                                                                                                                                                                      | `GA_Interaction_Collect` ([ULyraGameplayAbility])                                                                                                      | `W_AbilityProgress` ([ULyraTaggedWidget])                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [FLyraInteractionDurationMessage]        | 期間情報（インタラクション）                                                       |
| `Ability.Respawn.Duration.Message`                                                                                                                                                                          | `GA_AutoRespawn` ([ULyraGameplayAbility])                                                                                                              | `W_RespawnTimer` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                              | [FLyraInteractionDurationMessage]        | 期間情報（リスポーンまでの期間）                                                   |
| `Ability.Respawn.Completed.Message`                                                                                                                                                                         | `GA_AutoRespawn` ([ULyraGameplayAbility])<br>by [ALyraGameState::MulticastReliableMessageToClients()]                                                  | `W_RespawnTimer` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                              | [FLyraVerbMessage]                       | リスポーン情報                                                                     |
| `Ability.UserFacingSimpleActivateFail.Message`                                                                                                                                                              | [ULyraGameplayAbility]<br>`B_WeaponSpawner` ([ALyraWeaponSpawner])                                                                                     | `W_AbilityFailureFeedback` ([ULyraTaggedWidget])                                                                                                                                                                                                                                                                                                                                                                                                                                              | [FLyraAbilitySimpleFailureMessage]       | アビリティのアクティブ化の失敗の原因                                               |
| `Ability.PlayMontageOnActivateFail.Message`                                                                                                                                                                 | [ULyraGameplayAbility]                                                                                                                                 | `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon])                                                                                                                                                                                                                                                                                                                                                                                                                                        | [FLyraAbilityMontageFailureMessage]      | アビリティのアクティブ化の失敗の原因<br>（とその際に利用可能なモンタージュの情報） |
| `GameplayEvent.Reset`                                                                                                                                                                                       | [ULyraGameplayAbility_Reset]                                                                                                                           | `GA_AutoRespawn` ([ULyraGameplayAbility])                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [FLyraPlayerResetMessage]                | プレイヤーリセットの発生                                                           |
| `Gameplay.Message.ADS`                                                                                                                                                                                      | `GA_ADS` (`GA_AbilityWithWidget`)                                                                                                                      | `W_Reticle_Shotgun` ([ULyraReticleWidgetBase])<br>`W_Reticle_Rifle` ([ULyraReticleWidgetBase])<br>`W_Reticle_Pistol` ([ULyraReticleWidgetBase])                                                                                                                                                                                                                                                                                                                                               | `Struct_UIMessaging`                     | ADS しているかの情報                                                               |
| `Gameplay.Message.Nameplate.Add`                                                                                                                                                                            | `NameplateSource` (`UControllerComponent`)                                                                                                             | `NameplateManagerComponent` (`UControllerComponent`)                                                                                                                                                                                                                                                                                                                                                                                                                                          | `Message_NameplateInfo`                  | ネームプレート情報追加                                                             |
| `Gameplay.Message.Nameplate.Remove`                                                                                                                                                                         | `NameplateSource` (`UControllerComponent`)                                                                                                             | `NameplateManagerComponent` (`UControllerComponent`)                                                                                                                                                                                                                                                                                                                                                                                                                                          | `Message_NameplateInfo`                  | ネームプレート情報削除                                                             |
| `Gameplay.Message.Nameplate.Discover`                                                                                                                                                                       | `NameplateManagerComponent` (`UControllerComponent`)                                                                                                   | `NameplateSource` (`UControllerComponent`)                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `Message_NameplateRequest`               | ネームプレート情報問い合わせ                                                       |
| `Lyra.QuickBar.Message.SlotsChanged`                                                                                                                                                                        | [ULyraQuickBarComponent]                                                                                                                               | `W_QuickBarSlot` ([ULyraTaggedWidget])                                                                                                                                                                                                                                                                                                                                                                                                                                                        | [FLyraQuickBarSlotsChangedMessage]       | 武器のスロット内容の変更                                                           |
| `Lyra.QuickBar.Message.ActiveIndexChanged`                                                                                                                                                                  | [ULyraQuickBarComponent]                                                                                                                               | `W_QuickBarSlot` ([ULyraTaggedWidget])                                                                                                                                                                                                                                                                                                                                                                                                                                                        | [FLyraQuickBarActiveIndexChangedMessage] | 武器のアクティブスロットの変更                                                     |
| `Lyra.Inventory.Message.StackChanged`                                                                                                                                                                       | [FLyraInventoryList]                                                                                                                                   | `W_InventoryGrid` (`UUserWidget`)<br>`W_ItemAcquiredList` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                     | [FLyraInventoryChangeMessage]            | インベントリの変更                                                                 |
| `Lyra.Damage.Message`                                                                                                                                                                                       | [ULyraHealthSet]                                                                                                                                       | [ULyraDamageLogDebuggerComponent]<br>[UAssistProcessor]                                                                                                                                                                                                                                                                                                                                                                                                                                       | [FLyraVerbMessage]                       | ヘルスの減少                                                                       |
| `Lyra.Elimination.Message`                                                                                                                                                                                  | [ULyraHealthComponent]<br>`B_EliminationFeedRelay` ([UGameplayMessageProcessor])<br>by [ALyraGameState::MulticastReliableMessageToClients()]           | [UAssistProcessor]<br>[UElimChainProcessor]<br>[UElimStreakProcessor]<br>[UGameplayMessageProcessor]<br>`B_MusicManagerComponent_Base` (`UActorComponent`)<br>`W_Reticle_Shotgun` ([ULyraReticleWidgetBase])<br>`W_Reticle_Rifle` ([ULyraReticleWidgetBase])<br>`W_Reticle_Pistol` ([ULyraReticleWidgetBase])<br>`B_ShooterGameScoring_Base` (`UGameStateComponent`)<br>`B_TopDownArena_GameComponent_Base` (`UGameStateComponent`)<br>`B_EliminationFeedRelay` ([UGameplayMessageProcessor]) | [FLyraVerbMessage]                       | ヘルスがなくなった                                                                 |
| `Lyra.Assist.Message`                                                                                                                                                                                       | [UAssistProcessor]                                                                                                                                     | `B_ShooterGameScoring_Base` (`UGameStateComponent`)<br>`B_TopDownArena_GameComponent_Base` (`UGameStateComponent`)                                                                                                                                                                                                                                                                                                                                                                            | [FLyraVerbMessage]                       | キルのアシストをした                                                               |
| `Lyra.AddNotification.Message`                                                                                                                                                                              | `B_AccoladeRelay` ([UGameplayMessageProcessor])                                                                                                        | [ULyraAccoladeHostWidget]                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [FLyraNotificationMessage]               | 称賛情報（表示用）                                                                 |
| `Lyra.AddNotification.KillFeed`                                                                                                                                                                             | `B_EliminationFeedRelay` ([UGameplayMessageProcessor])                                                                                                 | `W_EliminationFeed` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `EliminationFeedMessage`                 | フィード情報                                                                       |
| `Lyra.ShooterGame.Accolade`                                                                                                                                                                                 |                                                                                                                                                        | `B_AccoladeRelay` ([UGameplayMessageProcessor])<br>（`Lyra.ShooterGame.Accolade.*` をまとめて処理している）                                                                                                                                                                                                                                                                                                                                                                                   | [FLyraVerbMessage]                       | 称賛情報                                                                           |
| `Lyra.ShooterGame.Accolade.EliminationChain.2x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.3x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.4x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.5x`    | `B_ElimChainProcessor` ([UElimChainProcessor])<br>`B_AccoladeRelay` ([UGameplayMessageProcessor])<br>by [ALyraPlayerState::ClientBroadcastMessage()]   | `B_AccoladeRelay` ([UGameplayMessageProcessor])                                                                                                                                                                                                                                                                                                                                                                                                                                               | [FLyraVerbMessage]                       | 称賛情報（連鎖排除）<br> `5x` は送信されていない。                                 |
| `Lyra.ShooterGame.Accolade.EliminationStreak.5`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.10`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.15`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.20` | `B_ElimStreakProcessor` ([UElimStreakProcessor])<br>`B_AccoladeRelay` ([UGameplayMessageProcessor])<br>by [ALyraPlayerState::ClientBroadcastMessage()] | `B_AccoladeRelay` ([UGameplayMessageProcessor])                                                                                                                                                                                                                                                                                                                                                                                                                                               | [FLyraVerbMessage]                       | 称賛情報（連続排除）                                                               |
| `Lyra.Damage.Taken.Message`                                                                                                                                                                                 | `GCNL_Character_DamageTaken` ([AGameplayCueNotify_BurstLatent])                                                                                        | `B_MusicManagerComponent_Base` (`UActorComponent`)                                                                                                                                                                                                                                                                                                                                                                                                                                            | [FLyraVerbMessage]                       | 被ダメージ情報（ボリューム調整用）                                                 |
| `ShooterGame.GamePhase.MatchBeginCountdown`                                                                                                                                                                 | `Phase_Warmup` ([ULyraGamePhaseAbility])<br>by [ALyraGameState::MulticastMessageToClients()]<br>by [UGameplayMessageSubsystem::BroadcastMessage()]     | `W_WaitingForPlayers_Message` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                 | [FLyraVerbMessage]                       | `ShooterCore` のゲームフェーズ<br>`Warmup` でのカウントダウン通知                  |
| `ShooterGame.ControlPoint.Captured.Message`                                                                                                                                                                 | `B_ControlPointVolume` (`AActor`)                                                                                                                      | `B_MusicManagerComponent_ControlPoint` (`B_MusicManagerComponent_Base`)                                                                                                                                                                                                                                                                                                                                                                                                                       | [FLyraControlPointStatusMessage]         | キャプチャーしたチーム情報                                                         |

`Lyra.ShooterGame.Accolade.*` の処理の流れは大まかに以下のような形。  
![](images/AccoladeMessageSequence.png)

### UGameplayMessageSubsystem::BroadcastMessage()

* 概要
	* 指定されたチャンネルでメッセージをブロードキャストで送る。
	* 以下の RPC 関数経由でも呼び出されている。
		* [ALyraGameState::MulticastMessageToClients()]
		* [ALyraGameState::MulticastReliableMessageToClients()]
		* [ALyraPlayerState::ClientBroadcastMessage()]
	* [FLyraVerbMessageReplication] からも呼び出されている。

## UAsyncAction_ListenForGameplayMessage

# GameplayMessage Processor 関連（ Lyra 側）

## UGameplayMessageProcessor

> Base class for any message processor which observes other gameplay messages and potentially re-emits updates  
> (e.g., when a chain or combo is detected)  
>  
> Note that these processors are spawned on the server once (not per player)  
> and should do their own internal filtering if only relevant for some players.  
> 
> ----
> 他のゲームプレイメッセージを監視し、更新を再送信する可能性のあるメッセージプロセッサの基本クラス  
> （例：チェーンやコンボが検出されたときなど）。 
>  
> これらのプロセッサはサーバー上で一度生成され（プレイヤー毎ではありません）、
> 一部のプレイヤーにのみ関連する場合は、独自の内部フィルタリングを行うべきであることに注意してください。 

* 概要
	* [UGameplayMessageSubsystem] への登録・解除のための機能を実装した、 [UGameplayMessageSubsystem] を利用したメッセージのリッスンを行うための基底クラス。
		* あくまで [UGameplayMessageSubsystem] の機能を利用しているだけなので、このクラスを派生することは必須ではない。
		* たとえば [ULyraAccoladeHostWidget] 等の widget は自前で [UGameplayMessageSubsystem] の機能を利用してメッセージをリッスンしている。
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet]) などから `AGameStateBase` 派生クラスに追加される。
	* この派生クラスは主に [UGameFeatureAction_AddComponents] によって追加される。


## UElimChainProcessor

> Tracks a chain of eliminations (X eliminations without more than Y seconds passing between each one)  
> 
> ----
> 排除の連鎖を追跡する（各排除の間にY秒以上経過することなくX回の排除を行う）。  

* 概要
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet]) などから `AGameStateBase` 派生クラスにサーバー側にだけ追加される。
	* Elimination/ControlPoint の際、敵の連鎖撃破を追跡するクラス。


## UElimStreakProcessor

> Tracks a streak of eliminations (X eliminations without being eliminated)  
> 
> ----
> 連続排除の記録（排除されずにX回排除）  

* 概要
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet]) などから `AGameStateBase` 派生クラスにサーバー側にだけ追加される。
	* Elimination/ControlPoint の際、敵の連続撃破を追跡するクラス。


## UAssistProcessor

> Tracks assists (dealing damage to another player without finishing them)  
> 
> ----
> アシストを追跡する（他のプレイヤーにダメージを与え、フィニッシュしない）。  

* 概要
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet]) などから `AGameStateBase` 派生クラスにサーバー側にだけ追加される。
	* Elimination/ControlPoint の際、撃破のアシストを追跡するクラス。


# GameplayMessage MessageStruct 関連（ Lyra 側）

## FLyraControlPointStatusMessage

> Message indicating the state of a control point is changing  
> 
> ----

* [UGameplayMessageProcessor] で送信する構造体。
* `ControlPoint` で拠点をキャプチャーしたチームの情報を示す。

## FLyraInteractionDurationMessage


* 概要
	* [UGameplayMessageProcessor] で送信する構造体。
	* 期間を示す。

## FLyraNotificationMessage

> A message destined for a transient log (e.g., an elimination feed or inventory pickup stream)  
> 
> ----
> 一時的なログ（エリミネーションフィードやインベントリーピックアップストリームなど）を宛先とするメッセージ  

* 概要
	* [UGameplayMessageProcessor] で送信する構造体。
	* 称賛情報を示す。

### FLyraNotificationMessage::PayloadTag

> Extra payload specific to the target channel (e.g., a style or definition asset)  
> 
> ----
> ターゲットチャンネルに固有の追加ペイロード（例：スタイルや定義アセットなど）  

* 称賛情報の場合は以下が設定される。
	* `B_ElimChainProcessor` ([UElimChainProcessor])
		* `Lyra.ShooterGame.Accolade.EliminationChain.2x`
		* `Lyra.ShooterGame.Accolade.EliminationChain.3x`
		* `Lyra.ShooterGame.Accolade.EliminationChain.4x`
		* `Lyra.ShooterGame.Accolade.EliminationChain.5x`
	* `B_ElimStreakProcessor` ([UElimStreakProcessor])
		* `Lyra.ShooterGame.Accolade.EliminationStreak.5`
		* `Lyra.ShooterGame.Accolade.EliminationStreak.10`
		* `Lyra.ShooterGame.Accolade.EliminationStreak.15`
		* `Lyra.ShooterGame.Accolade.EliminationStreak.20`

## FLyraQuickBarActiveIndexChangedMessage

* [UGameplayMessageProcessor] で送信する構造体。
* 武器のアクティブスロットの変更

## FLyraQuickBarSlotsChangedMessage

* [UGameplayMessageProcessor] で送信する構造体。
* 武器のスロット内容の変更

## FLyraInventoryChangeMessage

> A message when an item is added to the inventory  
> 
> ----

* [UGameplayMessageProcessor] で送信する構造体。
* インベントリのアイテム変更

## FLyraPlayerResetMessage

* [UGameplayMessageProcessor] で送信する構造体。
* プレイヤーリセットの発生

## FLyraAbilitySimpleFailureMessage

* [UGameplayMessageProcessor] で送信する構造体。
* アビリティのアクティブ化の失敗の原因

## FLyraAbilityMontageFailureMessage

* [UGameplayMessageProcessor] で送信する構造体。
* アビリティのアクティブ化の失敗の原因（とその際に利用可能なモンタージュの情報）


## FLyraVerbMessage

> Represents a generic message of the form Instigator Verb Target (in Context, with Magnitude)  
> 
> ----
> Instigator Verb Target (in Context, with Magnitude) という形式の汎用メッセージを表す。  

* 概要
	* Instigator や Target や Magnitude 等を送る、汎用的なメッセージ。

## FLyraVerbMessageReplication

> Container of verb messages to replicate  
> 
> ----
> 複製する verb メッセージのコンテナ  

* 概要
	* [FLyraVerbMessage] をまとめてレプリケーションするためのクラス。
	* 現状では利用されていない？


# GameplayMessage Accolade 関連（ Lyra 側）

## FLyraAccoladeDefinitionRow

* 称賛で使用するデータアセットの定義用。

## ULyraAccoladeHostWidget

* 称賛情報を表示するための widget 。
* [UGameplayMessageSubsystem] を利用し、称賛情報を含んだメッセージ ([FLyraNotificationMessage]) の受信を待つ。
* 受信をしたら、関連付けられたデータをロードし、称賛の通知するアイコンの表示やサウンドの再生等をする。
	* データのロードは [UDataRegistrySubsystem] を利用する。
		* その際、 `RegistryType` に `Accolades` を、`ItemName` に [FLyraNotificationMessage::PayloadTag] を指定する。
			* [FLyraNotificationMessage::PayloadTag] には `Lyra.ShooterGame.*` が設定されている。
			* これは `B_AccoladeRelay` ([UGameplayMessageProcessor]) で指定されている。
		* ロードされるのは [FLyraAccoladeDefinitionRow] である。
			* `DT_BasicShooterAccolades` / `AccoladeDataRegistry` ([FLyraAccoladeDefinitionRow]) で定義している。
			* ここで定義している RowName は [FLyraNotificationMessage::PayloadTag] と同じにしている。
			* そうすることで、 [UGameplayMessageSubsystem] で受信した名前をそのまま [UDataRegistrySubsystem] で利用している。
	* [UDataRegistrySubsystem] への登録方法
		* `ShooterCore` [UGameFeatureData] の設定経由で行っている。
		* [UGameFeatureData::Actions] で [UGameFeatureAction_DataRegistry] のパラメータに `AccoladeDataRegistry` を設定している。
		* そうすることで、フィーチャーの適用時に `AccoladeDataRegistry` が [UDataRegistrySubsystem] に登録される。
* データレジストリに関しては以下を参照。
	[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]


### ULyraAccoladeHostWidget::OnNotificationMessage()

























# Lyra インベントリ関連

## FLyraInventoryList

> List of inventory items  
> 
> ----

* インベントリアイテムのリスト。


## ULyraInventoryManagerComponent

> Manages an inventory  
> 
> ----

* TODO: インベントリの管理クラス？要確認。

# Lyra Weapon 関連

## ULyraWeaponStateComponent

> Tracks weapon state and recent confirmed hit markers to display on screen  
> 
> ----


# Lyra キャラクター設定関連


## ULyraPawnData

> Non-mutable data asset that contains properties used to define a pawn.  
> 
> ----
> ポーンを定義するために使用されるプロパティを含む、変更不可のデータアセットです。  

* 所有者 は [ALyraGameState]
	* エクスペリエンスのロード時に [ALyraGameState] に追加された [ULyraExperienceManagerComponent] のメンバ [ULyraExperienceDefinition] に設定される。
* キャッシュ
	* エクスペリエンスのロード後、 [ALyraPlayerState] に渡し、キャッシュをもたせる。
	* ポーンのスポーン時に [ALyraGameMode] にて [ULyraPawnExtensionComponent] に渡し、キャッシュをもたせる。

処理の流れは大まかに以下のようになっている。

![](images/ULyraPawnData_Lifetime.png)


### ULyraPawnData::InputConfig
### ULyraPawnData::TagRelationshipMapping
### ULyraPawnData::DefaultCameraMode
### ULyraPawnData::AbilitySets


# Lyra widget 関連


## ULyraReticleWidgetBase

* レティクル用 widget の基底クラス。
* 派生クラスは以下の通り。
	* `W_AmmoCounter_Pistol`
	* `W_AmmoCounter_Rifle`
	* `W_AmmoCounter_Shotgun`
	* `W_Reticle_AmmoBar`
	* `W_Reticle_Pistol`
	* `W_Reticle_Rifle`
	* `W_Reticle_Shotgun`
	* `W_Temp_ReticleDot`
	* `W_DebugWeaponSpreadWidget`

## ULyraTaggedWidget

> An widget in a layout that has been tagged (can be hidden or shown via tags on the owning player)  
> 
> ----
> タグ付けされたレイアウトのウィジェット（所有するプレーヤーのタグで非表示または表示可能）。  

> @TODO: The other TODOs in this file are all related to tag-based showing/hiding of widgets, see UE-142237  
> @TODO: このファイルの他の TODO は、すべてタグベースのウィジェットの表示/非表示に関連するもので、UE-142237 を参照してください。  

[Unreal Engine Issues > UE-142237] が見つからないため、詳細は不明ですが、この機能は実装されていません。

* 派生クラスは以下の通り。
	* `W_AbilityFailureFeedback`
	* `W_AbilityProgress`
	* `W_ControlPointStatusWidget`
	* `W_CPSourceWidget`
	* `W_QuickBar`
	* `W_QuickBarSlot`
	* `W_RoundTimer`
	* `W_ScoreWidget_Elimination`
	* `W_WeaponAmmoAndName`

## UCommonActivatableWidget

> The base for widgets that are capable of being "activated" and "deactivated" during their lifetime without being otherwise modified or destroyed. 
>
> This is generally desired for one or more of the following purposes:
>	- This widget can turn on/off without being removed from the hierarchy (or otherwise reconstructing the underlying SWidgets), so Construct/Destruct are insufficient
>	- You'd like to be able to "go back" from this widget, whether that means back a breadcrumb, closing a modal, or something else. This is built-in here.
>	- This widget's place in the hierarchy is such that it defines a meaningful node-point in the tree of activatable widgets through which input is routed to all widgets.
>
> By default, an activatable widget:
>	- Is not automatically activated upon construction
>	- Does not register to receive back actions (or any other actions, for that matter)
>	- If classified as a back handler, is automatically deactivated (but not destroyed) when it receives a back action
> 
> Note that removing an activatable widget from the UI (i.e. triggering Destruct()) will always deactivate it, even if the UWidget is not destroyed.
> Re-constructing the underlying SWidget will only result in re-activation if auto-activate is enabled.
>
> TODO: ADD MORE INFO ON INPUTS

## ULyraActivatableWidget

> An activatable widget that automatically drives the desired input config when activated

## ULyraHUDLayout

> Widget used to lay out the player's HUD (typically specified by an Add Widgets action in the experience)

## ULyraWeaponUserInterface

## ULyraPerfStatContainerBase

> Panel that contains a set of ULyraPerfStatWidgetBase widgets and manages
> their visibility based on user settings.

## ULyraSimulatedInputWidget

> A UMG widget with base functionality to inject input (keys or input actions) to the enhanced input subsystem.

## ULyraJoystickWidget

> This will calculate a 2D vector clamped between -1 and 1
> to input as a key value to the player, simulating a gamepad analog stick.
>
> This is intended for use with and Enhanced Input player.


## ULyraTouchRegion

> A "Touch Region" is used to define an area on the screen that should trigger some input when the user presses a finger on it




# Lyra その他

## ALyraCharacter
> The base character pawn class used by this project.  
> Responsible for sending events to pawn components.  
> New behavior should be added via pawn components when possible.  
> 
> ----
> このプロジェクトで使用される基本キャラクターのポーンクラス。  
> ポーンコンポーネントにイベントを送信する責任があります。  
> 可能であれば、ポーンコンポーネントを介して新しい動作を追加する必要があります。  

* キャラクターの基底クラス。
* 詳しい説明は割愛。

* [ULyraPawnExtensionComponent] を追加している。
	* アビリティシステムに関するアクセサと、コンポーネントの初期化周りの関数を呼び出している。


## ALyraPlayerController

> The base player controller class used by this project.  
> 
> ----


## ALyraGameMode

> The base game mode class used by this project.  
> 
> ----

### ALyraGameMode::InitGame()

> Initialize the game.
> The GameMode's InitGame() event is called before any other functions (including PreInitializeComponents() )
> and is used by the GameMode to initialize parameters and spawn its helper classes.
> @warning: this is called before actors' PreInitializeComponents.
> 
> ----
> ゲームを初期化する。
> GameMode の InitGame() イベントは他の関数（ PreInitializeComponents() を含む）の前に呼ばれ、 GameMode によってパラメータを初期化し、
> そのヘルパークラスを起動するために使用される。
> 警告: これはアクターのPreInitializeComponentsの前に呼び出される。

* 概要
	* マップのロード時などに呼び出される。
	* `SetTimerForNextTick()` に [ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()] を登録し、次のフレームに呼び出している。
		* 以下のようなコメントがあるので、`SetTimerForNextTick()` を経由しているのは PIE で動作させるためらしい。
			> Eventually only do this for PIE/auto
			> 
			> ----
			> いずれはPIE/autoのみ行う。


### ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()

> Precedence order (highest wins)
>  - Matchmaking assignment (if present)
>  - URL Options override
>  - Developer Settings (PIE only)
>  - Command Line override
>  - World Settings
>  - Default experience
> 
> ----
> 優先順位
>  ※以下、原文のままなので略

* 概要
	* 引用したコメントに記載された優先順位に従い、使用するエクスペリエンスを決め、ロードする。

### ALyraGameMode::GetPawnDataForController()


## ALyraGameState

* TODO: ソースを見て追記事項があれば。
* TODO: 特に以下。
	> Ability System Component をアビリティとして実装された Game Phase (ゲーム フェーズ) とともに使用します。  
	> これらの Game Phase はアクティブ/非アクティブ化され、ゲームプレイ イベントを処理する方法に影響を及ぼします。  
	> たとえば、ShooterCore は次のフェーズを実装します。  
* [ULyraAbilitySystemComponent] を追加しています。
* GameState であり、 ASC を追加しています。
* また、その ASC は

### ALyraGameState::MulticastMessageToClients()

> Send a message that all clients will (probably) get  
> (use only for client notifications like eliminations, server join messages, etc... that can handle being lost)  
> 
> ----
> すべてのクライアントが（おそらく）受け取ることになるメッセージを送る  
> (削除、サーバ参加メッセージなど、紛失しても大丈夫なクライアントからの通知にのみ使用します)  

* 以下で呼び出されている。
	* `Phase_Warmup`
* この呼び出しは `Phase_Warmup` が `GameState` に付与されるアビリティのため、サーバーのみで動作するため、


### ALyraGameState::MulticastReliableMessageToClients()

> Send a message that all clients will be guaranteed to get  
> (use only for client notifications that cannot handle being lost)  
> 
> ----
> すべてのクライアントが確実に受け取ることができるメッセージを送信する  
> (紛失に耐えられないクライアントへの通知のみに使用)  

* 以下で呼び出されている。
	* `GA_Auto_Respawn`
	* `B_EliminationFeedRelay`
* どちらの呼び出しも `HasAuthority` により、サーバーのみで呼び出す様にしている。



## ALyraPlayerState

> Base player state class used by this project.  
> 
> ----
> このプロジェクトで使用されるベースプレーヤーステートクラス。  

[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ フレームワークのクイック リファレンス] より

> PlayerState は、人プレーヤーやプレイヤーをシミュレートしているボットなどの、ゲームの参加者のステートです。  
> ゲームの一部として存在する非プレイヤーの AI は PlayerState を持ちません。  

ShooterGame での敵は上記における「プレイヤーをシミュレートしているボット」扱いです。  
要は [ALyraPlayerState] があります。


----
このへん

----


* [ULyraPawnData] との関係
	* レプリケーション対象のプロパティとしてキャッシュを保持する。
	* [ULyraPawnData::AbilitySets] を元にアビリティの付与を行う。
* [ULyraPawnExtensionComponent] との関係
	* [ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()] を呼び出す。

### ALyraPlayerState::StatTags

* ASC ではなく、このクラスが保持する GameplayTag 。
* プレイヤーに紐づく任意の情報を保持する。
* スコア関連で利用している。例えば以下。
	* `ShooterGame.Score.Eliminations`
	* `ShooterGame.Score.Assists`
	* `ShooterGame.Score.Deaths`
	* `ShooterGame.Score.ControlPointCapture`
* サーバー側で更新し、クライアントにレプリケーションされる。
* 現状ではイベントドリブンでの実装になっておらず、タイマーで表示に反映させている。
	* 詳しくは **W_SB_PlayerState** の実装を参照。

### ALyraPlayerState::OnExperienceLoaded()

* [ULyraExperienceManagerComponent] に登録しているデリゲート用の関数。
* エクスペリエンスのロードが完了した際に呼び出される。
* [ALyraGameMode::GetPawnDataForController()] で [ULyraPawnData] を取得し、 [ALyraPlayerState::SetPawnData()] に渡す。

### ALyraPlayerState::SetPawnData()

* 渡された [ULyraPawnData] をキャッシュとして保持する。
* [ULyraPawnData::AbilitySets] を元に [ULyraAbilitySet::GiveToAbilitySystem()] を呼び出し、アビリティの付与を行う。


### ALyraPlayerState::ClientBroadcastMessage()

> Send a message to just this player  
> (use only for client notifications like accolades, quest toasts, etc... that can handle being occasionally lost)  
> 
> ----
> このプレイヤーにだけメッセージを送る  
> (賞賛、クエストトーストなど、時々失われても大丈夫なクライアント通知のみに使用する)  

* 以下で呼び出されている。
	* `B_AccoladeRelay` ([UGameplayMessageProcessor])
* この呼び出しは `HasAuthority` により、サーバーのみで呼び出す様にしている。

## ALyraWeaponSpawner

* 武器などのスポーン用アクター



## ULyraCameraMode

> Base class for all camera modes.  
> 
> ----

* カメラの設定用クラス。

## ULyraCheatManager

> Base cheat manager class used by this project.  
> 
> ----


## ULyraSettingsLocal

* ゲームオプションの設定内容を保持する。
* キーバインドなどもここから参照される。


## ULyraDamageLogDebuggerComponent

## ULyraEquipmentManagerComponent

> Manages equipment applied to a pawn
> 
> ----


## ULyraIndicatorManagerComponent



## ULyraQuickBarComponent

* `LAS_ShooterGame_StandardComponents` ([ULyraExperienceActionSet])
	* `Controller` に対して `AddComponent` するように設定されている。
* その他、誰が持っている？
* 派生クラス
	* `B_QuickBarComponent` ([ULyraQuickBarComponent])


## ULyraBotCreationComponent

## UAimAssistTargetManagerComponent

> The Aim Assist Target Manager Component is used to gather all aim assist targets that are within  
> a given player's view. Targets must implement the IAimAssistTargetInterface and be on the  
> collision channel that is set in the ShooterCoreRuntimeSettings.   
> 
> ----



## ULyraNumberPopComponent

* UControllerComponent
	* ULyraNumberPopComponent


## ULyraNumberPopComponent_NiagaraText

* UControllerComponent
	* ULyraNumberPopComponent
		* ULyraNumberPopComponent_NiagaraText


## ULyraFrontendStateComponent

* UGameStateComponent
	* ULyraFrontendStateComponent
* Interface
	* ILoadingProcessInterface

## ULyraTeamCreationComponent

* UGameStateComponent
	* ULyraTeamCreationComponent


## ULyraPlayerSpawningManagerComponent

* UGameStateComponent
	* ULyraPlayerSpawningManagerComponent


## UTDM_PlayerSpawningManagmentComponent

* UGameStateComponent
	* ULyraPlayerSpawningManagerComponent
		* UTDM_PlayerSpawningManagmentComponent

## ULyraControllerComponent_CharacterParts

> A component that configure what cosmetic actors to spawn for the owning controller when it possesses a pawn  
> 
> ----

* UControllerComponent
	* ULyraControllerComponent_CharacterParts


# 終わりに

> TODO:なんかかく。


-----
おしまい。

<!--- ページ内のリンク --->
[UOnlineHotfixManager]: #uonlinehotfixmanager
[ULyraHotfixManager]: #ulyrahotfixmanager
[UDataRegistrySubsystem]: #udataregistrysubsystem
[UDataRegistrySubsystem::AcquireItem()]: #udataregistrysubsystemacquireitem
[FPrimaryAssetTypeInfo]: #fprimaryassettypeinfo
[IGameFeatureStateChangeObserver]: #igamefeaturestatechangeobserver
[UGameFeaturesProjectPolicies]: #ugamefeaturesprojectpolicies
[UDefaultGameFeaturesProjectPolicies]: #udefaultgamefeaturesprojectpolicies
[UGameFeatureAction]: #ugamefeatureaction
[UGameFeatureAction_DataRegistry]: #ugamefeatureaction_dataregistry
[UGameFeatureAction_AddComponents]: #ugamefeatureaction_addcomponents
[UGameFeatureData]: #ugamefeaturedata
[UGameFeatureData::Actions]: #ugamefeaturedataactions
[UGameFeatureData::PrimaryAssetTypesToScan]: #ugamefeaturedataprimaryassettypestoscan
[UGameFeaturesSubsystem]: #ugamefeaturessubsystem
[UGameFeaturesSubsystem::AddObserver()]: #ugamefeaturessubsystemaddobserver
[ULyraGameFeaturePolicy]: #ulyragamefeaturepolicy
[FMappableConfigPair]: #fmappableconfigpair
[UGameFeatureAction_WorldActionBase]: #ugamefeatureaction_worldactionbase
[UGameFeatureAction_AddInputBinding]: #ugamefeatureaction_addinputbinding
[UGameFeatureAction_AddInputContextMapping]: #ugamefeatureaction_addinputcontextmapping
[UGameFeatureAction_SplitscreenConfig]: #ugamefeatureaction_splitscreenconfig
[UGameFeatureAction_AddAbilities]: #ugamefeatureaction_addabilities
[UGameFeatureAction_AddInputConfig]: #ugamefeatureaction_addinputconfig
[UGameFeatureAction_AddWidgets]: #ugamefeatureaction_addwidgets
[UGameFeatureAction_AddGameplayCuePath]: #ugamefeatureaction_addgameplaycuepath
[UApplyFrontendPerfSettingsAction]: #uapplyfrontendperfsettingsaction
[ULyraGameFeature_HotfixManager]: #ulyragamefeature_hotfixmanager
[ULyraGameFeature_AddGameplayCuePaths]: #ulyragamefeature_addgameplaycuepaths
[ALyraWorldSettings]: #alyraworldsettings
[ULyraExperienceActionSet]: #ulyraexperienceactionset
[ULyraExperienceActionSet::Actions]: #ulyraexperienceactionsetactions
[ULyraExperienceDefinition]: #ulyraexperiencedefinition
[ULyraExperienceDefinition::Actions]: #ulyraexperiencedefinitionactions
[ULyraExperienceDefinition::ActionSets]: #ulyraexperiencedefinitionactionsets
[ULyraExperienceManagerComponent]: #ulyraexperiencemanagercomponent
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()]: #ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_highpriority
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()]: #ulyraexperiencemanagercomponentcallorregister_onexperienceloaded
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()]: #ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_lowpriority
[UAsyncAction_ExperienceReady]: #uasyncaction_experienceready
[UInputMappingContext]: #uinputmappingcontext
[UPlayerMappableInputConfig]: #uplayermappableinputconfig
[ULyraInputConfig]: #ulyrainputconfig
[UGameplayCueManager]: #ugameplaycuemanager
[ULyraGameplayCueManager]: #ulyragameplaycuemanager
[AGameplayCueNotify_BurstLatent]: #agameplaycuenotify_burstlatent
[UGameplayAbility]: #ugameplayability
[UGameplayAbility::MakeOutgoingGameplayEffectSpec()]: #ugameplayabilitymakeoutgoinggameplayeffectspec
[UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]: #ugameplayabilityapplyabilitytagstogameplayeffectspec
[FGameplayAbilitySpec]: #fgameplayabilityspec
[FGameplayAbilitySpec::DynamicAbilityTags]: #fgameplayabilityspecdynamicabilitytags
[FGameplayEffectSpec]: #fgameplayeffectspec
[FGameplayEffectSpec::CapturedSourceTags]: #fgameplayeffectspeccapturedsourcetags
[ULyraGlobalAbilitySystem]: #ulyraglobalabilitysystem
[ULyraAbilitySystemComponent]: #ulyraabilitysystemcomponent
[ULyraAbilitySystemComponent::SetTagRelationshipMapping()]: #ulyraabilitysystemcomponentsettagrelationshipmapping
[ULyraGameplayAbility]: #ulyragameplayability
[ULyraGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]: #ulyragameplayabilityapplyabilitytagstogameplayeffectspec
[ILyraReadyInterface]: #ilyrareadyinterface
[ILyraReadyInterface::IsPawnComponentReadyToInitialize()]: #ilyrareadyinterfaceispawncomponentreadytoinitialize
[ULyraPawnComponent]: #ulyrapawncomponent
[ULyraPawnExtensionComponent]: #ulyrapawnextensioncomponent
[ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]: #ulyrapawnextensioncomponentcheckpawnreadytoinitialize
[ULyraPawnExtensionComponent::PawnData]: #ulyrapawnextensioncomponentpawndata
[ULyraPawnExtensionComponent::GetPawnData()]: #ulyrapawnextensioncomponentgetpawndata
[ULyraPawnExtensionComponent::SetPawnData()]: #ulyrapawnextensioncomponentsetpawndata
[ULyraPawnExtensionComponent::AbilitySystemComponent]: #ulyrapawnextensioncomponentabilitysystemcomponent
[ULyraPawnExtensionComponent::GetLyraAbilitySystemComponent()]: #ulyrapawnextensioncomponentgetlyraabilitysystemcomponent
[ULyraPawnExtensionComponent::InitializeAbilitySystem()]: #ulyrapawnextensioncomponentinitializeabilitysystem
[ULyraPawnExtensionComponent::UninitializeAbilitySystem()]: #ulyrapawnextensioncomponentuninitializeabilitysystem
[ULyraHeroComponent]: #ulyraherocomponent
[ULyraHeroComponent::DefaultInputConfigs]: #ulyraherocomponentdefaultinputconfigs
[ULyraHeroComponent::IsPawnComponentReadyToInitialize()]: #ulyraherocomponentispawncomponentreadytoinitialize
[ULyraHeroComponent::OnPawnReadyToInitialize()]: #ulyraherocomponentonpawnreadytoinitialize
[ULyraHeroComponent::InitializePlayerInput()]: #ulyraherocomponentinitializeplayerinput
[ULyraHeroComponent::DetermineCameraMode()]: #ulyraherocomponentdeterminecameramode
[ULyraAbilitySet]: #ulyraabilityset
[ULyraAbilitySet::GiveToAbilitySystem()]: #ulyraabilitysetgivetoabilitysystem
[ULyraAbilityTagRelationshipMapping]: #ulyraabilitytagrelationshipmapping
[ULyraGameplayAbility_FromEquipment]: #ulyragameplayability_fromequipment
[ULyraGameplayAbility_RangedWeapon]: #ulyragameplayability_rangedweapon
[ULyraGameplayAbility_Reset]: #ulyragameplayability_reset
[ULyraGameplayAbility_Death]: #ulyragameplayability_death
[ULyraGameplayAbility_Interact]: #ulyragameplayability_interact
[ULyraGameplayAbility_Jump]: #ulyragameplayability_jump
[ULyraGamePhaseAbility]: #ulyragamephaseability
[ULyraAttributeSet]: #ulyraattributeset
[ULyraHealthSet]: #ulyrahealthset
[ULyraHealthSet::Health]: #ulyrahealthsethealth
[ULyraHealthSet::MaxHealth]: #ulyrahealthsetmaxhealth
[ULyraHealthSet::Healing]: #ulyrahealthsethealing
[ULyraHealthSet::Damage]: #ulyrahealthsetdamage
[ULyraHealthComponent]: #ulyrahealthcomponent
[UGameplayMessageSubsystem]: #ugameplaymessagesubsystem
[UGameplayMessageSubsystem::BroadcastMessage()]: #ugameplaymessagesubsystembroadcastmessage
[UAsyncAction_ListenForGameplayMessage]: #uasyncaction_listenforgameplaymessage
[UGameplayMessageProcessor]: #ugameplaymessageprocessor
[UElimChainProcessor]: #uelimchainprocessor
[UElimStreakProcessor]: #uelimstreakprocessor
[UAssistProcessor]: #uassistprocessor
[FLyraControlPointStatusMessage]: #flyracontrolpointstatusmessage
[FLyraInteractionDurationMessage]: #flyrainteractiondurationmessage
[FLyraNotificationMessage]: #flyranotificationmessage
[FLyraNotificationMessage::PayloadTag]: #flyranotificationmessagepayloadtag
[FLyraQuickBarActiveIndexChangedMessage]: #flyraquickbaractiveindexchangedmessage
[FLyraQuickBarSlotsChangedMessage]: #flyraquickbarslotschangedmessage
[FLyraInventoryChangeMessage]: #flyrainventorychangemessage
[FLyraPlayerResetMessage]: #flyraplayerresetmessage
[FLyraAbilitySimpleFailureMessage]: #flyraabilitysimplefailuremessage
[FLyraAbilityMontageFailureMessage]: #flyraabilitymontagefailuremessage
[FLyraVerbMessage]: #flyraverbmessage
[FLyraVerbMessageReplication]: #flyraverbmessagereplication
[FLyraAccoladeDefinitionRow]: #flyraaccoladedefinitionrow
[ULyraAccoladeHostWidget]: #ulyraaccoladehostwidget
[ULyraAccoladeHostWidget::OnNotificationMessage()]: #ulyraaccoladehostwidgetonnotificationmessage
[FLyraInventoryList]: #flyrainventorylist
[ULyraInventoryManagerComponent]: #ulyrainventorymanagercomponent
[ULyraWeaponStateComponent]: #ulyraweaponstatecomponent
[ULyraPawnData]: #ulyrapawndata
[ULyraPawnData::InputConfig]: #ulyrapawndatainputconfig
[ULyraPawnData::TagRelationshipMapping]: #ulyrapawndatatagrelationshipmapping
[ULyraPawnData::DefaultCameraMode]: #ulyrapawndatadefaultcameramode
[ULyraPawnData::AbilitySets]: #ulyrapawndataabilitysets
[ULyraReticleWidgetBase]: #ulyrareticlewidgetbase
[ULyraTaggedWidget]: #ulyrataggedwidget
[UCommonActivatableWidget]: #ucommonactivatablewidget
[ULyraActivatableWidget]: #ulyraactivatablewidget
[ULyraHUDLayout]: #ulyrahudlayout
[ULyraWeaponUserInterface]: #ulyraweaponuserinterface
[ULyraPerfStatContainerBase]: #ulyraperfstatcontainerbase
[ULyraSimulatedInputWidget]: #ulyrasimulatedinputwidget
[ULyraJoystickWidget]: #ulyrajoystickwidget
[ULyraTouchRegion]: #ulyratouchregion
[ALyraCharacter]: #alyracharacter
[ALyraPlayerController]: #alyraplayercontroller
[ALyraGameMode]: #alyragamemode
[ALyraGameMode::InitGame()]: #alyragamemodeinitgame
[ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]: #alyragamemodehandlematchassignmentifnotexpectingone
[ALyraGameMode::GetPawnDataForController()]: #alyragamemodegetpawndataforcontroller
[ALyraGameState]: #alyragamestate
[ALyraGameState::MulticastMessageToClients()]: #alyragamestatemulticastmessagetoclients
[ALyraGameState::MulticastReliableMessageToClients()]: #alyragamestatemulticastreliablemessagetoclients
[ALyraPlayerState]: #alyraplayerstate
[ALyraPlayerState::StatTags]: #alyraplayerstatestattags
[ALyraPlayerState::OnExperienceLoaded()]: #alyraplayerstateonexperienceloaded
[ALyraPlayerState::SetPawnData()]: #alyraplayerstatesetpawndata
[ALyraPlayerState::ClientBroadcastMessage()]: #alyraplayerstateclientbroadcastmessage
[ALyraWeaponSpawner]: #alyraweaponspawner
[ULyraCameraMode]: #ulyracameramode
[ULyraCheatManager]: #ulyracheatmanager
[ULyraSettingsLocal]: #ulyrasettingslocal
[ULyraDamageLogDebuggerComponent]: #ulyradamagelogdebuggercomponent
[ULyraEquipmentManagerComponent]: #ulyraequipmentmanagercomponent
[ULyraIndicatorManagerComponent]: #ulyraindicatormanagercomponent
[ULyraQuickBarComponent]: #ulyraquickbarcomponent
[ULyraBotCreationComponent]: #ulyrabotcreationcomponent
[UAimAssistTargetManagerComponent]: #uaimassisttargetmanagercomponent
[ULyraNumberPopComponent]: #ulyranumberpopcomponent
[ULyraNumberPopComponent_NiagaraText]: #ulyranumberpopcomponent_niagaratext
[ULyraFrontendStateComponent]: #ulyrafrontendstatecomponent
[ULyraTeamCreationComponent]: #ulyrateamcreationcomponent
[ULyraPlayerSpawningManagerComponent]: #ulyraplayerspawningmanagercomponent
[UTDM_PlayerSpawningManagmentComponent]: #utdm_playerspawningmanagmentcomponent
[ULyraControllerComponent_CharacterParts]: #ulyracontrollercomponent_characterparts

<!--- 関連ドキュメント --->
<!--- qiita
[【UE5】Lyra に学ぶ Enhanced Input]: https://qiita.com/sentyaanko/items/dd4990d4aa0e84478b59
--->
<!--- github --->
[【UE5】Lyra に学ぶ Enhanced Input]: https://github.com/sentyaanko/ReadingLyra/blob/main/InputTag/%E3%80%90UE5%E3%80%91Lyra%20%E3%81%AB%E5%AD%A6%E3%81%B6%20%E5%85%A5%E5%8A%9B%E5%87%A6%E7%90%86%E7%94%A8%20GameplayTag(InputTag).md

<!--- qiita --->
[【UE4】Gameplay Ability System を使い始めたい人向けの情報]: https://qiita.com/sentyaanko/items/314ee39feb62ce67b885

[GASDocumentation(和訳) > 11.1.2 Community Questions]: https://github.com/sentyaanko/GASDocumentation/blob/lang-ja/README.jp.md#resources-daveratti-community2

<!--- 公式：Unreal Engine Issues --->
[Unreal Engine Issues > UE-142237]: https://issues.unrealengine.com/issue/UE-142237

<!--- 公式：5.0/Subsystem --->
[Unreal Engine 5.0 Documentation > プログラミング サブシステム]: https://docs.unrealengine.com/5.0/ja/programming-subsystems/

<!--- 公式：5.0/データ レジストリ --->
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ >  データ レジストリのクイック スタート ガイド]: https://docs.unrealengine.com/5.0/ja/quick-start-guide-for-unreal-engine-data-registries/
[データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/

<!--- 公式：5.0/ゲームプレイフレームワーク --->
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ フレームワークのクイック リファレンス]: https://docs.unrealengine.com/5.0/ja/unreal-engine-gameplay-framework-quick-reference/

<!--- 公式：5.0/GAS --->
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-system-for-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > アビリティ システム コンポーネントと属性]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-system-component-and-gameplay-attributes-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > ゲームプレイ アビリティ]: https://docs.unrealengine.com/5.0/ja/using-gameplay-abilities-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > ゲームプレイ アトリビュートとゲームプレイ エフェクト]: https://docs.unrealengine.com/5.0/ja/gameplay-attributes-and-gameplay-effects-for-the-gameplay-ability-system-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > アビリティ タスク]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-tasks-in-unreal-engine/

<!--- 公式：5.0/Lyra --->
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム (一部日本語準備中)]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム (一部日本語準備中) > Lyra のアビリティ]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム (一部日本語準備中) > Lyra のアニメーション > ゲームプレイ タグ バインディング]: https://docs.unrealengine.com/5.0/ja/animation-in-lyra-sample-game-in-unreal-engine/#%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%97%E3%83%AC%E3%82%A4%E3%82%BF%E3%82%B0%E3%83%90%E3%82%A4%E3%83%B3%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム (一部日本語準備中) > Lyra インタラクション システム]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-interaction-system-in-unreal-engine/
[Unreal Engine 5.0 Documentation > Game Features と Modular Gameplay]: https://docs.unrealengine.com/5.0/ja/game-features-and-modular-gameplay/
[Unreal Engine 5.0 Documentation > プロダクション パイプラインをセットアップする > アセット管理]: https://docs.unrealengine.com/5.0/ja/asset-management-in-unreal-engine/

[Lyra のアビリティ]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/
[Lyra のアビリティ > ALyraPlayerState]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#alyraplayerstate
[Lyra のアビリティ > ULyraGlobalAbilitySystem]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#ulyraglobalabilitysystem




<!--- 公式：5.0/古代の谷 --->
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]: https://docs.unrealengine.com/5.0/ja/valley-of-the-ancient-sample-game-for-unreal-engine/#modulargameplay%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B

<!--- 公式：マーケットプレイス --->
[マーケットプレイス > Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[マーケットプレイス > 古代の谷]: https://www.unrealengine.com/marketplace/en-US/product/ancient-game-01

[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra

<!--- 公式：blog --->
[Modular Game Features in UE5: プラグアンドプレイ、 Unreal な方法で]: https://www.unrealengine.com/ja/blog/modular-game-features-in-ue5-plug-n-play-the-unreal-way

<!--- 公式：youtube --->
[Youtube > Unreal Engine > Modular Game Features | Inside Unreal > 8:10]: https://youtu.be/7F28p564kuY?list=PLZlv_N0_O1gbggHiwNP2JBXGeD2h12tbB&t=490
[Youtube > Unreal Engine > Modular Game Features | Inside Unreal > 40:56]: https://youtu.be/7F28p564kuY?list=PLZlv_N0_O1gbggHiwNP2JBXGeD2h12tbB&t=2456
[Youtube > Unreal Engine > Programming Subsystems | Live from HQ | Inside Unreal]: https://www.youtube.com/watch?v=v5b1FvKBYzc
[Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]: https://www.youtube.com/watch?v=3PBnqC7TxvM

<!--- docswell --->
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2#p54
[ドクセル > 2021/10/2 > 出張ヒストリア！ ゲーム開発勉強会2021 > 目指せ脱UE4初心者！？知ってると開発が楽になる便利機能を紹介 - DataAsset, Subsystem, GameplayAbility編 -]: https://www.docswell.com/s/historia_Inc/5WVYJK-ue4-dataasset-subsystem-gameplayability
[ドクセル > 2021/10/2 > 出張ヒストリア！ ゲーム開発勉強会2021 > 目指せ脱UE4初心者！？知ってると開発が楽になる便利機能を紹介 - DataAsset, Subsystem, GameplayAbility編 - > p46]: https://www.docswell.com/s/historia_Inc/5WVYJK-ue4-dataasset-subsystem-gameplayability#p46
[ドクセル > 2017/11/25 > UE4のモバイル開発におけるコンテンツアップデートの話　- Chunk IDとの激闘編 - > p34]: https://www.docswell.com/s/EpicGamesJapan/5RQMEK-ue4-chunk-id#p34

<!--- Let's Enjoy Unreal Engine --->
[(2021/11/28) Let's Enjoy Unreal Engine > UE5 Game Featuresで簡単に依存関係なしのコンポーネントを作ってみる]: https://unrealengine.hatenablog.com/entry/2021/11/28/111821

<!--- qiita --->
[(2019/08/15) Qiita > 【UE4】 Asset Managerのアセットの非同期ロード機能について その1 ( 非同期ロードの解説 & レベルの裏読み編 )]: https://qiita.com/EGJ-Kaz_Okada/items/f18bca3fb5c8fc1aea9c
[(2019/12/21) Qiita > 【UE4】 Asset Managerのアセットの非同期ロード機能について その2 ( レベルアセット以外の裏読み編 )]: https://qiita.com/EGJ-Kaz_Okada/items/7dba130c3641aa456b73

<!--- historia --->
[(2021/06/18) 【UE5】 プレイヤーの技などをプラグインで実装できる！　GameFeaturesプラグインの紹介]: https://historia.co.jp/archives/21145/


https://argonauts.hatenablog.jp/entry/2021/12/23/083634
