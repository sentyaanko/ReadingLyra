## ULyraHealthSet

> Class that defines attributes that are necessary for taking damage.  
> Attribute examples include: health, shields, and resistances.  
> 
> ----
> ダメージを受けるために必要な属性を定義したクラスです。  
> 属性の例としては、ヘルス、シールド、レジスタンスなどがあります。 

* 概要
	* [ULyraAttributeSet] の派生クラスです。
	* [ALyraPlayerState] に追加されます。

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
> 着信回復値。これは +Health に直接マッピングされます。 

* 概要
	* いわゆるメタ属性です。

### ULyraHealthSet::Damage

> Incoming damage. This is mapped directly to -Health  
> 
> ----
> 着信ダメージ値。これは -Health に直接マッピングされます。 

* 概要
	* いわゆるメタ属性です。
	* [ULyraHealthSet::Health] と同様に `UPROPERTY` の `Meta` にて `HideFromModifiers` が指定されています。
	* そのため、 [ULyraHealthSet::Health] と同様に modifier では変更できず execution(`UGameplayEffectExecutionCalculation` 派生クラス等) のみで修正可能です。


### ULyraHealthSet::OnOutOfHealth

> Delegate to broadcast when the health attribute reaches zero.  
> 
> ----
> health 属性が 0 になったときにブロードキャストするためのデリゲートです。  

* 概要
	* `FLyraAttributeEvent` 型のデリゲートです。
	* [ULyraHealthComponent] にて [ULyraHealthComponent::HandleOutOfHealth()] が設定されています。

### ULyraHealthSet::PostGameplayEffectExecute()

> Called just before a GameplayEffect is executed to modify the base value of an attribute.  
> No more changes can be made.  
> Note this is only called during an 'execute'.  
> E.g., a modification to the 'base value' of an attribute.  
> It is not called during an application of a GameplayEffect, such as a 5 ssecond +10 movement speed buff. 
> 
> ----
> GameplayEffect が実行される直前に呼び出され、属性の基本値が変更されます。  
> それ以上の変更はできません。  
> これは 'execute' 中にのみ呼び出されることに注意してください。  
> 例：アトリビュートの「基本値」の変更。  
> 5 秒間の移動速度 +10 バフのような GameplayEffect の適用中には呼び出されません。  

* 概要
	* `UAttributeSet::PostGameplayEffectExecute()` のオーバーライドです。
	* GameplayEffect の内容により、いくつかの処理を行っています。
		* Health を減らす場合
			* [UGameplayMessageSubsystem::BroadcastMessage()] により Gameplay Message `Lyra.Damage.Message` を送ります。
		* Health が 0 以下になったとき
			* [ULyraHealthSet::OnOutOfHealth] を呼び出します。
		* Healing 関連の処理
			* **未確認。 [ULyraHealExecution] のときに使われそうな内容だが、そちらで設定しているアトリビュートが Healing ではなく Health なので、実行されないように読める。**

### ULyraHealthSet::PreGameplayEffectExecute()

> Called just before modifying the value of an attribute. 
> AttributeSet can make additional modifications here. 
> Return true to continue, or false to throw out the modification.  
> Note this is only called during an 'execute'. 
> E.g., a modification to the 'base value' of an attribute. 
> It is not called during an application of a GameplayEffect, such as a 5 ssecond +10 movement speed buff.  
> 
> ----
> 属性の値を変更する直前に呼び出されます。  
> AttributeSet はここで追加の修正を行うことができます。  
> 続行するには true を、修正を破棄するには false を返します。  
> これは、'execute'の間だけ呼び出されることに注意が必要です。  
> 例えば、属性の'基本値'を変更する場合などです。  
> 5 秒間の移動速度 +10 バフのような GameplayEffect の適用中には呼び出されません。  

* 概要
	* `UAttributeSet::PreGameplayEffectExecute()` のオーバーライドです。
	* GameplayTag `Gameplay.Damage.SelfDestruct` / `Gameplay.DamageImmunity` などの状態をもとに、ダメージ値を 0 に変更したりします。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraHealthSet::Health]: #ulyrahealthsethealth
[ULyraHealthSet::OnOutOfHealth]: #ulyrahealthsetonoutofhealth
[ULyraAttributeSet]: ../../Lyra/GameplayAbility/ULyraAttributeSet.md#ulyraattributeset
[ULyraHealExecution]: ../../Lyra/GameplayAbility/ULyraHealExecution.md#ulyrahealexecution
[ULyraHealthComponent]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponent
[ULyraHealthComponent::HandleOutOfHealth()]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponenthandleoutofhealth
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[UGameplayMessageSubsystem::BroadcastMessage()]: ../../Plugin/GameplayMessageSubsystem/UGameplayMessageSubsystem.md#ugameplaymessagesubsystembroadcastmessage
