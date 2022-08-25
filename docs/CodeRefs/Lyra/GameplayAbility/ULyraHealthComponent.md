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


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraHealthSet::OnOutOfHealth]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsetonoutofhealth
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[UAssistProcessor]: ../../Lyra/GameplayMessageProcessor/UAssistProcessor.md#uassistprocessor
