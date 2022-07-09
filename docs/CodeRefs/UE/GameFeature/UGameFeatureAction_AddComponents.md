## UGameFeatureAction_AddComponents

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameFeatures > UGameFeatureAction_AddComponents](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameFeatures/UGameFeatureAction_AddComponents/)

> Adds actor<->component spawn requests to the component manager  
>  
> @see UGameFrameworkComponentManager  
> 
> ----
> actor<->component のスポーン要求をコンポーネントマネージャに追加する。
>  
> @UGameFrameworkComponentManager  を参照。

* 概要
	* 任意のアクターに任意のコンポーネントを追加するアクションを定義している。
	* サーバー、クライアントを追加の条件に指定可能。
* Lyra での使われ方
	| Asset                                                              | ActorClass                                      | ComponentClass                                                           | bClientComponent | bServerComponent |
	| ------------------------------------------------------------------ | ----------------------------------------------- | ------------------------------------------------------------------------ | ---------------- | ---------------- |
	| `ShooterCore`<br>([UGameFeatureData])                              | `AGameStateBase`                                | `B_EliminationFeedRelay`<br>([UGameplayMessageProcessor])                | ✔               | ✔               |
	|                                                                    | [ALyraCharacter]                                | [ULyraEquipmentManagerComponent]                                         | ✔               | ✔               |
	|                                                                    | [ALyraPlayerController]                         | [ULyraIndicatorManagerComponent]                                         | ✔               |                  |
	|                                                                    | `AController`                                   | [ULyraInventoryManagerComponent]                                         | ✔               | ✔               |
	|                                                                    | `AController`                                   | [ULyraWeaponStateComponent]                                              | ✔               | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_AimAssistTargetManager`<br>([UAimAssistTargetManagerComponent])       | ✔               |                  |
	| `EAS_BasicShooterAcolades`<br>([ULyraExperienceActionSet])         | `AGameStateBase`                                | `B_ElimChainProcessor`<br>([UElimChainProcessor])                        |                  | ✔               |
	|                                                                    | `AGameStateBase`                                | `B_ElimStreakProcessor`<br>([UElimStreakProcessor])                      |                  | ✔               |
	|                                                                    | `AGameStateBase`                                | `UAssistProcessor`                                                       |                  | ✔               |
	|                                                                    | `AGameStateBase`                                | `B_AccoladeRelay`<br>([UGameplayMessageProcessor])                       | ✔               | ✔               |
	| `LAS_ShooterGame_SharedComponents`<br>([ULyraExperienceActionSet]) | [ALyraPlayerController]                         | `B_NiagaraNumberPopComponent`<br>([ULyraNumberPopComponent_NiagaraText]) | ✔               |                  |
	|                                                                    | `AController`                                   | `B_QuickBarComponent`<br>([ULyraQuickBarComponent])                      | ✔               | ✔               |
	|                                                                    | [ALyraPlayerController]                         | `NameplateManagerComponent`<br>(`UControllerComponent`)                  | ✔               |                  |
	|                                                                    | `B_Hero_ShooterMannequin`<br>([ALyraCharacter]) | `NameplateSource`<br>(`UControllerComponent`)                            | ✔               |                  |
	| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])       | [ALyraGameState]                                | `B_LyraFrontendStateComponent`<br>([ULyraFrontendStateComponent])        | ✔               |                  |
	|                                                                    | [ALyraGameState]                                | `B_MusicManagerComponent_FE`<br>(`UActorComponent`)                      | ✔               |                  |
	| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition]) | [ALyraGameState]                                | `B_ControlPointScoring`<br>(`UGameStateComponent`)                       | ✔               | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_MusicManagerComponent_ControlPoint`<br>(`UActorComponent`)            | ✔               |                  |
	|                                                                    | [ALyraGameState]                                | `B_ShooterBotSpawner_ControlPoint`<br>([ULyraBotCreationComponent])      |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                    | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])       | [ALyraGameState]                                | `B_TeamDeathMatchScoring`<br>(`UGameStateComponent`)                     | ✔               | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_MusicManagerComponent_Elimitation`<br>(`UActorComponent`)             | ✔               |                  |
	|                                                                    | [ALyraGameState]                                | `B_ShooterBotSpawner`<br>([ULyraBotCreationComponent])                   |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                    | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])       | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                    | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState]                              | `B_PlayerUIComponent`<br>(`UPlayerStateComponent`)                       | ✔               |                  |
	|                                                                    | [ALyraGameState]                                | `B_TeamSetup_FourTeams`<br>([ULyraTeamCreationComponent])                |                  | ✔               |
	|                                                                    | [ALyraGameState]                                | `B_TopDownArena_GameComponent_Lives`<br>(`UGameStateComponent`)          | ✔               | ✔               |
	|                                                                    | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |