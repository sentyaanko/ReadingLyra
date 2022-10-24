## ULyraGamePhaseAbility

> The base gameplay ability for any ability that is used to change the active game phase.  
> 
> ----
> アクティブゲームフェーズを変更するために使用するアビリティのベースとなる Gameplay Ability です。 

* 概要
	* [ULyraGameplayAbility] の派生クラスです。
	* ゲームのフェーズごとに有効化／無効化をコントロールするための機能を実装したアビリティクラスです。
	* フェーズについて
		* Lyra ではフェーズをゲームルール上の進行状態を示すのに使用しています。
		* 例えば ShooterCore では、Warmup / Playing / PostGame からなります（ドキュメントに記載されているとおり）。
	* 派生ブループリントは以下のとおりです。
		* `Phase_Warmup`
		* `Phase_Playing`
		* `Phase_PostGame`
	* `Phase_Warmup` / `Phase_Playing` / `Phase_PostGame` について
		* 同名の別アセットがそれぞれ 2 つづつありますが、これは TopDownArena / ShooterCore で別の実装が必要なためです。

### ULyraGamePhaseAbility::GamePhaseTag

> Defines the game phase this game phase ability is part of.  
> For example, if your game phase is GamePhase.RoundStart, then it will cancel all sibling phases.
> 
> So, if you had a phase such as GamePhase.WaitingToStart that was active, starting the ability part of RoundStart would end WaitingToStart. 
> However, to get nested behaviors you can also nest the phases. 
> For example, GamePhase.Playing.NormalPlay, is a sub-phase of the parent GamePhase.Playing, 
> so changing the sub-phase to GamePhase.Playing.SuddenDeath, would stop any ability tied to GamePhase.Playing.*, but wouldn't end any ability tied to the GamePhase.Playing phase.
> 
> ----
> ゲームフェーズアビリティが属するゲームフェーズを定義します。 
> たとえば、ゲーム フェーズが GamePhase.RoundStart の場合、その兄弟フェーズをすべてキャンセルします。
> 
> つまり、 GamePhase.WaitingToStart などのフェーズがアクティブだった場合、
> RoundStart のアビリティ部分を開始すると、 WaitingToStart が終了します。
> ただし、ネストされたビヘイビアを得るには、フェーズをネストすることもできます。
> 例えば、 GamePhase.Playing.NormalPlay は親フェーズである GamePhase.Playing のサブフェーズなので、
> サブフェーズを GamePhase.Playing.SuddenDeath に変更すれば、 GamePhase.Playing.* に結びついた能力は停止しますが、 GamePhase.Playing フェーズに結びついたアビリティを停止するわけではありません。

* 概要
	* ゲームフェーズを表現する GameplayTag です。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
