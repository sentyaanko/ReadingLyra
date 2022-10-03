## ULyraHUDLayout

> Widget used to lay out the player's HUD (typically specified by an Add Widgets action in the experience)    
> 
> ----
> プレイヤーの HUD をレイアウトするために使用されるウィジェットです（通常、エクスペリエンスの Add Widgets アクションで指定されます）。  

* 概要
	* [ULyraActivatableWidget] の派生クラスです。
	* 派生ブループリントは以下の通りです。
		* `W_DefaultHUDLayout`
		* `W_FrontEndHUDLayout`
		* `W_ShooterHUDLayout`
		* `W_ShooterReplayHUD`
		* `W_TopDownArenaHUDLayout`
	* このクラスでは Esc アクション時に UI を表示する機能が実装されています。
	
### ULyraHUDLayout::EscapeMenuClass

* 概要
	* [UCommonActivatableWidget] を指定します。
	* ここで設定された値は Esc アクションが発生した際に [UCommonUIExtensions] を利用して UI を表示するのに利用されます。
	* すべての派生ブループリントで `W_LyraGameMenu` ([UCommonActivatableWidget]) が指定されています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraActivatableWidget]: ../../Lyra/Widget/ULyraActivatableWidget.md#ulyraactivatablewidget
[UCommonUIExtensions]: ../../Plugin/CommonGame/UCommonUIExtensions.md#ucommonuiextensions
[UCommonActivatableWidget]: ../../Plugin/CommonUI/UCommonActivatableWidget.md#ucommonactivatablewidget
