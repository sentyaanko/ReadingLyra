## UPrimaryGameLayout

>> 詳細は未確認です。

> The primary game UI layout of your game.  
> This widget class represents how to layout, push and display all layers of the UI for a single player.  
> Each player in a split-screen game will receive their own primary game layout.  
> 
> ----
> ゲームの主要な UI レイアウトです。  
> このウィジェットクラスは、 1 人のプレーヤーのために UI の全レイヤーをレイアウト、プッシュ、表示する方法を表します。 
> 分割画面のゲームでは、各プレイヤーにそれぞれのプライマリゲームレイアウトが表示されます。 

* 概要
	* `UCommonUserWidget` の派生クラスです。
	* レイアウトをセットアップするための基底クラスで、ユーザーは派生クラスでレイアウトに関する設定を行います。
* Lyra での使われ方
	* [UGameFeatureAction_AddWidgets] にて widget のレイアウトを追加する際に利用しています。
	* `W_OverallUILayout` の基底クラスです。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureactionaddwidgets
