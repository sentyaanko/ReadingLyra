# 【UE5】Lyra に学ぶ GameplayMessage <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中では、GameplayMessage という仕組みが実装されています。  
このドキュメントは GameplayMessage についての解説です。  

* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [UGameplayMessageSubsystem について](#ugameplaymessagesubsystem-について)
- [終わりに](#終わりに)


# UGameplayMessageSubsystem について

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

上記はおそらくこの仕組みに類するものだと思います。  
(UnrealEngine のリポジトリを検索しても見つけることができなかったので、これがそのままそれというわけではないようです。)

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
				* コスメティック処理が可能な場合(リッスンサーバー or クライアント or スタンドアロン)は別のメッセージを送信する。
					* (そのメッセージは表示クラスが監視し、受信時に表示を行う)
				* 基底クラスの機能は利用していない。
			* `B_EliminationFeedRelay` ([UGameplayMessageProcessor])
				* **ヘルスがなくなった事**を追跡し、サーバーからクライアントに情報を送り、他のメッセージにリレーするクラス。
				* サーバー、クライアント両方に追加されるコンポーネント。
				* サーバー側が受け取った際は同じメッセージを **Multicast RPC** する。
				* コスメティック処理が可能な場合(リッスンサーバー or クライアント or スタンドアロン)は別のメッセージを送信する。
					* (そのメッセージは表示クラスが監視し、受信時に表示を行う)
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


# 終わりに

> TODO:なんかかく。


-----
おしまい。

<!--- ページ内のリンク --->

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
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E6%8B%A1%E5%BC%B5%E3%81%95%E3%82%8C%E3%81%9F%E3%82%BF%E3%82%B0%E9%96%A2%E4%BF%82%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > ゲームプレイ タグ バインディング]: https://docs.unrealengine.com/5.0/ja/animation-in-lyra-sample-game-in-unreal-engine/#%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%97%E3%83%AC%E3%82%A4%E3%82%BF%E3%82%B0%E3%83%90%E3%82%A4%E3%83%B3%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra インタラクション システム]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-interaction-system-in-unreal-engine/
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
[Youtube > Unreal Engine > Developing in UE5 | Inside Unreal]: https://www.youtube.com/watch?v=5jb5ZMul94Q

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

<!--- アルゴンUE4/UE5＆アプリ開発日記 --->
[(2021/12/23) 【UE4/UE5】標準プラグインについて調べてみた]: https://argonauts.hatenablog.jp/entry/2021/12/23/083634

<!--- CodeRefs --->
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
[IEnhancedInputSubsystemInterface::GetPlayerInput()]: CodeRefs/UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfacegetplayerinput
[IEnhancedInputSubsystemInterface::InjectInputForAction()]: CodeRefs/UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceinjectinputforaction
[IEnhancedInputSubsystemInterface::InjectInputVectorForAction()]: CodeRefs/UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceinjectinputvectorforaction
[UEnhancedInputLocalPlayerSubsystem]: CodeRefs/UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystem
[UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()]: CodeRefs/UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystemgetplayerinput
[UInputAction]: CodeRefs/UE/Input/UInputAction.md#uinputaction
[UInputMappingContext]: CodeRefs/UE/Input/UInputMappingContext.md#uinputmappingcontext
[UInputMappingContext::Mappings]: CodeRefs/UE/Input/UInputMappingContext.md#uinputmappingcontextmappings
[UPlayerMappableInputConfig]: CodeRefs/UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
[UPlayerMappableInputConfig::Contexts]: CodeRefs/UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfigcontexts

