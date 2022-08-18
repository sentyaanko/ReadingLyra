## UGameFeatureAction_AddWidgets

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----
> 指定されたタイプのアクターに GameplayAbility（と Attribute ）を付与する責任を持つ GameFeatureAction です。	
>> Note: UGameFeatureAction_AddAbilities のコピペなので実態に即していません。

* 概要
	* [UGameFeatureAction_WorldActionBase] の派生クラスです。
	* Game Feature がアクティブになった際に widget の追加を行う GameFeatureAction です。
	* 例： `LAS_ShooterGame_StandardHUD` ([ULyraExperienceActionSet])
		* [UGameFeatureAction_AddWidgets::Widgets] の 0 項目目で `HUD.Slot.EliminationFeed` / `W_EliminationFeed` を指定しています。
		* [UGameFeatureAction_AddWidgets::Layout] で `W_ShooterHUDLayout` を指定しています。
		* `W_ShooterHUDLayout` では [UUIExtensionPointWidget::ExtensionPointTag] が `HUD.Slot.EliminationFeed` に設定している `ExtensionPoint_ModeStatus_1` が左下あたりに配置されています。
		* この設定によって、 `W_ShooterHUDLayout` の `ExtensionPoint_ModeStatus_1` の位置に `W_EliminationFeed` が置かれます。


### UGameFeatureAction_AddWidgets::Layout

> Layout to add to the HUD
> 
> ----
> HUD に追加するレイアウトです。  

* 概要
	* [FLyraHUDLayoutRequest] の配列です。
	* アセットの設定は以下の通りです。
		| Asset                                                               | LayoutClass ([ULyraHUDLayout])  | LayerID         |
		| ------------------------------------------------------------------- | ------------------------------- | --------------- |
		| `LAS_ShooterGame_StandardHUD`<br>([ULyraExperienceActionSet])       | `W_ShooterHUDLayout`            | `UI.Layer.Game` |
		| `B_LyraDefaultExperience`<br>([ULyraExperienceDefinition])          | `W_DefaultHUDLayout`            | `UI.Layer.Game` |
		| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])         | `W_TopDownArenaHUDLayout`       | `UI.Layer.Game` |


### UGameFeatureAction_AddWidgets::Widgets

> Widgets to add to the HUD
> 
> ----
> HUD に追加する widget です。  

* 概要
	* [FLyraHUDElementEntry] の配列です。
	* アセットの設定は以下の通りです。
		| Asset                                                               | WidgetClass ([FLyraHUDElementEntry])                              | SlotID                          |
		| ------------------------------------------------------------------- | ----------------------------------------------------------------- | ------------------------------- |
		| `LAS_ShooterGame_StandardHUD`<br>([ULyraExperienceActionSet])       | `W_EliminationFeed`<br>(`UUserWidget`)                            | `HUD.Slot.EliminationFeed`      |
		|                                                                     | `W_QuickBar`<br>([ULyraTaggedWidget])                             | `HUD.Slot.Equipment`            |
		|                                                                     | `W_AccoladeHostWidget`<br>([ULyraAccoladeHostWidget])             | `HUD.Slot.TopAccolades`         |
		|                                                                     | `W_WeaponReticleHost`<br>([ULyraWeaponUserInterface])             | `HUD.Slot.Reticle`              |
		|                                                                     | `W_PerfStatContainer_GraphOnly`<br>([ULyraPerfStatContainerBase]) | `HUD.Slot.PerfStats.Graph`      |
		|                                                                     | `W_PerfStatContainer_TextOnly`<br>([ULyraPerfStatContainerBase])  | `HUD.Slot.PerfStats.Text`       |
		|                                                                     | `W_OnScreenJoystick_Left`<br>([ULyraJoystickWidget])              | `HUD.Slot.LeftSideTouchInputs`  |
		|                                                                     | `W_OnScreenJoystick_Right`<br>([ULyraJoystickWidget])             | `HUD.Slot.RightSideTouchInputs` |
		|                                                                     | `W_FireButton`<br>(`UUserWidget`)                                 | `HUD.Slot.RightSideTouchInputs` |
		|                                                                     | `W_TouchRegion_Right`<br>([ULyraTouchRegion])                     | `HUD.Slot.RightSideTouchRegion` |
		|                                                                     | `W_TouchRegion_Left`<br>([ULyraTouchRegion])                      | `HUD.Slot.LeftSideTouchRegion`  |
		| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])        | `W_PerfStatContainer_FrontEnd`<br>([ULyraPerfStatContainerBase])  | `HUD.Slot.PerfStats.Text`       |
		| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])  | `W_CPScoreWidget`<br>([ULyraTaggedWidget])                        | `HUD.Slot.TeamScore`            |
		|                                                                     | `W_ControlPointStatusWidget`<br>([ULyraTaggedWidget])             | `HUD.Slot.ModeStatus`           |
		| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])        | `W_ScoreWidget_Elimination`<br>([ULyraTaggedWidget])              | `HUD.Slot.TeamScore`            |
		| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])        | `W_CPScoreWidge`<br>([ULyraTaggedWidget])                         | `HUD.Slot.TeamScore`            |
		|                                                                     | `W_ControlPointStatusWidget`<br>([ULyraTaggedWidget])             | `HUD.Slot.ModeStatus`           |




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[FLyraHUDElementEntry]: ../../Lyra/GameFeature/FLyraHUDElementEntry.md#flyrahudelemententry
[FLyraHUDLayoutRequest]: ../../Lyra/GameFeature/FLyraHUDLayoutRequest.md#flyrahudlayoutrequest
[UGameFeatureAction_AddWidgets::Layout]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgetslayout
[UGameFeatureAction_AddWidgets::Widgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgetswidgets
[UGameFeatureAction_WorldActionBase]: ../../Lyra/GameFeature/UGameFeatureAction_WorldActionBase.md#ugamefeatureaction_worldactionbase
[ULyraAccoladeHostWidget]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidget
[ULyraHUDLayout]: ../../Lyra/Widget/ULyraHUDLayout.md#ulyrahudlayout
[ULyraJoystickWidget]: ../../Lyra/Widget/ULyraJoystickWidget.md#ulyrajoystickwidget
[ULyraPerfStatContainerBase]: ../../Lyra/Widget/ULyraPerfStatContainerBase.md#ulyraperfstatcontainerbase
[ULyraTaggedWidget]: ../../Lyra/Widget/ULyraTaggedWidget.md#ulyrataggedwidget
[ULyraTouchRegion]: ../../Lyra/Widget/ULyraTouchRegion.md#ulyratouchregion
[ULyraWeaponUserInterface]: ../../Lyra/Widget/ULyraWeaponUserInterface.md#ulyraweaponuserinterface
[UUIExtensionPointWidget::ExtensionPointTag]: ../../Plugin/UIExtension/UUIExtensionPointWidget.md#uuiextensionpointwidgetextensionpointtag
