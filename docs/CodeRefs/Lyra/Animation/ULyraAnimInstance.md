## ULyraAnimInstance

> The base game animation instance class used by this project.
> 
> ----
> 本プロジェクトで使用するベースゲームアニメーションのインスタンスクラスです。

* 概要
	* [UAnimInstance] の派生クラスです。
	* [ABP_Mannequin_Base] の基底クラスです。
	* Update の際、オーナーアクターの地面までの距離を保存しています。
	* [ULyraAnimInstance::GameplayTagPropertyMap] を利用することで、 GameplayTag の変更をプロパティに反映させられるようにしています。


### ULyraAnimInstance::NativeInitializeAnimation()

* 概要
	* [UAnimInstance::NativeInitializeAnimation()] のオーバーライドです。
	* [ULyraAnimInstance::InitializeWithAbilitySystem()] を呼び出します。


### ULyraAnimInstance::NativeUpdateAnimation()

* 概要
	* [UAnimInstance::NativeUpdateAnimation()] のオーバーライドです。
	* オーナーアクターの真下にある地形までの距離を計測して [ULyraAnimInstance::GroundDistance] に設定します。


### ULyraAnimInstance::InitializeWithAbilitySystem()

* 概要
	* [ULyraAnimInstance::GameplayTagPropertyMap] の [FGameplayTagBlueprintPropertyMap::Initialize()] を呼び出します。
		* そうすることで、予め [FGameplayTagBlueprintPropertyMap::PropertyMappings] に設定された GameplayTag に連動してプロパティの値が更新されるようになります。
		* これを利用してアニメーションブループリント内で GameplayTag を利用したキャラクターの状態を読み取っています。

### ULyraAnimInstance::GameplayTagPropertyMap

> Gameplay tags that can be mapped to blueprint variables.  
> The variables will automatically update as the tags are added or removed.  
> These should be used instead of manually querying for the gameplay tags.  
> 
> ----
> ブループリントの変数にマッピング可能なゲームプレイタグです。  
> タグが追加または削除されると、変数が自動的に更新されます。  
> ゲームプレイタグを手動で照会する代わりに、これらを使用するべきです。

* 既存のドキュメント
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション] > ゲームプレイ タグ バインディング
		> Lyra は、プレイヤーのほとんどのアクションで ゲームプレイ アビリティ システム を使用しています。  
		> アニメーション ブループリントでは、ゲームプレイ タグ バインディングを使用して、これらのイベントに対応することができます。  
		> AnimBP_Mannequin_Base ブループリント内のゲームプレイ タグは、`Class Defaults > Details > Gameplay Tags > Gameplay Tag Property Map` から操作できます。
* 概要
	* [FGameplayTagBlueprintPropertyMap] 型です。
	* これを利用することでプロパティの値を見るだけで GameplayTag の状態を取得することができ、アニメーションブループリント内で GameplayTag を直接照会しないようにしています。


### ULyraAnimInstance::GroundDistance

* 概要
	* オーナーアクターの真下にある地形までの距離です。
	* [ULyraAnimInstance::NativeUpdateAnimation()] で更新されます。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAnimInstance::NativeUpdateAnimation()]: #ulyraaniminstancenativeupdateanimation
[ULyraAnimInstance::InitializeWithAbilitySystem()]: #ulyraaniminstanceinitializewithabilitysystem
[ULyraAnimInstance::GameplayTagPropertyMap]: #ulyraaniminstancegameplaytagpropertymap
[ULyraAnimInstance::GroundDistance]: #ulyraaniminstancegrounddistance
[ABP_Mannequin_Base]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[UAnimInstance]: ../../UE/Animation/UAnimInstance.md#uaniminstance
[UAnimInstance::NativeInitializeAnimation()]: ../../UE/Animation/UAnimInstance.md#uaniminstancenativeinitializeanimation
[UAnimInstance::NativeUpdateAnimation()]: ../../UE/Animation/UAnimInstance.md#uaniminstancenativeupdateanimation
[FGameplayTagBlueprintPropertyMap]: ../../UE/GameplayAbility/FGameplayTagBlueprintPropertyMap.md#fgameplaytagblueprintpropertymap
[FGameplayTagBlueprintPropertyMap::Initialize()]: ../../UE/GameplayAbility/FGameplayTagBlueprintPropertyMap.md#fgameplaytagblueprintpropertymapinitialize
[FGameplayTagBlueprintPropertyMap::PropertyMappings]: ../../UE/GameplayAbility/FGameplayTagBlueprintPropertyMap.md#fgameplaytagblueprintpropertymappropertymappings
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
