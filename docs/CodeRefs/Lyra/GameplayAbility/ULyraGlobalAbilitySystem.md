## ULyraGlobalAbilitySystem

[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ULyraGlobalAbilitySystem] より  
> たとえば、Lyra の Elimination モードは、マッチのウォームアップ フェーズで、  
> グローバルに Gameplay Effect (GE_PregameLobby) を適用します。  
> これはすべてのプレイヤーに対するダメージ無効化タグを付与し、  
> マッチがまだ開始されていないことを示す UI 要素を有効にする Gameplay Cue (ゲームプレイ キュー) をトリガーします。  

* 概要
	* `UWorldSubsystem` の派生クラスです。
	* [ULyraAbilitySystemComponent] から参照されています。
		* 初期化/破棄時に [ULyraGlobalAbilitySystem::RegisterASC()] / [ULyraGlobalAbilitySystem::UnregisterASC()] を呼び出すことでこのクラス内で ASC の参照を保持しています。
	* ASC の初期化/破棄の際に登録/削除を行うことで、このプロジェクトで有効な ASC を保持し、それらすべてを対象にした操作(GameplayAbility や GameplayEffect の付与や削除)を行える仕組みを提供しています。
	* `Phase_PostGame` (ShooterCore 用) から参照されています。
		* `GE_DamageImmutiy_FromGameMode` を付与しています。
			* これにより、ゲームフェーズが PostGame に移行したあとはダメージが無効化されます。
		* `GE_BlockAbilityInput` を付与しています。
			* これにより、 GameplayTag `Gameplay.AbilityInputBlocked` が付与され、アビリティの起動が抑制されます。
				* 詳しくは [ULyraAbilitySystemComponent::ProcessAbilityInput()] を参照してください。
	* `Phase_Warmup` (ShooterCore 用) から参照されています。
		* `GE_PregameLobby` を付与しています。
			* これにより、 GameplayTag `Gameplay.DamageImmunity` が付与されます。
				* 詳しくは [ULyraHealthSet::PreGameplayEffectExecute()] を参照してください。
			* これにより、 GameplayTag `GameplayCue.ShooterGame.UserMessage.WaitingForPlayers` をもとに GameplayCue `GCNL_WaitingForPlayers` (`AGameplayCueNotify_Looping`) が再生されます。
				* これにより、 `W_WaitingForPlayers_Message` (`UUserWidget`) が表示されます。
					* この widget は入力を受け取らない( `Visibility` が `Collapsed` / `SelfHitTestInvisible` のみで構成され、 EventGrap で入力イベントも持たない)コスメティックな UI なので、 GameplayCue で表示しても影響がありません。
	* `Phase_Warmup` (TopDownArena 用) から参照されています。
		* `GE_Warmup` を付与しています。
			* これにより、 GameplayTag `Gameplay.DamageImmunity` が付与されます。
				* 詳しくは [ULyraHealthSet::PreGameplayEffectExecute()] を参照してください。
			* これにより、 GameplayTag `Gameplay.MovementStopped` が付与されます。
				* 詳しくは [ULyraCharacterMovementComponent::GetDeltaRotation()] / [ULyraCharacterMovementComponent::GetMaxSpeed()] を参照してください。

### ULyraGlobalAbilitySystem::RegisterASC()

> Register an ASC with global system and apply any active global effects/abilities.  
> 
> ----
> ASC をグローバルシステムに登録し、アクティブなグローバルエフェクト/アビリティを適用します。 

* 概要
	* [ULyraAbilitySystemComponent]`::InitAbilityActorInfo()` から呼び出されます。


### ULyraGlobalAbilitySystem::UnregisterASC()

> Removes an ASC from the global system, along with any active global effects/abilities.  
> 
> ----
> ASC をグローバルシステムから削除し、アクティブなグローバルエフェクト/アビリティも削除します。 

* 概要
	* [ULyraAbilitySystemComponent]`::EndPlay()` から呼び出されます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGlobalAbilitySystem::RegisterASC()]: #ulyraglobalabilitysystemregisterasc
[ULyraGlobalAbilitySystem::UnregisterASC()]: #ulyraglobalabilitysystemunregisterasc
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraAbilitySystemComponent::ProcessAbilityInput()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentprocessabilityinput
[ULyraHealthSet::PreGameplayEffectExecute()]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsetpregameplayeffectexecute
[ULyraCharacterMovementComponent::GetDeltaRotation()]: ../../Lyra/GameplayFramework/ULyraCharacterMovementComponent.md#ulyracharactermovementcomponentgetdeltarotation
[ULyraCharacterMovementComponent::GetMaxSpeed()]: ../../Lyra/GameplayFramework/ULyraCharacterMovementComponent.md#ulyracharactermovementcomponentgetmaxspeed
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ULyraGlobalAbilitySystem]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#ulyraglobalabilitysystem
