## UGameplayMessageSubsystem

> This system allows event raisers and listeners to register for messages without having to know about each other directly,  
> though they must agree on the format of the message (as a USTRUCT() type).  
>  
> You can get to the message router from the game instance:  
> 	UGameInstance::GetSubsystem<UGameplayMessageSubsystem>(GameInstance)  
> or directly from anything that has a route to a world:  
> 	UGameplayMessageSubsystem::Get(WorldContextObject)  
>  
> Note that call order when there are multiple listeners for the same channel is not guaranteed and can change over time!  
> 
> ----
> このシステムにより、イベント発信者と受信者は、メッセージのフォーマット（USTRUCT()型として）に合意する必要があるものの、  
> 互いのことを直接知らなくても、メッセージを登録することができるようになります。  
>  
> メッセージルーターは、ゲームインスタンスから:  
> 	UGameInstance::GetSubsystem<UGameplayMessageSubsystem>(GameInstance)  
> またはワールドへのルートを持つものから直接取得できます。  
> 	UGameplayMessageSubsystem::Get(WorldContextObject)  
>  
> 同じチャンネルに複数のリスナーがいる場合の呼び出し順は保証されておらず、  
> 時間の経過とともに変化する可能性があることに注意してください。  

* 概要
	* 受信者はこのクラスにリスナー関数を登録する。
	* 送信者はメッセージを渡し、このクラスは保持している受信者のリスナー関数を呼び出す。

利用状況は概ね以下の通り。

