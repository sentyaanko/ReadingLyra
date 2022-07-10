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

-----
おしまい。

<!--- CodeRefs --->
[ALyraWeaponSpawner]: ../../Lyra/Etc/ALyraWeaponSpawner.md#alyraweaponspawner
[UAimAssistTargetManagerComponent]: ../../Lyra/Etc/UAimAssistTargetManagerComponent.md#uaimassisttargetmanagercomponent
[ULyraBotCreationComponent]: ../../Lyra/Etc/ULyraBotCreationComponent.md#ulyrabotcreationcomponent
[ULyraCameraMode]: ../../Lyra/Etc/ULyraCameraMode.md#ulyracameramode
[ULyraCheatManager]: ../../Lyra/Etc/ULyraCheatManager.md#ulyracheatmanager
[ULyraControllerComponent_CharacterParts]: ../../Lyra/Etc/ULyraControllerComponent_CharacterParts.md#ulyracontrollercomponent_characterparts
[ULyraDamageLogDebuggerComponent]: ../../Lyra/Etc/ULyraDamageLogDebuggerComponent.md#ulyradamagelogdebuggercomponent
[ULyraEquipmentManagerComponent]: ../../Lyra/Etc/ULyraEquipmentManagerComponent.md#ulyraequipmentmanagercomponent
[ULyraFrontendStateComponent]: ../../Lyra/Etc/ULyraFrontendStateComponent.md#ulyrafrontendstatecomponent
[ULyraIndicatorManagerComponent]: ../../Lyra/Etc/ULyraIndicatorManagerComponent.md#ulyraindicatormanagercomponent
[ULyraNumberPopComponent]: ../../Lyra/Etc/ULyraNumberPopComponent.md#ulyranumberpopcomponent
[ULyraNumberPopComponent_NiagaraText]: ../../Lyra/Etc/ULyraNumberPopComponent_NiagaraText.md#ulyranumberpopcomponent_niagaratext
[ULyraPlayerSpawningManagerComponent]: ../../Lyra/Etc/ULyraPlayerSpawningManagerComponent.md#ulyraplayerspawningmanagercomponent
[ULyraQuickBarComponent]: ../../Lyra/Etc/ULyraQuickBarComponent.md#ulyraquickbarcomponent
[ULyraSettingsLocal]: ../../Lyra/Etc/ULyraSettingsLocal.md#ulyrasettingslocal
[ULyraTeamCreationComponent]: ../../Lyra/Etc/ULyraTeamCreationComponent.md#ulyrateamcreationcomponent
[UTDM_PlayerSpawningManagmentComponent]: ../../Lyra/Etc/UTDM_PlayerSpawningManagmentComponent.md#utdm_playerspawningmanagmentcomponent
[ALyraWorldSettings]: ../../Lyra/Experience/ALyraWorldSettings.md#alyraworldsettings
[UAsyncAction_ExperienceReady]: ../../Lyra/Experience/UAsyncAction_ExperienceReady.md#uasyncaction_experienceready
[UAsyncAction_ExperienceReady::OnReady]: ../../Lyra/Experience/UAsyncAction_ExperienceReady.md#uasyncaction_experiencereadyonready
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceActionSet::Actions]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionsetactions
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceDefinition::DefaultPawnData]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitiondefaultpawndata
[ULyraExperienceDefinition::Actions]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitionactions
[ULyraExperienceDefinition::ActionSets]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitionactionsets
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_highpriority
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_lowpriority
[ULyraUserFacingExperienceDefinition]: ../../Lyra/Experience/ULyraUserFacingExperienceDefinition.md#ulyrauserfacingexperiencedefinition
[FMappableConfigPair]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpair
[FMappableConfigPair::Config]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairconfig
[FMappableConfigPair::Type]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairtype
[FMappableConfigPair::DependentPlatformTraits]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairdependentplatformtraits
[FMappableConfigPair::ExcludedPlatformTraits]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairexcludedplatformtraits
[FMappableConfigPair::bShouldActivateAutomatically]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairbshouldactivateautomatically
[UApplyFrontendPerfSettingsAction]: ../../Lyra/GameFeature/UApplyFrontendPerfSettingsAction.md#uapplyfrontendperfsettingsaction
[UGameFeatureAction_AddAbilities]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureaction_addabilities
[UGameFeatureAction_AddGameplayCuePath]: ../../Lyra/GameFeature/UGameFeatureAction_AddGameplayCuePath.md#ugamefeatureaction_addgameplaycuepath
[UGameFeatureAction_AddInputBinding]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md#ugamefeatureaction_addinputbinding
[UGameFeatureAction_AddInputConfig]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfig
[UGameFeatureAction_AddInputConfig::InputConfigs]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfiginputconfigs
[UGameFeatureAction_AddInputContextMapping]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureaction_addinputcontextmapping
[UGameFeatureAction_AddWidgets]: ../../Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgets
[UGameFeatureAction_SplitscreenConfig]: ../../Lyra/GameFeature/UGameFeatureAction_SplitscreenConfig.md#ugamefeatureaction_splitscreenconfig
[UGameFeatureAction_WorldActionBase]: ../../Lyra/GameFeature/UGameFeatureAction_WorldActionBase.md#ugamefeatureaction_worldactionbase
[ULyraGameFeaturePolicy]: ../../Lyra/GameFeature/ULyraGameFeaturePolicy.md#ulyragamefeaturepolicy
[ULyraGameFeature_AddGameplayCuePaths]: ../../Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeature_addgameplaycuepaths
[ULyraGameFeature_HotfixManager]: ../../Lyra/GameFeature/ULyraGameFeature_HotfixManager.md#ulyragamefeature_hotfixmanager
[ALyraCharacterWithAbilities]: ../../Lyra/GameplayAbility/ALyraCharacterWithAbilities.md#alyracharacterwithabilities
[FLyraAbilityTagRelationship]: ../../Lyra/GameplayAbility/FLyraAbilityTagRelationship.md#flyraabilitytagrelationship
[ILyraReadyInterface]: ../../Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterface
[ILyraReadyInterface::IsPawnComponentReadyToInitialize()]: ../../Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterfaceispawncomponentreadytoinitialize
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraAbilitySet::GiveToAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilitysetgivetoabilitysystem
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraAbilitySystemComponent::SetTagRelationshipMapping()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentsettagrelationshipmapping
[ULyraAbilityTagRelationshipMapping]: ../../Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraAttributeSet]: ../../Lyra/GameplayAbility/ULyraAttributeSet.md#ulyraattributeset
[ULyraDamageExecution]: ../../Lyra/GameplayAbility/ULyraDamageExecution.md#ulyradamageexecution
[ULyraGamePhaseAbility]: ../../Lyra/GameplayAbility/ULyraGamePhaseAbility.md#ulyragamephaseability
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayabilityapplyabilitytagstogameplayeffectspec
[ULyraGameplayAbility_Death]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Death.md#ulyragameplayability_death
[ULyraGameplayAbility_FromEquipment]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_FromEquipment.md#ulyragameplayability_fromequipment
[ULyraGameplayAbility_Interact]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Interact.md#ulyragameplayability_interact
[ULyraGameplayAbility_Jump]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Jump.md#ulyragameplayability_jump
[ULyraGameplayAbility_RangedWeapon]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayability_rangedweapon
[ULyraGameplayAbility_Reset]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Reset.md#ulyragameplayability_reset
[ULyraGlobalAbilitySystem]: ../../Lyra/GameplayAbility/ULyraGlobalAbilitySystem.md#ulyraglobalabilitysystem
[ULyraHealExecution]: ../../Lyra/GameplayAbility/ULyraHealExecution.md#ulyrahealexecution
[ULyraHealthComponent]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponent
[ULyraHealthSet]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthset
[ULyraHealthSet::Health]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsethealth
[ULyraHealthSet::MaxHealth]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsetmaxhealth
[ULyraHealthSet::Healing]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsethealing
[ULyraHealthSet::Damage]: ../../Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthsetdamage
[ULyraHeroComponent]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponent
[ULyraHeroComponent::DefaultInputConfigs]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentdefaultinputconfigs
[ULyraHeroComponent::IsPawnComponentReadyToInitialize()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentispawncomponentreadytoinitialize
[ULyraHeroComponent::OnPawnReadyToInitialize()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentonpawnreadytoinitialize
[ULyraHeroComponent::InitializePlayerInput()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinitializeplayerinput
[ULyraHeroComponent::DetermineCameraMode()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentdeterminecameramode
[ULyraPawnComponent]: ../../Lyra/GameplayAbility/ULyraPawnComponent.md#ulyrapawncomponent
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentcheckpawnreadytoinitialize
[ULyraPawnExtensionComponent::PawnData]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentpawndata
[ULyraPawnExtensionComponent::GetPawnData()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentgetpawndata
[ULyraPawnExtensionComponent::SetPawnData()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentsetpawndata
[ULyraPawnExtensionComponent::AbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentabilitysystemcomponent
[ULyraPawnExtensionComponent::GetLyraAbilitySystemComponent()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentgetlyraabilitysystemcomponent
[ULyraPawnExtensionComponent::InitializeAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentinitializeabilitysystem
[ULyraPawnExtensionComponent::UninitializeAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentuninitializeabilitysystem
[AGameplayCueNotify_BurstLatent]: ../../Lyra/GameplayCue/AGameplayCueNotify_BurstLatent.md#agameplaycuenotify_burstlatent
[ULyraGameplayCueManager]: ../../Lyra/GameplayCue/ULyraGameplayCueManager.md#ulyragameplaycuemanager
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ALyraGameMode]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraGameMode::InitGame()]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodeinitgame
[ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodehandlematchassignmentifnotexpectingone
[ALyraGameMode::GetPawnDataForController()]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodegetpawndataforcontroller
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraGameState::MulticastMessageToClients()]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestatemulticastmessagetoclients
[ALyraGameState::MulticastReliableMessageToClients()]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestatemulticastreliablemessagetoclients
[ALyraPlayerController]: ../../Lyra/GameplayFramework/ALyraPlayerController.md#alyraplayercontroller
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ALyraPlayerState::StatTags]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstatestattags
[ALyraPlayerState::OnExperienceLoaded()]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstateonexperienceloaded
[ALyraPlayerState::SetPawnData()]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstatesetpawndata
[ALyraPlayerState::ClientBroadcastMessage()]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstateclientbroadcastmessage
[UAsyncAction_ListenForGameplayMessage]: ../../Lyra/GameplayMessage/UAsyncAction_ListenForGameplayMessage.md#uasyncaction_listenforgameplaymessage
[UGameplayMessageSubsystem]: ../../Lyra/GameplayMessage/UGameplayMessageSubsystem.md#ugameplaymessagesubsystem
[UGameplayMessageSubsystem::BroadcastMessage()]: ../../Lyra/GameplayMessage/UGameplayMessageSubsystem.md#ugameplaymessagesubsystembroadcastmessage
[FLyraAccoladeDefinitionRow]: ../../Lyra/GameplayMessageAccolade/FLyraAccoladeDefinitionRow.md#flyraaccoladedefinitionrow
[ULyraAccoladeHostWidget]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidget
[ULyraAccoladeHostWidget::OnNotificationMessage()]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidgetonnotificationmessage
[UAssistProcessor]: ../../Lyra/GameplayMessageProcessor/UAssistProcessor.md#uassistprocessor
[UElimChainProcessor]: ../../Lyra/GameplayMessageProcessor/UElimChainProcessor.md#uelimchainprocessor
[UElimStreakProcessor]: ../../Lyra/GameplayMessageProcessor/UElimStreakProcessor.md#uelimstreakprocessor
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
[FLyraAbilityMontageFailureMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraAbilityMontageFailureMessage.md#flyraabilitymontagefailuremessage
[FLyraAbilitySimpleFailureMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraAbilitySimpleFailureMessage.md#flyraabilitysimplefailuremessage
[FLyraControlPointStatusMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraControlPointStatusMessage.md#flyracontrolpointstatusmessage
[FLyraInteractionDurationMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraInteractionDurationMessage.md#flyrainteractiondurationmessage
[FLyraInventoryChangeMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraInventoryChangeMessage.md#flyrainventorychangemessage
[FLyraNotificationMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md#flyranotificationmessage
[FLyraNotificationMessage::PayloadTag]: ../../Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md#flyranotificationmessagepayloadtag
[FLyraPlayerResetMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraPlayerResetMessage.md#flyraplayerresetmessage
[FLyraQuickBarActiveIndexChangedMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraQuickBarActiveIndexChangedMessage.md#flyraquickbaractiveindexchangedmessage
[FLyraQuickBarSlotsChangedMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraQuickBarSlotsChangedMessage.md#flyraquickbarslotschangedmessage
[FLyraVerbMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraVerbMessage.md#flyraverbmessage
[FLyraVerbMessageReplication]: ../../Lyra/GameplayMessageProcessorStruct/FLyraVerbMessageReplication.md#flyraverbmessagereplication
[ULyraHotfixManager]: ../../Lyra/HotfixManager/ULyraHotfixManager.md#ulyrahotfixmanager
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[FLyraInventoryList]: ../../Lyra/Inventory/FLyraInventoryList.md#flyrainventorylist
[ULyraInventoryManagerComponent]: ../../Lyra/Inventory/ULyraInventoryManagerComponent.md#ulyrainventorymanagercomponent
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[ULyraPawnData::PawnClass]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatapawnclass
[ULyraPawnData::InputConfig]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatainputconfig
[ULyraPawnData::TagRelationshipMapping]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatatagrelationshipmapping
[ULyraPawnData::DefaultCameraMode]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatadefaultcameramode
[ULyraPawnData::AbilitySets]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndataabilitysets
[ULyraWeaponStateComponent]: ../../Lyra/Weapon/ULyraWeaponStateComponent.md#ulyraweaponstatecomponent
[UCommonActivatableWidget]: ../../Lyra/Widget/UCommonActivatableWidget.md#ucommonactivatablewidget
[ULyraActivatableWidget]: ../../Lyra/Widget/ULyraActivatableWidget.md#ulyraactivatablewidget
[ULyraHUDLayout]: ../../Lyra/Widget/ULyraHUDLayout.md#ulyrahudlayout
[ULyraJoystickWidget]: ../../Lyra/Widget/ULyraJoystickWidget.md#ulyrajoystickwidget
[ULyraPerfStatContainerBase]: ../../Lyra/Widget/ULyraPerfStatContainerBase.md#ulyraperfstatcontainerbase
[ULyraReticleWidgetBase]: ../../Lyra/Widget/ULyraReticleWidgetBase.md#ulyrareticlewidgetbase
[ULyraSimulatedInputWidget]: ../../Lyra/Widget/ULyraSimulatedInputWidget.md#ulyrasimulatedinputwidget
[ULyraTaggedWidget]: ../../Lyra/Widget/ULyraTaggedWidget.md#ulyrataggedwidget
[ULyraTouchRegion]: ../../Lyra/Widget/ULyraTouchRegion.md#ulyratouchregion
[ULyraWeaponUserInterface]: ../../Lyra/Widget/ULyraWeaponUserInterface.md#ulyraweaponuserinterface
[FPrimaryAssetTypeInfo]: ../../UE/AssetManager/FPrimaryAssetTypeInfo.md#fprimaryassettypeinfo
[UDataRegistrySubsystem]: ../../UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystem
[UDataRegistrySubsystem::AcquireItem()]: ../../UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystemacquireitem
[IGameFeatureStateChangeObserver]: ../../UE/GameFeature/IGameFeatureStateChangeObserver.md#igamefeaturestatechangeobserver
[UDefaultGameFeaturesProjectPolicies]: ../../UE/GameFeature/UDefaultGameFeaturesProjectPolicies.md#udefaultgamefeaturesprojectpolicies
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
[UGameFeatureAction_DataRegistry]: ../../UE/GameFeature/UGameFeatureAction_DataRegistry.md#ugamefeatureaction_dataregistry
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UGameFeatureData::Actions]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedataactions
[UGameFeatureData::PrimaryAssetTypesToScan]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedataprimaryassettypestoscan
[UGameFeaturesProjectPolicies]: ../../UE/GameFeature/UGameFeaturesProjectPolicies.md#ugamefeaturesprojectpolicies
[UGameFeaturesSubsystem]: ../../UE/GameFeature/UGameFeaturesSubsystem.md#ugamefeaturessubsystem
[UGameFeaturesSubsystem::AddObserver()]: ../../UE/GameFeature/UGameFeaturesSubsystem.md#ugamefeaturessubsystemaddobserver
[FGameplayAbilitySpec]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspec
[FGameplayAbilitySpec::DynamicAbilityTags]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspecdynamicabilitytags
[FGameplayEffectSpec]: ../../UE/GameplayAbility/FGameplayEffectSpec.md#fgameplayeffectspec
[FGameplayEffectSpec::CapturedSourceTags]: ../../UE/GameplayAbility/FGameplayEffectSpec.md#fgameplayeffectspeccapturedsourcetags
[UGameplayAbility]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayability
[UGameplayAbility::MakeOutgoingGameplayEffectSpec()]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilitymakeoutgoinggameplayeffectspec
[UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilityapplyabilitytagstogameplayeffectspec
[UGameplayCueManager]: ../../UE/GameplayCue/UGameplayCueManager.md#ugameplaycuemanager
[UOnlineHotfixManager]: ../../UE/HotfixManager/UOnlineHotfixManager.md#uonlinehotfixmanager
[FEnhancedActionKeyMapping]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymapping
[FEnhancedActionKeyMapping::Action]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingaction
[FEnhancedActionKeyMapping::Key]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingkey
[IEnhancedInputSubsystemInterface]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterface
[IEnhancedInputSubsystemInterface::GetPlayerInput()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfacegetplayerinput
[IEnhancedInputSubsystemInterface::InjectInputForAction()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceinjectinputforaction
[IEnhancedInputSubsystemInterface::InjectInputVectorForAction()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceinjectinputvectorforaction
[UEnhancedInputLocalPlayerSubsystem]: ../../UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystem
[UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()]: ../../UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystemgetplayerinput
[UInputAction]: ../../UE/Input/UInputAction.md#uinputaction
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
[UInputMappingContext::Mappings]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontextmappings
[UPlayerMappableInputConfig]: ../../UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
[UPlayerMappableInputConfig::Contexts]: ../../UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfigcontexts
