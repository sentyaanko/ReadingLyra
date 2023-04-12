## UElimChainProcessor

> Tracks a chain of eliminations (X eliminations without more than Y seconds passing between each one)  
> 
> ----
> 撃破の連鎖を追跡します（各撃破の間にY秒以上経過することなくX回の撃破を行う）。  

* 概要
	* [UGameplayMessageProcessor] の派生クラスです。
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet]) などから `AGameStateBase` 派生クラスにサーバー側にだけ追加されます。
	* Elimination/ControlPoint の際、敵の連鎖撃破を追跡するクラスです。
	* 追跡は Gameplay Message `Lyra.Elimination.Message` をリッスンすることで行っています。
		* この Gameplay Message は [ULyraHealthComponent::HandleOutOfHealth()] で送信されます。
	* 派生ブループリントとして `B_ElimChainProcessor` があります。

### UElimChainProcessor::PlayerChainHistory

* 概要
	* ダメージを与えた PlayerState をキーとし [FPlayerElimChainInfo] を値とする連想配列です。
	* [UElimChainProcessor::OnEliminationMessage()] 内で更新します。

### UElimChainProcessor::ElimChainTags

> The event to rebroadcast when a user gets a chain of a certain length  
> 
> ----
> ユーザーが一定の長さのチェーンを取得したときに再送信するイベントです。  

* 概要
	* 撃破の連鎖数 (int) をキーとし 送信する Gameplay Message の GameplayTag を値とする連想配列です。
	* `B_ElimChainProcessor` では以下の設定がされています。
		| key | value                                           |
		|-----|-------------------------------------------------|
		| 2   | `Lyra.ShooterGame.Accolade.EliminationChain.2x` |
		| 3   | `Lyra.ShooterGame.Accolade.EliminationChain.3x` |
		| 4   | `Lyra.ShooterGame.Accolade.EliminationChain.4x` |

### UElimChainProcessor::OnEliminationMessage()

* 概要
	* Gameplay Message `Lyra.Elimination.Message` を受信した際に実行させる関数です。
		* この Gameplay Message は [ULyraHealthComponent::HandleOutOfHealth()] から送られます。
	* [UElimChainProcessor::PlayerChainHistory] に撃破の時刻と連鎖数を記録します。
	* [UElimChainProcessor::ElimChainTags] のキーに設定された撃破の連鎖が発生した際に、値に設定された Gameplay Message (`Lyra.ShooterGame.Accolade.EliminationChain.2x` 等) を送信します。
		* Gameplay Message `Lyra.ShooterGame.Accolade.*` は `B_AccoladeRelay` ([UGameplayMessageProcessor]) が受信します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UElimChainProcessor::PlayerChainHistory]: #uelimchainprocessorplayerchainhistory
[UElimChainProcessor::ElimChainTags]: #uelimchainprocessorelimchaintags
[UElimChainProcessor::OnEliminationMessage()]: #uelimchainprocessoroneliminationmessage
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraHealthComponent::HandleOutOfHealth()]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponenthandleoutofhealth
[FPlayerElimChainInfo]: ../../Lyra/GameplayMessageProcessor/FPlayerElimChainInfo.md#fplayerelimchaininfo
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
