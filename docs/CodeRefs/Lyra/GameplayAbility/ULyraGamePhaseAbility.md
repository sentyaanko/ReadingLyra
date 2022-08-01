## ULyraGamePhaseAbility

> The base gameplay ability for any ability that is used to change the active game phase.  
> 
> ----


* ゲームのフェーズごとに有効化／無効化をコントロールするための機能を実装したアビリティクラスです。
* Lyra におけるフェーズとは？
	* ゲームルール上の進行状態を示すもの。
	* 例えば ShooterCore では、Warmup / Playing / PostGame からなる（ドキュメントに記載されているとおり）。

LyraGamePhaseAbility.h のコメント
> Defines the game phase this game phase ability is part of.  
> For example, if your game phase is GamePhase.RoundStart, then it will cancel all sibling phases.
> 
> So, if you had a phase such as GamePhase.WaitingToStart that was active, starting the ability part of RoundStart would end WaitingToStart. 
> However, to get nested behaviors you can also nest the phases. 
> For example, GamePhase.Playing.NormalPlay, is a sub-phase of the parent GamePhase.Playing, 
> so changing the sub-phase to GamePhase.Playing.SuddenDeath, would stop any ability tied to GamePhase.Playing.*, but wouldn't end any ability tied to the GamePhase.Playing phase.
> 
> ----
> このゲーム フェーズ能力が属するゲーム フェーズを定義します。 
> たとえば、ゲーム フェーズが GamePhase.RoundStart の場合、その兄弟フェーズをすべてキャンセルします。
> 
> つまり、GamePhase.WaitingToStartなどのフェーズがアクティブだった場合、
> RoundStartのアビリティ部分を開始すると、WaitingToStartが終了します。
> ただし、ネストされたビヘイビアを得るには、フェーズをネストすることもできます。
> 例えば、GamePhase.Playing.NormalPlayは親フェーズであるGamePhase.Playingのサブフェーズなので、
> サブフェーズをGamePhase.Playing.SuddenDeathに変更すれば、GamePhase.Playing.*に結びついた能力は停止しますが、GamePhase.Playingフェーズに結びついた能力を停止するわけではありません。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->

