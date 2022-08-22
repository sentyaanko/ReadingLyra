## ULyraSettingsLocal

>> TODO: このドキュメントは書きかけです。

* 概要
	* ゲームオプションの設定内容を保持する。
	* キーバインドなどもここから参照される。

	* [UGameUserSettings] 派生クラスです。
	* キーコンフィグの内容等を保持する。
	* `RegisteredInputConfigs` に [FLoadedMappableConfigPair] の配列を保持しています。

	* *Project Settings > Engine - General Settings > Default Classes > Game User Settings Class* でこのクラスを指定しています。
	* そのため、  `GEngine->GetGameUserSettings()` でインスタンスを取得できます。
	* 設定された値はこれを経由してあちこちからアクセスされています。


## ULyraSettingsLocal::RegisteredInputConfigs

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



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction_AddInputConfig]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfig
[FLoadedMappableConfigPair]: ../../Lyra/Input/FLoadedMappableConfigPair.md#floadedmappableconfigpair
[UGameUserSettings]: ../../UE/GameFramework/UGameUserSettings.md#ugameusersettings
