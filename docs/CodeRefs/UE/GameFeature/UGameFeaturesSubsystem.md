## UGameFeaturesSubsystem

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameFeatures > UGameFeaturesSubsystem](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameFeatures/UGameFeaturesSubsystem/)

> The manager subsystem for game features  
> 
> ----
> GameFeature の管理を行うサブシステムです。

* 概要
	* `UEngineSubsystem` の派生クラスです。
	* GameFeature の管理クラスです。
* Lyra での使われ方
	* [ULyraGameFeaturePolicy]
		* GameFeature の Policy 実装のため、オブザーバ関連とアセットのパス関連の機能を利用しています。
	* [ULyraExperienceManagerComponent]
		* エクスペリエンスの実装方法として利用しています。
		* GameFeature のロードやアクティブ化などの機能を利用しています。

### UGameFeaturesSubsystem::AddObserver()

* 概要
	* [IGameFeatureStateChangeObserver] インターフェイスを持つ `UObject` 派生クラスを受け取り、保持します。
	* GameFeature のアクティブ化などが発生した際は保持しているクラスの対応した関数を呼び出します。
* Lyra での使われ方
	* [ULyraGameFeature_HotfixManager] / [ULyraGameFeature_AddGameplayCuePaths] を登録しています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraGameFeaturePolicy]: ../../Lyra/GameFeature/ULyraGameFeaturePolicy.md#ulyragamefeaturepolicy
[ULyraGameFeature_AddGameplayCuePaths]: ../../Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeature_addgameplaycuepaths
[ULyraGameFeature_HotfixManager]: ../../Lyra/GameFeature/ULyraGameFeature_HotfixManager.md#ulyragamefeature_hotfixmanager
[IGameFeatureStateChangeObserver]: ../../UE/GameFeature/IGameFeatureStateChangeObserver.md#igamefeaturestatechangeobserver
