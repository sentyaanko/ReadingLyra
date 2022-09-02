## UAssistProcessor

> Tracks assists (dealing damage to another player without finishing them)  
> 
> ----
> アシストを追跡します（他のプレイヤーにダメージを与え、とどめを刺していない）。  

* 概要
	* [UGameplayMessageProcessor] の派生クラスです。
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet]) などから `AGameStateBase` 派生クラスにサーバー側にだけ追加されます。
	* Elimination/ControlPoint の際、撃破のアシストを追跡するクラスです。

### UAssistProcessor::DamageHistory

> Map of player to damage dealt to them  
> 
> ----
> プレイヤーに与えたダメージに対するプレイヤーのマップです。  

* 概要
	* ダメージを受けた PlayerState をキーとし [FPlayerAssistDamageTracking] を値とする連想配列です。

### UAssistProcessor::OnDamageMessage()

* 概要
	* Gameplay Message `Lyra.Damage.Message` を受信した際に実行させる関数です。
		* この Gameplay Message は [ULyraHealthSet::PostGameplayEffectExecute()] から送られます。
	* [UAssistProcessor::DamageHistory] にダメージ値を記録します。

### UAssistProcessor::OnEliminationMessage()

* 概要
	* Gameplay Message `Lyra.Elimination.Message` を受信した際に実行させる関数です。
	* [UAssistProcessor::DamageHistory] に記録されたダメージ値を調べ、撃破のアシストをしていた場合は Gameplay Message `Lyra.Assist.Message` を送信します。
		* この Gameplay Message を受信するのは以下になります。
			* `B_ShooterGameScoring_Base` (`UGameStateComponent`)
			* `B_TopDownArena_GameComponent_Base` (`UGameStateComponent`)


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraHealthSet::PostGameplayEffectExecute()]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsetpostgameplayeffectexecute
[FPlayerAssistDamageTracking]: ../../Lyra/GameplayMessageProcessor/FPlayerAssistDamageTracking.md#fplayerassistdamagetracking
[UAssistProcessor::DamageHistory]: ../../Lyra/GameplayMessageProcessor/UAssistProcessor.md#uassistprocessordamagehistory
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
