## FLyraNotificationMessage

> A message destined for a transient log (e.g., an elimination feed or inventory pickup stream)  
> 
> ----
> 一時的なログ（エリミネーションフィードやインベントリーピックアップストリームなど）を宛先とするメッセージです。  

* 概要
	* Gameplay Message `Lyra.AddNotification.Message` で送信する構造体です。
		* この Gameplay Message は `B_AccoladeRelay` ([UGameplayMessageProcessor]) が送信します。
			* このクラスは Gameplay Message `Lyra.ShooterGame.Accolade.*` を [ALyraPlayerState::ClientBroadcastMessage()] を利用しサーバーからクライアントに Gameplay Message を伝播させ、コスメティック処理が可能な環境のみ Gameplay Message `Lyra.AddNotification.Message` を送信します。
			* つまり、称賛の通知を示す Gameplay Message `Lyra.ShooterGame.Accolade.*` を受け取り、称賛の表示の要求を示す Gameplay Message `Lyra.AddNotification.Message` を必要な環境で送信するという役目を負っています。
		* この Gameplay Message は [ULyraAccoladeHostWidget] が受信します。
	* 現状は称賛でしか利用されていませんが、仕組みとしてはそれに依存するものではないので、複雑な情報を付与する必要がないのであれば、一般的なログに使用することが可能です。

### FLyraNotificationMessage::PayloadTag

> Extra payload specific to the target channel (e.g., a style or definition asset)  
> 
> ----
> ターゲットチャンネルに固有の追加ペイロードです。（例：スタイルや定義アセットなど）  

* 概要
	* 称賛情報の場合は以下を設定しています。
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



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ALyraPlayerState::ClientBroadcastMessage()]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstateclientbroadcastmessage
[ULyraAccoladeHostWidget]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidget
[UElimChainProcessor]: ../../Lyra/GameplayMessageProcessor/UElimChainProcessor.md#uelimchainprocessor
[UElimStreakProcessor]: ../../Lyra/GameplayMessageProcessor/UElimStreakProcessor.md#uelimstreakprocessor
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
