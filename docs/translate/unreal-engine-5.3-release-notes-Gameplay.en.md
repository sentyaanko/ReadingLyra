# Gameplay

## API Change:

* It is now safe to call Super::ActivateAbility in a child class. Previously, it would call CommitAbility.
* This will make it a little easier to write triggers/modifiers in Enhanced Input that want to access the Local Player if they want access to the User Settings object to check aim sensitivity or other things.
* This is useful piece of state for games to use during pawn initialization.
* Commands are prefixed with AbilitySystem.
* GameplayTagQueries that are empty are ambiguous and should be handled on a case-by-case basis by the caller.
* We can go back to the old way of loading the source texture if this breaks something with the "Paper2d.DisableSyncLoadInEditor" CVar flag.
* passing nullptr into SDetailsViewBase::HighlightProperty no longer does nothing and will instead un-highlight all properties
* This is a critical fix if you are attempting to use the input device subsystem. 

## New:

* Added an option to a Targeting System's AOE Targeting Task to offset based on relative space rather than world space.
* Moved TargetingSubsystem functions into the same metadata category.
* Added ULocalPlayerSaveGame base class to the engine that provides utility functions for saving and loading a save game object for a specific Local Player. This wraps the existing save/load logic on GameplayStatics and provides functionality needed to properly support save/load on non-PC platforms.
* OnAvatarSet is now called on the primary instance instead of the CDO for instanced per Actor Gameplay Abilities.
* Added the source location of the AOE task trace as the TraceStart of any FHitResult returned by that task so users have that information available after targeting.
* Input slots now support enum ranges.
* Updated enhanced input settings to allow deferral of settings updates.
* MatchAnyTags, MatchAllTags, and MatchNoTags tag queries now have exposed make nodes in Blueprint.
* Marked UTargetingTask as Abstract so it can't be chosen for EditInlineNew properties.
* Added Data Store for Collision parameters used by the AOE targeting Task.
* Added hook to override collision data from the data store in the AOE Targeting Task.
* Exposed Async Task in the Perform Targeting node so we can get the Targeting Handle before get targeting results.
* Added GetPlatformUserIndex function to LocalPlayer and fixed comments to explain the different indices.
* Expanded AInfo's constructor to support a default ObjectInitializer parameter, covering cases where derived classes could override the default constructor and miss AInfo-specific initialization.
* Allow both Activate Ability and Activate Ability From Event in the same Gameplay Ability Graph.
* AnimTask_PlayMontageAndWait now has a toggle to allow Completed and Interrupted after a BlendOut event.
* Post-process settings from camera shakes and camera animations are now handled as overrides, rather than base world values.
* Added aspect ratio axis constraint override on camera components.
* Added a GetOwningLocalPlayer function to the UPlayerInput class.
* GAS: Added a GameplayTagQuery field to FGameplayTagRequirements to enable more complex requirements to be specified.
* Added a ReceivedPlayerController function to UPlayer, called from it's owning Player Controller when the owning APlayerController pointer is now valid on that player. Alongside this, add a "OnPlayerControllerChanged" delegate to ULocalPlayer and Local Player Subsystems for an easy hook in.
* Introduced FGameplayEffectQuery::SourceAggregateTagQuery to augment SourceTagQuery.
* GAS: ModMagnitudeCalc wrapper functions have been declared const.
* Marked all exec pins as advanced view on Input Action event nodes except for "Triggered".
* Added continuous Input Injection to Enhanced Input.
* Added support for setting AllowedTypes on FPrimaryAssetId function parameters. To use this, add UPARAM(meta = (AllowedTypes = "SomeAssetType")) to a parameter.
* Added EKeys::AnyKey support to Enhanced Input.
* GAS: Extended the functonality to execute and cancel Gameplay Abilities & Gameplay Effects from a console command.
* Added the ability to perform an "Audit" on Gameplay Ability Blueprints that will show information on how they're developed and intended to be used.
* FGameplayTagQuery::Matches now returns false for empty queries.
* Exposed FDateTime's To/From Unix Timestamp functions to Blueprints.
* Added support for properly replicating different types of FGameplayEffectContext.
* Updated FGameplayAttribute::PostSerialize to mark the contained attribute as a searchable name.
* FGameplayEffectContextHandle will now check if data is valid before retrieving "Actors".
* Retain rotation for Gameplay Ability System Target Data LocationInfo.
* Gameplay Ability System now stops searching for PC only if a valid PC is found.
* Updated GetAbilitySystemComponent to default parameter to Self.
* When diffing assets, their detail panels now have colored highlights signifying the changed properties.
* Updated the comments on the Enhanced Action Key Mapping and the Input Action asset to be explict about the order of which modifiers are applied. Modifiers defined in individual key mappings will be applied before those defined in the Input Action asset. Modifiers will not override any that are defined on the Input Action asset, they will be combined together during evaluation.
* Added callback options with metadata on FInstancedPropertyBag
	* Added a TypeFilter callback to filter out some types when changing the type of a property
	* Added a RemoveCheck callback to cancel the removal of a property
	* Added a generic way to invoke 
