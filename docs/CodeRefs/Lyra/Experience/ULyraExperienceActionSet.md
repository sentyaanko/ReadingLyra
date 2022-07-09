## ULyraExperienceActionSet

> Definition of a set of actions to perform as part of entering an experience  
> 
> ----
> エクスペリエンスに入るために行う一連の動作の定義  

* [ULyraExperienceDefinition::ActionSets] で利用される。
* 以下の 5 種類
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet])
	* `LAS_InventoryTest` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedInput` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedComponents` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedHUD` ([ULyraExperienceActionSet])


### ULyraExperienceActionSet::Actions

> List of actions to perform as this experience is loaded/activated/deactivated/unloaded  
> 
> ----

* [UGameFeatureAction] の配列。


