## FLyraAbilityTagRelationship

> Struct that defines the relationship between different ability tags  
> 
> ----
> 異なるアビリティタグの関係を定義する構造体  

* 概要
	* アビリティの関係を定義するための構造体です。
	* GameplayTag によるアビリティの有効化のブロックやキャンセルをアビリティ自体から独立させるための仕組みです。
		* ゲームルールの変更時に不整合を起こりにくくすることを目的として作られた仕組みです。
* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]


### FLyraAbilityTagRelationship::AbilityTag

> The tag that this container relationship is about. Single tag, but abilities can have multiple of these  
> 
> ----
> このコンテナ関係が関係するタグです。単一のタグですが、アビリティはこれらの複数を持つことができます。 

### FLyraAbilityTagRelationship::AbilityTagsToBlock

> The other ability tags that will be blocked by any ability using this tag  
> 
> ----
> このタグを使用したアビリティによってブロックされる他のアビリティタグです。  

### FLyraAbilityTagRelationship::AbilityTagsToCancel

> The other ability tags that will be canceled by any ability using this tag  
> 
> ----
> このタグを使用したアビリティによってキャンセルされる他のアビリティタグです。  

### FLyraAbilityTagRelationship::ActivationRequiredTags

> If an ability has the tag, this is implicitly added to the activation required tags of the ability  
> 
> ----
> アビリティがこのタグを持つ場合、アビリティのアクティブ化に必須タグに暗黙のうちに追加されます。  

### FLyraAbilityTagRelationship::ActivationBlockedTags

> If an ability has the tag, this is implicitly added to the activation blocked tags of the ability  
> 
> ----
> アビリティがタグを持つ場合、アビリティのアクティブ化ブロックタグに暗黙のうちに追加されます。  


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E6%8B%A1%E5%BC%B5%E3%81%95%E3%82%8C%E3%81%9F%E3%82%BF%E3%82%B0%E9%96%A2%E4%BF%82%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0
