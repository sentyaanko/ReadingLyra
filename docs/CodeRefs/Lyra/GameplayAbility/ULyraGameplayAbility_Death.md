## ULyraGameplayAbility_Death

> Gameplay ability used for handling death.
> Ability is activated automatically via the "GameplayEvent.Death" ability trigger tag.
> 
> ----
> 死を処理するために使用される Gameplay Ability です。  
> アビリティは、 "GameplayEvent.Death" アビリティトリガー・タグによって自動的にアクティブ化されます。

このへんから
* 概要
	* `ULyraGameplayAbility` の派生クラスです。
	* Gameplay Event `GameplayEvent.Death` をトリガーにアクティブ化します。
	* アクティブ化すると `UAbilitySystemComponent::CancelAbilities()` を利用して [FGameplayAbilitySpec::AbilityTags] に GameplayTag `Ability.Behavior.SurvivesDeath` を含んでいないアビリティを `UAbilitySystemComponent::CancelAbilitySpec()` を利用してキャンセルします。
	* 死亡処理は [ULyraHealthComponent] を通じて行います。
	* 派生ブループリントは以下のとおりです。
		* `GA_ArenaHero_Death`
		* `GA_Hero_Death`
	* `GA_ArenaHero_Death` について
		* `AbilitySet_Arena` ([ULyraAbilitySet]) に設定されています。
			* `AbilitySet_Arena` ([ULyraAbilitySet]) は `HeroData_Arena` ([ULyraPawnData]) に設定されており、 `B_Hero_Arena` ([ALyraCharacter]) に付与されるように設定されています。
			* `HeroData_Arena` ([ULyraPawnData]) は `B_TopDownArenaExperience` ([ULyraExperienceDefinition]) に設定されています。
			* `B_TopDownArenaExperience` ([ULyraExperienceDefinition]) は レベル `L_TopDownArenaGym` に設定されています。
		* `GA_ArenaHero_Death` はこれらを通じて、 TopDownArena の死亡処理としてエクスペリエンスのロードの際にキャラクターに付与されます。
	* `GA_Hero_Death` について
		* `AbilitySet_ShooterHero` ([ULyraAbilitySet]) に設定されています。
			* `AbilitySet_ShooterHero` ([ULyraAbilitySet]) は `HeroData_ShooterGame` ([ULyraPawnData]) に設定されており、 `B_Hero_ShooterMannequin` ([ALyraCharacter]) に付与されるように設定されています。
			* `HeroData_ShooterGame` ([ULyraPawnData]) は `B_LyraShooterMage_ControlPoints` / `B_LyraShooterMage_Elimination` / `B_TestInventoryExperience` ([ULyraExperienceDefinition]) に設定されています。
			* `B_LyraShooterMage_ControlPoints` ([ULyraExperienceDefinition]) は レベル `L_Convolution_Blockout` に設定されています。
			* `B_LyraShooterMage_Elimination` ([ULyraExperienceDefinition]) は レベル `L_ShooterGym` / `L_Expanse` / `L_Expanse_Blockout` / `L_FiringRange_WP` に設定されています。
			* `B_TestInventoryExperience` ([ULyraExperienceDefinition]) は レベル `L_InventoryTestMap` に設定されています。
		* `GA_Hero_Death` はこれらを通じて、 `ControlPoints` / `Elimination` 等の死亡処理としてエクスペリエンスのロードの際にキャラクターに付与されます。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraHealthComponent]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponent
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[FGameplayAbilitySpec::AbilityTags]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspecabilitytags
