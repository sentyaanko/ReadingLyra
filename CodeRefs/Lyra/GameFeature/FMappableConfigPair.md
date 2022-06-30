## FMappableConfigPair

> A container to organize potentially unloaded player mappable configs to their CommonUI input type  
> 
> ----
> アンロードされる可能性のあるプレイヤーのマッピング可能な構成を CommonUI 入力タイプに整理するためのコンテナー

* 概要
	* [UPlayerMappableInputConfig] など、入力設定に関するをメンバに持つ。
* Lyra での使われ方
	* [UGameFeatureAction_AddInputConfig::InputConfigs] 
		* GameFeature 経由で InputMappingContext を設定する際に使用する。
	* [ULyraHeroComponent::DefaultInputConfigs]
		* GameFeature を使わないで InputMappingContext を設定する際に使用する。

### FMappableConfigPair::Config

* 概要
	* [UPlayerMappableInputConfig] 型の変数。
	* いわゆる Input Mapping Context.

### FMappableConfigPair::Type

> The type of config that this is. 
> Useful for filtering out configs by the current input device for things like the settings screen, 
> or if you only want to apply this config when a certain input type is being used.
> 
> ----
> 構成のタイプ。  
> 設定画面などの現在の入力デバイスで構成を除外する場合や、  
> 特定の入力タイプが使用されている場合にのみこの構成を適用する場合に便利です。

* 概要
	* `ECommonInputType` の変数。
		* `MouseAndKeyboard` / `Gamepad` / `Touch` からなる enum で、入力デバイスの種類を示す。


### FMappableConfigPair::DependentPlatformTraits
> Container of platform traits that must be set in order for this input to be activated.  
> If the platform does not have one of the traits specified it can still be registered, but cannot be activated.   
> 
> ----


### FMappableConfigPair::ExcludedPlatformTraits

> If the current platform has any of these traits, then this config will not be actived.  
> 
> ----

### FMappableConfigPair::bShouldActivateAutomatically
> If true, then this input config will be activated when it's associated Game Feature is activated.  
> This is normally the desirable behavior
> 
> ----


