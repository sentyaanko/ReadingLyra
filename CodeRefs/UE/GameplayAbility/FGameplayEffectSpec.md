## FGameplayEffectSpec

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > FGameplayEffectSpec](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameplayAbilities/FGameplayEffectSpec/)

> GameplayEffect Specification. Tells us:  
> - What UGameplayEffect (const data)
> - What Level
> - Who instigated
>  
> FGameplayEffectSpec is modifiable. We start with initial conditions and modifications be applied to it.  
> In this sense, it is stateful/mutable but it is still distinct from an FActiveGameplayEffect which in an applied instance of an FGameplayEffectSpec.  
> 
> ----
> ゲームプレイエフェクトの仕様です。説明  
> - どの UGameplayEffect (const data) か
> - どのようなレベルか
> - 誰が実行したか
>  
> FGameplayEffectSpec は変更可能である。初期状態から始まり、修正が適用される。  
> この意味で、ステートフル／ミュータブルですが、FGameplayEffectSpec を適用したインスタンスである FActiveGameplayEffect とは区別される。  


### FGameplayEffectSpec::CapturedSourceTags

> Captured Source Tags on GameplayEffectSpec creation  
> 
> ----
> GameplayEffectSpec 作成時にキャプチャされたソースタグ。  

* Lyra での使われ方
	* [FGameplayAbilitySpec::DynamicAbilityTags] に **InputTag** が設定される都合上、ここにも **InputTag** がキャプチャされる。
	* 利用されているかは未確認。

