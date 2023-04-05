## FGameplayTagBlueprintPropertyMap

[Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > FGameplayTagBlueprintPropertyMap](https://docs.unrealengine.com/5.1/en-US/API/Plugins/GameplayAbilities/FGameplayTagBlueprintPropertyMap/)

> Struct used to manage gameplay tag blueprint property mappings.  
> It registers the properties with delegates on an ability system component.  
> This struct can not be used in containers (such as TArray)  
> since it uses a raw pointer to bind the delegate and it's address could change causing an invalid binding.
>
> ----
> ゲームプレイタグのブループリントのプロパティマッピングを管理するために使用される構造体です。  
> この構造体は、アビリティシステムコンポーネントのデリゲートとプロパティを登録します。  
> この構造体はコンテナ（ TArray など）の中で使用することはできません。  
> なぜなら、デリゲートのバインドにローポインタを使用し、アドレスが変更されると無効なバインドが発生する可能性があるからです。  

* 概要
	* GameplayTag の変更をプロパティに記録するための構造体です。


### FGameplayTagBlueprintPropertyMap::Initialize()

> Call this to initialize and bind the properties with the ability system component.
> 
> ----
> これを呼び出して、プロパティを初期化し、アビリティシステムコンポーネントとバインドします。

* 概要
	* [FGameplayTagBlueprintPropertyMap::PropertyMappings] に従い `UAbilitySystemComponent::RegisterAndCallGameplayTagEvent()` を呼び出し、特定の GameplayTag の変更を [FGameplayTagBlueprintPropertyMap::GameplayTagEventCallback()] に通知するデリゲートを登録します。
* Lyra での使われ方
	* [ULyraAnimInstance::InitializeWithAbilitySystem()] で呼び出しています。

### FGameplayTagBlueprintPropertyMap::GameplayTagEventCallback()

* 概要
	* [FGameplayTagBlueprintPropertyMap::Initialize()] で `UAbilitySystemComponent` にバインドされる、 GameplayTag が変更されたときに呼び出される関数。


### FGameplayTagBlueprintPropertyMap::PropertyMappings

* 概要
	* アビリティの特徴を示す GameplayTag を格納した [FGameplayTagBlueprintPropertyMapping] です。
* Lyra での使われ方



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAnimInstance::InitializeWithAbilitySystem()]: ../../Lyra/Animation/ULyraAnimInstance.md#ulyraaniminstanceinitializewithabilitysystem
[FGameplayTagBlueprintPropertyMap::Initialize()]: ../../UE/GameplayAbility/FGameplayTagBlueprintPropertyMap.md#fgameplaytagblueprintpropertymapinitialize
[FGameplayTagBlueprintPropertyMap::GameplayTagEventCallback()]: ../../UE/GameplayAbility/FGameplayTagBlueprintPropertyMap.md#fgameplaytagblueprintpropertymapgameplaytageventcallback
[FGameplayTagBlueprintPropertyMap::PropertyMappings]: ../../UE/GameplayAbility/FGameplayTagBlueprintPropertyMap.md#fgameplaytagblueprintpropertymappropertymappings
[FGameplayTagBlueprintPropertyMapping]: ../../UE/GameplayAbility/FGameplayTagBlueprintPropertyMapping.md#fgameplaytagblueprintpropertymapping
