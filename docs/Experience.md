# 【UE5】Lyra に学ぶ基礎 <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
自作のアプリケーションのたたき台としても利用できるこのプロジェクトは UE の様々の機能を利用しています。  
このドキュメントは Lyra のゲームロジックを読み解くに当たって基礎となる機能について解説していきます。  
重点を置いているのはエクスペリエンスと呼ばれる仕組みに関する部分となります。

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
	- [ULyraHeroComponent で設定できる FMappableConfigPair に関して](#ulyraherocomponent-で設定できる-fmappableconfigpair-に関して)
	- [プレイヤーが操作するアクターのについて](#プレイヤーが操作するアクターのについて)
- [クラス解説](#クラス解説)
	- [Inheritance Hierarchy](#inheritance-hierarchy)
	- [機能別](#機能別)
- [おまけ](#おまけ)
- [終わりに](#終わりに)


# Lyra で使用している UE の機能とその拡張

## AssetManager に関して

GameFeature と絡む部分があります。設定方法は知っておくと良いです。

* 既存のドキュメント
	* [ドクセル > 2017/11/25 > UE4のモバイル開発におけるコンテンツアップデートの話　- Chunk IDとの激闘編 - > p34]
		* 設定方法についてわかりやすい解説
	* [Unreal Engine 5.0 Documentation > プロダクション パイプラインをセットアップする > アセット管理]
		* 公式ドキュメント。
	* [Qiita > (2019/08/15) > 【UE4】 Asset Managerのアセットの非同期ロード機能について その1 ( 非同期ロードの解説 & レベルの裏読み編 )]
	* [Qiita > (2019/12/21) > 【UE4】 Asset Managerのアセットの非同期ロード機能について その2 ( レベルアセット以外の裏読み編 )]
		* AssetManager に関するおかずさんの記事。主な話題は非同期ロードに関してなので、参考までに。
	* [historia > (2021/06/18) > 【UE5】 プレイヤーの技などをプラグインで実装できる！　GameFeaturesプラグインの紹介]
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
	* [Let's Enjoy Unreal Engine > (2021/11/28) > UE5 Game Featuresで簡単に依存関係なしのコンポーネントを作ってみる]
		* 使用する際の手順やサンプルがまとめられています。
	* [Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 40:56]
		* Game Feature Module でアビリティの追加を行っている説明
	* [Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]
		* Game Feature Module に関する説明。
	* [ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]
		* Game Features & Modular Gameplay という題で説明があります。
		* 時間が経っている(2022/04/11 現在)ので、ドクセル内のプレゼン資料から公式ドキュメントへのリンクは無くなっているものが多いので注意です。
			* ```https://docs.unrealengine.com/5.0/ja/GameplayFeatures/``` 以下はまるごと無いですし、「Game Features」等でドキュメントを検索してもほとんどデッドリンクです。
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]
		* 古代の谷のドキュメント内での説明。
* 概要
	* 「 GameFutures プラグイン」 と 「 Modular Gameplay プラグイン」 と 「 Modular Gameplay Actors プラグイン」 を利用した、独立した機能を実装する仕組みです。
* UE で用意されているクラス
	| Class                                 | 概要                                                                                                                                                                                                                        | Lyra                                                                                                                  |
	| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
	| [IGameFeatureStateChangeObserver]     | GameFeature 切り替えなどの際の処理をオーバーライドするためのインターフェイス                                                                                                                                                |                                                                                                                       |
	| [UGameFeaturesProjectPolicies]        | GameFeature 挙動を定義するための基底クラス。<br>`Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class` でこの派生クラスを指定する。                                                | [ULyraGameFeaturePolicy] を指定している。                                                                             |
	| [UDefaultGameFeaturesProjectPolicies] | [UGameFeaturesProjectPolicies] 派生クラス。<br>GameFeature のロード時等の挙動のデフォルト実装を定義している。                                                                                                               |                                                                                                                       |
	| [UGameFeatureAction]                  | GameFeature のアクティブ時等に実行されるアクションを定義するための基底クラス。                                                                                                                                              |                                                                                                                       |
	| [UGameFeatureAction_DataRegistry]     | [UGameFeatureAction] 派生クラス。<br>データ レジストリにデータを追加するアクションを定義している。                                                                                                                          |                                                                                                                       |
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
	* [ReadingLyra > 【UE5】Lyra に学ぶ Enhanced Input]
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


## プレイヤーが操作するアクターのについて

Lyra ではプレイヤーが操作するアクターはエクスペリエンスの設定に従うようにように実装されており、レベル毎に異なるアクターが利用可能です。

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > Lyra キャラクターを初期化する方法]
		* キャラクターの初期化フローに関する解説があります。
* 概要
	* プレイヤーが操作するポーンの情報として、ポーンクラス以外に、キャラクターに付与するアビリティ、入力設定などが含まれています。
	* その結果、モジュール式にアビリティや入力設定を割り当てられるようになっています。
* Lyra で実装しているクラス
	* [ULyraPawnData]
		* プレイヤーのポーンに関する設定を保持するデータアセット。
		* 具体的にはポーンクラスと、以下の4つのクラスを保持します。
			* [ULyraAbilitySet]
				* アビリティに関する情報を保持するデータアセット。
				* 具体的には GameplayAbility 、 GameplayEffect 、 AttributeSet を保持します。
			* [ULyraAbilityTagRelationshipMapping]
				* タグリレーションマッピングを保持するデータアセット。
				* 詳しくは後述します。
			* [ULyraInputConfig]
				* InputAction と InputTag を紐づけるためのデータアセット。
				* 詳しくは [ReadingLyra > 【UE5】Lyra に学ぶ Enhanced Input] / [ReadingLyra > 【UE5】Lyra に学ぶ 入力処理用 GameplayTag(InputTag)] を参照してください。
			* [ULyraCameraMode]
				* カメラの設定用のデータ専用ブループリント。
	* [ULyraExperienceDefinition]
		* エクスペリエンスの定義を保持するデータアセット。
		* 利用する [ULyraPawnData] を保持しています。


# クラス解説

ここでは、このドキュメントで触れた Lyra で利用している UE のクラスと、 Lyra で実装しているクラスについてまとめています。

## Inheritance Hierarchy

クラス

* `UObject`
	* `UPrimaryDataAsset`
		* [UGameFeatureData]
		* [ULyraExperienceActionSet]
		* [ULyraExperienceDefinition]
		* [ULyraUserFacingExperienceDefinition]
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
					* [ALyraCharacterWithAbilities]
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
	* `UGameplayEffectCalculation`
		* `UGameplayEffectExecutionCalculation`
			* [ULyraHealExecution]
			* [ULyraDamageExecution]

構造体

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

<!--- TODO: 漏れがないか確認すること --->

## 機能別

* HotfixManager 関連
	* UE
		- [UOnlineHotfixManager]
	* Lyra
		- [ULyraHotfixManager]
* DataRegistry 関連
	* UE
		- [UDataRegistrySubsystem]
			- [UDataRegistrySubsystem::AcquireItem()]
* AssetManager 関連
	* UE
		- [FPrimaryAssetTypeInfo]
* GameFeature 関連
	* UE
		- [IGameFeatureStateChangeObserver]
		- [UGameFeaturesProjectPolicies]
		- [UDefaultGameFeaturesProjectPolicies]
		- [UGameFeatureAction]
		- [UGameFeatureAction_DataRegistry]
		- [UGameFeatureAction_AddComponents]
		- [UGameFeatureData]
			- [UGameFeatureData::Actions]
			- [UGameFeatureData::PrimaryAssetTypesToScan]
		- [UGameFeaturesSubsystem]
			- [UGameFeaturesSubsystem::AddObserver()]
	* Lyra
		- [ULyraGameFeaturePolicy]
		- [FMappableConfigPair]
			- [FMappableConfigPair::Config]
			- [FMappableConfigPair::Type]
			- [FMappableConfigPair::DependentPlatformTraits]
			- [FMappableConfigPair::ExcludedPlatformTraits]
			- [FMappableConfigPair::bShouldActivateAutomatically]
		- [UGameFeatureAction_WorldActionBase]
		- [UGameFeatureAction_AddInputBinding]
		- [UGameFeatureAction_AddInputContextMapping]
		- [UGameFeatureAction_SplitscreenConfig]
		- [UGameFeatureAction_AddAbilities]
		- [UGameFeatureAction_AddInputConfig]
			- [UGameFeatureAction_AddInputConfig::InputConfigs]
		- [UGameFeatureAction_AddWidgets]
		- [UGameFeatureAction_AddGameplayCuePath]
		- [UApplyFrontendPerfSettingsAction]
		- [ULyraGameFeature_HotfixManager]
		- [ULyraGameFeature_AddGameplayCuePaths]
* Experience 関連
	* Lyra
		- [ALyraWorldSettings]
		- [ULyraExperienceActionSet]
			- [ULyraExperienceActionSet::Actions]
		- [ULyraExperienceDefinition]
			- [ULyraExperienceDefinition::DefaultPawnData]
			- [ULyraExperienceDefinition::Actions]
			- [ULyraExperienceDefinition::ActionSets]
		- [ULyraUserFacingExperienceDefinition]
		- [ULyraExperienceManagerComponent]
			- [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()]
			- [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()]
			- [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()]
		- [UAsyncAction_ExperienceReady]
			- [UAsyncAction_ExperienceReady::OnReady]
* Input 関連
	* UE
		- [IEnhancedInputSubsystemInterface]
		- [UEnhancedInputLocalPlayerSubsystem]
		- [UInputAction]
		- [UInputMappingContext]
			- [UInputMappingContext::Mappings]
		- [FEnhancedActionKeyMapping]
			- [FEnhancedActionKeyMapping::Action]
			- [FEnhancedActionKeyMapping::Key]
		- [UPlayerMappableInputConfig]
		- [UPlayerMappableInputConfig::Contexts]
	* Lyra
		- [ULyraInputConfig]
* GameplayCue 関連
	* UE
		- [UGameplayCueManager]
	* Lyra
		- [ULyraGameplayCueManager]
		- [AGameplayCueNotify_BurstLatent]
* GameplayAbility 関連
	* UE
		- [UGameplayAbility]
			- [UGameplayAbility::MakeOutgoingGameplayEffectSpec()]
			- [UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]
		- [FGameplayAbilitySpec]
			- [FGameplayAbilitySpec::DynamicAbilityTags]
		- [FGameplayEffectSpec]
			- [FGameplayEffectSpec::CapturedSourceTags]
	* Lyra
		- [ULyraGlobalAbilitySystem]
		- [ULyraAbilitySystemComponent]
			- [ULyraAbilitySystemComponent::SetTagRelationshipMapping()]
		- [ULyraGameplayAbility]
			- [ULyraGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]
		- [ILyraReadyInterface]
			- [ILyraReadyInterface::IsPawnComponentReadyToInitialize()]
		- [ULyraPawnComponent]
		- [ULyraPawnExtensionComponent]
			- [ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]
			- [ULyraPawnExtensionComponent::PawnData]
			- [ULyraPawnExtensionComponent::GetPawnData()]
			- [ULyraPawnExtensionComponent::SetPawnData()]
			- [ULyraPawnExtensionComponent::AbilitySystemComponent]
			- [ULyraPawnExtensionComponent::GetLyraAbilitySystemComponent()]
			- [ULyraPawnExtensionComponent::InitializeAbilitySystem()]
			- [ULyraPawnExtensionComponent::UninitializeAbilitySystem()]
		- [ULyraHeroComponent]
			- [ULyraHeroComponent::DefaultInputConfigs]
			- [ULyraHeroComponent::IsPawnComponentReadyToInitialize()]
			- [ULyraHeroComponent::OnPawnReadyToInitialize()]
			- [ULyraHeroComponent::InitializePlayerInput()]
			- [ULyraHeroComponent::DetermineCameraMode()]
		- [ULyraAbilitySet]
			- [ULyraAbilitySet::GiveToAbilitySystem()]
		- [FLyraAbilityTagRelationship]
		- [ULyraAbilityTagRelationshipMapping]
		- [ULyraGameplayAbility_FromEquipment]
		- [ULyraGameplayAbility_RangedWeapon]
		- [ULyraGameplayAbility_Reset]
		- [ULyraGameplayAbility_Death]
		- [ULyraGameplayAbility_Interact]
		- [ULyraGameplayAbility_Jump]
		- [ULyraGamePhaseAbility]
		- [ULyraAttributeSet]
		- [ULyraHealthSet]
			- [ULyraHealthSet::Health]
			- [ULyraHealthSet::MaxHealth]
			- [ULyraHealthSet::Healing]
			- [ULyraHealthSet::Damage]
		- [ULyraHealthComponent]
		- [ULyraHealExecution]
		- [ULyraDamageExecution]
		- [ALyraCharacterWithAbilities]
* GameplayMessage 関連
	* Lyra
		- [UGameplayMessageSubsystem]
			- [UGameplayMessageSubsystem::BroadcastMessage()]
		- [UAsyncAction_ListenForGameplayMessage]
* GameplayMessageProcessor 関連
	* Lyra
		- [UGameplayMessageProcessor]
		- [UElimChainProcessor]
		- [UElimStreakProcessor]
		- [UAssistProcessor]
* GameplayMessageMessageStruct 関連
	* Lyra
		- [FLyraControlPointStatusMessage]
		- [FLyraInteractionDurationMessage]
		- [FLyraNotificationMessage]
			- [FLyraNotificationMessage::PayloadTag]
		- [FLyraQuickBarActiveIndexChangedMessage]
		- [FLyraQuickBarSlotsChangedMessage]
		- [FLyraInventoryChangeMessage]
		- [FLyraPlayerResetMessage]
		- [FLyraAbilitySimpleFailureMessage]
		- [FLyraAbilityMontageFailureMessage]
		- [FLyraVerbMessage]
		- [FLyraVerbMessageReplication]
* GameplayMessageAccolade 関連
	* Lyra
		- [FLyraAccoladeDefinitionRow]
		- [ULyraAccoladeHostWidget]
			- [ULyraAccoladeHostWidget::OnNotificationMessage()]
* Inventory 関連
	* Lyra
		- [FLyraInventoryList]
		- [ULyraInventoryManagerComponent]
* Weapon 関連
	* Lyra
		- [ULyraWeaponStateComponent]
* PawnSetting 関連
	* Lyra
		- [ULyraPawnData]
			- [ULyraPawnData::PawnClass]
			- [ULyraPawnData::InputConfig]
			- [ULyraPawnData::TagRelationshipMapping]
			- [ULyraPawnData::DefaultCameraMode]
			- [ULyraPawnData::AbilitySets]
* widget 関連
	* Lyra
		- [ULyraReticleWidgetBase]
		- [ULyraTaggedWidget]
		- [UCommonActivatableWidget]
		- [ULyraActivatableWidget]
		- [ULyraHUDLayout]
		- [ULyraWeaponUserInterface]
		- [ULyraPerfStatContainerBase]
		- [ULyraSimulatedInputWidget]
		- [ULyraJoystickWidget]
		- [ULyraTouchRegion]
* GameplayFramework 関連
	* Lyra
		- [ALyraCharacter]
		- [ALyraPlayerController]
		- [ALyraGameMode]
			- [ALyraGameMode::InitGame()]
			- [ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]
			- [ALyraGameMode::GetPawnDataForController()]
		- [ALyraGameState]
			- [ALyraGameState::MulticastMessageToClients()]
			- [ALyraGameState::MulticastReliableMessageToClients()]
		- [ALyraPlayerState]
			- [ALyraPlayerState::StatTags]
			- [ALyraPlayerState::OnExperienceLoaded()]
			- [ALyraPlayerState::SetPawnData()]
			- [ALyraPlayerState::ClientBroadcastMessage()]
* その他
	* Lyra
		- [ALyraWeaponSpawner]
		- [ULyraCameraMode]
		- [ULyraCheatManager]
		- [ULyraSettingsLocal]
		- [ULyraDamageLogDebuggerComponent]
		- [ULyraEquipmentManagerComponent]
		- [ULyraIndicatorManagerComponent]
		- [ULyraQuickBarComponent]
		- [ULyraBotCreationComponent]
		- [UAimAssistTargetManagerComponent]
		- [ULyraNumberPopComponent]
		- [ULyraNumberPopComponent_NiagaraText]
		- [ULyraFrontendStateComponent]
		- [ULyraTeamCreationComponent]
		- [ULyraPlayerSpawningManagerComponent]
		- [UTDM_PlayerSpawningManagmentComponent]
		- [ULyraControllerComponent_CharacterParts]

<!--- TODO: 漏れがないか確認すること --->

# おまけ

* [Youtube > Unreal Engine > Developing in UE5 ｜ Inside Unreal]
	* 日本語字幕が付きました。
	* 画作りに興味がある方向け。
	* エンジニア的な内容は出てきません。


# 終わりに

> TODO:なんかかく。


-----
おしまい。

<!--- ページ内のリンク --->

<!--- 関連ドキュメント --->
[ReadingLyra > 【UE5】Lyra に学ぶ Enhanced Input]: EnhancedInput.md
[ReadingLyra > 【UE5】Lyra に学ぶ 入力処理用 GameplayTag(InputTag)]: InputTag.md

<!--- github --->
[GASDocumentation(和訳) > 11.1.2 Community Questions]: https://github.com/sentyaanko/GASDocumentation/blob/lang-ja/README.jp.md#resources-daveratti-community2

<!--- 公式：Unreal Engine Issues --->
[Unreal Engine Issues > UE-142237]: https://issues.unrealengine.com/issue/UE-142237

<!--- 公式：5.0/Subsystem --->
[Unreal Engine 5.0 Documentation > プログラミング サブシステム]: https://docs.unrealengine.com/5.0/ja/programming-subsystems/

<!--- 公式：5.0/データ レジストリ --->
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ >  データ レジストリのクイック スタート ガイド]: https://docs.unrealengine.com/5.0/ja/quick-start-guide-for-unreal-engine-data-registries/

<!--- 公式：5.0/ゲームプレイフレームワーク --->
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ フレームワークのクイック リファレンス]: https://docs.unrealengine.com/5.0/ja/unreal-engine-gameplay-framework-quick-reference/

<!--- 公式：5.0/GAS --->
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-system-for-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > アビリティ システム コンポーネントと属性]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-system-component-and-gameplay-attributes-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > ゲームプレイ アビリティ]: https://docs.unrealengine.com/5.0/ja/using-gameplay-abilities-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > ゲームプレイ アトリビュートとゲームプレイ エフェクト]: https://docs.unrealengine.com/5.0/ja/gameplay-attributes-and-gameplay-effects-for-the-gameplay-ability-system-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > アビリティ タスク]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-tasks-in-unreal-engine/

<!--- 公式：5.0/Lyra --->
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E6%8B%A1%E5%BC%B5%E3%81%95%E3%82%8C%E3%81%9F%E3%82%BF%E3%82%B0%E9%96%A2%E4%BF%82%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > Lyra キャラクターを初期化する方法]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#lyra%E3%82%AD%E3%83%A3%E3%83%A9%E3%82%AF%E3%82%BF%E3%83%BC%E3%82%92%E5%88%9D%E6%9C%9F%E5%8C%96%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > ゲームプレイ タグ バインディング]: https://docs.unrealengine.com/5.0/ja/animation-in-lyra-sample-game-in-unreal-engine/#%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%97%E3%83%AC%E3%82%A4%E3%82%BF%E3%82%B0%E3%83%90%E3%82%A4%E3%83%B3%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra インタラクション システム]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-interaction-system-in-unreal-engine/
[Unreal Engine 5.0 Documentation > Game Features と Modular Gameplay]: https://docs.unrealengine.com/5.0/ja/game-features-and-modular-gameplay/
[Unreal Engine 5.0 Documentation > プロダクション パイプラインをセットアップする > アセット管理]: https://docs.unrealengine.com/5.0/ja/asset-management-in-unreal-engine/




<!--- 公式：5.0/古代の谷 --->
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]: https://docs.unrealengine.com/5.0/ja/valley-of-the-ancient-sample-game-for-unreal-engine/#modulargameplay%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B

