## UGameFeatureAction_WorldActionBase

> Base class for GameFeatureActions that wish to do something world specific.  
> 
> ----
> ワールド固有の処理を行いたい GameFeatureActions のベースとなるクラスです。  

* 概要
	* [UGameFeatureAction_WorldActionBase] の派生クラスです。
	* Game Feature がアクティブになった際にワールド固有の処理を行う為の基底クラスです。
	* 以下のクラスの基底クラスです。
		* [UGameFeatureAction_AddAbilities]
		* [UGameFeatureAction_AddInputBinding]
		* [UGameFeatureAction_AddInputContextMapping]
		* [UGameFeatureAction_AddWidgets]
		* [UGameFeatureAction_SplitscreenConfig]
* 既存のドキュメント
	* [historia > (2021/06/18) > 【UE5】 プレイヤーの技などをプラグインで実装できる！　GameFeaturesプラグインの紹介]
		* `UMyAction_AddUi` という派生クラスの作成例と解説があります。

### UGameFeatureAction_WorldActionBase::OnGameFeatureActivating()

* 概要
	* [UGameFeatureAction::OnGameFeatureActivating()] のオーバーライドです。
	* [UGameFeatureAction_WorldActionBase::AddToWorld()] を呼び出します。

### UGameFeatureAction_WorldActionBase::AddToWorld()

> Override with the action-specific logic  
> 
> ----
> アクション固有のロジックでオーバーライドします。  

* 概要
	* 派生クラスでオーバーライドすることを想定している(`PURE_VIRTUAL マクロ` を使用している)仮想関数です。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction_AddAbilities]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilities
[UGameFeatureAction_AddInputBinding]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md#ugamefeatureactionaddinputbinding
[UGameFeatureAction_AddInputContextMapping]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureactionaddinputcontextmapping
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureactionaddwidgets
[UGameFeatureAction_SplitscreenConfig]: ../../Lyra/GameFeature/UGameFeatureAction_SplitscreenConfig.md#ugamefeatureactionsplitscreenconfig
[UGameFeatureAction_WorldActionBase]: ../../Lyra/GameFeature/UGameFeatureAction_WorldActionBase.md#ugamefeatureactionworldactionbase
[UGameFeatureAction_WorldActionBase::AddToWorld()]: ../../Lyra/GameFeature/UGameFeatureAction_WorldActionBase.md#ugamefeatureactionworldactionbaseaddtoworld
[UGameFeatureAction::OnGameFeatureActivating()]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureactionongamefeatureactivating
[historia > (2021/06/18) > 【UE5】 プレイヤーの技などをプラグインで実装できる！　GameFeaturesプラグインの紹介]: https://historia.co.jp/archives/21145/
