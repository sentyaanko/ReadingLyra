## UGameplayCueManager

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > UGameplayCueManager](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameplayAbilities/UGameplayCueManager/)

> Singleton manager object that handles dispatching gameplay cues and spawning GameplayCueNotify actors as needed
> 
> ----
> GameplayCue のディスパッチと、必要に応じて GameplayCueNotify アクターの生成を行うシングルトンマネージャーオブジェクトです。

`GameplayManager.h` より引用
> Loading GameplayCueNotifies from ObjectLibraries
> 
> There are two libraries in the GameplayCueManager:
> 1. The RunTime object library, which is initialized with the "always loaded" paths, via UAbilitySystemGlobals::GetGameplayCueNotifyPaths()
> 		- GC Notifies in this path are loaded at startup
> 		- Everything loaded will go into the global gameplaycue set, which is where GC events will be routed to by default
> 2. The Editor object library, which is initialized with the "all valid" paths, via UGameplayCueManager::GetValidGameplayCuePaths()
> 		- Only used in the editor.
> 		- Never loads clases or scans directly itself. 
> 		- Just reflect asset registry to show about "all gameplay cue notifies the game could know about"
> 
> ----
> ObjectLibraries から GameplayCueNotifies の読み込み  
> 
> GameplayCueManager には、 2 つのライブラリが存在します。  
> 1. RunTime オブジェクトライブラリ。 UAbilitySystemGlobals::GetGameplayCueNotifyPaths() により、「常にロードされる」パスで初期化される。  
> 		- このパスの GC Notify は起動時にロードされる。  
> 		- ロードされたすべてのものは、グローバルなゲームプレイキューセットに入り、デフォルトで GC イベントがルーティングされる場所になりる。  
> 2. UGameplayCueManager::GetValidGameplayCuePaths() により、"all valid" paths で初期化された Editor オブジェクト ライブラリ。  
> 		- エディターでのみ使用される。  
> 		- クラスやスキャンを直接ロードすることはない。   
> 		- アセットレジストリに、"ゲームが知りうるすべてのゲームプレイキューの通知" を反映させるだけ。  

* 概要
	* `UDataAsset` の派生クラスです。
	* `UAbilitySystemGlobals::Get().GetGameplayCueManager()` で取得可能です。
* Lyra での使われ方
	* [ULyraGameplayCueManager] の基底クラスです。
	* [ULyraGameFeature_AddGameplayCuePaths] にてモジュール式に GameplayCue のパスの追加/削除を行うために利用されています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameFeature_AddGameplayCuePaths]: ../../Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeature_addgameplaycuepaths
[ULyraGameplayCueManager]: ../../Lyra/GameplayCue/ULyraGameplayCueManager.md#ulyragameplaycuemanager
