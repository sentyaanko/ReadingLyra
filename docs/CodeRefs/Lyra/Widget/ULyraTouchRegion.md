## ULyraTouchRegion

> A "Touch Region" is used to define an area on the screen that should trigger some input when the user presses a finger on it
> 
> ----
> "Touch Region" は、ユーザーが指で触れたときに何らかの入力を引き起こす画面上の領域を定義するために使用されます。

* 概要
	* [ULyraSimulatedInputWidget] の派生クラスです。
	* 派生ブループリントは以下の通りです。
		* [ULyraTouchRegion]
			* `W_TouchRegion_Base`
				* `W_TouchRegion_Left`
				* `W_TouchRegion_Right`
	* `W_TouchRegion_Left` / `W_TouchRegion_Right` について
		* これらはそれぞれ左右に配置する、仮想ボタン用の widget です。
		* LAS_ShooterGame_StandardHUD` ([ULyraExperienceActionSet]) にて [UGameFeatureAction_AddWidgets] を利用することで画面に配置されています。
		> Note:  
		> もともと右側の操作用に実装したものを左側にも利用するように拡張したようで、  
		> `W_TouchRegion_Base` に右側用の `IA_Weapon_Fire` が設定されていたりします。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraTouchRegion]: #ulyratouchregion
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureactionaddwidgets
[ULyraSimulatedInputWidget]: ../../Lyra/Widget/ULyraSimulatedInputWidget.md#ulyrasimulatedinputwidget
