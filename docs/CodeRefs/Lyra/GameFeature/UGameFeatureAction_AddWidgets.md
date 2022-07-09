## UGameFeatureAction_AddWidgets

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----

* Lyra での使い方
	| Asset                                                               | LayoutClass<br>([ULyraHUDLayout])  | LayerID         | WidgetClass                                                       | SlotID                          |
	| ------------------------------------------------------------------- | ---------------------------------- | --------------- | ----------------------------------------------------------------- | ------------------------------- |
	| `LAS_ShooterGame_SharedHUD`<br>([ULyraExperienceActionSet])         | `W_ShooterHUDLayout`               | `UI.Layer.Game` | `W_EliminationFeed`<br>(`UUserWidget`)                            | `HUD.Slot.EliminationFeed`      |
	|                                                                     |                                    |                 | `W_QuickBar`<br>([ULyraTaggedWidget])                             | `HUD.Slot.Equipment`            |
	|                                                                     |                                    |                 | `W_AccoladeHostWidget`<br>([ULyraAccoladeHostWidget])             | `HUD.Slot.TopAccolades`         |
	|                                                                     |                                    |                 | `W_WeaponReticleHost`<br>([ULyraWeaponUserInterface])             | `HUD.Slot.Reticle`              |
	|                                                                     |                                    |                 | `W_PerfStatContainer_GraphOnly`<br>([ULyraPerfStatContainerBase]) | `HUD.Slot.PerfStats.Graph`      |
	|                                                                     |                                    |                 | `W_PerfStatContainer_TextOnly`<br>([ULyraPerfStatContainerBase])  | `HUD.Slot.PerfStats.Text`       |
	|                                                                     |                                    |                 | `W_OnScreenJoystick_Left`<br>([ULyraJoystickWidget])              | `HUD.Slot.LeftSideTouchInputs`  |
	|                                                                     |                                    |                 | `W_OnScreenJoystick_Right`<br>([ULyraJoystickWidget])             | `HUD.Slot.RightSideTouchInputs` |
	|                                                                     |                                    |                 | `W_FireButton`<br>(`UUserWidget`)                                 | `HUD.Slot.RightSideTouchInputs` |
	|                                                                     |                                    |                 | `W_TouchRegion_Right`<br>([ULyraTouchRegion])                     | `HUD.Slot.RightSideTouchRegion` |
	|                                                                     |                                    |                 | `W_TouchRegion_Left`<br>([ULyraTouchRegion])                      | `HUD.Slot.LeftSideTouchRegion`  |
	| `B_LyraDefaultExperience`<br>([ULyraExperienceDefinition])          | `W_DefaultHUDLayout`               |`UI.Layer.Game`  |                                                                   |                                 |
	| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])        |                                    |                 | `W_PerfStatContainer_FrontEnd`<br>([ULyraPerfStatContainerBase])  | `HUD.Slot.PerfStats.Text`       |
	| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])  |                                    |                 | `W_CPScoreWidget`<br>([ULyraTaggedWidget])                        | `HUD.Slot.TeamScore`            |
	|                                                                     |                                    |                 | `W_ControlPointStatusWidget`<br>([ULyraTaggedWidget])             | `HUD.Slot.ModeStatus`           |
	| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])        |                                    |                 | `W_ScoreWidget_Elimination`<br>([ULyraTaggedWidget])              | `HUD.Slot.TeamScore`            |
	| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])        |                                    |                 | `W_CPScoreWidge`<br>([ULyraTaggedWidget])                         | `HUD.Slot.TeamScore`            |
	|                                                                     |                                    |                 | `W_ControlPointStatusWidget`<br>([ULyraTaggedWidget])             | `HUD.Slot.ModeStatus`           |
	| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])         | `W_TopDownArenaHUDLayout`          | `UI.Layer.Game` |                                                                   |                                 |