| Channel                                                                                                                                                                                                     | 送信者                                                                                                                                                 | 受信者                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | メッセージの型                           | 内容                                                                               |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- | ---------------------------------------------------------------------------------- |
| `Ability.Grenade.Duration.Message`                                                                                                                                                                          | `GA_Grenade` ([ULyraGameplayAbility])                                                                                                                  | `W_GrenadeCooldown` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                           | [FLyraInteractionDurationMessage]        | 期間情報（グレネードのクールダウン）                                               |
| `Ability.Dash.Duration.Message`                                                                                                                                                                             | `GA_Hero_Dash` (`GA_AbilityWithWidget`)                                                                                                                | `W_DashTouchButton` (`UUserWidget`)<br>`W_DashCooldown` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                       | [FLyraInteractionDurationMessage]        | 期間情報（ダッシュのクールダウン）                                                 |
| `Ability.Interaction.Duration.Message`                                                                                                                                                                      | `GA_Interaction_Collect` ([ULyraGameplayAbility])                                                                                                      | `W_AbilityProgress` ([ULyraTaggedWidget])                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [FLyraInteractionDurationMessage]        | 期間情報（インタラクション）                                                       |
| `Ability.Respawn.Duration.Message`                                                                                                                                                                          | `GA_AutoRespawn` ([ULyraGameplayAbility])                                                                                                              | `W_RespawnTimer` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                              | [FLyraInteractionDurationMessage]        | 期間情報（リスポーンまでの期間）                                                   |
| `Ability.Respawn.Completed.Message`                                                                                                                                                                         | `GA_AutoRespawn` ([ULyraGameplayAbility])<br>by [ALyraGameState::MulticastReliableMessageToClients()]                                                  | `W_RespawnTimer` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                              | [FLyraVerbMessage]                       | リスポーン情報                                                                     |
| `Ability.UserFacingSimpleActivateFail.Message`                                                                                                                                                              | [ULyraGameplayAbility]<br>`B_WeaponSpawner` ([ALyraWeaponSpawner])                                                                                     | `W_AbilityFailureFeedback` ([ULyraTaggedWidget])                                                                                                                                                                                                                                                                                                                                                                                                                                              | [FLyraAbilitySimpleFailureMessage]       | アビリティのアクティブ化の失敗の原因                                               |
| `Ability.PlayMontageOnActivateFail.Message`                                                                                                                                                                 | [ULyraGameplayAbility]                                                                                                                                 | `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon])                                                                                                                                                                                                                                                                                                                                                                                                                                        | [FLyraAbilityMontageFailureMessage]      | アビリティのアクティブ化の失敗の原因<br>（とその際に利用可能なモンタージュの情報） |
| `GameplayEvent.Reset`                                                                                                                                                                                       | [ULyraGameplayAbility_Reset]                                                                                                                           | `GA_AutoRespawn` ([ULyraGameplayAbility])                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [FLyraPlayerResetMessage]                | プレイヤーリセットの発生                                                           |
| `Gameplay.Message.ADS`                                                                                                                                                                                      | `GA_ADS` (`GA_AbilityWithWidget`)                                                                                                                      | `W_Reticle_Shotgun` ([ULyraReticleWidgetBase])<br>`W_Reticle_Rifle` ([ULyraReticleWidgetBase])<br>`W_Reticle_Pistol` ([ULyraReticleWidgetBase])                                                                                                                                                                                                                                                                                                                                               | `Struct_UIMessaging`                     | ADS しているかの情報                                                               |
| `Gameplay.Message.Nameplate.Add`                                                                                                                                                                            | `NameplateSource` (`UControllerComponent`)                                                                                                             | `NameplateManagerComponent` (`UControllerComponent`)                                                                                                                                                                                                                                                                                                                                                                                                                                          | `Message_NameplateInfo`                  | ネームプレート情報追加                                                             |
| `Gameplay.Message.Nameplate.Remove`                                                                                                                                                                         | `NameplateSource` (`UControllerComponent`)                                                                                                             | `NameplateManagerComponent` (`UControllerComponent`)                                                                                                                                                                                                                                                                                                                                                                                                                                          | `Message_NameplateInfo`                  | ネームプレート情報削除                                                             |
| `Gameplay.Message.Nameplate.Discover`                                                                                                                                                                       | `NameplateManagerComponent` (`UControllerComponent`)                                                                                                   | `NameplateSource` (`UControllerComponent`)                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `Message_NameplateRequest`               | ネームプレート情報問い合わせ                                                       |
| `Lyra.QuickBar.Message.SlotsChanged`                                                                                                                                                                        | [ULyraQuickBarComponent]                                                                                                                               | `W_QuickBarSlot` ([ULyraTaggedWidget])                                                                                                                                                                                                                                                                                                                                                                                                                                                        | [FLyraQuickBarSlotsChangedMessage]       | 武器のスロット内容の変更                                                           |
| `Lyra.QuickBar.Message.ActiveIndexChanged`                                                                                                                                                                  | [ULyraQuickBarComponent]                                                                                                                               | `W_QuickBarSlot` ([ULyraTaggedWidget])                                                                                                                                                                                                                                                                                                                                                                                                                                                        | [FLyraQuickBarActiveIndexChangedMessage] | 武器のアクティブスロットの変更                                                     |
| `Lyra.Inventory.Message.StackChanged`                                                                                                                                                                       | [FLyraInventoryList]                                                                                                                                   | `W_InventoryGrid` (`UUserWidget`)<br>`W_ItemAcquiredList` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                     | [FLyraInventoryChangeMessage]            | インベントリの変更                                                                 |
| `Lyra.Damage.Message`                                                                                                                                                                                       | [ULyraHealthSet]                                                                                                                                       | [ULyraDamageLogDebuggerComponent]<br>[UAssistProcessor]                                                                                                                                                                                                                                                                                                                                                                                                                                       | [FLyraVerbMessage]                       | ヘルスの減少                                                                       |
| `Lyra.Elimination.Message`                                                                                                                                                                                  | [ULyraHealthComponent]<br>`B_EliminationFeedRelay` ([UGameplayMessageProcessor])<br>by [ALyraGameState::MulticastReliableMessageToClients()]           | [UAssistProcessor]<br>[UElimChainProcessor]<br>[UElimStreakProcessor]<br>[UGameplayMessageProcessor]<br>`B_MusicManagerComponent_Base` (`UActorComponent`)<br>`W_Reticle_Shotgun` ([ULyraReticleWidgetBase])<br>`W_Reticle_Rifle` ([ULyraReticleWidgetBase])<br>`W_Reticle_Pistol` ([ULyraReticleWidgetBase])<br>`B_ShooterGameScoring_Base` (`UGameStateComponent`)<br>`B_TopDownArena_GameComponent_Base` (`UGameStateComponent`)<br>`B_EliminationFeedRelay` ([UGameplayMessageProcessor]) | [FLyraVerbMessage]                       | ヘルスがなくなった                                                                 |
| `Lyra.Assist.Message`                                                                                                                                                                                       | [UAssistProcessor]                                                                                                                                     | `B_ShooterGameScoring_Base` (`UGameStateComponent`)<br>`B_TopDownArena_GameComponent_Base` (`UGameStateComponent`)                                                                                                                                                                                                                                                                                                                                                                            | [FLyraVerbMessage]                       | キルのアシストをした                                                               |
| `Lyra.AddNotification.Message`                                                                                                                                                                              | `B_AccoladeRelay` ([UGameplayMessageProcessor])                                                                                                        | [ULyraAccoladeHostWidget]                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [FLyraNotificationMessage]               | 称賛情報（表示用）                                                                 |
| `Lyra.AddNotification.KillFeed`                                                                                                                                                                             | `B_EliminationFeedRelay` ([UGameplayMessageProcessor])                                                                                                 | `W_EliminationFeed` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `EliminationFeedMessage`                 | フィード情報                                                                       |
| `Lyra.ShooterGame.Accolade`                                                                                                                                                                                 |                                                                                                                                                        | `B_AccoladeRelay` ([UGameplayMessageProcessor])<br>（`Lyra.ShooterGame.Accolade.*` をまとめて処理している）                                                                                                                                                                                                                                                                                                                                                                                   | [FLyraVerbMessage]                       | 称賛情報                                                                           |
| `Lyra.ShooterGame.Accolade.EliminationChain.2x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.3x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.4x`<br>`Lyra.ShooterGame.Accolade.EliminationChain.5x`    | `B_ElimChainProcessor` ([UElimChainProcessor])<br>`B_AccoladeRelay` ([UGameplayMessageProcessor])<br>by [ALyraPlayerState::ClientBroadcastMessage()]   | `B_AccoladeRelay` ([UGameplayMessageProcessor])                                                                                                                                                                                                                                                                                                                                                                                                                                               | [FLyraVerbMessage]                       | 称賛情報（連鎖排除）<br> `5x` は送信されていない。                                 |
| `Lyra.ShooterGame.Accolade.EliminationStreak.5`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.10`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.15`<br>`Lyra.ShooterGame.Accolade.EliminationStreak.20` | `B_ElimStreakProcessor` ([UElimStreakProcessor])<br>`B_AccoladeRelay` ([UGameplayMessageProcessor])<br>by [ALyraPlayerState::ClientBroadcastMessage()] | `B_AccoladeRelay` ([UGameplayMessageProcessor])                                                                                                                                                                                                                                                                                                                                                                                                                                               | [FLyraVerbMessage]                       | 称賛情報（連続排除）                                                               |
| `Lyra.Damage.Taken.Message`                                                                                                                                                                                 | `GCNL_Character_DamageTaken` ([AGameplayCueNotify_BurstLatent])                                                                                        | `B_MusicManagerComponent_Base` (`UActorComponent`)                                                                                                                                                                                                                                                                                                                                                                                                                                            | [FLyraVerbMessage]                       | 被ダメージ情報（ボリューム調整用）                                                 |
| `ShooterGame.GamePhase.MatchBeginCountdown`                                                                                                                                                                 | `Phase_Warmup` ([ULyraGamePhaseAbility])<br>by [ALyraGameState::MulticastMessageToClients()]<br>by [UGameplayMessageSubsystem::BroadcastMessage()]     | `W_WaitingForPlayers_Message` (`UUserWidget`)                                                                                                                                                                                                                                                                                                                                                                                                                                                 | [FLyraVerbMessage]                       | `ShooterCore` のゲームフェーズ<br>`Warmup` でのカウントダウン通知                  |
| `ShooterGame.ControlPoint.Captured.Message`                                                                                                                                                                 | `B_ControlPointVolume` (`AActor`)                                                                                                                      | `B_MusicManagerComponent_ControlPoint` (`B_MusicManagerComponent_Base`)                                                                                                                                                                                                                                                                                                                                                                                                                       | [FLyraControlPointStatusMessage]         | キャプチャーしたチーム情報                                                         |

`Lyra.ShooterGame.Accolade.*` の処理の流れは大まかに以下のような形。  
![](../../../GameplayAbility/images/AccoladeMessageSequence.png)

### UGameplayMessageSubsystem::BroadcastMessage()

* 概要
	* 指定されたチャンネルでメッセージをブロードキャストで送る。
	* 以下の RPC 関数経由でも呼び出されている。
		* [ALyraGameState::MulticastMessageToClients()]
		* [ALyraGameState::MulticastReliableMessageToClients()]
		* [ALyraPlayerState::ClientBroadcastMessage()]
	* [FLyraVerbMessageReplication] からも呼び出されている。
