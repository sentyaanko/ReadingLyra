## FLyraAbilitySimpleFailureMessage

* 概要
	* Gameplay Message `Ability.UserFacingSimpleActivateFail.Message` で送信する構造体です。
		* この Gameplay Message は `W_AbilityFailureFeedback` ([ULyraTaggedWidget]) が受信します。
	* [ULyraGameplayAbility::NativeOnAbilityFailedToActivate()] で利用されます。
	* 一例として、 `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon]) でコスト不足でアビリティがアクティブ化出来ない場合は以下が設定されます。
		| FailureTags                 | UserFacingReason |
		|-----------------------------|------------------|
		| `Ability.ActivateFail.Cost` | `No Ammo!` 　　　|

### FLyraAbilitySimpleFailureMessage::PlayerController

* 概要
	* `ULyraGameplayAbility::GetActorInfo().PlayerController` で取得できる、呼び出し元の GameplayAbility の OwningActor が設定されます。

### FLyraAbilitySimpleFailureMessage::FailureTags

* 概要
	* アビリティの失敗理由を示す GameplayTag です。

### FLyraAbilitySimpleFailureMessage::UserFacingReason

* 概要
	* 表示するテキストです。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility::NativeOnAbilityFailedToActivate()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayabilitynativeonabilityfailedtoactivate
[ULyraGameplayAbility_RangedWeapon]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayabilityrangedweapon
[ULyraTaggedWidget]: ../../Lyra/Widget/ULyraTaggedWidget.md#ulyrataggedwidget
