## ULyraGameFeature_AddGameplayCuePaths

* 概要
	* GameFeature で [UGameFeatureAction_AddGameplayCuePath] が設定された際、 [ULyraGameplayCueManager] にパス情報を渡し、 GameplayCue 再生時の検索パスに追加する。
	* [IGameFeatureStateChangeObserver] の派生クラスです。


`GameplayManager.h` より引用
> Loading GameplayCueNotifies from ObjectLibraries
> 
> There are two libraries in the GameplayCueManager:
> 1. The RunTime object library, which is initialized with the "always loaded" paths, via UAbilitySystemGlobals::GetGameplayCueNotifyPaths()
> 	- GC Notifies in this path are loaded at startup
> 	- Everything loaded will go into the global gameplaycue set, which is where GC events will be routed to by default
> 2. The Editor object library, which is initialized with the "all valid" paths, via UGameplayCueManager::GetValidGameplayCuePaths()
> 	- Only used in the editor.
> 	- Never loads clases or scans directly itself. 
> 	- Just reflect asset registry to show about "all gameplay cue notifies the game could know about"
> 
> ----
> ObjectLibraries から GameplayCueNotifies の読み込み
> 
> GameplayCueManager には、 2 つのライブラリが存在します。
> 1. RunTime オブジェクトライブラリ。 UAbilitySystemGlobals::GetGameplayCueNotifyPaths() により、「常にロードされる」パスで初期化される。
> 	- このパスの GC Notify は起動時にロードされる
> 	- ロードされたすべてのものは、グローバルなゲームプレイキューセットに入り、デフォルトで GC イベントがルーティングされる場所になります
> 2. UGameplayCueManager::GetValidGameplayCuePaths() により、"all valid" paths で初期化された Editor オブジェクト ライブラリ。
> 	- エディターでのみ使用されます。
> 	- クラスやスキャンを直接ロードすることはありません。 
> 	- アセットレジストリに、"ゲームが知りうるすべてのゲームプレイキューの通知" を反映させるだけです。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction_AddGameplayCuePath]: ../../Lyra/GameFeature/UGameFeatureAction_AddGameplayCuePath.md#ugamefeatureaction_addgameplaycuepath
[ULyraGameplayCueManager]: ../../Lyra/GameplayCue/ULyraGameplayCueManager.md#ulyragameplaycuemanager
[IGameFeatureStateChangeObserver]: ../../UE/GameFeature/IGameFeatureStateChangeObserver.md#igamefeaturestatechangeobserver
