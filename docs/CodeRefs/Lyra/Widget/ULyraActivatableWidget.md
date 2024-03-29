## ULyraActivatableWidget

> An activatable widget that automatically drives the desired input config when activated  
> 
> ----
> アクティブにすると、目的の入力コンフィグを自動的に駆動するアクティブ化可能な widget です。  

* 概要
	* [UCommonActivatableWidget] の派生クラスです。
	* [ULyraHUDLayout] の基底クラスです。
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
		* [ULyraHUDLayout]
			* `W_DefaultHUDLayout`
			* `W_FrontEndHUDLayout`
			* `W_ShooterHUDLayout`
			* `W_ShooterReplayHUD`
			* `W_TopDownArenaHUDLayout`

### ULyraActivatableWidget::GetDesiredInputConfig()

* 概要
	* [UCommonActivatableWidget::GetDesiredInputConfig()] のオーバーライドです。
	* [ULyraActivatableWidget::InputConfig] と [ULyraActivatableWidget::GameMouseCaptureMode] の設定を [FUIInputConfig] にして返します。
	* [ULyraActivatableWidget::InputConfig] の設定値に関して
		* [ELyraWidgetInputMode::Default] の場合
			* 設定をしていない状態となり、親の widget の設定に従います。
			* 親も設定していない場合は以下の設定をしたのと同等の挙動になります。（これは [ELyraWidgetInputMode::Menu] を指定した際の挙動と同等です）
				* [ULyraActivatableWidget::InputConfig] に [ECommonInputMode::Menu] を設定。
				* [ULyraActivatableWidget::GameMouseCaptureMode] に [EMouseCaptureMode::NoCapture] を設定。
		* [ELyraWidgetInputMode::GameAndMenu] の場合
			* [FUIInputConfig::InputMode] に [ECommonInputMode::All] を設定。
			* [FUIInputConfig::MouseCaptureMode] に [ULyraActivatableWidget::GameMouseCaptureMode] の内容を設定。
		* [ELyraWidgetInputMode::Game] の場合
			* [FUIInputConfig::InputMode] に [ECommonInputMode::Game] を設定。
			* [FUIInputConfig::MouseCaptureMode] に [ULyraActivatableWidget::GameMouseCaptureMode] の内容を設定。
		* [ELyraWidgetInputMode::Menu] の場合
			* [FUIInputConfig::InputMode] に [ECommonInputMode::Menu] を設定。
			* [FUIInputConfig::MouseCaptureMode] に [EMouseCaptureMode::NoCapture] を設定。

### ULyraActivatableWidget::InputConfig

> The desired input mode to use while this UI is activated, for example do you want key presses to still reach the game/player controller?  
> 
> ----
> この UI が有効なときに使用する入力モードです。例えば、キー操作をゲーム/プレーヤーコントローラーにそのまま反映させたいですか？  

* 概要
	* [ELyraWidgetInputMode] を指定します。
		* [ECommonInputMode] 型ではないのは、 [ELyraWidgetInputMode::Default] を追加することで親の設定に従う仕組みを実装するためです。
	* 入力を widget / ゲーム / 両方 のいずれに渡すかを指定します。
	* [ULyraActivatableWidget::GetDesiredInputConfig()] 内で [FUIInputConfig::InputMode] を決定するために利用する値です。

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
[ULyraActivatableWidget::GetDesiredInputConfig()]: #ulyraactivatablewidgetgetdesiredinputconfig
[ULyraActivatableWidget::InputConfig]: #ulyraactivatablewidgetinputconfig
[ULyraActivatableWidget::GameMouseCaptureMode]: #ulyraactivatablewidgetgamemousecapturemode
[ELyraWidgetInputMode]: ../../Lyra/Widget/ELyraWidgetInputMode.md#elyrawidgetinputmode
[ELyraWidgetInputMode::Default]: ../../Lyra/Widget/ELyraWidgetInputMode.md#elyrawidgetinputmodedefault
[ELyraWidgetInputMode::GameAndMenu]: ../../Lyra/Widget/ELyraWidgetInputMode.md#elyrawidgetinputmodegameandmenu
[ELyraWidgetInputMode::Game]: ../../Lyra/Widget/ELyraWidgetInputMode.md#elyrawidgetinputmodegame
[ELyraWidgetInputMode::Menu]: ../../Lyra/Widget/ELyraWidgetInputMode.md#elyrawidgetinputmodemenu
[ULyraHUDLayout]: ../../Lyra/Widget/ULyraHUDLayout.md#ulyrahudlayout
[ECommonInputMode]: ../../Plugin/CommonUI/ECommonInputMode.md#ecommoninputmode
[ECommonInputMode::Menu]: ../../Plugin/CommonUI/ECommonInputMode.md#ecommoninputmodemenu
[ECommonInputMode::Game]: ../../Plugin/CommonUI/ECommonInputMode.md#ecommoninputmodegame
[ECommonInputMode::All]: ../../Plugin/CommonUI/ECommonInputMode.md#ecommoninputmodeall
[FUIInputConfig]: ../../Plugin/CommonUI/FUIInputConfig.md#fuiinputconfig
[FUIInputConfig::InputMode]: ../../Plugin/CommonUI/FUIInputConfig.md#fuiinputconfiginputmode
[FUIInputConfig::MouseCaptureMode]: ../../Plugin/CommonUI/FUIInputConfig.md#fuiinputconfigmousecapturemode
[UCommonActivatableWidget]: ../../Plugin/CommonUI/UCommonActivatableWidget.md#ucommonactivatablewidget
[UCommonActivatableWidget::GetDesiredInputConfig()]: ../../Plugin/CommonUI/UCommonActivatableWidget.md#ucommonactivatablewidgetgetdesiredinputconfig
[EMouseCaptureMode]: ../../UE/Engine/EMouseCaptureMode.md#emousecapturemode
[EMouseCaptureMode::NoCapture]: ../../UE/Engine/EMouseCaptureMode.md#emousecapturemodenocapture
