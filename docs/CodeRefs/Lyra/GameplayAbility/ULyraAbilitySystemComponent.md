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

### ULyraAbilitySystemComponent::ProcessAbilityInput()

* 概要
	* [ALyraPlayerController::PostProcessInput()] から呼び出されます。
	* 入力処理の際に更新される以下の値をもとにアビリティの起動等を行います。
		* [ULyraAbilitySystemComponent::InputPressedSpecHandles]
		* [ULyraAbilitySystemComponent::InputReleasedSpecHandles]
		* [ULyraAbilitySystemComponent::InputHeldSpecHandles] 
	* ただし、 GameplayTag `Gameplay.AbilityInputBlocked` が付与されている場合は上記のバッファのクリアをしてすぐに終了します。
		* つまりこの GameplayTag が付与されているとアビリティの起動等が抑制されます。

### ULyraAbilitySystemComponent::ClearAbilityInput()

* 概要
	* アビリティの入力情報をクリアします。
	* [ULyraAbilitySystemComponent::ProcessAbilityInput()] から呼び出され、これによりアビリティが入力により起動しなくなります。
	* 以下の値をクリアします。
		* [ULyraAbilitySystemComponent::InputPressedSpecHandles]
		* [ULyraAbilitySystemComponent::InputReleasedSpecHandles]
		* [ULyraAbilitySystemComponent::InputHeldSpecHandles] 

### ULyraAbilitySystemComponent::AbilityInputTagPressed()

* 概要
	* アビリティの入力タグが押された際に呼び出すことで関連するアビリティのハンドルを内部で保持する関数です。
	* [ULyraHeroComponent::Input_AbilityInputTagPressed()] から呼び出されます。
	* 保持したハンドルは [ULyraAbilitySystemComponent::ProcessAbilityInput()] で消費されます。
	* `ULyraAbilitySystemComponent::InputPressedSpecHandles` に該当のハンドルを追加します。
	* `ULyraAbilitySystemComponent::InputHeldSpecHandles` に該当のハンドルを追加します。

### ULyraAbilitySystemComponent::AbilityInputTagReleased()

* 概要
	* アビリティの入力タグが離された際に呼び出すことで関連するアビリティのハンドルを内部で保持する関数です。
	* [ULyraHeroComponent::Input_AbilityInputTagReleased()] から呼び出されます。
	* 保持したハンドルは [ULyraAbilitySystemComponent::ProcessAbilityInput()] で消費されます。
	* `ULyraAbilitySystemComponent::InputReleasedSpecHandles` に該当のハンドルを追加します。
	* `ULyraAbilitySystemComponent::InputHeldSpecHandles` から該当のハンドルを削除します。

### ULyraAbilitySystemComponent::InputPressedSpecHandles

> Handles to abilities that had their input pressed this frame.  
> 
> ----
> このフレームで入力が押されたアビリティへのハンドルです。 

### ULyraAbilitySystemComponent::InputReleasedSpecHandles

> Handles to abilities that had their input released this frame.  
> 
> ----
> このフレームで入力が離されたアビリティへのハンドルです。 

### ULyraAbilitySystemComponent::InputHeldSpecHandles

> Handles to abilities that have their input held.  
> 
> ----
> 入力が保持されているアビリティへのハンドルです。 




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ALyraCharacterWithAbilities]: ../../Lyra/GameplayAbility/ALyraCharacterWithAbilities.md#alyracharacterwithabilities
[ULyraAbilitySystemComponent::NotifyAbilityFailed()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentnotifyabilityfailed
[ULyraAbilitySystemComponent::ClientNotifyAbilityFailed()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentclientnotifyabilityfailed
[ULyraAbilitySystemComponent::HandleAbilityFailed()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponenthandleabilityfailed
[ULyraAbilitySystemComponent::ProcessAbilityInput()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentprocessabilityinput
[ULyraAbilitySystemComponent::InputPressedSpecHandles]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentinputpressedspechandles
[ULyraAbilitySystemComponent::InputReleasedSpecHandles]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentinputreleasedspechandles
[ULyraAbilitySystemComponent::InputHeldSpecHandles]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentinputheldspechandles
[ULyraAbilityTagRelationshipMapping]: ../../Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraGameplayAbility::OnAbilityFailedToActivate()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayabilityonabilityfailedtoactivate
[ULyraHeroComponent::Input_AbilityInputTagPressed()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinput_abilityinputtagpressed
[ULyraHeroComponent::Input_AbilityInputTagReleased()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinput_abilityinputtagreleased
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraPlayerController::PostProcessInput()]: ../../Lyra/GameplayFramework/ALyraPlayerController.md#alyraplayercontrollerpostprocessinput
[FGameplayAbilitySpec]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspec
[FGameplayAbilitySpec::DynamicAbilityTags]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspecdynamicabilitytags
