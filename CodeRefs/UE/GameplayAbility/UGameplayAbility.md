## UGameplayAbility

### UGameplayAbility::MakeOutgoingGameplayEffectSpec()

> Convenience method for abilities to get outgoing gameplay effect specs  
> (for example, to pass on to projectiles to apply to whoever they hit)  
> 
> ----
> アビリティがゲームプレイエフェクト Spec を外部に出すための便利な方法  
> （例えば、投射物に渡して、当たった人に適用させるなど）。  

* `GameplayEffectSpec` を作るための関数で、ブループリントにも公開されている。
* [UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()] を呼び出す。


### UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()

> Add the Ability's tags to the given GameplayEffectSpec. This is likely to be overridden per project.  
> 
> ----
> 与えられたGameplayEffectSpecに、Abilityのタグを追加します。これは、プロジェクトごとにオーバーライドされる可能性が高いです。  

* 仮想関数。
* [UGameplayAbility::MakeOutgoingGameplayEffectSpec()] から呼ばれる。
* 渡された [FGameplayEffectSpec::CapturedSourceTags] に [FGameplayAbilitySpec::DynamicAbilityTags] を追加する。


