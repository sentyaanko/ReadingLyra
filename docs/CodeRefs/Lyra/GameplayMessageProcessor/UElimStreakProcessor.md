## UElimStreakProcessor

> Tracks a streak of eliminations (X eliminations without being eliminated)  
> 
> ----
> 連続撃破を記録します（撃破されずにX回撃破）。  

* 概要
	* [UGameplayMessageProcessor] の派生クラスです。
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet]) などから `AGameStateBase` 派生クラスにサーバー側にだけ追加されます。
	* Elimination/ControlPoint の際、敵の連続撃破を追跡するクラスです。
	* 追跡は Gameplay Message `Lyra.Elimination.Message` をリッスンすることで行っています。
		* この Gameplay Message は [ULyraHealthComponent::HandleOutOfHealth()] で送信されます。
	* 派生ブループリントとして `B_ElimStreakProcessor` があります。

### UElimStreakProcessor::PlayerStreakHistory

* 概要
	* ダメージを与えた PlayerState をキーとし int を値とする連想配列です。
	* [UElimStreakProcessor::OnEliminationMessage()] 内で更新します。

### UElimStreakProcessor::ElimStreakTags

> The event to rebroadcast when a user gets a streak of a certain length
> 
> ----
> ユーザーが一定の長さのストリークを取得したときに再送信するイベントです。  

* 概要
	* 連続撃破数 (int) をキーとし 送信する Gameplay Message の GameplayTag を値とする連想配列です。
	* `B_ElimStreakProcessor` では以下の設定がされています。
		| key | value                                            |
		|-----|--------------------------------------------------|
		| 5   | `Lyra.ShooterGame.Accolade.EliminationStreak.5`  |
		| 10  | `Lyra.ShooterGame.Accolade.EliminationStreak.10` |
		| 15  | `Lyra.ShooterGame.Accolade.EliminationStreak.15` |
		| 20  | `Lyra.ShooterGame.Accolade.EliminationStreak.20` |

### UElimStreakProcessor::OnEliminationMessage()

* 概要
	* Gameplay Message `Lyra.Elimination.Message` を受信した際に実行させる関数です。
		* この Gameplay Message は [ULyraHealthComponent::HandleOutOfHealth()] から送られます。
	* [UElimStreakProcessor::PlayerStreakHistory] に撃破数を記録します。
	* [UElimStreakProcessor::ElimStreakTags] のキーに設定された連続撃破が発生した際に、値に設定された Gameplay Message (`Lyra.ShooterGame.Accolade.EliminationStreak.5` 等)を送信します。
		* Gameplay Message `Lyra.ShooterGame.Accolade.*` は `B_AccoladeRelay` ([UGameplayMessageProcessor]) が受信します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UElimStreakProcessor::PlayerStreakHistory]: #uelimstreakprocessorplayerstreakhistory
[UElimStreakProcessor::ElimStreakTags]: #uelimstreakprocessorelimstreaktags
[UElimStreakProcessor::OnEliminationMessage()]: #uelimstreakprocessoroneliminationmessage
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraHealthComponent::HandleOutOfHealth()]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponenthandleoutofhealth
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
