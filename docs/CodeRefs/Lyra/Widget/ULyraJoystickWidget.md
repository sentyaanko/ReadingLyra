## ULyraJoystickWidget

> This will calculate a 2D vector clamped between -1 and 1 to input as a key value to the player,  
> simulating a gamepad analog stick.  
> 
> This is intended for use with and Enhanced Input player.  
> 
> ----
> これは、 -1 から 1 の間でクランプされた 2 次元ベクトルを計算し、
> ゲームパッドのアナログスティックをシミュレートしてプレイヤーのキー値として入力するものです。
> これは Enhanced Input Player で使用するためのものです。

* 概要
	* [ULyraSimulatedInputWidget] の派生クラスです。
	* 派生ブループリントは以下の通りです。
		* [ULyraJoystickWidget]
			* `W_OnScreenJoystick_Right`
				* `W_OnScreenJoystick_Left`
	* `W_OnScreenJoystick_Right` / `W_OnScreenJoystick_Left` について
		* これらはそれぞれ左右に配置する、仮想ジョイスティック用の widget です。
		* LAS_ShooterGame_StandardHUD` ([ULyraExperienceActionSet]) にて [UGameFeatureAction_AddWidgets] を利用することで画面に配置されています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgets
[ULyraJoystickWidget]: ../../Lyra/Widget/ULyraJoystickWidget.md#ulyrajoystickwidget
[ULyraSimulatedInputWidget]: ../../Lyra/Widget/ULyraSimulatedInputWidget.md#ulyrasimulatedinputwidget