* You can now merge DataAssets that are conflicted in revision control by right clicking on them in the content browser and selecting "Revision Control/Merge".
* Implemented support for changing default type in PropertyBag detail view Also move Metadata names to a seperate header to reference all available metadata values for StructUtils
* Added a Debug Display Name string to Player Controller input modes. This is useful for doing a quick debug session of why input may not be getting to the player because it could be consumed by the UI.
* Added clarification to the TouchInterface directions.
* Marked functions as virtual in AbilityTask_WaitTargetData.
* Added an advanced setting on the Input Action for the input accumulation behavior. This setting would allow you to change an input action to cumulatively combine input from different Action Key Mappings instead of always accepting the mapping with the highest key value. A practical example of when to use this would be for something like WASD movement, if you want pressing W and S to cancel each other out.
* Added filtering on containers you can use with Properties for StructUtils.
* Added SSourceControlReview::OpenChangelist method to allow external code to open the changelist review dialog.
* Diff tool overhaul that allows asynchronous diffing and improves diff accuracy for details panels.
* Added a EHardwareDeviceSupportedFeatures and EHardwareDevicePrimaryType enums to hardware device identifiers. These allow hardware device identifiers to set flags for themselves to identify some common traits that they have and check what kind of support they have. These are config flags that provide your game a method to change what they support for a given input device and add custom hardware types if desired.
* Added support for instanced struct object references in DataTable and DataRegistry.
* Allow for input injection based on a player key mapping name as well as a UInputAction pointer. We can do this by keeping track of the UInputAction* associated with each player mapping. Keep track of the owning Platform User ID of each player mappable key profile so that you can access the Local Player without needing to get the outer of the profile, which will be useful for custom profile subclasses. 

## Improvement:

* Refactored camera shakes' time management.
* Improved post-process settings blending between view targets.
* Added option for ProjectileMovementComponent to avoid interpolation transform updates on some frames when an object isn't as relevant. Default version is based on not recently rendered but can be extended.
* Added FScopedMovementUpdate around movement of interpolated component in ProjectileMovementComponent. This avoids moving its child components more than once if it then again simulates during the tick. 

## Crash Fix:

* Fixed a crash when trying to apply gameplay cues after a seamless travel.
* Fixed a crash caused by GlobalAbilityTaskCount when using Live Coding.
* Fixed UAbilityTask::OnDestroy to not crash if called recursively for cases like UAbilityTask_StartAbilityState.
* Fixed a crash caused by having entries added to the AsyncTargetingRequests while they were being processed (When an async targeting request node is chained with another one). Now we queue those and process them at the end of the tick.
* Fixed AddTimedDisplay crash when changing a level.
* Prevented a crash when attempting to add an invalid subobject class type with the Subobject Data Subsystem.
* Fixed a crash caused by AGeometryCollectionISMPoolActor holding a garbage pointer.
* Fixed a crash when diffing an Animation Blueprint.
* Fixed a crash when diffing asset additions and removals in the review tool. 

## Bug Fix:

