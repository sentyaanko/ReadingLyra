## FLyraHUDElementEntry

* 概要
	* widget を追加するために [UGameFeatureAction_AddWidgets] が使用するデータです。
	* 配置する widget と配置先を示すスロット ID を指定します。
	* 構築は [UUIExtensionSubsystem] を利用します。

### FLyraHUDElementEntry::WidgetClass

> The widget to spawn
> 
> ----
> 生成する widget です。

* 概要
	* `UUserWidget` を指定します。

### FLyraHUDElementEntry::SlotID

> The slot ID where we should place this widget
> 
> ----
> この widget を配置するスロット ID です。

* 概要
	* GameplayTag を指定します。
	* [FLyraHUDLayoutRequest::LayoutClass] で指定されたレイアウト用の widget に配置された [UUIExtensionPointWidget] のプロパティ [UUIExtensionPointWidget::ExtensionPointTag] と同じ値を指定することでその位置に widget を表示させています。




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLyraHUDLayoutRequest::LayoutClass]: ../../Lyra/GameFeature/FLyraHUDLayoutRequest.md#flyrahudlayoutrequestlayoutclass
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureactionaddwidgets
[UUIExtensionPointWidget]: ../../Plugin/UIExtension/UUIExtensionPointWidget.md#uuiextensionpointwidget
[UUIExtensionPointWidget::ExtensionPointTag]: ../../Plugin/UIExtension/UUIExtensionPointWidget.md#uuiextensionpointwidgetextensionpointtag
[UUIExtensionSubsystem]: ../../Plugin/UIExtension/UUIExtensionSubsystem.md#uuiextensionsubsystem
