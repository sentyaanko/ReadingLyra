## FLyraHUDLayoutRequest

* 概要
	* widget を追加するために [UGameFeatureAction_AddWidgets] が使用するデータです。
	* 使用するレイアウト用 widget とレイヤー ID を指定します。
	* 構築は [UCommonUIExtensions] を利用します。

### FLyraHUDLayoutRequest::LayoutClass

> The layout widget to spawn
> 
> ----
> 生成するレイアウト用 widget です。

* 概要
	* [UCommonActivatableWidget] を指定します。

### FLyraHUDLayoutRequest::LayerID

> The layer to insert the widget in
> 
> ----
> widget を挿入するレイヤーです。

* 概要
	* GameplayTag を指定します。
	* 指定できる値は `W_OverallUILayout` ([UPrimaryGameLayout]) でセットアップされており、以下の 4 種類です。
		* `UI.Layout.Game`
		* `UI.Layout.GameMenu`
		* `UI.Layout.Menu`
		* `UI.Layout.Modal`
	* プライオリティも `W_OverallUILayout` ([UPrimaryGameLayout]) のセットアップに従います。すなわち、上記の順番に描画されます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgets
[UCommonUIExtensions]: ../../Plugin/CommonGame/UCommonUIExtensions.md#ucommonuiextensions
[UPrimaryGameLayout]: ../../Plugin/CommonGame/UPrimaryGameLayout.md#uprimarygamelayout
[UCommonActivatableWidget]: ../../Plugin/CommonUI/UCommonActivatableWidget.md#ucommonactivatablewidget
