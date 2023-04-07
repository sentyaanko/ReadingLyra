# 【UE5】Lyra に学ぶ(04) GameplayMessage <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中では、GameplayMessage という仕組みが実装されています。  
このドキュメントは GameplayMessage についての解説です。  

* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [概要](#概要)
- [GameplayMessageSubsystem プラグイン](#gameplaymessagesubsystem-プラグイン)
- [Lyra での使われ方](#lyra-での使われ方)
- [終わりに](#終わりに)


# 概要

任意の構造体を使用してメッセージの送受信を行う仕組みを実装しており、これを利用することで送信者と受信者が互いに直接知らなくてもやり取りを可能にしています。

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

# GameplayMessageSubsystem プラグイン

コアな部分の実装はプラグインとなっています。

* 概要
	* [UAsyncAction_ListenForGameplayMessage]
		* `ListenForGameplayMessages` ノードを処理するクラスです。
	* [UK2Node_AsyncAction_ListenForGameplayMessages]
		* `ListenForGameplayMessages` ノードのカスタマイズのためのクラスです。
	* [UGameplayMessageSubsystem]
		* 送信者から渡されたメッセージを、保持している受信者に配信するクラスです。
	* `ListenForGameplayMessages` ノード
		* 任意の(GameplayTag で定義された)チャンネルに任意の(構造体で定義された)メッセージが届くのを非同期待ちするノードです。

# Lyra での使われ方

* 概要
	* リスナー用の基底クラス [UGameplayMessageProcessor] が作られています。
	* （基底クラスが異なるので） widget などは [UGameplayMessageSubsystem] の機能を直接利用してリスナー登録しています。
* Lyra で実装しているクラス
	* [UGameplayMessageProcessor]
		* ActorComponent です。
		* GameState 派生クラスに追加しています。
		* メッセージをリッスンする基底クラスです。
		* 派生クラスは以下の通りです。
			* [UElimChainProcessor]
				* 敵の連鎖撃破を追跡するクラスです。
			* [UElimStreakProcessor]
				* 敵の連続撃破を追跡するクラスです。
			* [UAssistProcessor]
				* 撃破のアシストを追跡するクラスです。
			* `B_AccoladeRelay` ([UGameplayMessageProcessor])
				* **称賛情報**を追跡し、サーバーからクライアントに情報を送り、他のメッセージにリレーするクラスです。
				* サーバー、クライアント両方に追加されるコンポーネントです。
				* サーバー側が受け取った際は同じメッセージを **Client RPC** します。
				* コスメティック処理が可能な場合(リッスンサーバー or クライアント or スタンドアロン)は別のメッセージを送信します。
					* (そのメッセージは表示クラスが監視し、受信時に表示を行う)
				* 基底クラスの機能は利用していません。
			* `B_EliminationFeedRelay` ([UGameplayMessageProcessor])
				* **ヘルスがなくなった事**を追跡し、サーバーからクライアントに情報を送り、他のメッセージにリレーするクラスです。
				* サーバー、クライアント両方に追加されるコンポーネントです。
				* サーバー側が受け取った際は同じメッセージを **Multicast RPC** します。
				* コスメティック処理が可能な場合(リッスンサーバー or クライアント or スタンドアロン)は別のメッセージを送信します。
					* (そのメッセージは表示クラスが監視し、受信時に表示を行う)
				* 基底クラスの機能は利用していません。
	* メッセージの送受信関連の情報
		* 詳しくは [UGameplayMessageSubsystem] の利用状況の表を参照してください。
		* メッセージをリッスンしているその他のクラスは以下の通りです。
			* [ULyraAccoladeHostWidget]
				* 称賛情報をリッスンする widget クラスです。
			* [ULyraDamageLogDebuggerComponent]
				* ダメージ情報をリッスンするデバッグログクラスです。
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
			* [FLyraVerbMessage] をまとめて処理するためのクラスです。


# 終わりに

この仕組みを用いることで、例えば Game Feature で実装する様々な機能の相互のやり取りが容易になり、モジュール式に作りやすくなります。  
ただしこれは根本的には、どこに届くかわからないメッセージを一方的に送るだけ、どこから来るかわからないメッセージを待つだけの仕組みです。  
レスポンスが必要な場合は互いにメッセージを待つか、別の仕組みを使うかなどが必要になります。  

どなたかの参考になれば幸いです。

-----
おしまい。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraDamageLogDebuggerComponent]: CodeRefs/Lyra/Etc/ULyraDamageLogDebuggerComponent.md#ulyradamagelogdebuggercomponent
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
[UAsyncAction_ListenForGameplayMessage]: CodeRefs/Plugin/GameplayMessageSubsystem/UAsyncAction_ListenForGameplayMessage.md#uasyncactionlistenforgameplaymessage
[UGameplayMessageSubsystem]: CodeRefs/Plugin/GameplayMessageSubsystem/UGameplayMessageSubsystem.md#ugameplaymessagesubsystem
[UK2Node_AsyncAction_ListenForGameplayMessages]: CodeRefs/Plugin/GameplayMessageSubsystem/UK2Node_AsyncAction_ListenForGameplayMessages.md#uk2nodeasyncactionlistenforgameplaymessages
[GASDocumentation(和訳) > 11.1.2 Community Questions]: https://github.com/sentyaanko/GASDocumentation/blob/lang-ja/README.jp.md#resources-daveratti-community2
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
