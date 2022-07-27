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

<!--- 自前の画像へのリンク --->

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