<!--- 公式：マーケットプレイス --->
[マーケットプレイス > Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[マーケットプレイス > 古代の谷]: https://www.unrealengine.com/marketplace/en-US/product/ancient-game-01

[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra

<!--- 公式：youtube --->
[Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 8:10]: https://youtu.be/7F28p564kuY?list=PLZlv_N0_O1gbggHiwNP2JBXGeD2h12tbB&t=490
[Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 40:56]: https://youtu.be/7F28p564kuY?list=PLZlv_N0_O1gbggHiwNP2JBXGeD2h12tbB&t=2456
[Youtube > Unreal Engine > Programming Subsystems ｜ Live from HQ ｜ Inside Unreal]: https://www.youtube.com/watch?v=v5b1FvKBYzc
[Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]: https://www.youtube.com/watch?v=3PBnqC7TxvM
[Youtube > Unreal Engine > Developing in UE5 ｜ Inside Unreal]: https://www.youtube.com/watch?v=5jb5ZMul94Q

<!--- docswell --->
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2#p54
[ドクセル > 2021/10/2 > 出張ヒストリア！ ゲーム開発勉強会2021 > 目指せ脱UE4初心者！？知ってると開発が楽になる便利機能を紹介 - DataAsset, Subsystem, GameplayAbility編 -]: https://www.docswell.com/s/historia_Inc/5WVYJK-ue4-dataasset-subsystem-gameplayability
[ドクセル > 2021/10/2 > 出張ヒストリア！ ゲーム開発勉強会2021 > 目指せ脱UE4初心者！？知ってると開発が楽になる便利機能を紹介 - DataAsset, Subsystem, GameplayAbility編 - > p46]: https://www.docswell.com/s/historia_Inc/5WVYJK-ue4-dataasset-subsystem-gameplayability#p46
[ドクセル > 2017/11/25 > UE4のモバイル開発におけるコンテンツアップデートの話　- Chunk IDとの激闘編 - > p34]: https://www.docswell.com/s/EpicGamesJapan/5RQMEK-ue4-chunk-id#p34

<!--- Let's Enjoy Unreal Engine --->
[Let's Enjoy Unreal Engine > (2021/11/28) > UE5 Game Featuresで簡単に依存関係なしのコンポーネントを作ってみる]: https://unrealengine.hatenablog.com/entry/2021/11/28/111821

<!--- Qiita --->
[Qiita > (2019/08/15) > 【UE4】 Asset Managerのアセットの非同期ロード機能について その1 ( 非同期ロードの解説 & レベルの裏読み編 )]: https://qiita.com/EGJ-Kaz_Okada/items/f18bca3fb5c8fc1aea9c
[Qiita > (2019/12/21) > 【UE4】 Asset Managerのアセットの非同期ロード機能について その2 ( レベルアセット以外の裏読み編 )]: https://qiita.com/EGJ-Kaz_Okada/items/7dba130c3641aa456b73

<!--- historia --->
[historia > (2021/06/18) > 【UE5】 プレイヤーの技などをプラグインで実装できる！　GameFeaturesプラグインの紹介]: https://historia.co.jp/archives/21145/

<!--- generated --->
[ALyraWeaponSpawner]: CodeRefs/Lyra/Etc/ALyraWeaponSpawner.md#alyraweaponspawner
[UAimAssistTargetManagerComponent]: CodeRefs/Lyra/Etc/UAimAssistTargetManagerComponent.md#uaimassisttargetmanagercomponent
[ULyraBotCreationComponent]: CodeRefs/Lyra/Etc/ULyraBotCreationComponent.md#ulyrabotcreationcomponent
[ULyraCameraMode]: CodeRefs/Lyra/Etc/ULyraCameraMode.md#ulyracameramode
[ULyraCheatManager]: CodeRefs/Lyra/Etc/ULyraCheatManager.md#ulyracheatmanager
[ULyraControllerComponent_CharacterParts]: CodeRefs/Lyra/Etc/ULyraControllerComponent_CharacterParts.md#ulyracontrollercomponent_characterparts
[ULyraDamageLogDebuggerComponent]: CodeRefs/Lyra/Etc/ULyraDamageLogDebuggerComponent.md#ulyradamagelogdebuggercomponent
[ULyraEquipmentManagerComponent]: CodeRefs/Lyra/Etc/ULyraEquipmentManagerComponent.md#ulyraequipmentmanagercomponent
[ULyraFrontendStateComponent]: CodeRefs/Lyra/Etc/ULyraFrontendStateComponent.md#ulyrafrontendstatecomponent
[ULyraIndicatorManagerComponent]: CodeRefs/Lyra/Etc/ULyraIndicatorManagerComponent.md#ulyraindicatormanagercomponent
[ULyraNumberPopComponent]: CodeRefs/Lyra/Etc/ULyraNumberPopComponent.md#ulyranumberpopcomponent
[ULyraNumberPopComponent_NiagaraText]: CodeRefs/Lyra/Etc/ULyraNumberPopComponent_NiagaraText.md#ulyranumberpopcomponent_niagaratext
[ULyraPlayerSpawningManagerComponent]: CodeRefs/Lyra/Etc/ULyraPlayerSpawningManagerComponent.md#ulyraplayerspawningmanagercomponent
[ULyraQuickBarComponent]: CodeRefs/Lyra/Etc/ULyraQuickBarComponent.md#ulyraquickbarcomponent
[ULyraSettingsLocal]: CodeRefs/Lyra/Etc/ULyraSettingsLocal.md#ulyrasettingslocal
[ULyraTeamCreationComponent]: CodeRefs/Lyra/Etc/ULyraTeamCreationComponent.md#ulyrateamcreationcomponent
[UTDM_PlayerSpawningManagmentComponent]: CodeRefs/Lyra/Etc/UTDM_PlayerSpawningManagmentComponent.md#utdm_playerspawningmanagmentcomponent
[ALyraWorldSettings]: CodeRefs/Lyra/Experience/ALyraWorldSettings.md#alyraworldsettings
[UAsyncAction_ExperienceReady]: CodeRefs/Lyra/Experience/UAsyncAction_ExperienceReady.md#uasyncaction_experienceready
[UAsyncAction_ExperienceReady::OnReady]: CodeRefs/Lyra/Experience/UAsyncAction_ExperienceReady.md#uasyncaction_experiencereadyonready
[ULyraExperienceActionSet]: CodeRefs/Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceActionSet::Actions]: CodeRefs/Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionsetactions
[ULyraExperienceDefinition]: CodeRefs/Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceDefinition::DefaultPawnData]: CodeRefs/Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitiondefaultpawndata
[ULyraExperienceDefinition::Actions]: CodeRefs/Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitionactions
[ULyraExperienceDefinition::ActionSets]: CodeRefs/Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitionactionsets
[ULyraExperienceManagerComponent]: CodeRefs/Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()]: CodeRefs/Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_highpriority
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()]: CodeRefs/Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()]: CodeRefs/Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_lowpriority
[ULyraUserFacingExperienceDefinition]: CodeRefs/Lyra/Experience/ULyraUserFacingExperienceDefinition.md#ulyrauserfacingexperiencedefinition
[FMappableConfigPair]: CodeRefs/Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpair
[FMappableConfigPair::Config]: CodeRefs/Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairconfig
[FMappableConfigPair::Type]: CodeRefs/Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairtype
[FMappableConfigPair::DependentPlatformTraits]: CodeRefs/Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairdependentplatformtraits
[FMappableConfigPair::ExcludedPlatformTraits]: CodeRefs/Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairexcludedplatformtraits
[FMappableConfigPair::bShouldActivateAutomatically]: CodeRefs/Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairbshouldactivateautomatically
[UApplyFrontendPerfSettingsAction]: CodeRefs/Lyra/GameFeature/UApplyFrontendPerfSettingsAction.md#uapplyfrontendperfsettingsaction
[UGameFeatureAction_AddAbilities]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureaction_addabilities
[UGameFeatureAction_AddGameplayCuePath]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddGameplayCuePath.md#ugamefeatureaction_addgameplaycuepath
[UGameFeatureAction_AddInputBinding]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md#ugamefeatureaction_addinputbinding
[UGameFeatureAction_AddInputConfig]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfig
[UGameFeatureAction_AddInputConfig::InputConfigs]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfiginputconfigs
[UGameFeatureAction_AddInputContextMapping]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureaction_addinputcontextmapping
[UGameFeatureAction_AddWidgets]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgets
[UGameFeatureAction_SplitscreenConfig]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_SplitscreenConfig.md#ugamefeatureaction_splitscreenconfig
[UGameFeatureAction_WorldActionBase]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_WorldActionBase.md#ugamefeatureaction_worldactionbase
[ULyraGameFeaturePolicy]: CodeRefs/Lyra/GameFeature/ULyraGameFeaturePolicy.md#ulyragamefeaturepolicy
[ULyraGameFeature_AddGameplayCuePaths]: CodeRefs/Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeature_addgameplaycuepaths
[ULyraGameFeature_HotfixManager]: CodeRefs/Lyra/GameFeature/ULyraGameFeature_HotfixManager.md#ulyragamefeature_hotfixmanager
[ALyraCharacterWithAbilities]: CodeRefs/Lyra/GameplayAbility/ALyraCharacterWithAbilities.md#alyracharacterwithabilities
[FLyraAbilityTagRelationship]: CodeRefs/Lyra/GameplayAbility/FLyraAbilityTagRelationship.md#flyraabilitytagrelationship
[ILyraReadyInterface]: CodeRefs/Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterface
[ILyraReadyInterface::IsPawnComponentReadyToInitialize()]: CodeRefs/Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterfaceispawncomponentreadytoinitialize
[ULyraAbilitySet]: CodeRefs/Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraAbilitySet::GiveToAbilitySystem()]: CodeRefs/Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilitysetgivetoabilitysystem
[ULyraAbilitySystemComponent]: CodeRefs/Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraAbilitySystemComponent::SetTagRelationshipMapping()]: CodeRefs/Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentsettagrelationshipmapping
[ULyraAbilityTagRelationshipMapping]: CodeRefs/Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraAttributeSet]: CodeRefs/Lyra/GameplayAbility/ULyraAttributeSet.md#ulyraattributeset
[ULyraDamageExecution]: CodeRefs/Lyra/GameplayAbility/ULyraDamageExecution.md#ulyradamageexecution
[ULyraGamePhaseAbility]: CodeRefs/Lyra/GameplayAbility/ULyraGamePhaseAbility.md#ulyragamephaseability
[ULyraGameplayAbility]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayabilityapplyabilitytagstogameplayeffectspec
[ULyraGameplayAbility_Death]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Death.md#ulyragameplayability_death
[ULyraGameplayAbility_FromEquipment]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_FromEquipment.md#ulyragameplayability_fromequipment
[ULyraGameplayAbility_Interact]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Interact.md#ulyragameplayability_interact
[ULyraGameplayAbility_Jump]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Jump.md#ulyragameplayability_jump
[ULyraGameplayAbility_RangedWeapon]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayability_rangedweapon
[ULyraGameplayAbility_Reset]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Reset.md#ulyragameplayability_reset
[ULyraGlobalAbilitySystem]: CodeRefs/Lyra/GameplayAbility/ULyraGlobalAbilitySystem.md#ulyraglobalabilitysystem
[ULyraHealExecution]: CodeRefs/Lyra/GameplayAbility/ULyraHealExecution.md#ulyrahealexecution
[ULyraHealthComponent]: CodeRefs/Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponent
[ULyraHealthSet]: CodeRefs/Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthset
[ULyraHealthSet::Health]: CodeRefs/Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsethealth
[ULyraHealthSet::MaxHealth]: CodeRefs/Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsetmaxhealth
[ULyraHealthSet::Healing]: CodeRefs/Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsethealing
[ULyraHealthSet::Damage]: CodeRefs/Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsetdamage
[ULyraHeroComponent]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponent
[ULyraHeroComponent::DefaultInputConfigs]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentdefaultinputconfigs
[ULyraHeroComponent::IsPawnComponentReadyToInitialize()]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentispawncomponentreadytoinitialize
[ULyraHeroComponent::OnPawnReadyToInitialize()]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentonpawnreadytoinitialize
[ULyraHeroComponent::InitializePlayerInput()]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinitializeplayerinput
[ULyraHeroComponent::DetermineCameraMode()]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentdeterminecameramode
[ULyraPawnComponent]: CodeRefs/Lyra/GameplayAbility/ULyraPawnComponent.md#ulyrapawncomponent
[ULyraPawnExtensionComponent]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentcheckpawnreadytoinitialize
[ULyraPawnExtensionComponent::PawnData]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentpawndata
[ULyraPawnExtensionComponent::GetPawnData()]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentgetpawndata
[ULyraPawnExtensionComponent::SetPawnData()]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentsetpawndata
[ULyraPawnExtensionComponent::AbilitySystemComponent]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentabilitysystemcomponent
[ULyraPawnExtensionComponent::GetLyraAbilitySystemComponent()]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentgetlyraabilitysystemcomponent
[ULyraPawnExtensionComponent::InitializeAbilitySystem()]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentinitializeabilitysystem
[ULyraPawnExtensionComponent::UninitializeAbilitySystem()]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentuninitializeabilitysystem
[AGameplayCueNotify_BurstLatent]: CodeRefs/Lyra/GameplayCue/AGameplayCueNotify_BurstLatent.md#agameplaycuenotify_burstlatent
[ULyraGameplayCueManager]: CodeRefs/Lyra/GameplayCue/ULyraGameplayCueManager.md#ulyragameplaycuemanager
[ALyraCharacter]: CodeRefs/Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ALyraGameMode]: CodeRefs/Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraGameMode::InitGame()]: CodeRefs/Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodeinitgame
[ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]: CodeRefs/Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodehandlematchassignmentifnotexpectingone
[ALyraGameMode::GetPawnDataForController()]: CodeRefs/Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodegetpawndataforcontroller
[ALyraGameState]: CodeRefs/Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraGameState::MulticastMessageToClients()]: CodeRefs/Lyra/GameplayFramework/ALyraGameState.md#alyragamestatemulticastmessagetoclients
[ALyraGameState::MulticastReliableMessageToClients()]: CodeRefs/Lyra/GameplayFramework/ALyraGameState.md#alyragamestatemulticastreliablemessagetoclients
[ALyraPlayerController]: CodeRefs/Lyra/GameplayFramework/ALyraPlayerController.md#alyraplayercontroller
[ALyraPlayerState]: CodeRefs/Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ALyraPlayerState::StatTags]: CodeRefs/Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstatestattags
[ALyraPlayerState::OnExperienceLoaded()]: CodeRefs/Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstateonexperienceloaded
[ALyraPlayerState::SetPawnData()]: CodeRefs/Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstatesetpawndata
[ALyraPlayerState::ClientBroadcastMessage()]: CodeRefs/Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstateclientbroadcastmessage
[UAsyncAction_ListenForGameplayMessage]: CodeRefs/Lyra/GameplayMessage/UAsyncAction_ListenForGameplayMessage.md#uasyncaction_listenforgameplaymessage
[UGameplayMessageSubsystem]: CodeRefs/Lyra/GameplayMessage/UGameplayMessageSubsystem.md#ugameplaymessagesubsystem
[UGameplayMessageSubsystem::BroadcastMessage()]: CodeRefs/Lyra/GameplayMessage/UGameplayMessageSubsystem.md#ugameplaymessagesubsystembroadcastmessage
[FLyraAccoladeDefinitionRow]: CodeRefs/Lyra/GameplayMessageAccolade/FLyraAccoladeDefinitionRow.md#flyraaccoladedefinitionrow
[ULyraAccoladeHostWidget]: CodeRefs/Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidget
[ULyraAccoladeHostWidget::OnNotificationMessage()]: CodeRefs/Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidgetonnotificationmessage
[UAssistProcessor]: CodeRefs/Lyra/GameplayMessageProcessor/UAssistProcessor.md#uassistprocessor
[UElimChainProcessor]: CodeRefs/Lyra/GameplayMessageProcessor/UElimChainProcessor.md#uelimchainprocessor
[UElimStreakProcessor]: CodeRefs/Lyra/GameplayMessageProcessor/UElimStreakProcessor.md#uelimstreakprocessor
[UGameplayMessageProcessor]: CodeRefs/Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
[FLyraAbilityMontageFailureMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraAbilityMontageFailureMessage.md#flyraabilitymontagefailuremessage
[FLyraAbilitySimpleFailureMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraAbilitySimpleFailureMessage.md#flyraabilitysimplefailuremessage
[FLyraControlPointStatusMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraControlPointStatusMessage.md#flyracontrolpointstatusmessage
[FLyraInteractionDurationMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraInteractionDurationMessage.md#flyrainteractiondurationmessage
[FLyraInventoryChangeMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraInventoryChangeMessage.md#flyrainventorychangemessage
[FLyraNotificationMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md#flyranotificationmessage
[FLyraNotificationMessage::PayloadTag]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md#flyranotificationmessagepayloadtag
[FLyraPlayerResetMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraPlayerResetMessage.md#flyraplayerresetmessage
[FLyraQuickBarActiveIndexChangedMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraQuickBarActiveIndexChangedMessage.md#flyraquickbaractiveindexchangedmessage
[FLyraQuickBarSlotsChangedMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraQuickBarSlotsChangedMessage.md#flyraquickbarslotschangedmessage
[FLyraVerbMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraVerbMessage.md#flyraverbmessage
[FLyraVerbMessageReplication]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraVerbMessageReplication.md#flyraverbmessagereplication
[ULyraHotfixManager]: CodeRefs/Lyra/HotfixManager/ULyraHotfixManager.md#ulyrahotfixmanager
[ULyraInputConfig]: CodeRefs/Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[FLyraInventoryList]: CodeRefs/Lyra/Inventory/FLyraInventoryList.md#flyrainventorylist
[ULyraInventoryManagerComponent]: CodeRefs/Lyra/Inventory/ULyraInventoryManagerComponent.md#ulyrainventorymanagercomponent
[ULyraPawnData]: CodeRefs/Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[ULyraPawnData::PawnClass]: CodeRefs/Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatapawnclass
[ULyraPawnData::InputConfig]: CodeRefs/Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatainputconfig
[ULyraPawnData::TagRelationshipMapping]: CodeRefs/Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatatagrelationshipmapping
[ULyraPawnData::DefaultCameraMode]: CodeRefs/Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatadefaultcameramode
[ULyraPawnData::AbilitySets]: CodeRefs/Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndataabilitysets
[ULyraWeaponStateComponent]: CodeRefs/Lyra/Weapon/ULyraWeaponStateComponent.md#ulyraweaponstatecomponent
[UCommonActivatableWidget]: CodeRefs/Lyra/Widget/UCommonActivatableWidget.md#ucommonactivatablewidget
[ULyraActivatableWidget]: CodeRefs/Lyra/Widget/ULyraActivatableWidget.md#ulyraactivatablewidget
[ULyraHUDLayout]: CodeRefs/Lyra/Widget/ULyraHUDLayout.md#ulyrahudlayout
[ULyraJoystickWidget]: CodeRefs/Lyra/Widget/ULyraJoystickWidget.md#ulyrajoystickwidget
[ULyraPerfStatContainerBase]: CodeRefs/Lyra/Widget/ULyraPerfStatContainerBase.md#ulyraperfstatcontainerbase
[ULyraReticleWidgetBase]: CodeRefs/Lyra/Widget/ULyraReticleWidgetBase.md#ulyrareticlewidgetbase
[ULyraSimulatedInputWidget]: CodeRefs/Lyra/Widget/ULyraSimulatedInputWidget.md#ulyrasimulatedinputwidget
[ULyraTaggedWidget]: CodeRefs/Lyra/Widget/ULyraTaggedWidget.md#ulyrataggedwidget
[ULyraTouchRegion]: CodeRefs/Lyra/Widget/ULyraTouchRegion.md#ulyratouchregion
[ULyraWeaponUserInterface]: CodeRefs/Lyra/Widget/ULyraWeaponUserInterface.md#ulyraweaponuserinterface
[FPrimaryAssetTypeInfo]: CodeRefs/UE/AssetManager/FPrimaryAssetTypeInfo.md#fprimaryassettypeinfo
[UDataRegistrySubsystem]: CodeRefs/UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystem
[UDataRegistrySubsystem::AcquireItem()]: CodeRefs/UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystemacquireitem
[IGameFeatureStateChangeObserver]: CodeRefs/UE/GameFeature/IGameFeatureStateChangeObserver.md#igamefeaturestatechangeobserver
[UDefaultGameFeaturesProjectPolicies]: CodeRefs/UE/GameFeature/UDefaultGameFeaturesProjectPolicies.md#udefaultgamefeaturesprojectpolicies
[UGameFeatureAction]: CodeRefs/UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureAction_AddComponents]: CodeRefs/UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
[UGameFeatureAction_DataRegistry]: CodeRefs/UE/GameFeature/UGameFeatureAction_DataRegistry.md#ugamefeatureaction_dataregistry
[UGameFeatureData]: CodeRefs/UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UGameFeatureData::Actions]: CodeRefs/UE/GameFeature/UGameFeatureData.md#ugamefeaturedataactions
[UGameFeatureData::PrimaryAssetTypesToScan]: CodeRefs/UE/GameFeature/UGameFeatureData.md#ugamefeaturedataprimaryassettypestoscan
[UGameFeaturesProjectPolicies]: CodeRefs/UE/GameFeature/UGameFeaturesProjectPolicies.md#ugamefeaturesprojectpolicies
[UGameFeaturesSubsystem]: CodeRefs/UE/GameFeature/UGameFeaturesSubsystem.md#ugamefeaturessubsystem
[UGameFeaturesSubsystem::AddObserver()]: CodeRefs/UE/GameFeature/UGameFeaturesSubsystem.md#ugamefeaturessubsystemaddobserver
[FGameplayAbilitySpec]: CodeRefs/UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspec
[FGameplayAbilitySpec::DynamicAbilityTags]: CodeRefs/UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspecdynamicabilitytags
[FGameplayEffectSpec]: CodeRefs/UE/GameplayAbility/FGameplayEffectSpec.md#fgameplayeffectspec
[FGameplayEffectSpec::CapturedSourceTags]: CodeRefs/UE/GameplayAbility/FGameplayEffectSpec.md#fgameplayeffectspeccapturedsourcetags
[UGameplayAbility]: CodeRefs/UE/GameplayAbility/UGameplayAbility.md#ugameplayability
[UGameplayAbility::MakeOutgoingGameplayEffectSpec()]: CodeRefs/UE/GameplayAbility/UGameplayAbility.md#ugameplayabilitymakeoutgoinggameplayeffectspec
[UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]: CodeRefs/UE/GameplayAbility/UGameplayAbility.md#ugameplayabilityapplyabilitytagstogameplayeffectspec
[UGameplayCueManager]: CodeRefs/UE/GameplayCue/UGameplayCueManager.md#ugameplaycuemanager
[UOnlineHotfixManager]: CodeRefs/UE/HotfixManager/UOnlineHotfixManager.md#uonlinehotfixmanager
[FEnhancedActionKeyMapping]: CodeRefs/UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymapping
[FEnhancedActionKeyMapping::Action]: CodeRefs/UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingaction
[FEnhancedActionKeyMapping::Key]: CodeRefs/UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingkey
[IEnhancedInputSubsystemInterface]: CodeRefs/UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterface
[UEnhancedInputLocalPlayerSubsystem]: CodeRefs/UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystem
[UInputAction]: CodeRefs/UE/Input/UInputAction.md#uinputaction
[UInputMappingContext]: CodeRefs/UE/Input/UInputMappingContext.md#uinputmappingcontext
[UInputMappingContext::Mappings]: CodeRefs/UE/Input/UInputMappingContext.md#uinputmappingcontextmappings
[UPlayerMappableInputConfig]: CodeRefs/UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
[UPlayerMappableInputConfig::Contexts]: CodeRefs/UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfigcontexts
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.0 Documentation > Game Features と Modular Gameplay]: https://docs.unrealengine.com/5.0/ja/game-features-and-modular-gameplay/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ >  データ レジストリのクイック スタート ガイド]: https://docs.unrealengine.com/5.0/ja/quick-start-guide-for-unreal-engine-data-registries/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]: https://docs.unrealengine.com/5.0/ja/valley-of-the-ancient-sample-game-for-unreal-engine/#modulargameplay%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > Lyra キャラクターを初期化する方法]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#lyra%E3%82%AD%E3%83%A3%E3%83%A9%E3%82%AF%E3%82%BF%E3%83%BC%E3%82%92%E5%88%9D%E6%9C%9F%E5%8C%96%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95
[Unreal Engine 5.0 Documentation > プロダクション パイプラインをセットアップする > アセット管理]: https://docs.unrealengine.com/5.0/ja/asset-management-in-unreal-engine/
[Youtube > Unreal Engine > Developing in UE5 ｜ Inside Unreal]: https://www.youtube.com/watch?v=5jb5ZMul94Q
[Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 40:56]: https://youtu.be/7F28p564kuY?list=PLZlv_N0_O1gbggHiwNP2JBXGeD2h12tbB&t=2456
[Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]: https://www.youtube.com/watch?v=3PBnqC7TxvM
[ドクセル > 2017/11/25 > UE4のモバイル開発におけるコンテンツアップデートの話　- Chunk IDとの激闘編 - > p34]: https://www.docswell.com/s/EpicGamesJapan/5RQMEK-ue4-chunk-id#p34
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2#p54
