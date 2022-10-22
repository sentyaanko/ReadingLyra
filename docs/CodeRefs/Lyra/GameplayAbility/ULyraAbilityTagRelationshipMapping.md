## ULyraAbilityTagRelationshipMapping

> Mapping of how ability tags block or cancel other abilities  
> 
> ----
> アビリティタグが他のアビリティをブロックまたはキャンセルする方法のマッピングです。

* 概要
	* `UDataAsset` の派生クラスです。
	* GameplayAbility の GameplayTag によるブロックやキャンセルの定義をまとめた構造体です。
	* [ULyraAbilitySystemComponent] から利用されます。
	* [ULyraPawnData::TagRelationshipMapping] で保持されています。
	* [ULyraPawnData] を元にポーンを構築する際に [ULyraAbilitySystemComponent] に渡し、そこでも保持されます。
	* [UGameplayAbility] のタグにアクセスする際に値がミックスされます。組み合わせは以下の通りです。
		| [FLyraAbilityTagRelationship]                         | [UGameplayAbility]                         |
		|-------------------------------------------------------|--------------------------------------------|
		| [FLyraAbilityTagRelationship::AbilityTagsToBlock]     | [UGameplayAbility::BlockAbilitiesWithTag]  |
		| [FLyraAbilityTagRelationship::AbilityTagsToCancel]    | [UGameplayAbility::CancelAbilitiesWithTag] |
		| [FLyraAbilityTagRelationship::ActivationRequiredTags] | [UGameplayAbility::ActivationRequiredTags] |
		| [FLyraAbilityTagRelationship::ActivationBlockedTags]  | [UGameplayAbility::ActivationBlockedTags]  |
* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]

> Note: [UGameplayAbility] でのタグの扱いがカプセル化されておらず、どこで使われているか追いきれていなません。要確認。  
> * 構築時に統合、というような単純な方法ではなく、参照されるたびに値をミックスしているように見受けられます。  
> * NonInstanced な Gameplay Ability の場合 CDO を使用するため、話はそう単純ではない（インスタンスがないため、構築時に統合、ということが出来ない）のだと思われます。  

### ULyraAbilityTagRelationshipMapping::AbilityTagRelationships

* 概要
	* [FLyraAbilityTagRelationship] の配列です。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLyraAbilityTagRelationship]: ../../Lyra/GameplayAbility/FLyraAbilityTagRelationship.md#flyraabilitytagrelationship
[FLyraAbilityTagRelationship::AbilityTagsToBlock]: ../../Lyra/GameplayAbility/FLyraAbilityTagRelationship.md#flyraabilitytagrelationshipabilitytagstoblock
[FLyraAbilityTagRelationship::AbilityTagsToCancel]: ../../Lyra/GameplayAbility/FLyraAbilityTagRelationship.md#flyraabilitytagrelationshipabilitytagstocancel
[FLyraAbilityTagRelationship::ActivationRequiredTags]: ../../Lyra/GameplayAbility/FLyraAbilityTagRelationship.md#flyraabilitytagrelationshipactivationrequiredtags
[FLyraAbilityTagRelationship::ActivationBlockedTags]: ../../Lyra/GameplayAbility/FLyraAbilityTagRelationship.md#flyraabilitytagrelationshipactivationblockedtags
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[ULyraPawnData::TagRelationshipMapping]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatatagrelationshipmapping
[UGameplayAbility]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayability
[UGameplayAbility::CancelAbilitiesWithTag]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilitycancelabilitieswithtag
[UGameplayAbility::BlockAbilitiesWithTag]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilityblockabilitieswithtag
[UGameplayAbility::ActivationRequiredTags]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilityactivationrequiredtags
[UGameplayAbility::ActivationBlockedTags]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilityactivationblockedtags
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E6%8B%A1%E5%BC%B5%E3%81%95%E3%82%8C%E3%81%9F%E3%82%BF%E3%82%B0%E9%96%A2%E4%BF%82%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0
