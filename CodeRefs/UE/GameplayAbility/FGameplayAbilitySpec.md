## FGameplayAbilitySpec

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > FGameplayAbilitySpec](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameplayAbilities/FGameplayAbilitySpec/)

> An activatable ability spec, hosted on the ability system component.  
> This defines both what the ability is (what class, what level, input binding etc)  
> and also holds runtime state that must be kept outside of the ability being instanced/activated.  
> 
> ----
> アビリティシステムコンポーネントでホストされる、起動可能なアビリティ Spec です。  
> これはアビリティが何であるか(どのクラス、どのレベル、入力バインディングなど)を定義するものである。  
> また、インスタンス化/アクティブ化されたアビリティの外側に保持されなければならない実行時状態も保持します。  

### FGameplayAbilitySpec::DynamicAbilityTags

> Optional ability tags that are replicated.  
> These tags are also captured as source tags by applied gameplay effects.  
> 
> ----
> 複製されるオプションのアビリティタグ。  
> これらのタグは、適用されたゲームプレイエフェクトによってソースタグとしてもキャプチャされる。  

* Lyra での使われ方
	* **InputTag** が設定されます。

