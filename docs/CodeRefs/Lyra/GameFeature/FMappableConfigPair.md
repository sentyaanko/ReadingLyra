## FMappableConfigPair

> A container to organize potentially unloaded player mappable configs to their CommonUI input type  
> 
> ----
> アンロードされる可能性のあるプレイヤーのマッピング可能な構成を CommonUI 入力タイプに整理するためのコンテナです。

* 概要
	* [UPlayerMappableInputConfig] など、入力設定に関するをメンバに持つ。
	* 利用箇所は以下の通りです。
		* [UGameFeatureAction_AddInputConfig::InputConfigs]
			* GameFeature 経由で InputMappingContext を設定する際に使用します。
		* [ULyraHeroComponent::DefaultInputConfigs]
			* GameFeature を使わないで InputMappingContext を設定する際に使用します。
	* [UGameFeatureAction_AddInputConfig] を使用しているアセットの設定は以下の通りです。
		| Asset                                  | Config<br>([UPlayerMappableInputConfig]) | Type             | DependentPlatformTraits                         |
		| ---------------------------------------| -----------------------------------------|------------------|-------------------------------------------------|
		| `ShooterCore`<br>([UGameFeatureData])  | `PMI_Default_KBM`                        | MouseAndKeyboard | `Platform.Trait.Input.SupportsMouseAndKeyboard` |
		|                                        | `PMI_Default_Gamepad`                    | Gamepad          |                                                 |
		|                                        | `PMI_ShooterDefaultConfig_KBM`           | MouseAndKeyboard | `Platform.Trait.Input.SupportsMouseAndKeyboard` |
		|                                        | `PMI_ShooterDefaultConfig_Gamepad`       | Gamepad          |                                                 |
		| `TopDownArena`<br>([UGameFeatureData]) | `PMI_Default_KBM`                        | MouseAndKeyboard |                                                 |
		|                                        | `PMI_Default_Gamepad`                    | Gamepad          |                                                 |
* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra 入力設定]

### FMappableConfigPair::Config

* 概要
	* [UPlayerMappableInputConfig] です。
	* いわゆる Input Mapping Context です。

### FMappableConfigPair::Type

> The type of config that this is. 
> Useful for filtering out configs by the current input device for things like the settings screen, 
> or if you only want to apply this config when a certain input type is being used.
> 
> ----
> 構成のタイプです。  
> 設定画面などの現在の入力デバイスで構成を除外する場合や、  
> 特定の入力タイプが使用されている場合にのみこの構成を適用する場合に便利です。

* 概要
	* `ECommonInputType` にてこの設定のタイプを指定します。
		* `ECommonInputType` は `MouseAndKeyboard` / `Gamepad` / `Touch` からなる enum で、入力デバイスの種類を示します。

### FMappableConfigPair::DependentPlatformTraits

> Container of platform traits that must be set in order for this input to be activated.  
> If the platform does not have one of the traits specified it can still be registered, but cannot be activated.   
> 
> ----
> この入力を有効にするために設定する必要があるプラットフォームの特性を示すコンテナです。 
> プラットフォームが指定された特性のいずれかを持っていない場合、それは依然として登録することはできますが、アクティブにすることはできません。  

* 概要
	* これを設定することで、 GameplayTag で示されたプラットフォームの特性があった場合のみアクティブに出来る設定を定義できます。
	* [FMappableConfigPair::CanBeActivated()] にて利用されます。
	* 使用している箇所は `ShooterCore` ([UGameFeatureData]) のみで、設定内容は以下の通りです。
		| Config                         | DependentPlatformTraits                         |
		|--------------------------------|-------------------------------------------------|
		| `PMI_Default_KBM`              | `Platform.Trait.Input.SupportsMouseAndKeyboard` |
		| `PMI_ShooterDefaultConfig_KBM` | `Platform.Trait.Input.SupportsMouseAndKeyboard` |
	* これ以外は全て未設定です。

### FMappableConfigPair::ExcludedPlatformTraits

> If the current platform has any of these traits, then this config will not be actived.  
> 
> ----
> 現在のプラットフォームがこれらの特徴のいずれかを持っている場合、この設定は有効になりません。 

* 概要
	* これを設定することで、 GameplayTag で示されたプラットフォーム特性が無かった場合のみアクティブに出来る設定を定義できます。
	* [FMappableConfigPair::CanBeActivated()] にて利用されます。
	* 現状は全て未設定です。

### FMappableConfigPair::bShouldActivateAutomatically

> If true, then this input config will be activated when it's associated Game Feature is activated.  
> This is normally the desirable behavior
> 
> ----
> trueの場合、この入力設定は、関連する Game Feature がアクティブになったときにアクティブになります。 
> これは通常、望ましい動作です。

* 概要
	* [UGameFeatureAction_AddInputConfig::OnGameFeatureActivating()] にて利用されます。
	* 現状は全て true です。

### FMappableConfigPair::CanBeActivated()

> Returns true if this config pair can be activated based on the current platform traits and settings.
> 
> ----
> 現在のプラットフォームの特性および設定に基づき、この設定ペアを有効にすることができる場合、true を返します。

* 概要
	* [FMappableConfigPair::DependentPlatformTraits] と [FMappableConfigPair::ExcludedPlatformTraits] を参照し、実行中の環境が合致するプラットフォーム化を検査します。
	* 検査は `ICommonUIModule::GetSettings().GetPlatformTraits()` の値をもとに行われます。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FMappableConfigPair::DependentPlatformTraits]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairdependentplatformtraits
[FMappableConfigPair::ExcludedPlatformTraits]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairexcludedplatformtraits
[FMappableConfigPair::CanBeActivated()]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpaircanbeactivated
[UGameFeatureAction_AddInputConfig]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfig
[UGameFeatureAction_AddInputConfig::InputConfigs]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfiginputconfigs
[UGameFeatureAction_AddInputConfig::OnGameFeatureActivating()]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfigongamefeatureactivating
[ULyraHeroComponent::DefaultInputConfigs]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentdefaultinputconfigs
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UPlayerMappableInputConfig]: ../../UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra 入力設定]: https://docs.unrealengine.com/5.0/ja/lyra-input-settings-in-unreal-engine/
