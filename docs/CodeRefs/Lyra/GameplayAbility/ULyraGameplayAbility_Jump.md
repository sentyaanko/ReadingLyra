## ULyraGameplayAbility_Jump

> Gameplay ability used for character jumping.  
> 
> ----
> キャラクターのジャンプに使用される Gameplay Ability です。  

* 概要
	* [ULyraGameplayAbility] の派生クラスです。
	* `UCLASS` にて `Abstract` が指定されています。
	* ジャンプ自体は　`AActor::Jump()` / `AActor::StopJumping()` / `AActor::CanJump()` / `AActor::UnCrouch()` などを利用します。
	* 派生ブループリントは以下のとおりです。
		* `GA_Hero_Jump`
	* `GA_Hero_Jump` について
		* `AbilitySet_ShooterHero` ([ULyraAbilitySet]) によりプレイヤーに付与されています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
