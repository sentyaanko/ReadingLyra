## FLyraAbilityMontageFailureMessage

> Failure reason that can be used to play an animation montage when a failure occurs  
> 
> ----
> 失敗発生時にアニメーションモンタージュを再生するために使用できる失敗理由  

* 概要
	* Gameplay Message `Ability.PlayMontageOnActivateFail.Message` で送信する構造体です。
		* この Gameplay Message は `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon]) が受信します。
	* [ULyraGameplayAbility::NativeOnAbilityFailedToActivate()] で利用されます。
	* 一例として、 `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon]) でコスト不足でアビリティがアクティブ化出来ない場合は以下が設定されます。
		| FailureTags   　            | FailureMontage        |
		|-----------------------------|-----------------------|
		| `Ability.ActivateFail.Cost` | `AM_MM_Rifle_DryFire` |

### FLyraAbilityMontageFailureMessage::PlayerController

* 概要
	* `ULyraGameplayAbility::GetActorInfo().PlayerController` で取得できる、呼び出し元の GameplayAbility の OwningActor が設定されます。

### FLyraAbilityMontageFailureMessage::FailureTags

> All the reasons why this ability has failed  
> 
> ----
> このアビリティが失敗したすべての理由  

* 概要
	* アビリティの失敗理由を示す GameplayTag です。

### FLyraAbilityMontageFailureMessage::FailureMontage

* 概要
	* 再生する `UAnimMontage` です。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility::NativeOnAbilityFailedToActivate()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayabilitynativeonabilityfailedtoactivate
[ULyraGameplayAbility_RangedWeapon]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayability_rangedweapon
