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

### ULyraAbilitySet::GrantedGameplayAbilities

> Gameplay abilities to grant when this ability set is granted.  
> 
> ----
> このアビリティセットが付与された時に付与されるゲームプレイアビリティです。  

* 概要
	* [FLyraAbilitySet_GameplayAbility] の配列です。
	* 例として `AbilitySet_ShooterPistol` の設定内容は以下の通りです。
		| GameplayAbility           | 概要                                       |
		|---------------------------|--------------------------------------------|
		| `GA_Weapon_Fire_Pistol`   | Pistol 用の射撃アビリティ                  |
		| `GA_Weapon_Reload_Pistol` | Pistol 用のリロードアビリティ              |
		| `GA_Weapon_AutoReload`    | リロードアビリティを呼び出す汎用アビリティ |



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLyraAbilitySet_GameplayAbility]: ../../Lyra/GameplayAbility/FLyraAbilitySet_GameplayAbility.md#flyraabilityset_gameplayability
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[FGameplayAbilitySpec]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspec
[FGameplayAbilitySpec::DynamicAbilityTags]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspecdynamicabilitytags
