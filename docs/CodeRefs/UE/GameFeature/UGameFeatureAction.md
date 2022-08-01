## UGameFeatureAction

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameFeatures > UGameFeatureAction](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameFeatures/UGameFeatureAction/)

> Represents an action to be taken when a game feature is activated  
> 
> ----
> GameFeature がアクティブになったときに実行されるアクションを表します。

* 概要
	* GameFeature がアクティブになったとき等に実行されるアクションの基底クラスです。
* Lyra での使われ方
	* 以下の基底クラスとして利用しています。
		* [UApplyFrontendPerfSettingsAction]
		* [UGameFeatureAction_SplitscreenConfig]
		* [UGameFeatureAction_AddInputBinding]
		* [UGameFeatureAction_AddInputContextMapping]
		* [UGameFeatureAction_AddInputConfig]
		* [UGameFeatureAction_AddAbilities]
		* [UGameFeatureAction_AddWidgets]
		* [UGameFeatureAction_AddGameplayCuePath]
	* [ULyraExperienceManagerComponent] 
		* エクスペリエンスの実装手段として利用しています。
	* 以下のアセットで利用しています。
		* [UGameFeatureData::Actions]
		* [ULyraExperienceActionSet::Actions]
		* [ULyraExperienceDefinition::Actions]
	* 各アセットでの使用状況
		| Asset                                                              | [UGameFeatureAction]                        |
		| ------------------------------------------------------------------ | ------------------------------------------- |
		| `ShooterCore`<br>([UGameFeatureData])                              | [UGameFeatureAction_AddComponents]          |
		|                                                                    | [UGameFeatureAction_DataRegistry]           |
		|                                                                    | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                    | [UGameFeatureAction_AddInputConfig]         |
		| `TopDownArena`<br>([UGameFeatureData])                             | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                    | [UGameFeatureAction_AddInputConfig]         |
		| `ShooterMaps`<br>([UGameFeatureData])                              | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                    |                                             |
		| `EAS_BasicShooterAcolades`<br>([ULyraExperienceActionSet])         | [UGameFeatureAction_AddComponents]          |
		| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])                | [UGameFeatureAction_AddInputContextMapping] |
		|                                                                    | [UGameFeatureAction_AddInputBinding]        |
		|                                                                    | [UGameFeatureAction_AddAbilities]           |
		| `LAS_ShooterGame_SharedInput`<br>([ULyraExperienceActionSet])      | [UGameFeatureAction_AddInputContextMapping] |
		|                                                                    | [UGameFeatureAction_AddInputBinding]        |
		| `LAS_ShooterGame_SharedComponents`<br>([ULyraExperienceActionSet]) | [UGameFeatureAction_AddComponents]          |
		| `LAS_ShooterGame_SharedHUD`<br>([ULyraExperienceActionSet])        | [UGameFeatureAction_AddWidgets]             |
		|                                                                    |                                             |
		| `B_LyraDefaultExperience`<br>([ULyraExperienceDefinition])         | [UGameFeatureAction_AddWidgets]             |
		| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])       | [UGameFeatureAction_SplitscreenConfig]      |
		|                                                                    | [UGameFeatureAction_AddComponents]          |
		|                                                                    | [UApplyFrontendPerfSettingsAction]          |
		|                                                                    | [UGameFeatureAction_AddWidgets]             |
		| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition]) | [UGameFeatureAction_AddWidgets]             |
		|                                                                    | [UGameFeatureAction_AddAbilities]           |
		|                                                                    | [UGameFeatureAction_AddComponents]          |
		| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])       | [UGameFeatureAction_AddAbilities]           |
		|                                                                    | [UGameFeatureAction_AddComponents]          |
		|                                                                    | [UGameFeatureAction_AddWidgets]             |
		| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])       | [UGameFeatureAction_AddWidgets]             |
		|                                                                    | [UGameFeatureAction_AddAbilities]           |
		|                                                                    | [UGameFeatureAction_AddComponents]          |
		| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])        | [UGameFeatureAction_AddWidgets]             |
		|                                                                    | [UGameFeatureAction_SplitscreenConfig]      |
		|                                                                    | [UGameFeatureAction_AddComponents]          |


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceActionSet::Actions]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionsetactions
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceDefinition::Actions]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitionactions
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[UApplyFrontendPerfSettingsAction]: ../../Lyra/GameFeature/UApplyFrontendPerfSettingsAction.md#uapplyfrontendperfsettingsaction
[UGameFeatureAction_AddAbilities]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureaction_addabilities
[UGameFeatureAction_AddGameplayCuePath]: ../../Lyra/GameFeature/UGameFeatureAction_AddGameplayCuePath.md#ugamefeatureaction_addgameplaycuepath
[UGameFeatureAction_AddInputBinding]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md#ugamefeatureaction_addinputbinding
[UGameFeatureAction_AddInputConfig]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfig
[UGameFeatureAction_AddInputContextMapping]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureaction_addinputcontextmapping
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgets
[UGameFeatureAction_SplitscreenConfig]: ../../Lyra/GameFeature/UGameFeatureAction_SplitscreenConfig.md#ugamefeatureaction_splitscreenconfig
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
[UGameFeatureAction_DataRegistry]: ../../UE/GameFeature/UGameFeatureAction_DataRegistry.md#ugamefeatureaction_dataregistry
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UGameFeatureData::Actions]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedataactions
