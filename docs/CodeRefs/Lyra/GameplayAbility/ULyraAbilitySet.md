## ULyraAbilitySet

> Non-mutable data asset used to grant gameplay abilities and gameplay effects.  
> 
> ----
> ゲームプレイアビリティおよびゲームプレイエフェクトを付与するために使用される非ミュータブルなデータアセットです。  

* Game Feature がアクティブになった際に付与する入力マッピング情報を保持する。
* `GrantedGameplayAbilities` に [FLyraAbilitySet_GameplayAbility] の配列を保持する。


### ULyraAbilitySet::GiveToAbilitySystem()

* 渡された [ULyraAbilitySystemComponent] の Owner が `authoritative` ならばアビリティを付与する。
	* 付与する際、 [FGameplayAbilitySpec::DynamicAbilityTags] に **InputTag** を設定する。
		* この値は、入力があった際に **InputTag** から [FGameplayAbilitySpec] を見つけるのに利用される。
		* 詳しくは [ULyraAbilitySystemComponent] を参照してください。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLyraAbilitySet_GameplayAbility]: ../../Lyra/GameplayAbility/FLyraAbilitySet_GameplayAbility.md#flyraabilityset_gameplayability
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[FGameplayAbilitySpec]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspec
[FGameplayAbilitySpec::DynamicAbilityTags]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspecdynamicabilitytags
