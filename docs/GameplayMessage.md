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

<!--- アルゴンUE4/UE5＆アプリ開発日記 --->
[アルゴンUE4/UE5＆アプリ開発日記 > (2021/12/23) > 【UE4/UE5】標準プラグインについて調べてみた]: https://argonauts.hatenablog.jp/entry/2021/12/23/083634

<!--- generated --->
[ULyraDamageLogDebuggerComponent]: CodeRefs/Lyra/Etc/ULyraDamageLogDebuggerComponent.md#ulyradamagelogdebuggercomponent
[UAsyncAction_ListenForGameplayMessage]: CodeRefs/Lyra/GameplayMessage/UAsyncAction_ListenForGameplayMessage.md#uasyncaction_listenforgameplaymessage
[UGameplayMessageSubsystem]: CodeRefs/Lyra/GameplayMessage/UGameplayMessageSubsystem.md#ugameplaymessagesubsystem
[ULyraAccoladeHostWidget]: CodeRefs/Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidget
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
[FLyraPlayerResetMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraPlayerResetMessage.md#flyraplayerresetmessage
[FLyraQuickBarActiveIndexChangedMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraQuickBarActiveIndexChangedMessage.md#flyraquickbaractiveindexchangedmessage
[FLyraQuickBarSlotsChangedMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraQuickBarSlotsChangedMessage.md#flyraquickbarslotschangedmessage
[FLyraVerbMessage]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraVerbMessage.md#flyraverbmessage
[FLyraVerbMessageReplication]: CodeRefs/Lyra/GameplayMessageProcessorStruct/FLyraVerbMessageReplication.md#flyraverbmessagereplication
[GASDocumentation(和訳) > 11.1.2 Community Questions]: https://github.com/sentyaanko/GASDocumentation/blob/lang-ja/README.jp.md#resources-daveratti-community2
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
