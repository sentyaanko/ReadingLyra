## ULyraSimulatedInputWidget

> A UMG widget with base functionality to inject input (keys or input actions) to the enhanced input subsystem.  
> 
> ----
> enhanced input subsystem に入力（キーまたは入力アクション）を注入するための基本機能を持つ UMG ウィジェットです。

* 概要
	* `UCommonUserWidget` の派生クラスです。
	* [ULyraJoystickWidget] / [ULyraTouchRegion] の基底クラスです。
		* これらはそれぞれ仮想的なジョイスティックやボタンのための基底クラスです。

### ULyraSimulatedInputWidget::AssociatedAction

> The associated input action that we should simulate input for  
> 
> ----
> 入力のシミュレーションを行うべき、関連する入力アクションです。

* 概要
	* この widget で注入するアクションを [UInputAction] で指定します。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraJoystickWidget]: ../../Lyra/Widget/ULyraJoystickWidget.md#ulyrajoystickwidget
[ULyraTouchRegion]: ../../Lyra/Widget/ULyraTouchRegion.md#ulyratouchregion
[UInputAction]: ../../UE/Input/UInputAction.md#uinputaction
