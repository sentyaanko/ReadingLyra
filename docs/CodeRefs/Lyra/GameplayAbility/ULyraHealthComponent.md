## ULyraHealthComponent

> An actor component used to handle anything related to health.  
> 
> ----
> Health に関することを扱うためのアクターコンポーネントです。  

* 概要
	* `UGameFrameworkComponent` の派生クラスです。
	* [ALyraCharacter] に追加されています。

### ULyraHealthComponent::HandleOutOfHealth()

* 概要
	* [ULyraHealthSet::OnOutOfHealth] に設定してるデリゲート用の関数です。
	* すなわち、 health が 0 になったときに実行したい処理で、概ね以下を行います。
		* ASC に Gameplay Event `GameplayEvent.Death` を送信します。
		* Gameplay Message `Lyra.Elimination.Message` を送信します。
			* これは [UAssistProcessor] が受信します。
		* なお、これらの処理は `WITH_SERVER_CODE` でくくられています。

### ULyraHealthComponent::StartDeath()

> Begins the death sequence for the owner.  
> 
> ----
> 所有者の死亡シークエンスを開始します。  

* 概要
	* health が 0 になったり、 [ULyraGameplayAbility_Death] によって死亡処理が開始された際に呼び出されます。


### ULyraHealthComponent::OnDeathStarted

> Delegate fired when the death sequence has started.  
> 
> ----
> デスシークエンスが開始されたときに発生するデリゲートです。 

* 概要
	* [ULyraHealthComponent::StartDeath()] 内で呼び出されます。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraHealthComponent::StartDeath()]: #ulyrahealthcomponentstartdeath
[ULyraGameplayAbility_Death]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Death.md#ulyragameplayabilitydeath
[ULyraHealthSet::OnOutOfHealth]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsetonoutofhealth
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[UAssistProcessor]: ../../Lyra/GameplayMessageProcessor/UAssistProcessor.md#uassistprocessor
