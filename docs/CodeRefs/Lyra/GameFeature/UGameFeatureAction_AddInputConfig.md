## UGameFeatureAction_AddInputConfig

> Registers a Player Mappable Input config to the Game User Settings  
>  
> Expects that local players are set up to use the EnhancedInput system.  
> 
> ----
> ゲームユーザー設定に Player Mappable Input config を登録します。 
>  
> ローカルプレイヤーは EnhancedInput システムを使用するように設定されていることを想定しています。 

* 概要
	* [UGameFeatureAction] の派生クラスです。
	* Game Feature がアクティブになった際に入力マッピングの追加を行う GameFeatureAction です。
	* 使用しているアセットは以下の通りです。
		* `ShooterCore`<br>([UGameFeatureData])
		* `TopDownArena`<br>([UGameFeatureData])

### UGameFeatureAction_AddInputConfig::InputConfigs

> The player mappable configs to register for user with this config  
> 
> ----
> このコンフィグを持つユーザーに対して登録するプレーヤーマップ可能なコンフィグ  

* 概要
	* [FMappableConfigPair] の配列です。

### UGameFeatureAction_AddInputConfig::OnGameFeatureActivating()

* 概要
	* [UGameFeatureAction::OnGameFeatureActivating()] のオーバーライドです。
	* [UGameFeatureAction_AddInputConfig::InputConfigs] をイテレート処理します。
		* [FMappableConfigPair::bShouldActivateAutomatically] が true の場合は即座にアクティブ化します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FMappableConfigPair]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpair
[FMappableConfigPair::bShouldActivateAutomatically]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpairbshouldactivateautomatically
[UGameFeatureAction_AddInputConfig::InputConfigs]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureactionaddinputconfiginputconfigs
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureAction::OnGameFeatureActivating()]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureactionongamefeatureactivating
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
