## UGameFeatureAction

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameFeatures > UGameFeatureAction](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameFeatures/UGameFeatureAction/)

> Represents an action to be taken when a game feature is activated  
> 
> ----
> GameFeature がアクティブになったときに実行されるアクションを表します。

* 概要
	* GameFeature がアクティブになったとき等に実行されるアクションを定義するための基底クラス。
* Lyra での使われ方
	* 以下の基底クラスとして利用。
		* [UApplyFrontendPerfSettingsAction]
		* [UGameFeatureAction_SplitscreenConfig]
		* [UGameFeatureAction_AddInputBinding]
		* [UGameFeatureAction_AddInputContextMapping]
		* [UGameFeatureAction_AddInputConfig]
		* [UGameFeatureAction_AddAbilities]
		* [UGameFeatureAction_AddWidgets]
		* [UGameFeatureAction_AddGameplayCuePath]
	* [ULyraExperienceManagerComponent] 
		* エクスペリエンスの実装手段として利用。
	* 以下のアセットで利用。
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
