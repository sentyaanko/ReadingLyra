## UGameFeatureAction_AddInputBinding

> Adds InputMappingContext to local players' EnhancedInput system. 
> Expects that local players are set up to use the EnhancedInput system.  
> 
> ----
> ローカル プレイヤーの EnhancedInput システムに InputMappingContext を追加します。
> ローカル プレーヤーが EnhancedInput システムを使用するように設定されていることが期待されます。

* 概要
	* [UGameFeatureAction_WorldActionBase] の派生クラスです。
	* Game Feature がアクティブになった際に入力バインディングの追加を行う GameFeatureAction です。
	* 入力バインディングの追加を行う GameFeatureAction です。
	* アセットの設定は以下の通りです。
		| Asset                                                      | InputConfigs<br>([ULyraInputConfig]) |
		| ---------------------------------------------------------- | ------------------------------------ |
		| `LAS_InventoryTest` ([ULyraExperienceActionSet])           | `InputData_InventoryTest`            |
		| `LAS_ShooterGame_SharedInput` ([ULyraExperienceActionSet]) | `InputData_ShooterGame_AddOns`       |

### UGameFeatureAction_AddInputBinding::InputConfigs

* 概要
	* [ULyraInputConfig] の配列です。
	* 追加する入力バインディングをアセットで指定します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[UGameFeatureAction_WorldActionBase]: ../../Lyra/GameFeature/UGameFeatureAction_WorldActionBase.md#ugamefeatureactionworldactionbase
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
