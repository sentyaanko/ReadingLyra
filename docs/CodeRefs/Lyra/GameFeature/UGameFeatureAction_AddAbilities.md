## UGameFeatureAction_AddAbilities

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----
> 指定されたタイプのアクターに GameplayAbility（と Attribute ）を付与する責任を持つ GameFeatureAction 。

* Game Feature がアクティブになった際に付与するアビリティ情報を保持する。
* [UGameFeatureAction] の派生クラス。
* FGameFeatureAbilitiesEntry の配列を保持する。
* Game Feature がアクティブになった際に付与するアビリティはここの設定を利用する。


* Lyra での使い方
	| Asset                                                               | ActorClass         | GrantedAbilities  | GrantedAttributes | GrantedAbilitySets<br>([ULyraAbilitySet]) |
	| ------------------------------------------------------------------- | ------------------ | ----------------- | ----------------- | ----------------------------------------- |
	| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])                 | [ALyraPlayerState] |                   |                   | `AbilitySet_InventoryTest`                |
	| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])  | [ALyraPlayerState] |                   |                   | `AbilitySet_ControlPoint`                 |
	| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState] |                   |                   | `AbilitySet_Elimination`                  |
	| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState] |                   |                   | `AbilitySet_ControlPoint`                 |




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
