## FGameplayAbilitySpec

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > FGameplayAbilitySpec](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameplayAbilities/FGameplayAbilitySpec/)

> An activatable ability spec, hosted on the ability system component.  
> This defines both what the ability is (what class, what level, input binding etc)  
> and also holds runtime state that must be kept outside of the ability being instanced/activated.  
> 
> ----
> アビリティシステムコンポーネントでホストされる、起動可能なアビリティ Spec です。  
> これはアビリティが何であるか(どのクラス、どのレベル、入力バインディングなど)を定義するものです。  
> また、インスタンス化/アクティブ化されたアビリティの外側に保持されなければならない実行時状態も保持します。  

* 概要
	* GameplayAbility の起動可能な詳細情報です。
	* [UGameplayAbility] を元に実行時に構築されるクラスです。


### FGameplayAbilitySpec::DynamicAbilityTags

> Optional ability tags that are replicated.  
> These tags are also captured as source tags by applied gameplay effects.  
> 
> ----
> 複製されるオプションのアビリティタグです。  
> これらのタグは、適用されたゲームプレイエフェクトによってソースタグとしてもキャプチャされます。  

* 概要
	* 上記の引用どおり、「適用されたゲームプレイエフェクトによってソースタグとしてもキャプチャ」される以外には使われていない。
* Lyra での使われ方
	* **InputTag** を設定しています。
		* そうすることで、実行中のアビリティから特定の **InputTag** が含まれる物を探すことが可能となります。
		* これを利用して入力情報をアビリティに渡しています。

### FGameplayAbilitySpec::AbilityTags

>  This ability has these tags  
> 
> ----
> このアビリティはこれらのタグを持ちます。

* 概要
	* アビリティの特徴を示す GameplayTag を格納した `FGameplayTagContainer` です。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameplayAbility]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayability
