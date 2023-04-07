## FLyraVerbMessage

> Represents a generic message of the form Instigator Verb Target (in Context, with Magnitude)  
> 
> ----
> Instigator Verb Target (in Context, with Magnitude) という形式の汎用メッセージを表します。  

* 概要
	* Instigator や Target や Magnitude 等を送る、汎用的情報を格納するための構造体です。
	* Gamepaly Message で送受信する他、 RPC でクライアントに送ることが可能です。
		* 以下の関数があります。
			* [ALyraGameState::MulticastMessageToClients()]
			* [ALyraGameState::MulticastReliableMessageToClients()]
			* [ALyraPlayerState::ClientBroadcastMessage()]
		* どの関数も内部で `UGameplayMessageSubsystem::BroadcastMessage()` を呼び出しています。
		* そうすることで Gameplay Message をサーバーからクライアントに伝播させています。
	* 利用している Gameplay Message は以下の通りです。
		| Channel                                                                                                                                                                                                     | 送信者                                                                                                                                                 | 受信者                                                                                                                                                                                                                                                                                                                                                                                                                                                         | 内容                                                              |
		| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| ------------------------------------------------------------------|
		| `Ability.Respawn.Completed.Message`                                                                                                                                                                         | `GA_AutoRespawn` ([ULyraGameplayAbility])<br>by [ALyraGameState::MulticastReliableMessageToClients()]                                                  | `W_RespawnTimer` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                               | リスポーン情報                                                    |
		| `Lyra.Damage.Message`                                                                                                                                                                                       | [ULyraHealthSet]                                                                                                                                       | [ULyraDamageLogDebuggerComponent]<br>[UAssistProcessor]                                                                                                                                                                                                                                                                                                                                                                                                        | ヘルスの減少                                                      |
		| `Lyra.Elimination.Message`                                                                                                                                                                                  | [ULyraHealthComponent]<br>`B_EliminationFeedRelay` ([UGameplayMessageProcessor])<br>by [ALyraGameState::MulticastReliableMessageToClients()]           | [UAssistProcessor]<br>[UElimChainProcessor]<br>[UElimStreakProcessor]<br>`B_MusicManagerComponent_Base` (`UActorComponent`)<br>`W_Reticle_Shotgun` ([ULyraReticleWidgetBase])<br>`W_Reticle_Rifle` ([ULyraReticleWidgetBase])<br>`W_Reticle_Pistol` ([ULyraReticleWidgetBase])<br>`B_ShooterGameScoring_Base` (`UGameStateComponent`)<br>`B_TopDownArena_GameComponent_Base` (`UGameStateComponent`)<br>`B_EliminationFeedRelay` ([UGameplayMessageProcessor]) | ヘルスがなくなった                                                |
		| `Lyra.Assist.Message`                                                                                                                                                                                       | [UAssistProcessor]                                                                                                                                     | `B_ShooterGameScoring_Base` (`UGameStateComponent`)<br>`B_TopDownArena_GameComponent_Base` (`UGameStateComponent`)                                                                                                                                                                                                                                                                                                                                             | キルのアシストをした                                              |
		| `Lyra.ShooterGame.Accolade`                                                                                                                                                                                 |                                                                                                                                                        | `B_AccoladeRelay` ([UGameplayMessageProcessor])<br>（`Lyra.ShooterGame.Accolade.*` をまとめて処理している）                                                                                                                                                                                                                                                                                                                                                    | 称賛情報                                                          |
		| `Lyra.ShooterGame.Accolade.EliminationChain.2x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.3x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.4x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.5x`    | `B_ElimChainProcessor` ([UElimChainProcessor])<br>`B_AccoladeRelay` ([UGameplayMessageProcessor])<br>by [ALyraPlayerState::ClientBroadcastMessage()]   | `B_AccoladeRelay` ([UGameplayMessageProcessor])                                                                                                                                                                                                                                                                                                                                                                                                                | 称賛情報（連鎖撃破）<br> `5x` は送信されていない。                |
		| `Lyra.ShooterGame.Accolade.EliminationStreak.5`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.10`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.15`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.20` | `B_ElimStreakProcessor` ([UElimStreakProcessor])<br>`B_AccoladeRelay` ([UGameplayMessageProcessor])<br>by [ALyraPlayerState::ClientBroadcastMessage()] | `B_AccoladeRelay` ([UGameplayMessageProcessor])                                                                                                                                                                                                                                                                                                                                                                                                                | 称賛情報（連続撃破）                                              |
		| `Lyra.Damage.Taken.Message`                                                                                                                                                                                 | `GCNL_Character_DamageTaken` ([AGameplayCueNotify_BurstLatent])                                                                                        | `B_MusicManagerComponent_Base` (`UActorComponent`)                                                                                                                                                                                                                                                                                                                                                                                                             | 被ダメージ情報（ボリューム調整用）                                |
		| `ShooterGame.GamePhase.MatchBeginCountdown`                                                                                                                                                                 | `Phase_Warmup` ([ULyraGamePhaseAbility])<br>by [ALyraGameState::MulticastMessageToClients()]<br>by [UGameplayMessageSubsystem::BroadcastMessage()]     | `W_WaitingForPlayers_Message` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                  | `ShooterCore` のゲームフェーズ<br>`Warmup` でのカウントダウン通知 |
	* 補足
		* `Ability.Respawn.Completed.Message`
			* このメッセージはリスポーンが完了したことを知らせるためのものです。
			* 送信
				* `GA_AutoRespawn` ([ULyraGameplayAbility]) 
					* `HasAuthority` の環境のみ [ALyraGameState::MulticastReliableMessageToClients()] を呼び出すことでサーバー/クライアントに通知しています。
			* 受信
				* `W_RespawnTimer` (`UUserWidget`)
					* 表示に反映させるのに利用しています。
		* `Lyra.Elimination.Message`
			* このメッセージはヘルスが 0 以下になったことを知らせるためのものです。
			* 送信
				* [ULyraHealthComponent]
					* `WITH_SERVER_CODE` でくくられたコードで [UGameplayMessageSubsystem::BroadcastMessage()] を呼び出すことで、サーバー内に通知しています。
			* 受信
				* `B_EliminationFeedRelay` ([UGameplayMessageProcessor])
					* `HasAuthority` の環境のみ [ALyraGameState::MulticastReliableMessageToClients()] を呼び出すことでサーバー/クライアントに通知しています。
						* [ALyraGameState::MulticastReliableMessageToClients()] により、サーバー内で送られていた Gameplay Message `Lyra.Elimination.Message` がクライアントにも送らることになります。
				* [UAssistProcessor]
					* キルアシストの判定に利用しています。
				* [UElimChainProcessor]
					* 連鎖撃破の判定に利用しています。
				* [UElimStreakProcessor]
					* 連続撃破の判定に利用しています。
				* `B_MusicManagerComponent_Base` (`UActorComponent`)
					* 死亡中は MusicSystem の Intensity を 0 にするのに利用しています。
				* `W_Reticle_Shotgun` / `W_Reticle_Rifle` / `W_Reticle_Pistol` ([ULyraReticleWidgetBase])
					* レティクルに撃破アニメーションを再生するのに利用しています。
				* `B_ShooterGameScoring_Base` / `B_TopDownArena_GameComponent_Base` (`UGameStateComponent`)
					* スコア集計に利用しています。
		* `Lyra.ShooterGame.Accolade.*`
			* このメッセージは称賛情報を知らせるためのものです。
			* 送信
				* `B_ElimChainProcessor` ([UElimChainProcessor])
					* [UGameplayMessageSubsystem::BroadcastMessage()] を呼び出すことで、連鎖撃破の発生をサーバー内に通知しています。
				* `B_ElimStreakProcessor` ([UElimStreakProcessor])
					* [UGameplayMessageSubsystem::BroadcastMessage()] を呼び出すことで、連続撃破の発生をサーバー内に通知しています。
			* 受信
				* `B_AccoladeRelay` ([UGameplayMessageProcessor])
					* `HasAuthority` の環境のみ [ALyraPlayerState::ClientBroadcastMessage()] を呼び出すことでクライアントに通知しています。
						* [ALyraPlayerState::ClientBroadcastMessage()] により、サーバー内で送られていた Gameplay Message `Lyra.ShooterGame.Accolade.*` が PlayerState のオーナークライアントにも送らることになります。
					* コスメティック処理が可能な環境のみ、 Gameplay Message `Lyra.AddNotification.Message` を送信します。
						* この Gameplay Message は [ULyraAccoladeHostWidget] が受信します。
		* `ShooterGame.GamePhase.MatchBeginCountdown`
			* このメッセージはマッチング期間の終了カウントダウンの開始を知らせるためのものです。
			* 送信
				* `Phase_Warmup` ([ULyraGamePhaseAbility])
					* `HasAuthority` の環境のみ [ALyraGameState::MulticastMessageToClients()] を呼び出すことでサーバー/クライアントに通知しています。
						* [ALyraGameState::MulticastMessageToClients()] により、サーバー内で送られていた Gameplay Message `ShooterGame.GamePhase.MatchBeginCountdown` がクライアントにも送らることになります。
					* コスメティック処理が可能な環境のみ、 Gameplay Message `ShooterGame.GamePhase.MatchBeginCountdown` を送信します。
						* この Gameplay Message は `W_WaitingForPlayers_Message` (`UUserWidget`) が受信します。
			* 受信
				* `W_WaitingForPlayers_Message` (`UUserWidget`)
					* マッチング終了(ゲーム開始)カウントダウンアニメーションの再生開始に利用しています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraDamageLogDebuggerComponent]: ../../Lyra/Etc/ULyraDamageLogDebuggerComponent.md#ulyradamagelogdebuggercomponent
[ULyraGamePhaseAbility]: ../../Lyra/GameplayAbility/ULyraGamePhaseAbility.md#ulyragamephaseability
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraHealthComponent]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponent
[ULyraHealthSet]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthset
[AGameplayCueNotify_BurstLatent]: ../../Lyra/GameplayCue/AGameplayCueNotify_BurstLatent.md#agameplaycuenotifyburstlatent
[ALyraGameState::MulticastMessageToClients()]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestatemulticastmessagetoclients
[ALyraGameState::MulticastReliableMessageToClients()]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestatemulticastreliablemessagetoclients
[ALyraPlayerState::ClientBroadcastMessage()]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstateclientbroadcastmessage
[ULyraAccoladeHostWidget]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidget
[UAssistProcessor]: ../../Lyra/GameplayMessageProcessor/UAssistProcessor.md#uassistprocessor
[UElimChainProcessor]: ../../Lyra/GameplayMessageProcessor/UElimChainProcessor.md#uelimchainprocessor
[UElimStreakProcessor]: ../../Lyra/GameplayMessageProcessor/UElimStreakProcessor.md#uelimstreakprocessor
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
[ULyraReticleWidgetBase]: ../../Lyra/Widget/ULyraReticleWidgetBase.md#ulyrareticlewidgetbase
[UGameplayMessageSubsystem::BroadcastMessage()]: ../../Plugin/GameplayMessageSubsystem/UGameplayMessageSubsystem.md#ugameplaymessagesubsystembroadcastmessage
