## FPrimaryAssetTypeInfo

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Runtime > Engine > Engine > FPrimaryAssetTypeInfo](https://docs.unrealengine.com/5.0/en-US/API/Runtime/Engine/Engine/FPrimaryAssetTypeInfo/)

> Structure with publicly exposed information about an asset type. These can be loaded out of a config file.  
> 
> ----
> アセットタイプに関する一般に公開された情報を持つ構造体。これらは設定ファイルから読み込むことができます。  

* 概要
	* AssetManager が使用する設定情報。
* Lyra での使われ方
	* `Project Settings > Game - Asset Manager`
		* プロジェクト設定が可能。以下が設定されている。
			| Primary Asset Type                 | Asset Base Class                      | 備考                                                            |
			|------------------------------------|---------------------------------------|-----------------------------------------------------------------|
			| Map                                | `UWorld`                              |                                                                 |
			| LyraGameData                       | [ULyraGameData]                       | `DefaultGameData` のみが該当する。                              |
			| PrimaryAssetLabel                  | `UPrimaryAssetLabel`                  |                                                                 |
			| GameFeatureData                    | [UGameFeatureData]                    |                                                                 |
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |                                                                 |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] | `L_DefaultEditorOverview` のポータルとしても利用。              |
			| LyraLobbyBackground                | [ULyraLobbyBackground]                | `ShooterGameLobbyBG` 飲みが該当する。ロビーの背景用レベル情報。 |
			| LyraExperienceActionSet            | [ULyraExperienceActionSet]            |                                                                 |
	* [UGameFeatureData::PrimaryAssetTypesToScan]
		* GameFeature の設定も可能。
		* `ShooterCore` ([UGameFeatureData]) では以下が設定されている。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
			| LyraExperienceActionSet            | [ULyraExperienceActionSet]            |
			| Map                                | `UWorld`                              |
			| PlayerMappableInputConfig          | [UPlayerMappableInputConfig]          |
		* `ShooterMaps` ([UGameFeatureData]) では以下が設定されている。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| Map                                | `UWorld`                              |
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| LyraLobbyBackground                | [ULyraLobbyBackground]                |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
		* `TopDownArena` ([UGameFeatureData]) では以下が設定されている。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| Map                                | `UWorld`                              |
			| PlayerMappableInputConfig          | [UPlayerMappableInputConfig]          |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
		* それぞれの GameFeature のパスを設定している。


