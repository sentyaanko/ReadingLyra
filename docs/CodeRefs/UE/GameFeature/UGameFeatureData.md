## UGameFeatureData

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameFeatures > UGameFeatureData](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameFeatures/UGameFeatureData/)

> Data related to a game feature, a collection of code and content that adds a separable discrete feature to the game  
> 
> ----
> GameFeature に関連するデータです。これは、ゲームに分離可能な個別の機能を追加するコードとコンテンツの集合体です。  

* 概要
	* `UPrimaryDataAsset` の派生クラスです。
	* GameFeature を作成するためのデータアセットです。
* Lyra での使われ方
	* 以下の 3 つのアセットが存在します。
		* `ShooterCore` ([UGameFeatureData])
		* `TopDownArena` ([UGameFeatureData])
		* `ShooterMaps` ([UGameFeatureData])


### UGameFeatureData::Actions

> List of actions to perform as this game feature is loaded/activated/deactivated/unloaded  
> 
> ----
> この GameFeature のロード/アクティブ化/非アクティブ化/アンロードに伴って実行されるアクションの一覧です。  

* 概要
	* [UGameFeatureAction] の配列です。
	* この GameFeature で使用したいアクションを設定します。
* Lyra での使われ方
	* [UGameFeatureAction] の表を参照してください。


### UGameFeatureData::PrimaryAssetTypesToScan

> List of asset types to scan at startup  
> 
> ----
> 起動時にスキャンするアセットタイプのリストです。  

* 概要
	* [FPrimaryAssetTypeInfo] の配列です。
	* この GameFeature で使用したい AssetManager への設定項目を設定します。
* Lyra での使われ方
	* [FPrimaryAssetTypeInfo] の表を参照してください。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FPrimaryAssetTypeInfo]: ../../UE/AssetManager/FPrimaryAssetTypeInfo.md#fprimaryassettypeinfo
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
