## UGameFeatureData

> Data related to a game feature, a collection of code and content that adds a separable discrete feature to the game  
> 
> ----
> GameFeature に関連するデータ。これは、ゲームに分離可能な個別の機能を追加するコードとコンテンツの集合体です。  

* 概要
	* GameFeature を設定するためのデータアセット。
* Lyra での使われ方
	* 以下の 3 つのアセットが存在する。
		* `ShooterCore` ([UGameFeatureData])
		* `TopDownArena` ([UGameFeatureData])
		* `ShooterMaps` ([UGameFeatureData])


### UGameFeatureData::Actions

> List of actions to perform as this game feature is loaded/activated/deactivated/unloaded  
> 
> ----
> この GameFeature のロード/アクティブ化/非アクティブ化/アンロードに伴って実行されるアクションの一覧です。  

* 概要
	* [UGameFeatureAction] の配列。
	* この GameFeature で使用したいアクションを設定する。


### UGameFeatureData::PrimaryAssetTypesToScan

> List of asset types to scan at startup  
> 
> ----
> 起動時にスキャンするアセットタイプのリスト  

* 概要
	* [FPrimaryAssetTypeInfo] の配列。
	* この GameFeature で使用したい AssetManager への設定項目を設定する。
* Lyra での使われ方
	* [FPrimaryAssetTypeInfo] の表を参照。
