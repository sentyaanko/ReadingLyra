## FGameplayTagBlueprintPropertyMapping

[Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > FGameplayTagBlueprintPropertyMapping](https://docs.unrealengine.com/5.1/en-US/API/Plugins/GameplayAbilities/FGameplayTagBlueprintPropertyMap-/)

> Struct used to update a blueprint property with a gameplay tag count.  
> The property is automatically updated as the gameplay tag count changes.  
> It only supports boolean, integer, and float properties.  
> 
> ----
> ゲームプレイタグカウントを持つブループリントのプロパティを更新するために使用される構造です。
> ゲームプレイタグカウントが変更されると、プロパティは自動的に更新されます。
> boolean 、 integer 、 float プロパティのみをサポートします。

* 概要
	* GameplayTag とプロパティのペアを保持する構造体です。
	* 指定された GmapelayTag の付与状態が変更されるとプロパティが更新されます。
	* [FGameplayTagBlueprintPropertyMap::PropertyMappings] で利用されています。


### FGameplayTagBlueprintPropertyMapping::TagToMap

> Gameplay tag being counted.
> 
> ----
> カウントされるゲームプレイタグです。

* 概要
	* 監視する GameplayTag を指定します。

### FGameplayTagBlueprintPropertyMapping::PropertyToEdit

> Property to update with the gameplay tag count. */
>
> ----
> GameplayTag の数を記録するためのプロパティです。

* 概要
	* 監視する GameplayTag が変更されたときに更新するプロパティを指定します。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FGameplayTagBlueprintPropertyMap::PropertyMappings]: ../../UE/GameplayAbility/FGameplayTagBlueprintPropertyMap.md#fgameplaytagblueprintpropertymappropertymappings
