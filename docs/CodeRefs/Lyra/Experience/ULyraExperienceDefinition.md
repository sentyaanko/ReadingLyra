## ULyraExperienceDefinition

> Definition of an experience  
> 
> ----
> エクスペリエンスの定義

* 概要
	* `UPrimaryDataAsset` の派生クラスです。
	* `UCLASS` にて `Const` が指定されています。
	* エクスペリエンスを作成するためのデータアセットです。
	* [ALyraWorldSettings::DefaultGameplayExperience] で利用しています。
		* この値は各レベルの `WolrdSettings > Game Mode > Default Gameplay Experience` で指定します。
	* [ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()] でアセットがロードされ、設定された内容はその後に利用されます。
	* 派生ブループリントは以下のとおりです。
		* `B_LyraDefaultExperience`
		* `B_LyraFrontEnd_Experience`
		* `B_LyraShooterGame_ControlPoints`
		* `B_ShooterGame_Elimination`
		* `B_TestInventoryExperience`
		* `B_TopDownArenaExperience`
	* DataAssett としてではなく派生ブループリントとして作られている事を想定しています。
		> `ULyraExperienceDefinition::IsDataValid()` 内に以下のようなコメントがあります。
		>> Make sure users didn't subclass from a BP of this (it's fine and expected to subclass once in BP, just not twice)  
		>> 
		>> ----
		>> ユーザーがこの BP からサブクラス化していないことを確認する（BP で一度サブクラス化することは問題なく、期待されているが、二度目はない）。
		>
		> 理由は確認できていません。
	* 各レベル（の WorldSettings ）で指定しているエクスペリエンスは以下のとおりです。
		| レベル名                      | WolrdSettings > Game Mode > Default Gameplay Experience |
		|-------------------------------|---------------------------------------------------------|
		| `L_Convolution_Blockout`      | `B_LyraShooterGame_ControlPoints`                       |
		| `L_Expanse`                   | `B_ShooterGame_Elimination`                             |
		| `L_Expanse_Blockout`          | `B_ShooterGame_Elimination`                             |
		| `L_FiringRange_WP`            | `B_ShooterGame_Elimination`                             |
		| `L_ShooterGym`                | `B_ShooterGame_Elimination`                             |
		| `L_TopDownArenaGym`           | `B_TopDownArenaExperience`                              |
		| `L_InventoryTestMap`          | `B_TestInventoryExperience`                             |
		| `L_LyraFrontEnd`              | `B_LyraFrontEnd_Experience`                             |
		| `L_DefaultEditorOverview`     | None (`B_LyraDefaultExperience`)                        |
		| `L_ShooterFrontendBackground` | None (`B_LyraDefaultExperience`)                        |
	* `B_LyraDefaultExperience` について
		* B_LyraDefaultExperience はレベル（の WorldSettings ）で指定していない場合に使用されるデフォルト値です。
		* C++ の [ALyraGameMode] で直接指定されています。



### ULyraExperienceDefinition::GameFeaturesToEnable

> List of Game Feature Plugins this experience wants to have active  
> 
> ----
> このエクスペリエンスでアクティブにしたい Game Feature プラグインのリストです。  

* 概要
	* 有効にしたい Game Feature プラグインを FString の配列で指定します。
	* 使用する [UGameFeatureData] を `Plugins/GameFeatures` 内のプラグイン名で指定します。
		* ここで指定された名前をもとに [UGameFeatureData] をアクティブにします。
	* 派生ブループリントで指定している値は以下のとおりです。
		| アセット名                        | 値            | 
		|-----------------------------------|---------------|
		| `B_LyraShooterGame_ControlPoints` | `ShooterCore` |
		| `B_ShooterGame_Elimination`       | `ShooterCore` |
		| `B_TopDownArenaExperience`        | `TopDownArena`|
		| `B_TestInventoryExperience`       | `ShooterCore` |
		| `B_LyraFrontEnd_Experience`       | (null)        |
		| `B_LyraDefaultExperience`         | (null)        |

### ULyraExperienceDefinition::DefaultPawnData

> The default pawn class to spawn for players  
> 
> ----
> プレイヤーがスポーンするためのデフォルトのポーンクラスです。  

* 概要
	* [ULyraPawnData] です。
	* 派生ブループリントで指定している値は以下のとおりです。
		| アセット名                        | 値                     | 
		|-----------------------------------|------------------------|
		| `B_LyraShooterGame_ControlPoints` | `HeroData_ShooterGame` |
		| `B_ShooterGame_Elimination`       | `HeroData_ShooterGame` |
		| `B_TopDownArenaExperience`        | `HeroData_Arena`       |
		| `B_TestInventoryExperience`       | `HeroData_ShooterGame` |
		| `B_LyraFrontEnd_Experience`       | (null)                 |
		| `B_LyraDefaultExperience`         | `SimplePawnData`       |

### ULyraExperienceDefinition::Actions

> List of actions to perform as this experience is loaded/activated/deactivated/unloaded  
> 
> ----
> このエクスペリエンスのロード/アクティブ化/非アクティブ化/アンロードに伴って実行されるアクションの一覧です。  

* 概要
	* [UGameFeatureAction] の配列です。

### ULyraExperienceDefinition::ActionSets

> List of additional action sets to compose into this experience  
> 
> ----
> このエクスペリエンスに合成する追加アクションセットのリストです。  

* 概要
	* [ULyraExperienceActionSet] の配列です。
	* 派生ブループリントで指定している値は以下のとおりです。
		| アセット名                        | 値                                   |
		|-----------------------------------|--------------------------------------|
		| `B_LyraShooterGame_ControlPoints` | `LAS_ShooterGame_SharedInput`        |
		|                                   | `LAS_ShooterGame_StandardComponents` |
		|                                   | `LAS_ShooterGame_StandardHUD`        |
		|                                   | `EAS_BasicShooterAcolades`           |
		| `B_ShooterGame_Elimination`       | `LAS_ShooterGame_SharedInput`        |
		|                                   | `LAS_ShooterGame_StandardComponents` |
		|                                   | `LAS_ShooterGame_StandardHUD`        |
		|                                   | `EAS_BasicShooterAcolades`           |
		| `B_TopDownArenaExperience`        | None                                 |
		| `B_TestInventoryExperience`       | `LAS_ShooterGame_SharedInput`        |
		|                                   | `LAS_ShooterGame_StandardComponents` |
		|                                   | `LAS_ShooterGame_StandardHUD`        |
		|                                   | `LAS_InventoryTest`                  |
		| `B_LyraFrontEnd_Experience`       | None                                 |
		| `B_LyraDefaultExperience`         | None                                 |



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ALyraWorldSettings::DefaultGameplayExperience]: ../../Lyra/Experience/ALyraWorldSettings.md#alyraworldsettingsdefaultgameplayexperience
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ALyraGameMode]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodehandlematchassignmentifnotexpectingone
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
