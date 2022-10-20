## UGameFeatureAction_AddComponents

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameFeatures > UGameFeatureAction_AddComponents](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameFeatures/UGameFeatureAction_AddComponents/)

> Adds actor<->component spawn requests to the component manager  
>  
> @see UGameFrameworkComponentManager  
> 
> ----
> actor<->component のスポーン要求をコンポーネントマネージャに追加します。
>  
> @UGameFrameworkComponentManager  を参照してください。

* 概要
	* 任意のアクターに任意のコンポーネントを追加するアクションです。
	* サーバー、クライアントを追加の条件に指定可能です。
* Lyra での使われ方
	| Asset                                                                | ActorClass                                      | ComponentClass                                                           | bClientComponent | bServerComponent |
	| -------------------------------------------------------------------- | ----------------------------------------------- | ------------------------------------------------------------------------ | ---------------- | ---------------- |
	| `ShooterCore`<br>([UGameFeatureData])                                | `AGameStateBase`                                | `B_EliminationFeedRelay`<br>([UGameplayMessageProcessor])                | ✔               | ✔               |
	|                                                                      | [ALyraCharacter]                                | [ULyraEquipmentManagerComponent]                                         | ✔               | ✔               |
	|                                                                      | [ALyraPlayerController]                         | [ULyraIndicatorManagerComponent]                                         | ✔               |                  |
	|                                                                      | `AController`                                   | [ULyraInventoryManagerComponent]                                         | ✔               | ✔               |
	|                                                                      | `AController`                                   | [ULyraWeaponStateComponent]                                              | ✔               | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_AimAssistTargetManager`<br>([UAimAssistTargetManagerComponent])       | ✔               |                  |
	| `EAS_BasicShooterAcolades`<br>([ULyraExperienceActionSet])           | `AGameStateBase`                                | `B_ElimChainProcessor`<br>([UElimChainProcessor])                        |                  | ✔               |
	|                                                                      | `AGameStateBase`                                | `B_ElimStreakProcessor`<br>([UElimStreakProcessor])                      |                  | ✔               |
	|                                                                      | `AGameStateBase`                                | `UAssistProcessor`                                                       |                  | ✔               |
	|                                                                      | `AGameStateBase`                                | `B_AccoladeRelay`<br>([UGameplayMessageProcessor])                       | ✔               | ✔               |
	| `LAS_ShooterGame_StandardComponents`<br>([ULyraExperienceActionSet]) | [ALyraPlayerController]                         | `B_NiagaraNumberPopComponent`<br>([ULyraNumberPopComponent_NiagaraText]) | ✔               |                  |
	|                                                                      | `AController`                                   | `B_QuickBarComponent`<br>([ULyraQuickBarComponent])                      | ✔               | ✔               |
	|                                                                      | [ALyraPlayerController]                         | `NameplateManagerComponent`<br>(`UControllerComponent`)                  | ✔               |                  |
	|                                                                      | `B_Hero_ShooterMannequin`<br>([ALyraCharacter]) | `NameplateSource`<br>(`UControllerComponent`)                            | ✔               |                  |
	| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])         | [ALyraGameState]                                | `B_LyraFrontendStateComponent`<br>([ULyraFrontendStateComponent])        | ✔               |                  |
	|                                                                      | [ALyraGameState]                                | `B_MusicManagerComponent_FE`<br>(`UActorComponent`)                      | ✔               |                  |
	| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])   | [ALyraGameState]                                | `B_ControlPointScoring`<br>(`UGameStateComponent`)                       | ✔               | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_MusicManagerComponent_ControlPoint`<br>(`UActorComponent`)            | ✔               |                  |
	|                                                                      | [ALyraGameState]                                | `B_ShooterBotSpawner_ControlPoint`<br>([ULyraBotCreationComponent])      |                  | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                      | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])         | [ALyraGameState]                                | `B_TeamDeathMatchScoring`<br>(`UGameStateComponent`)                     | ✔               | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_MusicManagerComponent_Elimitation`<br>(`UActorComponent`)             | ✔               |                  |
	|                                                                      | [ALyraGameState]                                | `B_ShooterBotSpawner`<br>([ULyraBotCreationComponent])                   |                  | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                      | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])         | [ALyraGameState]                                | `B_TeamSetup_TwoTeams`<br>([ULyraTeamCreationComponent])                 |                  | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_TeamSpawnRules`<br>([UTDM_PlayerSpawningManagmentComponent])          |                  | ✔               |
	|                                                                      | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |
	| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])          | [ALyraPlayerState]                              | `B_PlayerUIComponent`<br>(`UPlayerStateComponent`)                       | ✔               |                  |
	|                                                                      | [ALyraGameState]                                | `B_TeamSetup_FourTeams`<br>([ULyraTeamCreationComponent])                |                  | ✔               |
	|                                                                      | [ALyraGameState]                                | `B_TopDownArena_GameComponent_Lives`<br>(`UGameStateComponent`)          | ✔               | ✔               |
	|                                                                      | `AController`                                   | `B_PickRandomCharacter`<br>([ULyraControllerComponent_CharacterParts])   |                  | ✔               |


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraEquipmentManagerComponent]: ../../Lyra/Equipment/ULyraEquipmentManagerComponent.md#ulyraequipmentmanagercomponent
[UAimAssistTargetManagerComponent]: ../../Lyra/Etc/UAimAssistTargetManagerComponent.md#uaimassisttargetmanagercomponent
[ULyraBotCreationComponent]: ../../Lyra/Etc/ULyraBotCreationComponent.md#ulyrabotcreationcomponent
[ULyraControllerComponent_CharacterParts]: ../../Lyra/Etc/ULyraControllerComponent_CharacterParts.md#ulyracontrollercomponent_characterparts
[ULyraFrontendStateComponent]: ../../Lyra/Etc/ULyraFrontendStateComponent.md#ulyrafrontendstatecomponent
[ULyraIndicatorManagerComponent]: ../../Lyra/Etc/ULyraIndicatorManagerComponent.md#ulyraindicatormanagercomponent
[ULyraNumberPopComponent_NiagaraText]: ../../Lyra/Etc/ULyraNumberPopComponent_NiagaraText.md#ulyranumberpopcomponent_niagaratext
[ULyraQuickBarComponent]: ../../Lyra/Etc/ULyraQuickBarComponent.md#ulyraquickbarcomponent
[ULyraTeamCreationComponent]: ../../Lyra/Etc/ULyraTeamCreationComponent.md#ulyrateamcreationcomponent
[UTDM_PlayerSpawningManagmentComponent]: ../../Lyra/Etc/UTDM_PlayerSpawningManagmentComponent.md#utdm_playerspawningmanagmentcomponent
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraPlayerController]: ../../Lyra/GameplayFramework/ALyraPlayerController.md#alyraplayercontroller
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[UElimChainProcessor]: ../../Lyra/GameplayMessageProcessor/UElimChainProcessor.md#uelimchainprocessor
[UElimStreakProcessor]: ../../Lyra/GameplayMessageProcessor/UElimStreakProcessor.md#uelimstreakprocessor
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
[ULyraInventoryManagerComponent]: ../../Lyra/Inventory/ULyraInventoryManagerComponent.md#ulyrainventorymanagercomponent
[ULyraWeaponStateComponent]: ../../Lyra/Weapon/ULyraWeaponStateComponent.md#ulyraweaponstatecomponent
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
