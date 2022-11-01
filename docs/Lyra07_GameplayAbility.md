# 【UE5】Lyra に学ぶ(07) GameplayAbility <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中では、`Gameplay Ability System` (以降 GAS と略します) が利用されています。  
このドキュメントは GameplayAbility で実装されている機能についての解説です。  

* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [GameplayAbility の一覧](#gameplayability-の一覧)
- [終わりに](#終わりに)

# GameplayAbility の一覧

Lyra で実装されている GameplayAbility は以下の通り。

* [ULyraGameplayAbility]
	* [ULyraGameplayAbility_Death]
		* `GA_ArenaHero_Death`
		* `GA_Hero_Death`
	* [ULyraGameplayAbility_FromEquipment]
		* `GA_Weapon_AutoReload`
		* `GA_Weapon_ReloadMagazine`
			* `GA_Weapon_Reload_Pistol`
			* `GA_Weapon_Reload_Rifle`
			* `GA_Weapon_Reload_Shotgun`
			* `GA_Weapon_Reload_NetShooter`
		* [ULyraGameplayAbility_RangedWeapon]
			* `GA_HealPickup`
			* `GA_Weapon_Fire`
				* `GA_Weapon_Fire_Pistol`
				* `GA_Weapon_Fire_Rifle`
				* `GA_Weapon_Fire_Shotgun`
				* `GA_WeaponNetShooter`
	* [ULyraGameplayAbility_Interact]
		* `GA_Interact`
	* [ULyraGameplayAbility_Jump]
		* `GA_Hero_Jump`
	* [ULyraGameplayAbility_Reset]
	* [ULyraGamePhaseAbility]
		* `Phase_Playing` (ShooterCore/TopDownArena の 2 種)
		* `Phase_PostGame` (ShooterCore/TopDownArena の 2 種)
		* `Phase_Warmup` (ShooterCore/TopDownArena の 2 種)
	* `GA_AbilityWithWidget`
		* `GA_ADS`
		* `GA_Emoto`
		* `GA_Hero_Dash`
		* `GA_Melee`
	* `GAB_ShowWidget_WhenInputPressed`
		* `GA_ToggleInventory`
		* `GA_ToggleMap`
	* `GAB_ShowWidget_WhileInputHeld`
		* `GA_ShowLeaderboard_CP`
		* `GA_ShowLeaderboard_TDM`
	* `GA_AutoRespawn`
	* `GA_DropBomb`
	* `GA_Grenade`
	* `GA_Hero_Heal`
	* `GA_Interaction_Collect`
	* `GA_QuickbarSlots`
	* `GA_SpawnEffect`
	* `GA_ToggleMarkerInWorld`


# 終わりに

GAS に関わるネイティブ実装のうち、主に仕組みに関わる部分について大まかにまとめました。  
すべてをまとめきれてはいないドキュメントですが、どなたかの参考になれば幸いです。


-----
おしまい。

<!--- ページ内のリンク --->
[【UE5】Lyra に学ぶ GAS(C++)]: GameplayAbilityNative.md

<!--- 自前の画像へのリンク --->
[Lyra_CharacterAndComponents]: images/Lyra_CharacterAndComponents.png

<!--- generated --->
[ULyraGamePhaseAbility]: CodeRefs/Lyra/GameplayAbility/ULyraGamePhaseAbility.md#ulyragamephaseability
[ULyraGameplayAbility]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraGameplayAbility_Death]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Death.md#ulyragameplayability_death
[ULyraGameplayAbility_FromEquipment]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_FromEquipment.md#ulyragameplayability_fromequipment
[ULyraGameplayAbility_Interact]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Interact.md#ulyragameplayability_interact
[ULyraGameplayAbility_Jump]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Jump.md#ulyragameplayability_jump
[ULyraGameplayAbility_RangedWeapon]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayability_rangedweapon
[ULyraGameplayAbility_Reset]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Reset.md#ulyragameplayability_reset
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
