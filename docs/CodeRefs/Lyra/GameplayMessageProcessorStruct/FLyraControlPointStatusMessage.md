## FLyraControlPointStatusMessage

> Message indicating the state of a control point is changing  
> 
> ----
> ControlPoint の状態が変化していることを示すメッセージ  

* 概要
	* `B_ControlPointVolume` (`AActor`) が Gameplay Message `ShooterGame.ControlPoint.Captured.Message` で送信する構造体です。
		* この Gameplay Message は `B_MusicManagerComponent_ControlPoint` (`UActorComponent`) が受信します。
	* `ControlPoint` で拠点をキャプチャーしたチームの情報を示します。

### FLyraControlPointStatusMessage::ControlPoint

* 概要
	* 拠点を示す `AActor` です。
	* 現状、受信側で使用されていません。

### FLyraControlPointStatusMessage::OwnerTeamID

* 概要
	* 拠点をキャプチャーしたチームを示す int です。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->

