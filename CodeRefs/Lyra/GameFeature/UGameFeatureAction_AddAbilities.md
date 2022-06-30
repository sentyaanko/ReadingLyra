## UGameFeatureAction_AddAbilities

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----

* Lyra での使い方
	| Asset                                                               | ActorClass         | GrantedAbilities  | GrantedAttributes | GrantedAbilitySets<br>([ULyraAbilitySet]) |
	| ------------------------------------------------------------------- | ------------------ | ----------------- | ----------------- | ----------------------------------------- |
	| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])                 | [ALyraPlayerState] |                   |                   | `AbilitySet_InventoryTest`                |
	| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])  | [ALyraPlayerState] |                   |                   | `AbilitySet_ControlPoint`                 |
	| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState] |                   |                   | `AbilitySet_Elimination`                  |
	| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState] |                   |                   | `AbilitySet_ControlPoint`                 |


