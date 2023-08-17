# 【UE5】Lyra に学ぶ(13) Update5.2 <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
Unreal Engine 5.2 がリリースされたことで、 5.0 用と 5.1 用の 5.2 用の 3 つのバージョンが存在するようになっています。  
このドキュメントは 5.1 と 5.2 の違いについてまとめたものですが、公式ドキュメントに詳しい解説があるので、そちらを見るのが一番良いです。  
[Unreal Engine 5.2 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra Starter Game を最新エンジン リリースにアップグレードする]  
追記している情報は .cpp/.h など、テキスト形式で比較可能なものが中心となっています。

* バージョン
	* [Lyra Starter Game]
		* 2023/08/08 版

# Index <!-- omit in toc -->

- [0. オーバービュー](#0-オーバービュー)
- [1. ドキュメント](#1-ドキュメント)
- [2. ビルド関連](#2-ビルド関連)
	- [2.1. .uproject](#21-uproject)
	- [2.2. .uplugin](#22-uplugin)
	- [2.3. .Build.cs](#23-buildcs)
- [3. 設定ファイル](#3-設定ファイル)
- [4. アセット](#4-アセット)
	- [4.1. .uasset](#41-uasset)
	- [4.2. .umap](#42-umap)
- [5. ローカライゼーション](#5-ローカライゼーション)
- [6. ソースファイル](#6-ソースファイル)
	- [6.1. 軽微な変更](#61-軽微な変更)
		- [6.1.1. DEPRECATED 関連](#611-deprecated-関連)
		- [6.1.2. バリデーションチェック関連](#612-バリデーションチェック関連)
		- [6.1.3. その他](#613-その他)
	- [6.2. 大きめな変更](#62-大きめな変更)
		- [6.2.1. 専用サーバー・ローカル マルチプレイヤー・シームレス移動の対応](#621-専用サーバーローカル-マルチプレイヤーシームレス移動の対応)
		- [6.2.2. 暗号化の対応](#622-暗号化の対応)
		- [6.2.3. Replication Graph の対応](#623-replication-graph-の対応)
		- [6.2.4. 入力デバイスのプロパティ](#624-入力デバイスのプロパティ)
		- [6.2.5. GameplayTag 関連](#625-gameplaytag-関連)
		- [6.2.6. `ShooterTestsRuntime` モジュール用](#626-shootertestsruntime-モジュール用)
- [終わりに](#終わりに)


# 0. オーバービュー

748 ファイルの差分（変更、追加、削除）があります。

大まかな分類とファイル数は以下のようになります。

| 分類						| パス、拡張子等				| ファイル数	|
|----						|----							|----			|
| [ドキュメント]			| .md							| 1				|
| [ビルド関連]				| .uproject						| 1				|
|							| .uplugin						| 1				|
|							| .Build.cs						| 2				|
| [設定ファイル]			| .ini							| 8				|
| [アセット]				| .uasset						| 57			|
|							| .umap							| 1				|
| [ローカライゼーション]	| Content/Localization 以下		| 90			|
| [ソースファイル]			| .cpp .h						| 587			|

ローカライゼーション について補足

* ファイル数
	* 変更が 78 ファイル、削除が 12 ファイルの合計 90 ファイルです。
* 削除ファイルについて
	* 10 ファイルは `locres` ファイルです。
		* `Content/Localization/Game` 以下の `en` / `ja` / `ko` / `zh-Hans` を除いたものが対象です。
			> 理由不明。詳細未確認。
	* 残りの 2 ファイルは以下のものです。
		* Content/Localization/EngineOverrides/EngineOverrides.locmeta	
			> 理由不明。詳細未確認。
		* Content/Localization/EngineOverrides/EngineOverrides_Conflicts.txt	
			> 用途不明。詳細未確認。
* 変更ファイルについて
	* カルチャ別テキストはきちんと翻訳されたものが設定されたようです。（以前は多くが空文字列でした）

ソースファイル について補足

* ファイル数
	* ヘッダの構成だけ変わったファイルが 519 あります。  
	* 何らかのコードの変更があったファイルは 587-519=68 となります。
* 変更内容が特に多い項目
	* 専用サーバー・ローカル マルチプレイヤー・シームレス移動の対応
		> 変更箇所が散らばっており、互いに似たような場所を変更していることが多いです。
	* Replication Graph の対応
		> 使用しなくても動作するようになっている為、範囲は限定的で見通しは良いです。
	* GameplayTag の定義方法とアクセス方法
		> 数が多いだけなので難しくはないです。


# 1. ドキュメント

* README.md
	* UnrealEngine のリポジトリにも Lyra が置かれるようになっており、おそらくその為に追加されたファイル。
	* ビルド手順等が記載されている。


# 2. ビルド関連

## 2.1. .uproject

* LyraStarterGame.uproject
	* `EngineAssociation` を `5.2` に変更
	* プラグインの追加
		* `AESGCMHandlerComponent` (`AES GCM network packet handler`: 暗号化復号化関連)
		* `DTLSHandlerComponent` (`DTLS network packet handler`: 暗号化復号化関連)
		* `D3DExternalGPUStatistics` (詳細不明)

## 2.2. .uplugin

* Plugins/GameFeatures/ShooterTests/ShooterTests.uplugin
	* `Modules` に `ShooterTestsRuntime` の追加

## 2.3. .Build.cs

* Source/LyraGame/LyraGame.Build.cs
	* `PublicDependencyModuleNames` に `PropertyPath` が追加
	* `PrivateDependencyModuleNames` に `DTLSHandlerComponent` が追加
	* `SetupGameplayDebuggerSupport(Target)` (GameplayDebugger の設定)の追加
	* `SetupIrisSupport(Target)` (Iris の設定)の追加
	> 参考 https://forums.unrealengine.com/t/error-in-lyra-sample-project-ue-5-2/1146671
* Plugins/GameFeatures/ShooterTests/Source/ShooterTestsRuntime/ShooterTestsRuntime.Build.cs
	* `ShooterTestsRuntime` モジュール用に追加


# 3. 設定ファイル

* Config/Custom/EOS/DefaultEngine.ini
	* `OSSv2` の指定が `GameLobby` からその親の `LobbyBase` に変更
		> 参考 https://docs.unrealengine.com/5.1/ja/lobbies-interface-in-unreal-engine/#コンフィギュレーション
* Config/DefaultEngine.ini
	* Iris 関連の設定
	* ビルドターゲットの設定
	* 以下の設定の有効化
	* `ConsoleVariables` の `net.AllowPIESeamlessTravel` を 1 で追加
		> 参考 https://docs.unrealengine.com/5.1/ja/unreal-engine-5.1-release-notes/
	* `Android` の `bEnableMulticastSupport` の有効化
		> 詳細未確認
	* `Android File Server` 関連の記述の削除
		> 詳細未確認  
		> 参考 https://docs.unrealengine.com/5.2/ja/android-file-server-for-unreal-engine/
	* クラッシュレポートに関する設定の変更
* Config/DefaultGame.ini
	* `CommonLoadingScreenSettings` の `ForceTickLoadingScreenEvenInEditor` を `false` で追加
	* `ProjectPackagingSettings` の `bGenerateChunks` を `true` に変更
	* `ProjectPackagingSettings` の `DirectoriesToAlwaysStageAs` を `(Path="DTLS")` で追加
	* `LyraReplicationGraphSettings` 関連の追加
* Config/DefaultGameplayTags.ini
	* `HUD.Slot.RespawnTimer` の追加
* Config/Windows/WindowsEngine.ini
	* `SonyController` 関連をコメントアウト状態で追加
* Config/Linux/LinuxGame.ini
* Config/Mac/MacGame.ini
* Config/Windows/WindowsGame.ini
	* リプレイサポートの設定
	* `CommonUISettings` の `Platform.Trait.ReplaySupport` を追加
	> 関連:  
	> * Source/LyraGame/GameModes/LyraUserFacingExperienceDefinition.cpp


# 4. アセット

## 4.1. .uasset

### 4.1.1. PrimaryAssetLabel 関連

* Content/DefaultGame_Label.uasset
* Plugins/GameFeatures/ShooterMaps/Content/ShooterMaps_Label.uasset
* Plugins/GameFeatures/TopDownArena/Content/TopDownArena_Label.uasset
	* パッケージ分割で利用される PrimaryAssetLabel アセットの追加
* Plugins/GameFeatures/ShooterMaps/Content/ShooterMaps.uasset
* Plugins/GameFeatures/TopDownArena/Content/TopDownArena.uasset
	* 対応する PrimaryAssetLabel の指定を追加

### 4.1.2. 未確認/変更ファイル

* Content/Audio/Sounds/EditorUtilities/UB_SetSoundWavesToBink.uasset
* Content/Characters/Heroes/Mannequin/Rig/CR_Mannequin_Body.uasset
* Content/Characters/Heroes/Mannequin/Rig/CR_Mannequin_FootPlant.uasset
* Content/Characters/Heroes/Mannequin/Rig/CR_Mannequin_Procedural.uasset
* Content/Tools/BakedGeneratedMeshSystem/EditorActions/FindSourceMesh.uasset
* Content/Tools/BakedGeneratedMeshSystem/EditorActions/SwapGeneratedActor_FromSM.uasset
* Content/Tools/BakedGeneratedMeshSystem/EditorActions/SwapGeneratedActor_ToSM.uasset
* Content/Tools/BakedGeneratedMeshSystem/EditorActions/SyncSourceKey.uasset
* Content/UI/DT_UniversalActions.uasset
* Content/UI/Foundation/Platform/Input/GamepadXboxOne/CommonInput_Gamepad_XboxOne.uasset
* Content/UI/Menu/Experiences/W_SessionBrowserEntry.uasset
* Content/UI/Menu/W_LyraFrontEnd.uasset
* Content/UI/Menu/W_UserWatermark.uasset
* Plugins/GameFeatures/ShooterCore/Content/Game/B_Hero_ShooterMannequin.uasset
* Plugins/GameFeatures/ShooterCore/Content/Game/Respawn/GA_AutoRespawn.uasset
* Plugins/GameFeatures/ShooterCore/Content/UserInterface/HUD/W_QuickBarSlot.uasset
* Plugins/GameFeatures/ShooterCore/Content/Weapons/Rifle/GCN_Weapon_Rifle_Fire.uasset
* Plugins/GameFeatures/ShooterCore/Content/Weapons/Shotgun/B_WeaponInstance_Shotgun.uasset
* Plugins/GameFeatures/ShooterMaps/Content/ShooterMaps.uasset
* Plugins/GameFeatures/TopDownArena/Content/TopDownArena.uasset

### 4.1.3. 未確認/追加ファイル

* Content/DefaultGame_Label.uasset
* Content/Environments/Gameplay/AS_InstantHeal.uasset
* Content/Environments/Gameplay/B_GameplayEffectPad_Child_Healing.uasset
* Content/Environments/Materials/Grid/TextureGrid/Grid_BW_512.uasset
* Content/Environments/Materials/Grid/TextureGrid/M_Grid_Texture.uasset
* Content/Environments/Materials/Grid/TextureGrid/MI_Grid_Texture.uasset
* Content/Feedback/Haptics/Weapon_Fire_Auto/C_Weapon_AutoVibration_Amplitude.uasset
* Content/Feedback/Haptics/Weapon_Fire_Auto/C_Weapon_AutoVibration_Frequency.uasset
* Content/Feedback/Haptics/Weapon_Fire_Auto/C_Weapon_AutoVibration_Position.uasset
* Content/Feedback/Haptics/Weapon_Fire_Auto/FFE_Weapon_Fire_Auto.uasset
* Content/GameplayEffects/GE_GameplayCueTest_Burst.uasset
* Content/GameplayEffects/GE_GameplayCueTest_BurstLatent.uasset
* Content/GameplayEffects/GE_GameplayCueTest_Looping.uasset
* Content/GameplayEffects/Heal/GE_Heal_Instant.uasset
* Content/UI/Menu/W_UserLoginButton.uasset
* Plugins/GameFeatures/ShooterCore/Content/Game/B_TeamColor_DeviceProperty.uasset
* Plugins/GameFeatures/ShooterMaps/Content/ShooterMaps_Label.uasset
* Plugins/GameFeatures/ShooterTests/Content/Blueprint/B_DevicePropertyTester.uasset
* Plugins/GameFeatures/ShooterTests/Content/Blueprint/BP_GameplayEffectPad_Forcefeedback.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/C_InputDeviceColor.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/DeviceColor/B_InputDeviceColor.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/DeviceColor/C_InputDeviceColor.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/DeviceColor/FFE_ChangeColorOverTime.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/DeviceColor/FFE_ChangeColorTest.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/FFE_ChangeColorTest.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/SoundVibrations/B_AudioBasedVibration.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/SoundVibrations/Emote_FingerGuns_Test.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/SoundVibrations/GamepadAudioSubmix.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/SoundVibrations/GamepadVibrationSubmix.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/TriggerFeedback/B_TriggerFeedbackTest.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/TriggerFeedback/C_TriggerPosition.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/TriggerFeedback/C_TriggerStr.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/TriggerVibration/B_Trigger_Vibration_Test.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/TriggerVibration/C_TriggerVibration_Amplitude.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/TriggerVibration/C_TriggerVibration_Frequency.uasset
* Plugins/GameFeatures/ShooterTests/Content/Input/TriggerVibration/C_TriggerVibration_Position.uasset
* Plugins/GameFeatures/TopDownArena/Content/TopDownArena_Label.uasset


## 4.2. .umap

* Plugins/GameFeatures/ShooterTests/Content/Maps/L_ShooterTest_DeviceProperties.umap
	* 振動やコントローラのライトの色等、入力デバイスのハプティック フィードバックの確認用レベルの追加


# 5. ローカライゼーション

* 未確認です。


# 6. ソースファイル

## 6.1. 軽微な変更

### 6.1.1. DEPRECATED 関連
 
* Plugins/CommonGame/Source/Private/CommonPlayerInputKey.cpp
	* 使用していた `ToPaintGeometry()` が DEPRECATED となったのでオーバーロードされている異なる引数の関数に変更
* Plugins/PocketWorlds/Source/Private/PocketLevelInstance.cpp
	* 使用していた `GetCurrentState()` が DEPRECATED となったので `GetLevelStreamingState()` に変更
* Source/LyraGame/Input/LyraInputComponent.cpp
	* 使用していた `AddPlayerMappedKey()` が DEPRECATED となったので `AddPlayerMappedKeyInSlot()` に変更
	* 使用していた `RemovePlayerMappedKey()` が DEPRECATED となったので `RemovePlayerMappedKeyInSlot()` に変更
* Source/LyraGame/Settings/LyraSettingsLocal.cpp
	* 使用していた `AddPlayerMappedKey()` が DEPRECATED となったので `AddPlayerMappedKeyInSlot()` に変更
	* 使用していた `RemovePlayerMappedKey()` が DEPRECATED となったので `RemoveAllPlayerMappedKeysForMapping()` に変更
		* 本来対応する関数は `RemovePlayerMappedKeyInSlot()` だが、上記の全件削除する関数を使用している。
* Source/LyraGame/UI/IndicatorSystem/SActorCanvas.cpp
	* 使用していた `ToPaintGeometry()` が DEPRECATED となったのでオーバーロードされている異なる引数の関数に変更


### 6.1.2. バリデーションチェック関連

* Plugins/CommonGame/Source/Private/CommonUIExtensions.cpp
	* 引数のバリデーションチェックの追加
* Plugins/GameFeatures/ShooterCore/Source/ShooterCoreRuntime/Private/TDM_PlayerSpawningManagmentComponent.cpp
	* 引数のバリデーションチェックの追加
* Source/LyraGame/AbilitySystem/Executions/LyraDamageExecution.cpp
	* `ULyraTeamSubsystem` 取得の際のバリデーションチェックの追加
* Source/LyraGame/Character/LyraHeroComponent.cpp
	* 入力コンポーネントのバリデーションチェックの方法の改善
* Source/LyraGame/Player/LyraPlayerState.cpp
	* `GetWolrd()` の戻り値のバリデーションチェックの追加
* Source/LyraGame/Teams/LyraTeamInfoBase.cpp
	* `ULyraTeamSubsystem` 取得時のバリデーションチェックの追加
* Source/LyraGame/Teams/LyraTeamSubsystem.cpp
* Source/LyraGame/Teams/LyraTeamSubsystem.h
	* チーム登録、抹消時に取得したチーム ID のバリデーションチェックの追加
		> 登録、抹消の正否を返すようになったが、戻り値は利用されていない。


### 6.1.3. その他

* Plugins/AsyncMixin/Source/Private/AsyncMixin.cpp
	* `FString::JoinBy()` の第三引数のデリゲートの戻り値の型を `FString` に変更（おそらく不要なコンストラクタ呼び出し削減の為）
* Source/LyraEditor/LyraEditor.cpp
	* カスタムツールバー用のサンプル専用関数の削除と、カスタムツールバーの初期化コードのコメントアウト
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility.cpp
	* デバッグ出力の削除
* Source/LyraEditor/Validation/EditorValidator_SourceControl.cpp
	* バージョン管理の判定の改善(バグ修正)
* Source/LyraGame/AbilitySystem/Attributes/LyraHealthSet.cpp
	* 被ダメージ時の GameplayMessage の送信判定が `Magnitude < 0.0` から `Magnitude > 0.0` に変更された。（おそらく不具合修正）
		> ULyraDamageLogDebuggerComponent は前述のメッセージを受け取るが、その際、 Magnitude に -1 を掛けた値で合計値を算出している。  
		> 合計値はログに表示されるだけなのでマイナス表記になるだけで動作に影響はない。  
		> また、このクラスはプロジェクト初期状態では使用されていない。利用する場合は注意。  
* Source/LyraGame/GameModes/LyraUserFacingExperienceDefinition.cpp
	* リプレイの保存を行うかをプラットフォームがリプレイをサポートするかをチェックするよう変更
	* `CommonUISettings` の `Platform.Trait.ReplaySupport` を参照して判定している。
	> 関連:   
	> * Config/Linux/LinuxGame.ini
	> * Config/Mac/MacGame.ini
	> * Config/Windows/WindowsGame.ini
* Source/LyraGame/UI/IndicatorSystem/SActorCanvas.cpp
	* ワールドが変更されている可能性がある時にその情報を変数に保存
		* （おそらく使用されていない為詳細未確認）
* Plugins/GameSettings/Source/Private/Widgets/GameSettingPanel.cpp
* Source/LyraGame/Settings/Screens/LyraBrightnessEditor.cpp
* Source/LyraGame/Settings/Screens/LyraSafeZoneEditor.cpp
	* コンストラクタ内で基底クラスの `bIsFocusable` の値を直接変えていたのを `SetIsFocusable()` 経由に変更
* Source/LyraGame/GameFeatures/GameFeatureAction_AddWidget.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddWidget.h
	* HUD アクターに widget を追加する際、 HUD アクターも保存するように変更
	* widget 削除の際に HUD アクターが登録されているかを事前にチェックするように変更
		> おそらくマルチプレイ対策。詳細未確認。
* Source/LyraGame/UI/IndicatorSystem/IndicatorDescriptor.cpp
* Source/LyraGame/UI/IndicatorSystem/IndicatorDescriptor.h
	* ScreenSize を示す変数の型を FVector2D から FVector2f に変更（ double から float ）


## 6.2. 大きめな変更

### 6.2.1. 専用サーバー・ローカル マルチプレイヤー・シームレス移動の対応

* Source/LyraGame/GameModes/LyraBotCreationComponent.cpp
	* `DispatchPostLogin()` の呼び出しを `GenericPlayerInitialization()` に変更（おそらくシームレス移動対応の一環）
* Source/LyraGame/System/LyraSystemStatics.cpp
	* 専用サーバーの対応
	* シームレス移動を有効にするためのオプションを URL に含める処理の追加
* Source/LyraGame/System/LyraGameSession.cpp
* Source/LyraGame/System/LyraGameSession.h
	* `ProcessAutoLogin()` のオーバーライド
		> 専用サーバー関連。詳細未確認。
* Source/LyraGame/GameModes/LyraExperienceManagerComponent.cpp
* Source/LyraGame/GameModes/LyraExperienceManagerComponent.h
	* `ServerSetCurrentExperience()` を `SetCurrentExperience()` に変え、サーバー専用関数で無くした
		> 専用サーバー関連。詳細未確認。  
		> 関連:   
		> * Source/LyraGame/GameModes/LyraGameMode.cpp
		> * Source/LyraGame/GameModes/LyraGameMode.h
	* エクスペリエンスで指定されたアセットのロードの前のバリデーションチェックの改善
* Source/LyraGame/GameModes/LyraGameMode.cpp
* Source/LyraGame/GameModes/LyraGameMode.h
	* コマンドラインからのエクスペリエンス指定でアセットが有効でなかった際のフォールバック処理
	* 専用サーバーへのログイン処理
	* `OnPostLogin()` の代わりに `GenericPlayerInitialization()` をオーバーライドするように変更
		> おそらくシームレス移動対応の一環
		> 関連:   
		> * Source/LyraGame/Teams/LyraTeamCreationComponent.cpp
		> * Source/LyraGame/Teams/LyraTeamCreationComponent.h
	* `LyraExperienceManagerComponent` の変更への対応
		> 関連:   
		> * Source/LyraGame/GameModes/LyraExperienceManagerComponent.cpp
		> * Source/LyraGame/GameModes/LyraExperienceManagerComponent.h
* Source/LyraGame/GameModes/LyraGameState.cpp
* Source/LyraGame/GameModes/LyraGameState.h
	* `SeamlessTravelTransitionCheckpoint()` のオーバーライドし、 有効でない bot と player の削除をするコードの追加
		> シームレス移動対応の一環。詳細未確認。
* Source/LyraGame/Teams/LyraTeamCreationComponent.cpp
* Source/LyraGame/Teams/LyraTeamCreationComponent.h
	* `OnPostLogin()` を `OnPlayerInitialized()` に名前変更
		> おそらくシームレス移動対応の一環
		> 関連:   
		> * Source/LyraGame/GameModes/LyraGameMode.cpp
		> * Source/LyraGame/GameModes/LyraGameMode.h
* Plugins/CommonUser/Source/CommonUser/Private/CommonSessionSubsystem.cpp
* Plugins/CommonUser/Source/CommonUser/Public/CommonSessionSubsystem.h
	* `APlayerController::ClientTravel()` 呼び出し前に URL を加工するためのイベントの用意
		* URL パラメータに暗号化トークンを追加するのに利用
		> 関連:   
		> * Source/LyraGame/System/LyraGameInstance.cpp
		> * Source/LyraGame/System/LyraGameInstance.h
	* 専用サーバーかどうかを判定するフラグの追加
	* セッションのエラー情報を保持する変数の追加と `UE_LOG` に出力していた通信関連のエラーをこの変数に保持するように変更
	* ローカルプレイヤーの対応
* Plugins/CommonUser/Source/CommonUser/Private/CommonUserSubsystem.cpp
* Plugins/CommonUser/Source/CommonUser/Public/CommonUserSubsystem.h
	* 専用サーバーかどうかを判定するフラグの追加と処理の分岐
	* ローカルプレイヤーの対応


### 6.2.2. 暗号化の対応

* Source/LyraGame/System/LyraGameInstance.cpp
* Source/LyraGame/System/LyraGameInstance.h
	* 暗号化のキーのサンプル実装
	* 専用サーバーの URL の加工(暗号化トークンの追加)
		> 関連:   
		> * Plugins/CommonUser/Source/CommonUser/Private/CommonSessionSubsystem.cpp
		> * Plugins/CommonUser/Source/CommonUser/Public/CommonSessionSubsystem.h


### 6.2.3. Replication Graph の対応

* Source/LyraGame/Character/LyraCharacter.cpp
* Source/LyraGame/Character/LyraCharacter.h
	* プロパティのレプリケーションがスキップされている場合に移動に関する情報だけを RPC で同期する仕組みの追加
		> 呼び出しは Replication Graph から行っている。
		> 詳細未確認。
* Source/LyraGame/System/LyraReplicationGraphTypes.h
	* このプロジェクトの Replication Graph のアクタークラス毎の基本設定を行う構造体 `FRepGraphActorClassSettings` の定義
	* 実体は `ULyraReplicationGraphSettings::ClassSettings` が保持
* Source/LyraGame/System/LyraReplicationGraphSettings.cpp
* Source/LyraGame/System/LyraReplicationGraphSettings.h
	* このプロジェクトの Replication Graph の基本設定を行うクラス `ULyraReplicationGraphSettings` の定義
	* Replication Graph の設定はこのクラスのデフォルトオブジェクトを使用
	* `ULyraReplicationGraphSettings::ClassSettings` のデフォルト値は未設定で ini ファイル(Project Settings)で設定
		> 関連:   
		> * Config/DefaultGame.ini
* Source/LyraGame/System/LyraReplicationGraph.cpp
* Source/LyraGame/System/LyraReplicationGraph.h
	* Replication Graph の実装
	* 詳しくは cpp ファイルに 80 行ほどのコメントがあるのでそちらを参照


### 6.2.4. 入力デバイスのプロパティ

* Source/LyraGame/Weapons/LyraWeaponInstance.cpp
* Source/LyraGame/Weapons/LyraWeaponInstance.h
	* 武器切替時に武器毎の入力デバイスのプロパティを設定する処理の追加
		> `B_WeaponInstance_Shotgun` の `Input Device > Applicable Device Properties` に `Trigger Resistance` を利用し設定
		> 詳しくは `UInputDeviceTriggerResistanceProperty` を参照


### 6.2.5. GameplayTag 関連

* Source/LyraGame/LyraGameplayTags.cpp
* Source/LyraGame/LyraGameplayTags.h
	* シングルトンクラスが保持していたものをグローバル変数を使うように変更
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility_Death.cpp
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility_Reset.cpp
	* GameplayTag の参照前に `UGameplayTagsManager` の `CallOrRegister_OnDoneAddingNativeTagsDelegate()` を利用した初期化順のためのコードが不要になった。
* Source/LyraGame/System/LyraAssetManager.cpp
	* GameplayTag がグローバル変数を使うようになった為、不要になった初期化関数呼び出しの削除
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility.cpp
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility_Death.cpp
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility_Death.h
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility_Reset.cpp
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility_Reset.h
* Source/LyraGame/AbilitySystem/Attributes/LyraHealthSet.cpp
* Source/LyraGame/Character/LyraCharacter.cpp
* Source/LyraGame/Character/LyraHealthComponent.cpp
* Source/LyraGame/Character/LyraHeroComponent.cpp
* Source/LyraGame/Character/LyraPawnExtensionComponent.cpp
* Source/LyraGame/Player/LyraCheatManager.cpp
* Source/LyraGame/Player/LyraPlayerController.cpp
* Source/LyraGame/System/LyraGameInstance.cpp
* Source/LyraGame/Teams/LyraTeamCreationComponent.cpp
	* 参照の方法変更


### 6.2.6. `ShooterTestsRuntime` モジュール用

* Plugins/GameFeatures/ShooterTests/Source/ShooterTestsRuntime/Private/ShooterTestsDevicePropertyTester.cpp
* Plugins/GameFeatures/ShooterTests/Source/ShooterTestsRuntime/Private/ShooterTestsDevicePropertyTester.h
* Plugins/GameFeatures/ShooterTests/Source/ShooterTestsRuntime/Private/ShooterTestsRuntimeModule.cpp
	* `L_ShooterTest_DeviceProperties` に配置している、テスト用のアクターの実装
	* オーバーラップすると入力デバイスのプロパティを設定する


# 終わりに

公式ドキュメントでまとめられているとおり、新たに利用する機能が多く、その影響の修正もあちこちで発生しています。  
ゲーム部分の変更は少なめだと思います。
なにかの参考になれば幸いです。


-----
おしまい。

<!--- ページ内のリンク --->
[オーバービュー]: #0-オーバービュー
[ドキュメント]: #1-ドキュメント
[ビルド関連]: #2-ビルド関連
[設定ファイル]: #3-設定ファイル
[アセット]: #4-アセット
[ローカライゼーション]: #5-ローカライゼーション
[ソースファイル]: #6-ソースファイル


<!--- 自前の画像へのリンク --->

<!--- generated --->
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.2 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra Starter Game を最新エンジン リリースにアップグレードする]: https://docs.unrealengine.com/5.2/ja/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine/
