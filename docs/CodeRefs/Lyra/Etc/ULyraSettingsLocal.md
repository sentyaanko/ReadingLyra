## ULyraSettingsLocal

* 概要
	* [UGameUserSettings] の派生クラスです。
	* キーコンフィグ等、ゲームオプションの設定内容を保持します。
	* *Project Settings > Engine - General Settings > Default Classes > Game User Settings Class* でこのクラスを指定しています。
		* そのため、  `GEngine->GetGameUserSettings()` でインスタンスを取得できます。
		* 保持された値はこれを経由してあちこちからアクセスされています。
	* [ULyraInputComponent] にて、このクラスで保持している情報を [UEnhancedInputLocalPlayerSubsystem] に渡すことで入力マッピング情報を設定しています。
	* [FMappableConfigPair] にて、このクラスへ入力設定を登録しています。


### ULyraSettingsLocal::RegisteredInputConfigs

> Array of currently registered input configs. This is populated by game feature plugins
> 
> @see UGameFeatureAction_AddInputConfig
> 
> ----
> 現在登録されている入力コンフィグの配列です。これは、 Game Feature プラグインによって登録されます。
> 
> [UGameFeatureAction_AddInputConfig] を参照してください。

* 概要
	* [FLoadedMappableConfigPair] の配列です。

### ULyraSettingsLocal::CustomKeyboardConfig

> Array of custom key mappings that have been set by the player. Empty by default.  
> 
> ----
> プレーヤーによって設定されたカスタムキーマッピングの配列です。デフォルトでは空です。  

* 概要
	* 保存に使用するユニークな名前をキーとし `FKey` を値とする連想配列です。
	* [UInputMappingContext::Mappings] に設定されている [FEnhancedActionKeyMapping::PlayerMappableOptions] ::Name をキーとして利用しています。	

### ULyraSettingsLocal::Get()

* 概要
	* `GEngine->GetGameUserSettings()` を利用してインスタンスを返します。

### ULyraSettingsLocal::GetAllRegisteredInputConfigs()

> Get all currently registered input configs
> 
> ----
> 現在登録されている全ての入力コンフィグを取得します

* 概要
	* [ULyraSettingsLocal::RegisteredInputConfigs] を返します。

### ULyraSettingsLocal::GetCustomPlayerInputConfig()

* 概要
	* [ULyraSettingsLocal::CustomKeyboardConfig] を返します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraSettingsLocal::RegisteredInputConfigs]: #ulyrasettingslocalregisteredinputconfigs
[ULyraSettingsLocal::CustomKeyboardConfig]: #ulyrasettingslocalcustomkeyboardconfig
[FMappableConfigPair]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpair
[UGameFeatureAction_AddInputConfig]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureactionaddinputconfig
[FLoadedMappableConfigPair]: ../../Lyra/Input/FLoadedMappableConfigPair.md#floadedmappableconfigpair
[ULyraInputComponent]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponent
[UGameUserSettings]: ../../UE/GameFramework/UGameUserSettings.md#ugameusersettings
[FEnhancedActionKeyMapping::PlayerMappableOptions]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingplayermappableoptions
[UEnhancedInputLocalPlayerSubsystem]: ../../UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystem
[UInputMappingContext::Mappings]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontextmappings
