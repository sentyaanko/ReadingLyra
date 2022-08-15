## UUIExtensionPointWidget

> A slot that defines a location in a layout, where content can be added later  
> 
> ----
> レイアウト内の位置を定義するスロットで、後からコンテンツを追加することができます。  

* 概要
	* `UDynamicEntryBoxBase` の派生クラスです。
* Lyra での使われ方
	* [UGameFeatureAction_AddWidgets] を利用してモジュール式に widget を配置する際に使用する、レイアウト用 widget に設置しています。
	* そうすることでこのコンポーネントの位置に任意の widget を表示させています。


## UUIExtensionPointWidget::ExtensionPointTag

> The tag that defines this extension point  
> 
> ----
> この拡張ポイントを定義するタグ  

* 概要
	* GameplayTag を指定します。
	* 実行時に任意の widget を表示させる際のキーとして利用します。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgets
