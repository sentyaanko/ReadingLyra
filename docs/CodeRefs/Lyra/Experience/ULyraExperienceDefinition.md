## ULyraExperienceDefinition

> Definition of an experience  
> 
> ----
> エクスペリエンスの定義

* 以下の 6 種類
	* `B_LyraDefaultExperience` ([ULyraExperienceDefinition])
	* `B_LyraFrontEnd_Experience` ([ULyraExperienceDefinition])
	* `B_LyraShooterGame_ControlPoints` ([ULyraExperienceDefinition])
	* `B_ShooterGame_Elimination` ([ULyraExperienceDefinition])
	* `B_TestInventoryExperience` ([ULyraExperienceDefinition])
	* `B_TopDownArenaExperience` ([ULyraExperienceDefinition])



* エクスペリエンスを定義するデータアセット。
* `GameFeaturesToEnable` にて使用する [UGameFeatureData] を `Plugins/GameFeatures` 内のプラグイン名で指定。
* `WolrdSettings > Game Mode > Default Gameplay Experience` で指定される。
* [ALyraGameMode]`::HandleMatchAssignmentIfNotExpectingOne()` でアセットがロードされ、設定された内容はその後に利用される。

各エクスペリエンスで指定している [UGameFeatureData]

| アセット名                      | GameFeaturesToEnable | 
|---------------------------------|----------------------|
| B_LyraShooterGame_ControlPoints | ShooterCore          |
| B_ShooterGame_Elimination       | ShooterCore          |
| B_TopDownArenaExperience        | TopDownArena         |
| B_TestInventoryExperience       | ShooterCore          |
| B_LyraFrontEnd_Experience       | (null)               |
| B_LyraDefaultExperience         | (null)               |

各レベル（の WorldSettings ）で指定しているエクスペリエンス

| レベル名                    | WolrdSettings > Game Mode > Default Gameplay Experience |
|-----------------------------|---------------------------------------------------------|
| L_Convolution_Blockout      | B_LyraShooterGame_ControlPoints                         |
| L_Expanse                   | B_ShooterGame_Elimination                               |
| L_Expanse_Blockout          | B_ShooterGame_Elimination                               |
| L_FiringRange_WP            | B_ShooterGame_Elimination                               |
| L_ShooterGym                | B_ShooterGame_Elimination                               |
| L_TopDownArenaGym           | B_TopDownArenaExperience                                |
| L_InventoryTestMap          | B_TestInventoryExperience                               |
| L_LyraFrontEnd              | B_LyraFrontEnd_Experience                               |
| L_DefaultEditorOverview     | None (B_LyraDefaultExperience)                          |
| L_ShooterFrontendBackground | None (B_LyraDefaultExperience)                          |

B_LyraDefaultExperience はレベル（の WorldSettings ）で指定していない場合に使用されるデフォルト値。  
C++ の [ALyraGameMode] で直接指定されている。



### ULyraExperienceDefinition::DefaultPawnData

> The default pawn class to spawn for players
> 
> ----


### ULyraExperienceDefinition::Actions

> List of actions to perform as this experience is loaded/activated/deactivated/unloaded  
> 
> ----

* [UGameFeatureAction] の配列。



### ULyraExperienceDefinition::ActionSets

> List of additional action sets to compose into this experience  
> 
> ----

* [ULyraExperienceActionSet] の配列。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ALyraGameMode]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
