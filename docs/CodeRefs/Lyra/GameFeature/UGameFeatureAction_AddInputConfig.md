## UGameFeatureAction_AddInputConfig

> Registers a Player Mappable Input config to the Game User Settings  
>  
> Expects that local players are set up to use the EnhancedInput system.  
> 
> ----

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

