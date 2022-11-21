## ULyraGameplayAbility_Interact

> Gameplay ability used for character interacting  
> 
> ----
> キャラクターとのインタラクトに使用される Gameplay Ability です。  

* 概要
	* [ULyraGameplayAbility] の派生クラスです。
	* [ALyraWorldCollectable] の派生クラスに対してインタラクトを行うアビリティです。
	* 派生ブループリントは以下の通りです。
		* `GA_Interact`
	* `GA_Interact` について
		* `L_InventoryTestMap` にてプレイヤーに付与されています。
			> note:  
			> 上記のレベルに配置されている `B_InteractableRock` ([ALyraWorldCollectable]) に近づきレティクルを合わせると `Interact` と表示されます。  
			> 触れるぐらい近づいた状態でインタラクトの入力（ `e` キーの入力）を行うとプレイヤーに吸い込まれるような動きをしたあと消滅し、インベントリのアイテムが追加されます。
		* 設定に関連するアセットは以下のとおりです。
			* `AbilitySet_InventoryTest` ([ULyraAbilitySet]) 
			* `LAS_InventoryTest` ([ULyraExperienceActionSet])
			* `B_TestInventoryExperience` ([ULyraExperienceDefinition])
			* `L_InventoryTestMap`
			* `IA_Interact` ([UInputAction])
			* `InputData_InventoryTest` ([ULyraInputConfig])
			* `IMC_InventoryTest` ([UInputMappingContext])

### ULyraGameplayAbility_Interact::TriggerInteraction()

* 概要
	* インタラクションを行う側がインタラクションを開始する処理を行う関数です。
	* Gameplay Event `Ability.Interaction.Activate` を呼び出します。
		* Instigator を `GetAvatarActorFromActorInfo()` にしています。

### ULyraGameplayAbility_Interact::ActivateAbility()

* 概要
	* [ULyraGameplayAbility::ActivateAbility()] のオーバーライドです。
	* アビリティタスク `UAbilityTask_GrantNearbyInteraction` の起動を行っています。
		* 設定された距離内で最も近いインタラクト可能なアクターを取得します。
		* そのアクターからインタラクトを行う側に付与する GameplayAbility を取得します。
		* 取得した GameplayAbility をインタラクトを行う側に付与します。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraGameplayAbility::ActivateAbility()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayabilityactivateability
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[ALyraWorldCollectable]: ../../Lyra/Interact/ALyraWorldCollectable.md#alyraworldcollectable
[UInputAction]: ../../UE/Input/UInputAction.md#uinputaction
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
