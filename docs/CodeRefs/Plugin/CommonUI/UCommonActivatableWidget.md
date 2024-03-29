## UCommonActivatableWidget

>> 詳細は未確認です。

> The base for widgets that are capable of being "activated" and "deactivated" during their lifetime without being otherwise modified or destroyed.   
>
> This is generally desired for one or more of the following purposes:  
> - This widget can turn on/off without being removed from the hierarchy (or otherwise reconstructing the underlying SWidgets), so Construct/Destruct are insufficient
> - You'd like to be able to "go back" from this widget, whether that means back a breadcrumb, closing a modal, or something else. This is built-in here.
> - This widget's place in the hierarchy is such that it defines a meaningful node-point in the tree of activatable widgets through which input is routed to all widgets.
>
> By default, an activatable widget:  
> - Is not automatically activated upon construction
> - Does not register to receive back actions (or any other actions, for that matter)
> - If classified as a back handler, is automatically deactivated (but not destroyed) when it receives a back action
> 
> Note that removing an activatable widget from the UI (i.e. triggering Destruct()) will always deactivate it, even if the UWidget is not destroyed.  
> Re-constructing the underlying SWidget will only result in re-activation if auto-activate is enabled.  
>
> TODO: ADD MORE INFO ON INPUTS  
> ----
>  ウィジェットが生きている間に、変更も破壊もされずに "活性化 "と "非活性化 "が可能なウィジェットのベースです。  
>
> これは、一般に、以下の目的の一つ以上のために望まれる。
> - このウィジェットは、階層から削除されることなく(あるいは、基礎となる SWidgets を再構築することなく)オン/オフでき、 構築/破棄 では不適当である。
> - このウィジェットから「戻る」ことができるようにしたい。パンくずを戻したり、モーダルを閉じたり、その他の手段でもよい。これは、ここに組み込まれています。
> - このウィジェットの階層での位置は、アクティブ化可能なウィジェットのツリーの中で、入力がすべてのウィジェットに送られる意味のあるノードポイントを定義するようなものです。
>
> デフォルトでは、アクティブ化可能なウィジェットは
> - 構築時に自動的にアクティブ化されない
> - バックアクション(または他のアクション)を受信するように登録しない。
> - バックハンドラとして分類される場合、バックアクションを受信すると自動的に非アクティブになる（ただし、破壊されない）。
> 
> UI からアクティブなウィジェットを削除する (すなわち Destruct() をトリガーする) と、UWidget が破壊されていなくても、常に非アクティブになることに注意してください。
> 基盤となる SWidget を再構築すると、自動起動が有効な場合のみ、再活性化されます。
>
> TODO: 入力に関するより詳細な情報を追加

* 概要
	* `UCommonUserWidget` の派生クラスです。
* Lyra での使われ方
	* 派生クラスとして以下があります。
		* `UGameSettingPressAnyKey`
		* `UGameSettingScreen`
		* `UCommonGameDialog`
		* [ULyraActivatableWidget]
	* [UPrimaryGameLayout] にて UI を置くためのレイヤーを登録する際の UI のレイアウト情報の型として使用しています。
	* [UCommonUIExtensions] にて UI をレイヤーに追加する際の型として使用しています。
	* [ULyraFrontendStateComponent] にて PressStart や Main の UI の情報として保持しています。

### UCommonActivatableWidget::GetDesiredInputConfig()

> Gets the desired input configuration to establish when this widget activates and can receive input (i.e. all parents are also active).  
> This configuration will override the existing one established by any previous activatable widget and restore it (if valid) upon deactivation.  
> 
> ----
> このウィジェットがアクティブになり、入力を受け取れるようになったときに確立したい入力構成を取得します (つまり、すべての親もアクティブになります)。  
> この設定は、以前のアクティブなウィジェットによって確立された既存のものを上書きし、非アクティブ化時に (有効であれば) 復元されます。

* 概要
	* widget が入力をどのように扱うかを取得するための仮想関数です。
	* [FUIInputConfig] を返します。
* Lyra での使われ方
	* [ULyraActivatableWidget::GetDesiredInputConfig()] でオーバーライドしています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraFrontendStateComponent]: ../../Lyra/Etc/ULyraFrontendStateComponent.md#ulyrafrontendstatecomponent
[ULyraActivatableWidget]: ../../Lyra/Widget/ULyraActivatableWidget.md#ulyraactivatablewidget
[ULyraActivatableWidget::GetDesiredInputConfig()]: ../../Lyra/Widget/ULyraActivatableWidget.md#ulyraactivatablewidgetgetdesiredinputconfig
[UCommonUIExtensions]: ../../Plugin/CommonGame/UCommonUIExtensions.md#ucommonuiextensions
[UPrimaryGameLayout]: ../../Plugin/CommonGame/UPrimaryGameLayout.md#uprimarygamelayout
[FUIInputConfig]: ../../Plugin/CommonUI/FUIInputConfig.md#fuiinputconfig
