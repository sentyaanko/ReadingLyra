## UGameplayCueManager

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > UGameplayCueManager](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameplayAbilities/UGameplayCueManager/)

> Singleton manager object that handles dispatching gameplay cues and spawning GameplayCueNotify actors as needed
> 
> ----
> GameplayCue のディスパッチと、必要に応じて GameplayCueNotify アクターの生成を行うシングルトンマネージャーオブジェクトです。

* 概要
	* `UAbilitySystemGlobals::Get().GetGameplayCueManager()` で取得可能です。
* Lyra での使われ方
	* [ULyraGameplayCueManager] の基底クラスです。
	* [ULyraGameFeature_AddGameplayCuePaths] にてモジュール式に GameplayCue のパスの追加/削除を行うために利用されています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameFeature_AddGameplayCuePaths]: ../../Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeature_addgameplaycuepaths
[ULyraGameplayCueManager]: ../../Lyra/GameplayCue/ULyraGameplayCueManager.md#ulyragameplaycuemanager
