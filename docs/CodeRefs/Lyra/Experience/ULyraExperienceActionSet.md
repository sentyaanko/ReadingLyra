## ULyraExperienceActionSet

> Definition of a set of actions to perform as part of entering an experience  
> 
> ----
> エクスペリエンスに入るために行う一連の動作の定義です。  

* 概要
	* `UPrimaryDataAsset` の派生クラスです。
	* エクスペリエンスを実現するために実行する GameFeatureAction を定義するデータアセットです。
	* [UGameFeatureAction] の配列を保持します。
	* [ULyraExperienceDefinition::ActionSets] で利用されます。
	* 派生ブループリントは以下のとおりです。
		* `EAS_BasicShooterAcolades`
			> * プレフィックスが ``EAS_`` な理由は不明です。
			> * Acolades は Accolades の typo だと思われます。
		* `LAS_InventoryTest`
		* `LAS_ShooterGame_SharedInput`
		* `LAS_ShooterGame_StandardComponents`
		* `LAS_ShooterGame_StandardHUD`



### ULyraExperienceActionSet::Actions

> List of actions to perform as this experience is loaded/activated/deactivated/unloaded  
> 
> ----

* 概要
	* [UGameFeatureAction] の配列です。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceDefinition::ActionSets]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitionactionsets
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
