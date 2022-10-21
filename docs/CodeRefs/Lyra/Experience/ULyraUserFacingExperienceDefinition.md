## ULyraUserFacingExperienceDefinition

> Description of settings used to display experiences in the UI and start a new session  
> 
> ----
> UI にエクスペリエンスを表示したり、新しいセッションを開始するために使用する設定の説明です。  

* 概要
	* `UPrimaryDataAsset` の派生クラスです。
	* `L_DefaultEditorOverview` / `L_LyraFrontEnd` 等で表示される UI やポータルアクター等で利用されます。
	* *Project Settings > Game - Asset Manager > Asset Manager > Primary Asset Types of Scan > Index[5]* にて指定されています。
	* [UGameFeatureData] の `Game Feature > Asset Manager > Primary Asset Types to Scan` でも指定されています。
		* [UGameFeatureData] は以下の 3 つがあり、その全てで指定されています。
			* `ShooterMaps`
			* `ShooterCore`
			* `TopDownArena`
	* アセットは以下のとおりです。
		* `DA_ExamplePlaylist`
		* `DA_Frontend`
		* `DA_ShooterGame_ShooterGym`
		* `DA_Convolution_ControlPoint`
		* `DA_Expanse_TDM`
		* `DA_TopDownArena_Splode`

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
