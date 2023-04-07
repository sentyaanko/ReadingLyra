## FGameFeatureAbilitiesEntry

* 概要
	* Gameplay Ability を付与するために [UGameFeatureAction_AddAbilities] が使用するデータです。
	* [FGameFeatureAbilitiesEntry::ActorClass] で指定した `AActor` 派生クラスに対して、アトリビュートセットとアビリティを付与します。
	* アトリビュートセットは [FGameFeatureAbilitiesEntry::GrantedAttributes] に従って付与されます。
	* アビリティは二通りの方法があります。
		* [FGameFeatureAbilitiesEntry::GrantedAbilities] で指定する。
			* 個々のアビリティを [FLyraAbilityGrant] で指定していく形です。
		* [FGameFeatureAbilitiesEntry::GrantedAbilitySets] で指定する。
			* いくつかのアビリティをまとめたデータアセット [FLyraAttributeSetGrant] を指定する形です。

### FGameFeatureAbilitiesEntry::ActorClass

> The base actor class to add to
> 
> ----
> 追加するベースアクターです。

* 概要
	* ここで指定した `AActor` 派生クラスに対して処理を行います。

### FGameFeatureAbilitiesEntry::GrantedAbilities

> List of abilities to grant to actors of the specified class
> 
> ----
> 指定されたクラスのアクターに付与するアビリティのリストです。

* 概要
	* [FLyraAbilityGrant] の配列です。
	* [UGameFeatureAction_AddAbilities::AddActorAbilities()] にて利用されます。

### FGameFeatureAbilitiesEntry::GrantedAttributes

> List of attribute sets to grant to actors of the specified class  
> 
> ----
> 指定されたクラスのアクターに付与するアトリビュートセットのリストです。

* 概要
	* [FLyraAttributeSetGrant] の配列です。
	* [UGameFeatureAction_AddAbilities::AddActorAbilities()] にて利用されます。

### FGameFeatureAbilitiesEntry::GrantedAbilitySets

> List of ability sets to grant to actors of the specified class
> 
> ----
> 指定されたクラスのアクターに付与するアビリティセットのリストです。

* 概要
	* [ULyraAbilitySet] の配列です。
	* [UGameFeatureAction_AddAbilities::AddActorAbilities()] にて利用されます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FGameFeatureAbilitiesEntry::ActorClass]: ../../Lyra/GameFeature/FGameFeatureAbilitiesEntry.md#fgamefeatureabilitiesentryactorclass
[FGameFeatureAbilitiesEntry::GrantedAbilities]: ../../Lyra/GameFeature/FGameFeatureAbilitiesEntry.md#fgamefeatureabilitiesentrygrantedabilities
[FGameFeatureAbilitiesEntry::GrantedAttributes]: ../../Lyra/GameFeature/FGameFeatureAbilitiesEntry.md#fgamefeatureabilitiesentrygrantedattributes
[FGameFeatureAbilitiesEntry::GrantedAbilitySets]: ../../Lyra/GameFeature/FGameFeatureAbilitiesEntry.md#fgamefeatureabilitiesentrygrantedabilitysets
[FLyraAbilityGrant]: ../../Lyra/GameFeature/FLyraAbilityGrant.md#flyraabilitygrant
[FLyraAttributeSetGrant]: ../../Lyra/GameFeature/FLyraAttributeSetGrant.md#flyraattributesetgrant
[UGameFeatureAction_AddAbilities]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilities
[UGameFeatureAction_AddAbilities::AddActorAbilities()]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureactionaddabilitiesaddactorabilities
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
