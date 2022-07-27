## ULyraHealthSet

> Class that defines attributes that are necessary for taking damage.  
> Attribute examples include: health, shields, and resistances.  
> 
> ----

### ULyraHealthSet::Health

> The current health attribute.  
> The health will be capped by the max health attribute.  
> Health is hidden from modifiers so only executions can modify it.  
> 
> ----
> 現在のヘルス属性です。  
> ヘルスは最大ヘルス属性で上限が設定されます。  
> ヘルスは modifier から隠されているので、 execution のみが修正可能です。  

### ULyraHealthSet::MaxHealth

> The current max health attribute.  
> Max health is an attribute since gameplay effects can modify it.  
> 
> ----
> 現在の最大ヘルス属性です。  
> 最大ヘルスはゲームプレイエフェクトで変更が可能なため、属性として扱われます。  

### ULyraHealthSet::Healing

> Incoming healing. This is mapped directly to +Health  
> 
> ----

* いわゆるメタ属性。

### ULyraHealthSet::Damage

> Incoming damage. This is mapped directly to -Health  
> 
> ----

> Damage is hidden from modifiers so only executions can modify it.  
> 
> ----

* いわゆるメタ属性。
* `UPROPERTY` の `Meta` にて `HideFromModifiers` が指定されている。
* そのため、 [ULyraAttributeSet::Health] と同様に modifier では変更できず execution(`UGameplayEffectExecutionCalculation` 派生クラス) のみで修正可能です。




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAttributeSet::Health]: ../../Lyra/GameplayAbility/ULyraAttributeSet.md#ulyraattributesethealth
