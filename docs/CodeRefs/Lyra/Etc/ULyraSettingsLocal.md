## ULyraSettingsLocal

* ゲームオプションの設定内容を保持する。
* キーバインドなどもここから参照される。

* [UGameUserSettings] 派生クラス。
* キーコンフィグの内容等を保持する。
* `RegisteredInputConfigs` に [FLoadedMappableConfigPair] の配列を保持しています。

* *Project Settings > Engine - General Settings > Default Classes > Game User Settings Class* でこのクラスを指定しています。
* そのため、  `GEngine->GetGameUserSettings()` でインスタンスを取得できます。
* 設定された値はこれを経由してあちこちからアクセスされています。






<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLoadedMappableConfigPair]: ../../Lyra/Input/FLoadedMappableConfigPair.md#floadedmappableconfigpair
[UGameUserSettings]: ../../UE/GameFramework/UGameUserSettings.md#ugameusersettings
