## ULyraAbilitySystemComponent

> Base ability system component class used by this project.  
> 
> ----
> このプロジェクトで使用する ability system component のベースクラスです。  

* 概要
	* `UAbilitySystemComponent` の派生クラスです。
	* [ALyraGameState] 及び [ALyraCharacterWithAbilities] に追加されています。
	* 入力アクションに関連づいた起動中のアビリティの検索について
		* 入力アクションが発生した際、すでに起動しているアビリティから入力アクションに紐づいた [FGameplayAbilitySpec] を探す必要があります。
			* 例えばダッシュボタンを話した際に、ダッシュのアビリティを探すなど。
		* そういった際は入力アクションにバインドされた **InputTag** をキーに [FGameplayAbilitySpec] を探します。
			* **InputTag** は初期化時に [FGameplayAbilitySpec::DynamicAbilityTags] に設定しており、この値を調べることで実現しています。

### ULyraAbilitySystemComponent::SetTagRelationshipMapping()

* 概要
	* [ULyraAbilityTagRelationshipMapping] を受け取り、保持します。
	* 渡されたクラスを利用して、アビリティの有効化の際にブロックやキャンセルを行うようになります。

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
