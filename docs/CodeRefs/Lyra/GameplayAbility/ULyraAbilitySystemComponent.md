## ULyraAbilitySystemComponent

* TODO: 要追記

* [FGameplayAbilitySpec::DynamicAbilityTags] について
	* 入力アクションが発生した際、バインドされた **InputTag** をキーに [FGameplayAbilitySpec] を探す。
	* その際、 [FGameplayAbilitySpec::DynamicAbilityTags] に **InputTag** を持つかで判定している。


### ULyraAbilitySystemComponent::SetTagRelationshipMapping()

* TODO: 要追記

### ULyraAbilitySystemComponent::NotifyAbilityFailed()

* 概要
	* `UAbilitySystemComponent::NotifyAbilityFailed()` のオーバーライドです。
	* アビリティのアクティブ化に失敗した際に呼び出されます。
	* [ULyraAbilitySystemComponent::ClientNotifyAbilityFailed()] や [ULyraAbilitySystemComponent::HandleAbilityFailed()] を呼び出します。

### ULyraAbilitySystemComponent::ClientNotifyAbilityFailed()

* 概要
	* アビリティのアクティブ化の失敗をクライアントに知らせるための関数です。
	* [ULyraAbilitySystemComponent::NotifyAbilityFailed()] から呼び出される Client RPC で、[ULyraAbilitySystemComponent::HandleAbilityFailed()] を呼び出します。

### ULyraAbilitySystemComponent::HandleAbilityFailed()

* 概要
	* アビリティのアクティブ化の失敗時の処理を行うための関数です。
	* [ULyraGameplayAbility::OnAbilityFailedToActivate()] を呼び出します。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAbilitySystemComponent::NotifyAbilityFailed()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentnotifyabilityfailed
[ULyraAbilitySystemComponent::ClientNotifyAbilityFailed()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentclientnotifyabilityfailed
[ULyraAbilitySystemComponent::HandleAbilityFailed()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponenthandleabilityfailed
[ULyraGameplayAbility::OnAbilityFailedToActivate()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayabilityonabilityfailedtoactivate
[FGameplayAbilitySpec]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspec
[FGameplayAbilitySpec::DynamicAbilityTags]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspecdynamicabilitytags
