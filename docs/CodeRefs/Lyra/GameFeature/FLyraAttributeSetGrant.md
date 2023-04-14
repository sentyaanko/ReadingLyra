## FLyraAttributeSetGrant

* 概要
	* Gameplay Ability を付与するために [UGameFeatureAction_AddAbilities] が使用するデータです。
	* アトリビュートセットの付与で利用する情報を納めるための構造体です。

### FLyraAttributeSetGrant::AttributeSetType
> Ability set to grant
> 
> ----
> 付与するアビリティセットです。

* 概要
	* `UAttributeSet` 派生クラスを指定します。

### FLyraAttributeSetGrant::InitializationData
> Data table referent to initialize the attributes with, if any (can be left unset)
> 
> ----
> アトリビュートを初期化するためのデータテーブル参照があれば指定します。（未設定のままでも可）

* 概要
	* `UDataTable` 派生クラスを指定します。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction_AddAbilities]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilities
