## FLyraPlayerResetMessage

* 概要
	* Gameplay Message `GameplayEvent.Reset` で送信する構造体です。
		* この Gameplay Message は [ULyraGameplayAbility_Reset] が送信します。
		* この Gameplay Message は `GA_AutoRespawn` ([ULyraGameplayAbility]) が受信します。
	* プレイヤーリセットの発生を知らせるためのメッセージであり、受信側はリスポーン処理を行っています。

### FLyraPlayerResetMessage::OwnerPlayerState

* 概要
	* リセット対象の PlayerState です。
	* `GA_AutoRespawn` ([ULyraGameplayAbility]) が受信した際、 ASC のオーナーが同じかを判断するのに使用しています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraGameplayAbility_Reset]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Reset.md#ulyragameplayability_reset
