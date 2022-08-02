## ULyraEquipmentDefinition

> Definition of a piece of equipment that can be applied to a pawn
> 
> ----
> ポーンに適用可能な装備の定義。

* 概要
	* 武器に付随するアビリティはここの設定を利用します。
	* `WID_` のプレフィックスを持ちます。
	* 作成されているアセットは以下の通りです。
		* `WID_Pistol`
		* `WID_Rifle`
		* `WID_Shotgun`
		* `WID_NetShooter`
		* `WID_InstantHeal`
		* `WID_HealPickup`

### ULyraEquipmentDefinition::AbilitySetsToGrant

> Gameplay ability sets to grant when this is equipped  
> 
> ----
> 装備時に付与される GameplayAbilitySet です。  

* 概要
	* [ULyraAbilitySet] の配列です。
	* 武器などを装備した際に装備したアクターに付与する GameplayAbility のセットを指定します。
	* 例として `WID_Pistol` では `AbilitySet_ShooterPistol` が設定されています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
