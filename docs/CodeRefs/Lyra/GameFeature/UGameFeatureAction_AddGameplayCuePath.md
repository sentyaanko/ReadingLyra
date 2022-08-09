## UGameFeatureAction_AddGameplayCuePath

> GameFeatureAction responsible for adding gameplay cue paths to the gameplay cue manager.  
>  
> @see UAbilitySystemGlobals::GameplayCueNotifyPaths  
>  
> ----
> GameplayCue のパスを GameplayCue Manager に追加する役割を担う GameFeatureAction です。  
>  
> [UAbilitySystemGlobals::GameplayCueNotifyPaths] を参照してください。 

* 概要
	* [UGameFeatureAction] の派生クラスです。
	* Game Feature がアクティブになった際に GameplayCue の検索パスの追加を行う GameFeatureAction です。
	* 実際に検索パスの追加は [ULyraGameFeature_AddGameplayCuePaths] で行っています。
	* アセットの設定は以下の通りです。
		| Asset                               | DirectoryPathsToAdd                       |
		| ----------------------------------- | ------------------------------------------|
		| `ShooterCore` ([UGameFeatureData])  | `/GameplayCues`<br>`/Weapons`<br>`/Items` |
		| `TopDownArena` ([UGameFeatureData]) | `/GameplayCues`                           |
		| `ShooterMaps` ([UGameFeatureData])  | `/GameplayCues`                           |



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameFeature_AddGameplayCuePaths]: ../../Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeature_addgameplaycuepaths
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UAbilitySystemGlobals::GameplayCueNotifyPaths]: ../../UE/GameplayAbility/UAbilitySystemGlobals.md#uabilitysystemglobalsgameplaycuenotifypaths
