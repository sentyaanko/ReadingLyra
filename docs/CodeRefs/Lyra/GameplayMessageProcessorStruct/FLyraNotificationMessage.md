## FLyraNotificationMessage

> A message destined for a transient log (e.g., an elimination feed or inventory pickup stream)  
> 
> ----
> 一時的なログ（エリミネーションフィードやインベントリーピックアップストリームなど）を宛先とするメッセージです。  

* 概要
	* Gameplay Message `Lyra.AddNotification.Message` で送信する構造体です。
		* この Gameplay Message は `B_AccoladeRelay` ([UGameplayMessageProcessor]) が送信します。
		* この Gameplay Message は [ULyraAccoladeHostWidget] が受信します。
	* 称賛情報を表します。

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
[UElimChainProcessor]: ../../Lyra/GameplayMessageProcessor/UElimChainProcessor.md#uelimchainprocessor
[UElimStreakProcessor]: ../../Lyra/GameplayMessageProcessor/UElimStreakProcessor.md#uelimstreakprocessor
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
