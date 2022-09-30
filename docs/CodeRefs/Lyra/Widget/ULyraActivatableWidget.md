## ULyraActivatableWidget

> An activatable widget that automatically drives the desired input config when activated  
> 
> ----
> アクティブにすると、目的の入力コンフィグを自動的に駆動するアクティブ化可能な widget です。  

* 概要
	* [UCommonActivatableWidget] の派生クラスです。
	* `ULyraHUDLayout` の基底クラスです。
	* widget の入力をどのように制御するかを設定するための基底クラスです。
	* 派生ブループリントは以下の通りです。
		* `W_Credits`
		* `W_ExperienceSelectionScrteen`
		* `W_GammaEditor`
		* `W_GetReady`
		* `W_HostSessionScreen`
		* `W_LyraFrontEnd`
		* `W_LyraGameMenu`
		* `W_LyraStartup`
		* `W_MatchScoreBoard_CP`
		* `W_MatchScoreBoard_Elimination`
		* `W_NoninteractiveSpinner`
		* `W_SessionBrowserScreen`
		* `ULyraHUDLayout`
			* `W_DefaultHUDLayout`
			* `W_FrontEndHUDLayout`
			* `W_ShooterHUDLayout`
			* `W_ShooterReplayHUD`
			* `W_TopDownArenaHUDLayout`


### ULyraActivatableWidget::InputConfig

> The desired input mode to use while this UI is activated, for example do you want key presses to still reach the game/player controller?  
> 
> ----
> この UI が有効なときに使用する入力モードです。例えば、キー操作をゲーム/プレーヤーコントローラーにそのまま反映させたいですか？  

* 概要
	* [ELyraWidgetInputMode] を指定します。
	* 入力を widget / ゲーム / 両方 のいずれに渡すかを指定します。

### ULyraActivatableWidget::GameMouseCaptureMode

> The desired mouse behavior when the game gets input.
> 
> ----
> ゲームに入力があったときのマウスの望ましい動作です。  

* 概要
	* [EMouseCaptureMode] を指定します。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UCommonActivatableWidget]: ../../Plugin/CommonUI/UCommonActivatableWidget.md#ucommonactivatablewidget
[EMouseCaptureMode]: ../../UE/Engine/EMouseCaptureMode.md#emousecapturemode