* Use existing GameplayCueParameters if it exists instead of default parameters object in RemoveGameplayCue_Internal.
* Changed Play in Editor initialization to create game instance subsystems before it creates and initializes world subsystems to match how it works in packaged games and map transfers.
* Fixed GetInputAnalogStickState double-to-float wrapper from calling the wrong function.
* GameplayAbilityWorldReticle now faces towards the source Actor instead of the TargetingActor.
* Cache trigger event data if it was passed in with GiveAbilityAndActivateOnce and the ability list was locked.
* Fixed RawScores from getting populated incorrectly in Targeting System Tasks.
* Fixed an issue with Blueprint Debugging 'StepOver' command stopping in incorrect Blueprints.
* TargetingSelectionTask_AOE now respects source actor rotation instead of being axis-aligned.
* Skip processing TargetingTaskSet elements that are null.
* Fixed SCS_Node Actor scenecomponents from not getting re-registered correctly after Build events.
* Fixed some issues with blending out some infinite camera shakes.
* Fixed composite camera shake pattern duration info as shown in sequencer.
* Support has been added for the FInheritedGameplayTags to update its CombinedTags immediately rather than waiting until a Save.
* Fixed Actor loading in the editor to correctly set the transform when a native root component changes class during reparenting.
* Fixed issue affecting the timing of server-forced pawn position updates when time dilation was involved.
* Limited the length of a player mappable name to the max length of FName's to properly check for the max length. This fixes a possible ensure that you could get if you used a name that's too long.
* Fixed regression that would cause erroneous "AttachChildren count increased while detaching" error when a USceneComponent was garbage collected
* Prevented AActor::RerunConstructionScripts from calling a redundant SetWorldTransform inside ExecuteConstruction when the transform hasn't changed. This was causing error accumulation in the relative and world transforms of a component that has an attach parent.
* Fixed character movement issue that could prevent client moves from being submitted at the intended rate when time was dilated.
* Fixed issue where a Character could intend to stay vertical (aligned with gravity) but unable to change pitch or roll to get there.
* Moved ShouldAbilityRespondToEvent from client-only code path to both server and client.
* Fixed an issue where subobjects that are stored in container properties (TArray, TSet, and TMap) would not show up in the details panel if they were created dynamically at runtime.
* Newly created Blueprint Child Classes are now marked as Transactional and therefore allow undo immediately upon creation, rather than after first save.
* Fixed pathing warnings when working with certain types of data assets and data tables.
* Only attempt to auto upgrade to Enhanced Input if the project has a name. This solves an issue where you would get toasts about EI from the project launcher.
* Check for null world pointer before starting/stopping shakes.
* Added some data validation for Combo Step Completion and Cancellation States to make sure at least one state is set.
* Do not attempt to synchronously load the source texture of a Paper2D sprite if we are already in the ASYNC loading thread. This can occur in the editor if cooked content is enabled, on post load of the sprite asset.
* Fixed FAttributeSetInitterDiscreteLevels from not working in Cooked Builds due to Curve Simplification.
* Set CurrentEventData in GameplayAbility.
* Ensure MinimalReplicationTags are set up correctly before potentially executing callbacks.
* Made Blueprint functions on the camera animation subsystem gracefully handle null pointers.
* Fixed comment for UPawnMovementComponent::AddInputVector.
* Fixed ShouldAbilityRespondToEvent from not getting called on the instanced GameplayAbility.
* Gameplay Cue Notify Actors executing on Child Actors no longer leak memory when gc.PendingKill is disabled.
* Made AActor::SetActorTickEnabled virtual.
* Fixed an issue in GameplayCueManager where GameplayCueNotify_Actors could be 'lost' due to hash collisions.
* WaitGameplayTagQuery will now respect its Query even if we have no Gameplay Tags on the Actor.
* PostAttributeChange and AttributeValueChangeDelegates will now have the correct OldValue.
* The minimal view info has been correctly reset to prevent parameters from "leaking" from one view target to the next.
* Applied current scale and easing value to post-process settings weight
* Fixed FGameplayTagQuery from not showing a proper Query Description if the struct was created by native code.
* When bIgnoreAllPressedKeysUntilRelease is true, don't only ignore key presses for keys that were in the previous key mappings, but for every key.
* Fixed not being able to Copy & Paste the Mappings list in an Input Mapping Context.
* Only modify config files if the project has a name, which avoids modifying default engine ini files from the project launcher.
* Fixed package load warning when loading changelists in the review tool that contain non-asset files.
* Resetting the value of the action value bindings when the action is not present in the current mappings.
* Added a "Force Reset" flag to device properties that gets set when PIE ends. This fixes an small bug where the light color or trigger effect could persist between PIE sessions.
* Updated text exporting of objects (used for copy/paste) to sanitize property names containing special characters that would otherwise break the parser on import
* Marked the FKey::KeyName as EditAnywhere so that its value is correctly propagated if it is changed on a subobject. Without this, the KeyName property will be filtered out when determining if a property has changed on a subobject, leading to an unusable UPROPERTY. This has no effect visually in the editor since the FKey has a custom details row.
* Fixed non-deterministic behavior during cook time with regard to the Scale Method pin in on SpawnActorFromClass nodes
* Fixed a regression that caused SDetailsViewBase::HighlightProperty to not support nullptr and thus removing any way to unhighlight a property
* Fixed an issue where some key mappings would incorrectly be displayed as overriden in the "showdebug EnhancedInput" command. This was happening because the AddUnique call to the array would always add a new mapping, since it was comparing the instanced arrays of modifiers and triggers.
* Removed an invalid "break" in a loop that created an order dependant check for chorded actions being blocked.
* Fixed the Input Device Subsystem not finding a valid Game World in a packaged windows project.The subsystem was searching for a PIE only play world, not a cooked game world as well.
* Fixed an issue when comparing enhanced action mappings during RebuildControlMappings because of a deep copy of the modifiers and triggers arrays, so any time we compare a new instance to old instance it would return false no matter what.
* Fixed a bug that caused OneFilePerActor Actors to always diff the local asset against itself instead of against a previous version.
* Ensure that the UAbilitySystemGlobals::InitGlobalData is called if the Ability System is in use. Previously if the user did not call it, the Gameplay Ability System did not function correctly.
* Fixed route gamepad to second window. When this setting is enabled, if you have a gamepad connected to the editor, all gamepad inputs will be routed to the next PIE window.
* Reduced false positives in text-based asset diffs by excluding export paths from the diff.
* Fixed a bug that caused RefreshPropertyObjects in SKismetInspector to not get garbage collected. 

## Deprecated:

* Removed unused function FGameplayAbilityTargetData::AddTargetDataToGameplayCueParameters.
* Removed vestigial GameplayAbility::SetMovementSyncPoint
* Deprecated UPlayerMappableInputConfig in favor of the new UEnhancedInputUserSettings with 5.3.
* Deprecated the FPlayerMappableKeySlot and all its related functions for 5.3, along with all the old player mapped key functions in favor of UEnhancedInputUserSettings. 

## Removed:

* Removed unused replication flag from Gameplay tasks & Ability system components
* Removed ensure when no combo actions are present. Logs a warning instead. 

----