[ALyraWeaponSpawner]: ../../Lyra/Etc/ALyraWeaponSpawner.md
[UAimAssistTargetManagerComponent]: ../../Lyra/Etc/UAimAssistTargetManagerComponent.md
[ULyraBotCreationComponent]: ../../Lyra/Etc/ULyraBotCreationComponent.md
[ULyraCameraMode]: ../../Lyra/Etc/ULyraCameraMode.md
[ULyraCheatManager]: ../../Lyra/Etc/ULyraCheatManager.md
[ULyraControllerComponent_CharacterParts]: ../../Lyra/Etc/ULyraControllerComponent_CharacterParts.md
[ULyraDamageLogDebuggerComponent]: ../../Lyra/Etc/ULyraDamageLogDebuggerComponent.md
[ULyraEquipmentManagerComponent]: ../../Lyra/Etc/ULyraEquipmentManagerComponent.md
[ULyraFrontendStateComponent]: ../../Lyra/Etc/ULyraFrontendStateComponent.md
[ULyraIndicatorManagerComponent]: ../../Lyra/Etc/ULyraIndicatorManagerComponent.md
[ULyraNumberPopComponent]: ../../Lyra/Etc/ULyraNumberPopComponent.md
[ULyraNumberPopComponent_NiagaraText]: ../../Lyra/Etc/ULyraNumberPopComponent_NiagaraText.md
[ULyraPlayerSpawningManagerComponent]: ../../Lyra/Etc/ULyraPlayerSpawningManagerComponent.md
[ULyraQuickBarComponent]: ../../Lyra/Etc/ULyraQuickBarComponent.md
[ULyraSettingsLocal]: ../../Lyra/Etc/ULyraSettingsLocal.md
[ULyraTeamCreationComponent]: ../../Lyra/Etc/ULyraTeamCreationComponent.md
[UTDM_PlayerSpawningManagmentComponent]: ../../Lyra/Etc/UTDM_PlayerSpawningManagmentComponent.md
[ALyraWorldSettings]: ../../Lyra/Experience/ALyraWorldSettings.md
[UAsyncAction_ExperienceReady]: ../../Lyra/Experience/UAsyncAction_ExperienceReady.md
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md
[ULyraUserFacingExperienceDefinition]: ../../Lyra/Experience/ULyraUserFacingExperienceDefinition.md
[FMappableConfigPair]: ../../Lyra/GameFeature/FMappableConfigPair.md
[UApplyFrontendPerfSettingsAction]: ../../Lyra/GameFeature/UApplyFrontendPerfSettingsAction.md
[UGameFeatureAction_AddAbilities]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md
[UGameFeatureAction_AddGameplayCuePath]: ../../Lyra/GameFeature/UGameFeatureAction_AddGameplayCuePath.md
[UGameFeatureAction_AddInputBinding]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md
[UGameFeatureAction_AddInputConfig]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md
[UGameFeatureAction_AddInputContextMapping]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md
[UGameFeatureAction_SplitscreenConfig]: ../../Lyra/GameFeature/UGameFeatureAction_SplitscreenConfig.md
[UGameFeatureAction_WorldActionBase]: ../../Lyra/GameFeature/UGameFeatureAction_WorldActionBase.md
[ULyraGameFeaturePolicy]: ../../Lyra/GameFeature/ULyraGameFeaturePolicy.md
[ULyraGameFeature_AddGameplayCuePaths]: ../../Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md
[ULyraGameFeature_HotfixManager]: ../../Lyra/GameFeature/ULyraGameFeature_HotfixManager.md
[ALyraCharacterWithAbilities]: ../../Lyra/GameplayAbility/ALyraCharacterWithAbilities.md
[FLyraAbilityTagRelationship]: ../../Lyra/GameplayAbility/FLyraAbilityTagRelationship.md
[ILyraReadyInterface]: ../../Lyra/GameplayAbility/ILyraReadyInterface.md
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md
[ULyraAbilityTagRelationshipMapping]: ../../Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md
[ULyraAttributeSet]: ../../Lyra/GameplayAbility/ULyraAttributeSet.md
[ULyraDamageExecution]: ../../Lyra/GameplayAbility/ULyraDamageExecution.md
[ULyraGamePhaseAbility]: ../../Lyra/GameplayAbility/ULyraGamePhaseAbility.md
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md
[ULyraGameplayAbility_Death]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Death.md
[ULyraGameplayAbility_FromEquipment]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_FromEquipment.md
[ULyraGameplayAbility_Interact]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Interact.md
[ULyraGameplayAbility_Jump]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Jump.md
[ULyraGameplayAbility_RangedWeapon]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md
[ULyraGameplayAbility_Reset]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Reset.md
[ULyraGlobalAbilitySystem]: ../../Lyra/GameplayAbility/ULyraGlobalAbilitySystem.md
[ULyraHealExecution]: ../../Lyra/GameplayAbility/ULyraHealExecution.md
[ULyraHealthComponent]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md
[ULyraHealthSet]: ../../Lyra/GameplayAbility/ULyraHealthSet.md
[ULyraHeroComponent]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md
[ULyraPawnComponent]: ../../Lyra/GameplayAbility/ULyraPawnComponent.md
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md
[AGameplayCueNotify_BurstLatent]: ../../Lyra/GameplayCue/AGameplayCueNotify_BurstLatent.md
[ULyraGameplayCueManager]: ../../Lyra/GameplayCue/ULyraGameplayCueManager.md
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md
[ALyraGameMode]: ../../Lyra/GameplayFramework/ALyraGameMode.md
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md
[ALyraPlayerController]: ../../Lyra/GameplayFramework/ALyraPlayerController.md
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md
[UAsyncAction_ListenForGameplayMessage]: ../../Lyra/GameplayMessage/UAsyncAction_ListenForGameplayMessage.md
[UGameplayMessageSubsystem]: ../../Lyra/GameplayMessage/UGameplayMessageSubsystem.md
[FLyraAccoladeDefinitionRow]: ../../Lyra/GameplayMessageAccolade/FLyraAccoladeDefinitionRow.md
[ULyraAccoladeHostWidget]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md
[UAssistProcessor]: ../../Lyra/GameplayMessageProcessor/UAssistProcessor.md
[UElimChainProcessor]: ../../Lyra/GameplayMessageProcessor/UElimChainProcessor.md
[UElimStreakProcessor]: ../../Lyra/GameplayMessageProcessor/UElimStreakProcessor.md
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md
[FLyraAbilityMontageFailureMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraAbilityMontageFailureMessage.md
[FLyraAbilitySimpleFailureMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraAbilitySimpleFailureMessage.md
[FLyraControlPointStatusMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraControlPointStatusMessage.md
[FLyraInteractionDurationMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraInteractionDurationMessage.md
[FLyraInventoryChangeMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraInventoryChangeMessage.md
[FLyraNotificationMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md
[FLyraPlayerResetMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraPlayerResetMessage.md
[FLyraQuickBarActiveIndexChangedMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraQuickBarActiveIndexChangedMessage.md
[FLyraQuickBarSlotsChangedMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraQuickBarSlotsChangedMessage.md
[FLyraVerbMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraVerbMessage.md
[FLyraVerbMessageReplication]: ../../Lyra/GameplayMessageProcessorStruct/FLyraVerbMessageReplication.md
[ULyraHotfixManager]: ../../Lyra/HotfixManager/ULyraHotfixManager.md
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md
[FLyraInventoryList]: ../../Lyra/Inventory/FLyraInventoryList.md
[ULyraInventoryManagerComponent]: ../../Lyra/Inventory/ULyraInventoryManagerComponent.md
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md
[ULyraWeaponStateComponent]: ../../Lyra/Weapon/ULyraWeaponStateComponent.md
[UCommonActivatableWidget]: ../../Lyra/Widget/UCommonActivatableWidget.md
[ULyraActivatableWidget]: ../../Lyra/Widget/ULyraActivatableWidget.md
[ULyraHUDLayout]: ../../Lyra/Widget/ULyraHUDLayout.md
[ULyraJoystickWidget]: ../../Lyra/Widget/ULyraJoystickWidget.md
[ULyraPerfStatContainerBase]: ../../Lyra/Widget/ULyraPerfStatContainerBase.md
[ULyraReticleWidgetBase]: ../../Lyra/Widget/ULyraReticleWidgetBase.md
[ULyraSimulatedInputWidget]: ../../Lyra/Widget/ULyraSimulatedInputWidget.md
[ULyraTaggedWidget]: ../../Lyra/Widget/ULyraTaggedWidget.md
[ULyraTouchRegion]: ../../Lyra/Widget/ULyraTouchRegion.md
[ULyraWeaponUserInterface]: ../../Lyra/Widget/ULyraWeaponUserInterface.md
[FPrimaryAssetTypeInfo]: ../../UE/AssetManager/FPrimaryAssetTypeInfo.md
[UDataRegistrySubsystem]: ../../UE/DataRegistry/UDataRegistrySubsystem.md
[IGameFeatureStateChangeObserver]: ../../UE/GameFeature/IGameFeatureStateChangeObserver.md
[UDefaultGameFeaturesProjectPolicies]: ../../UE/GameFeature/UDefaultGameFeaturesProjectPolicies.md
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md
[UGameFeatureAction_DataRegistry]: ../../UE/GameFeature/UGameFeatureAction_DataRegistry.md
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md
[UGameFeaturesProjectPolicies]: ../../UE/GameFeature/UGameFeaturesProjectPolicies.md
[UGameFeaturesSubsystem]: ../../UE/GameFeature/UGameFeaturesSubsystem.md
[FGameplayAbilitySpec]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md
[FGameplayEffectSpec]: ../../UE/GameplayAbility/FGameplayEffectSpec.md
[UGameplayAbility]: ../../UE/GameplayAbility/UGameplayAbility.md
[UGameplayCueManager]: ../../UE/GameplayCue/UGameplayCueManager.md
[UOnlineHotfixManager]: ../../UE/HotfixManager/UOnlineHotfixManager.md
[FEnhancedActionKeyMapping]: ../../UE/Input/FEnhancedActionKeyMapping.md
[IEnhancedInputSubsystemInterface]: ../../UE/Input/IEnhancedInputSubsystemInterface.md
[UEnhancedInputLocalPlayerSubsystem]: ../../UE/Input/UEnhancedInputLocalPlayerSubsystem.md
[UInputAction]: ../../UE/Input/UInputAction.md
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md
[UPlayerMappableInputConfig]: ../../UE/Input/UPlayerMappableInputConfig.md
