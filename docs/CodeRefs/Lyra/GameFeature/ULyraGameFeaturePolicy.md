## ULyraGameFeaturePolicy

> Manager to keep track of the state machines that bring a game feature plugin into memory and active  
> This class discovers plugins either that are built-in and distributed with the game or are reported externally (i.e. by a web service or other endpoint)  
> 
> ----
> GameFeature プラグインをメモリに取り込み、アクティブにするためのステートマシンを追跡するためのマネージャです。  
> このクラスは、ゲームに組み込まれて配布されるプラグイン、または外部（ウェブサービスや他のエンドポイント）から通知されるプラグインを検出します。 

* 概要
	* [UDefaultGameFeaturesProjectPolicies] の派生クラスです。
	* いくつか関数をオーバーライドしているが、実装は親クラスと同じになっています。
	* [UGameFeaturesSubsystem::AddObserver()] にて以下を登録しています。
		* [ULyraGameFeature_HotfixManager]
		* [ULyraGameFeature_AddGameplayCuePaths]
	* *Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class* でこのクラス指定しています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameFeature_AddGameplayCuePaths]: ../../Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeature_addgameplaycuepaths
[ULyraGameFeature_HotfixManager]: ../../Lyra/GameFeature/ULyraGameFeature_HotfixManager.md#ulyragamefeature_hotfixmanager
[UDefaultGameFeaturesProjectPolicies]: ../../UE/GameFeature/UDefaultGameFeaturesProjectPolicies.md#udefaultgamefeaturesprojectpolicies
[UGameFeaturesSubsystem::AddObserver()]: ../../UE/GameFeature/UGameFeaturesSubsystem.md#ugamefeaturessubsystemaddobserver
