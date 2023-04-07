## UGameFeatureAction_AddAbilities

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----
> 指定されたタイプのアクターに GameplayAbility（と Attribute ）を付与する責任を持つ GameFeatureAction です。	

* 概要
	* [UGameFeatureAction] の派生クラスです。
	* Game Feature がアクティブになった際にアビリティとアトリビュートセットを付与する GameFeatureAction です。
	* [UGameFeatureAction_AddAbilities::AbilitiesList] にて付与する情報を保持します。
	* 実際の利用状況は以下の通りです。
		| Asset                                                               | ActorClass         | GrantedAbilities  | GrantedAttributes | GrantedAbilitySets<br>([ULyraAbilitySet]) |
		| ------------------------------------------------------------------- | ------------------ | ----------------- | ----------------- | ----------------------------------------- |
		| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])                 | [ALyraPlayerState] |                   |                   | `AbilitySet_InventoryTest`                |
		| `B_LyraShooterGame_ControlPoints`<br>([ULyraExperienceDefinition])  | [ALyraPlayerState] |                   |                   | `AbilitySet_ControlPoint`                 |
		| `B_ShooterGame_Elimination`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState] |                   |                   | `AbilitySet_Elimination`                  |
		| `B_TestInventoryExperience`<br>([ULyraExperienceDefinition])        | [ALyraPlayerState] |                   |                   | `AbilitySet_ControlPoint`                 |

### UGameFeatureAction_AddAbilities::AbilitiesList

* 概要
	* [FGameFeatureAbilitiesEntry] の配列です。
	* 付与する情報を保持します。
	* 設定内容から分かる通り、 [FGameFeatureAbilitiesEntry::GrantedAbilitySets] のみ使用されています。

### UGameFeatureAction_AddAbilities::AddActorAbilities()

* 概要
	* [UGameFeatureAction_AddAbilities::AbilitiesList] に従いアビリティとアトリビュートセットの付与を行います。
	* [UGameFeatureAction_AddAbilities::HandleActorExtension()] から呼び出されます。

### UGameFeatureAction_AddAbilities::RemoveActorAbilities()

* 概要
	* [UGameFeatureAction_AddAbilities::AddActorAbilities()] で付与した内容の剥奪を行います。
	* [UGameFeatureAction_AddAbilities::HandleActorExtension()] から呼び出されます。


### UGameFeatureAction_AddAbilities::HandleActorExtension()

* 概要
	* Game Feature の状態が変更した際に呼ばれるデリゲートに登録される関数です。
	* Game Feature が追加されるときに [UGameFeatureAction_AddAbilities::AddActorAbilities()] を呼び出します。
	* Game Feature が削除されるときに [UGameFeatureAction_AddAbilities::RemoveActorAbilities()] を呼び出します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[FGameFeatureAbilitiesEntry]: ../../Lyra/GameFeature/FGameFeatureAbilitiesEntry.md#fgamefeatureabilitiesentry
[FGameFeatureAbilitiesEntry::GrantedAbilitySets]: ../../Lyra/GameFeature/FGameFeatureAbilitiesEntry.md#fgamefeatureabilitiesentrygrantedabilitysets
[UGameFeatureAction_AddAbilities::AbilitiesList]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilitiesabilitieslist
[UGameFeatureAction_AddAbilities::AddActorAbilities()]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilitiesaddactorabilities
[UGameFeatureAction_AddAbilities::RemoveActorAbilities()]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilitiesremoveactorabilities
[UGameFeatureAction_AddAbilities::HandleActorExtension()]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilitieshandleactorextension
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
