## ULyraAbilityTagRelationshipMapping

> Mapping of how ability tags block or cancel other abilities  
> 
> ----
> アビリティタグが他のアビリティをブロックまたはキャンセルする方法のマッピング

* GameplayAbility の GameplayTag によるブロックやキャンセルの定義をまとめた構造体。
* [ULyraAbilitySystemComponent] から利用される。
* 詳しくは [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム] 参照。

* `FLyraAbilityTagRelationship` の配列を保持する。
* `ULyraPawnData` から参照されている。
* `ULyraPawnData` を元にポーンを構築する際に ULyraAbilitySystemComponent に渡し、そこで保持される。
* `UGameplayAbility` のタグにアクセスする際に値がミックスされる。組み合わせは以下の通り。
	| FLyraAbilityTagRelationship | UGameplayAbility       |
	|-----------------------------|------------------------|
	| AbilityTagsToBlock          | BlockAbilitiesWithTag  |
	| AbilityTagsToCancel         | CancelAbilitiesWithTag |
	| ActivationRequiredTags      | ActivationRequiredTags |
	| ActivationBlockedTags       | ActivationBlockedTags  |
* `UGameplayAbility` でのタグの扱いがカプセル化されておらずどこで使われているか追いきれていない。要確認。
	* 構築時に統合、というような単純な方法ではなく、参照されるたびに値をミックスしている模様。
	* NonInstanced な Gameplay Ability の場合 CDO を使用するため、話はそう単純ではないのだと思われる。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E6%8B%A1%E5%BC%B5%E3%81%95%E3%82%8C%E3%81%9F%E3%82%BF%E3%82%B0%E9%96%A2%E4%BF%82%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0
