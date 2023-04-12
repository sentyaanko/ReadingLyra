## ULyraPerfStatContainerBase

> Panel that contains a set of ULyraPerfStatWidgetBase widgets and manages their visibility based on user settings.  
> 
> ----
> ULyraPerfStatWidgetBase ウィジェットのセットを含み、ユーザーの設定に基づいてそれらの可視性を管理するパネルです。  

* 概要
	* `UCommonUserWidget` の派生クラスです。
	* [ULyraPerfStatWidgetBase] 派生クラスのコンテナとなる widget です。
	* 派生ブループリントは以下の通りです。
		* [ULyraPerfStatContainerBase]
			* `W_PerfStatContainer_FrontEnd`
			* `W_PerfStatContainer_GraphOnly`
			* `W_PerfStatContainer_TextOnly`
	* `W_PerfStatContainer_FrontEnd` について
		* `B_LyraFrontEnd_Experience` ([ULyraExperienceDefinition]) にて [UGameFeatureAction_AddWidgets] を利用することで画面に配置されています。
	* `W_PerfStatContainer_GraphOnly` / `W_PerfStatContainer_TextOnly` について
		* `LAS_ShooterGame_StandardHUD` ([ULyraExperienceActionSet]) にて [UGameFeatureAction_AddWidgets] を利用することで画面に配置されています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraPerfStatContainerBase]: #ulyraperfstatcontainerbase
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureactionaddwidgets
[ULyraPerfStatWidgetBase]: ../../Lyra/PerformanceStats/ULyraPerfStatWidgetBase.md#ulyraperfstatwidgetbase
