## UGameFeatureAction

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameFeatures > UGameFeatureAction](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameFeatures/UGameFeatureAction/)

> Represents an action to be taken when a game feature is activated  
> 
> ----
> GameFeature がアクティブになったときに実行されるアクションを表します。

* 概要
	* `UObject` の派生クラスです。
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
		| Asset                                                                | [UGameFeatureAction]                        |
		| -------------------------------------------------------------------- | ------------------------------------------- |
		| `ShooterCore`<br>([UGameFeatureData])                                | [UGameFeatureAction_AddComponents]          |
		|                                                                      | [UGameFeatureAction_DataRegistry]           |
		|                                                                      | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                      | [UGameFeatureAction_AddInputConfig]         |
		| `TopDownArena`<br>([UGameFeatureData])                               | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                      | [UGameFeatureAction_AddInputConfig]         |
		| `ShooterMaps`<br>([UGameFeatureData])                                | [UGameFeatureAction_AddGameplayCuePath]     |
		|                                                                      |                                             |
		| `EAS_BasicShooterAcolades`<br>([ULyraExperienceActionSet])           | [UGameFeatureAction_AddComponents]          |
		| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])                  | [UGameFeatureAction_AddInputContextMapping] |
		|                                                                      | [UGameFeatureAction_AddInputBinding]        |
		|                                                                      | [UGameFeatureAction_AddAbilities]           |
		| `LAS_ShooterGame_SharedInput`<br>([ULyraExperienceActionSet])        | [UGameFeatureAction_AddInputContextMapping] |
		|                                                                      | [UGameFeatureAction_AddInputBinding]        |
		| `LAS_ShooterGame_StandardComponents`<br>([ULyraExperienceActionSet]) | [UGameFeatureAction_AddComponents]          |
		| `LAS_ShooterGame_StandardHUD`<br>([ULyraExperienceActionSet])        | [UGameFeatureAction_AddWidgets]             |
		|                                                                      |                                             |
		| `B_LyraDefaultExperience`<br>([ULyraExperienceDefinition])           | [UGameFeatureAction_AddWidgets]             |
		| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])         | [UGameFeatureAction_SplitscreenConfig]      |
		|                                                                      | [UGameFeatureAction_AddComponents]          |
		|                                                                      | [UApplyFrontendPerfSettingsAction]          |
		|                                                                      | [UGameFeatureAction_AddWidgets]             |
		| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])   | [UGameFeatureAction_AddWidgets]             |
		|                                                                      | [UGameFeatureAction_AddAbilities]           |
		|                                                                      | [UGameFeatureAction_AddComponents]          |
		| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])         | [UGameFeatureAction_AddAbilities]           |
		|                                                                      | [UGameFeatureAction_AddComponents]          |
		|                                                                      | [UGameFeatureAction_AddWidgets]             |
		| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])         | [UGameFeatureAction_AddWidgets]             |
		|                                                                      | [UGameFeatureAction_AddAbilities]           |
		|                                                                      | [UGameFeatureAction_AddComponents]          |
		| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])          | [UGameFeatureAction_AddWidgets]             |
		|                                                                      | [UGameFeatureAction_SplitscreenConfig]      |
		|                                                                      | [UGameFeatureAction_AddComponents]          |

### UGameFeatureAction::OnGameFeatureRegistering()

> Called when the object owning the action is registered for possible activation, this is called even if a feature never activates  
> 
> ----
> アクションを所有するオブジェクトが起動可能に登録されたときに呼び出され、これは Feature が起動しない場合でも呼び出されます。  

### UGameFeatureAction::OnGameFeatureUnregistering()

> Called to unregister an action, it will not be activated again without being registered again  
> 
> ----
> アクションの登録を解除するために呼び出され、再度登録しなければ再び起動することはありません。  

### UGameFeatureAction::OnGameFeatureLoading()

> Called to indicate that a feature is being loaded for activation in the near future  
> 
> ----
> 近い将来に起動するために Feature がロードされていることを示すために呼び出されます。 

### UGameFeatureAction::OnGameFeatureActivating()

> Called when the feature is actually applied  
> 
> ----
> Feature が実際に適用されるときに呼び出されます。  

### UGameFeatureAction::OnGameFeatureDeactivating()

> Called when game feature is deactivated, it may be activated again in the near future  
> 
> ----
> Game Feature が無効化されたときに呼び出され、近い将来に再び有効化される可能性もあります。  


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction]: #ugamefeatureaction
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceActionSet::Actions]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionsetactions
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceDefinition::Actions]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitionactions
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[UApplyFrontendPerfSettingsAction]: ../../Lyra/GameFeature/UApplyFrontendPerfSettingsAction.md#uapplyfrontendperfsettingsaction
[UGameFeatureAction_AddAbilities]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilities
[UGameFeatureAction_AddGameplayCuePath]: ../../Lyra/GameFeature/UGameFeatureAction_AddGameplayCuePath.md#ugamefeatureactionaddgameplaycuepath
[UGameFeatureAction_AddInputBinding]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md#ugamefeatureactionaddinputbinding
[UGameFeatureAction_AddInputConfig]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureactionaddinputconfig
[UGameFeatureAction_AddInputContextMapping]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureactionaddinputcontextmapping
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureactionaddwidgets
[UGameFeatureAction_SplitscreenConfig]: ../../Lyra/GameFeature/UGameFeatureAction_SplitscreenConfig.md#ugamefeatureactionsplitscreenconfig
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureactionaddcomponents
[UGameFeatureAction_DataRegistry]: ../../UE/GameFeature/UGameFeatureAction_DataRegistry.md#ugamefeatureactiondataregistry
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UGameFeatureData::Actions]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedataactions
