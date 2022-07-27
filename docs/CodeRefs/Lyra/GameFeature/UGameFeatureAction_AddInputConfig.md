## UGameFeatureAction_AddInputConfig

> Registers a Player Mappable Input config to the Game User Settings  
>  
> Expects that local players are set up to use the EnhancedInput system.  
> 
> ----

* Game Feature がアクティブになった際に付与する入力マッピング情報を保持する。
* ```InputConfigs``` に [FMappableConfigPair] の配列を保持しています。


* Lyra での使い方
	| Asset                                  | Config<br>([UPlayerMappableInputConfig]) | Type             | DependentPlatformTraits                         |
	| ---------------------------------------| -----------------------------------------|------------------|-------------------------------------------------|
	| `ShooterCore`<br>([UGameFeatureData])  | `PMI_Default_KBM`                        | MouseAndKeyboard | `Platform.Trait.Input.SupportsMouseAndKeyboard` |
	|                                        | `PMI_Default_Gamepad`                    | Gamepad          |                                                 |
	|                                        | `PMI_ShooterDefaultConfig_KBM`           | MouseAndKeyboard | `Platform.Trait.Input.SupportsMouseAndKeyboard` |
	|                                        | `PMI_ShooterDefaultConfig_Gamepad`       | Gamepad          |                                                 |
	| `TopDownArena`<br>([UGameFeatureData]) | `PMI_Default_KBM`                        | MouseAndKeyboard |                                                 |
	|                                        | `PMI_Default_Gamepad`                    | Gamepad          |                                                 |


### UGameFeatureAction_AddInputConfig::InputConfigs

> The player mappable configs to register for user with this config  
> 
> ----



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FMappableConfigPair]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpair
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UPlayerMappableInputConfig]: ../../UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
