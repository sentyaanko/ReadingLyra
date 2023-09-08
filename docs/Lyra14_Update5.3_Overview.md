# 【UE5】Lyra に学ぶ(14) Update5.3 <!-- omit in toc -->

UE5 の新しい？サンプル [Lyra Starter Game] 。  
Unreal Engine 5.3 がリリースされたことで、 5.0 ～ 5.3 用の 4 つのバージョンが存在するようになっています。  
このドキュメントは 5.2 と 5.3 の違いについてまとめたものですが、公式ドキュメントに詳しい解説があるので、そちらを見るのが一番良いです。  
[Unreal Engine 5.3 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra Starter Game を最新エンジン リリースにアップグレードする]  

> (2023/09/08 現在、日本語ドキュメントは更新されていません。更新されるまでは英語ドキュメントを参照しましょう。)

追記している情報は .cpp/.h など、テキスト形式で比較可能なものが中心となっています。

* バージョン
	* [Lyra Starter Game]
		* 2023/09/07 版

# Index <!-- omit in toc -->

- [1. オーバービュー](#1-オーバービュー)
- [2. ビルド関連](#2-ビルド関連)
	- [2.1. .uproject](#21-uproject)
	- [2.2. .Build.cs](#22-buildcs)
	- [2.3. .Target.cs](#23-targetcs)
- [3. 設定ファイル](#3-設定ファイル)
	- [3.1. Config/\*.ini](#31-configini)
- [4. .uasset](#4-uasset)
	- [4.1. Audio](#41-audio)
	- [4.2. Input](#42-input)
	- [4.3. Character](#43-character)
	- [4.4. etc](#44-etc)
	- [4.5. GameFeatures](#45-gamefeatures)
		- [4.5.1. ShooterCore](#451-shootercore)
		- [4.5.2. ShooterExplorer](#452-shooterexplorer)
		- [4.5.3. ShooterMaps](#453-shootermaps)
		- [4.5.4. TopDownArena](#454-topdownarena)
- [5. .umap](#5-umap)
- [6. ローカライゼーション](#6-ローカライゼーション)
- [7. ソースファイル](#7-ソースファイル)
	- [7.1. 更新情報に記載がある項目](#71-更新情報に記載がある項目)
		- [7.1.1. `Release Notes` より](#711-release-notes-より)
		- [7.1.2. `Lyra Starter Game を最新エンジン リリースにアップグレードする` より](#712-lyra-starter-game-を最新エンジン-リリースにアップグレードする-より)
	- [7.2. 軽微な変更](#72-軽微な変更)
		- [7.2.1. DEPRECATED 関連](#721-deprecated-関連)
		- [7.2.2. バリデーションチェック関連](#722-バリデーションチェック関連)
		- [7.2.3. その他](#723-その他)
	- [7.3. 大きめな変更](#73-大きめな変更)
		- [7.3.1. アトリビュート関連](#731-アトリビュート関連)
		- [7.3.2. 観戦関連](#732-観戦関連)
		- [7.3.3. widget 関連](#733-widget-関連)
		- [7.3.4. その他](#734-その他)
		- [7.3.5. Editor](#735-editor)
- [8. 終わりに](#8-終わりに)


# 1. オーバービュー

変更が 292 ファイル、追加が 90 ファイル、削除が 7 ファイルの合計 389 ファイルの差分があります。

大まかな分類とファイル数は以下のようになります。

| 分類						| パス、拡張子等				| 変更	| 追加	| 削除	|
|----						|----							|----	|----	|----	|
| [ビルド関連]				| .uproject						| 1		| 0		| 0		|
|							| .Build.cs						| 2		| 0		| 0		|
|							| .Target.cs					| 4		| 0		| 0		|
| [設定ファイル]			| .ini							| 6		| 1		| 0		|
| [アセット]				| .uasset						| 98	| 45	| 7		|
| [マップ]					| .umap							| 2		| 2		| 0		|
| [ローカライゼーション]	| Content/Localization 以下		| 80	| 38	| 0		|
| [ソースファイル]			| .cpp							| 58	| 2		| 0		|
|							| .h							| 41	| 2		| 0		|


# 2. ビルド関連

## 2.1. .uproject

* LyraStarterGame.uproject
	> * `EngineAssociation` を `5.3` に変更しました。
	> * 以下のプラグインを削除しました。
	> 	* `OculusVR`
	> * 以下のプラグインを追加しました。
	> 	* `GameplayInteractions` (Player and NPC interactions)
	> 	* `SmartObjects` (Support for ambient life populating the game world)
	> 	* `ContextualAnimation` (詳細不明)
	> 	* `GameplayBehaviorSmartObjects` (Plugins for SmartObjects using GameplayBehavior as their default runtime behavior)
	> 	* `GameplayStateTree` (StateTree for AI/Gameplay Behaviors)
	> 	* `GameplayBehaviors` (`AI Behaviors`: Encapsulated fire-and-forget behaviors for AI agents)

## 2.2. .Build.cs

* Plugins/GameplayMessageRouter/Source/GameplayMessageNodes/GameplayMessageNodes.Build.cs
	> * モジュール `BlueprintGraph` の追加先を `PublicDependencyModuleNames` から `PrivateDependencyModuleNames` に変更しました。
* Source/LyraGame/LyraGame.Build.cs
	> * 空行が追加されたのみで、変更はありません。


## 2.3. .Target.cs

* Source/LyraClient.Target.cs
* Source/LyraEditor.Target.cs
* Source/LyraGame.Target.cs
* Source/LyraServer.Target.cs
	> * `DefaultBuildSettings` / `IncludeOrderVersion` の指定がなくなりました。
* Source/LyraEditor.Target.cs
	> * 条件次第で `NativePointerMemberBehaviorOverride` の指定を行うように変更されました。
* Source/LyraGame.Target.cs
	> * `DefaultBuildSettings` / `IncludeOrderVersion` の指定を個別でなくここでまとめて指定するようになりました。
	> * ログの保存方法が変更されました。
	> * 同じ `.uplugin` の読み込みを何度も行わないように処理が変更されました。

> **Note**  
> `NativePointerMemberBehaviorOverride` について
> 以下のリンクより引用
> https://docs.unrealengine.com/5.2/ja/unreal-engine-build-tool-target-reference/
>> NativePointerMemberBehaviorOverride (Nullable)
>> UCLASS と USTRUCT がネイティブ ポインタ メンバを持つことを許可するかどうかを制御する動作をオーバーライドするために使用されます。
>> 許可されていない場合、それらは Unreal Header Tool (UHT) エラーになり、TObjectPtr メンバで置き換える必要があります。


# 3. 設定ファイル

## 3.1. Config/*.ini

* Config/Custom/EOS/DefaultEngine.ini
	> * EOS 関連の設定を削除しました。
* Config/DefaultEditorPerProjectUserSettings.ini
	> * 追加したレベル `L_ShooterTest_DeviceProperties` をメインツールバーの `Commpn Map` に追加しました。
* Config/DefaultEngine.ini
	> * Iris 関連の設定を削除しました。
	> * OnlineSubsystemEOS の設定を追加しました。
	> * リプレイに関する設定が追加されました。
	> * Nanite の設定が追加されました。
	> * bSharedLinearTextureEncoding の設定が追加されました。
	> * ターゲットが windows の設定が変更されました。
	> 	* シェーダー関連の設定が追加されました。
	> 	* Vulkan の設定が追加されました。
	> 	* サウンド関連の設定が追加されました。
	> * `Android File Server` 関連の記述が追加されました。
	> 	> これは 5.2 の際に削除されたものが戻されました。
	> * ターゲットが Linux の設定が追加されました。
* Config/DefaultGame.ini
	> * ProjectID が変更されているだけで意味のある更新はありません。
* Config/DefaultInput.ini
	> * Enhanced Input の設定が追加されました。
* Config/DefaultScalability.ini
	> * パラメータ `r.DistanceFieldAO` を設定するセクションが `[ShadowQuality@0]` 等から `[GlobalIlluminationQuality@0]` などに変更されました。

> **Note**  
> `bSharedLinearTextureEncoding` について
> `Engine\Source\Runtime\Engine\Private\TextureEncodingSettingsPrivate.h` より
> ```c++
> 	// If true, platforms that want to take a linearly encoded texture and then tile them
> 	// will try to reuse the linear texture rather than encode it for every platform. This can result in
> 	// massive speedups for texture building as tiling is very fast compared to encoding. So instead of:
> 	//
> 	//	Host Platform: Linear encode
> 	//	Console 1: Linear encode + platform specific tile
> 	//	Console 2: Linear encode + platform specific tile
> 	//
> 	// you instead get:
> 	//	Host platform: Linear encode
> 	//	Console 1: fetch linear + platform specific tile
> 	//	Console 2: fetch linear + platform specific tile
> 	//
> 	// Note that this has no effect on cook time, only build time - once the texture is in the DDC this has no
> 	// effect.
> 	UPROPERTY(EditAnywhere, config, Category=EncodeSettings, meta = (ConfigRestartRequired = true))
> 	uint32 bSharedLinearTextureEncoding : 1;
> ```


# 4. .uasset

## 4.1. Audio

> * 以下のファイルの更新内容は未確認です。
* Content/Audio/Blueprints/B_MusicManagerComponent_Base.uasset
* Content/Audio/MetaSounds/lib_RandInterpTo.uasset
* Content/Audio/MetaSounds/lib_RandPanStereo.uasset
* Content/Audio/MetaSounds/lib_StereoBalance.uasset
* Content/Audio/MetaSounds/lib_TriggerAfter.uasset
* Content/Audio/MetaSounds/lib_TriggerEvery.uasset
* Content/Audio/MetaSounds/lib_TriggerModulo.uasset
* Content/Audio/MetaSounds/lib_TriggerStopAfter.uasset
* Content/Audio/MetaSounds/mx_PlayAmbientChord.uasset
* Content/Audio/MetaSounds/mx_PlayAmbientElement.uasset
* Content/Audio/MetaSounds/mx_Stingers.uasset
* Content/Audio/MetaSounds/mx_System.uasset
* Content/Audio/MetaSounds/sfx_Amb_Wind_lp_meta.uasset
* Content/Audio/MetaSounds/sfx_BaseLayer_Interactable_Pad_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_CapturePoint_Progress_meta.uasset
* Content/Audio/MetaSounds/sfx_Character_DamageGivenKill_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Character_DamageGivenWeakSpot_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Character_DamageGiven_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Character_DamageTakenWeakSpot_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Character_DamageTaken_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Character_RespawnTimer_meta.uasset
* Content/Audio/MetaSounds/sfx_DashStereo_nl_meta_Preset.uasset
* Content/Audio/MetaSounds/sfx_Emote_FingerGuns_nl_meta_Preset.uasset
* Content/Audio/MetaSounds/sfx_EndOfRound-LowScore_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_EndOfRound-Tick_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_ImpactPlaster_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Interactable_JumpPad_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Interactable_WeaponPad_Collect_nl_metaPreset.uasset
* Content/Audio/MetaSounds/sfx_KillingSpree_nl_meta_Preset.uasset
* Content/Audio/MetaSounds/sfx_MeleeWhoosh_nl_meta_Preset.uasset
* Content/Audio/MetaSounds/sfx_RandomStereo_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_RandomWLimitedRangeLayer_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Spawn_nl_meta_Preset.uasset
* Content/Audio/MetaSounds/sfx_Teleport_nl_meta_Preset.uasset
* Content/Audio/MetaSounds/sfx_Weapon_FullyAutomatic_lp_meta.uasset
* Content/Audio/MetaSounds/sfx_Weapon_GrenadeExplosion_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Weapon_GrenadeImpact_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Weapon_MeleeImpact_nl_meta.uasset
* Content/Audio/MetaSounds/sfx_Weapon_Melee_nl_metaPreset.uasset
* Content/Audio/MetaSounds/sfx_Weapon_SemiAutomatic_nl_meta.uasset
* Content/Audio/Sounds/UI/sfx_UI_Lobby_Highlight_nl_meta_Preset.uasset
* Content/Audio/Sounds/UI/sfx_UI_Lobby_Select_nl_meta_Preset.uasset
* Content/Audio/Sounds/UI/sfx_UI_MainMenu_Highlight_nl_meta_Preset.uasset
* Content/Audio/Sounds/UI/sfx_UI_MainMenu_Select_nl_meta_Preset.uasset
* Content/Audio/Sounds/UI/sfx_UI_SubMenu_Back_nl_meta_Preset.uasset
* Content/Audio/Sounds/UI/sfx_UI_SubMenu_Highlight_nl_meta_Preset.uasset
* Content/Audio/Sounds/UI/sfx_UI_SubMenu_Select_nl_meta_Preset.uasset
* 以降は追加ファイル
* Content/Audio/MetaSounds/MS_Graph_RandomPitch_Stereo.uasset
* Content/Audio/MetaSounds/MS_Graph_TriggerDelayPitchShift_Mono.uasset


## 4.2. Input

> * ほとんどの InputAction は `Input Mappable Key Settings` の設定が変更されました。
> 	* （一部設定されていないものもあります。）
* Content のファイル群
	* Content/Input/Actions/IA_Ability_Dash.uasset
	* Content/Input/Actions/IA_Ability_Heal.uasset
	* Content/Input/Actions/IA_AutoRun.uasset
	* Content/Input/Actions/IA_Crouch.uasset
	* Content/Input/Actions/IA_Jump.uasset
	* Content/Input/Actions/IA_Weapon_Fire.uasset
	* Content/Input/Actions/IA_Weapon_Fire_Auto.uasset
	* Content/Input/Actions/IA_Weapon_Reload.uasset
* ShooterCore のファイル群
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_ADS.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_DropWeapon.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_Emote.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_Grenade.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_Melee.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_QuickSlot1.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_QuickSlot2.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_QuickSlot3.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_QuickSlot_CycleBackward.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_QuickSlot_CycleForward.uasset
	* Plugins/GameFeatures/ShooterCore/Content/Input/Actions/IA_ShowScoreboard.uasset

> * InputAction IA_Look_Stick の Modifier が以下のように変更されました。
> 	* 削除
> 		* `Dead Zone` (指定を元に入力のデッドゾーンを反映する)
> 	* 追加
> 		* `Negative` (指定された Axis の入力方向を反転させる)
> 		* `Lyra Settings Driven Dead Zone` (LocalSetting を元に入力のデッドゾーンを反映する)
> 		* `Lyra Aim Inversion Setting` (LocalSetting を元に入力方向を反転する)
> * IMC_ADS_Speed の変更内容が関連しています。
* Content/Input/Actions/IA_Look_Stick.uasset

> * InputMappingContext IA_Look_Mouse の Modifier が以下のように変更されました。
> 	* 削除
> 		* `Lyra Aim Inversion Setting` (LocalSetting を元に入力方向を反転する)
> * InputMappingContext IA_Look_Stick の Modifier が以下のように変更されました。
> 	* 削除
> 		* `Negative` (指定された Axis の入力方向を反転させる)
> 		* `Lyra Settings Driven Dead Zone` (LocalSetting を元に入力のデッドゾーンを反映する)
> 		* `Lyra Aim Inversion Setting` (LocalSetting を元に入力方向を反転する)
> * IA_Look_Stick の変更内容が関連しています。
* Plugins/GameFeatures/ShooterCore/Content/Input/Mappings/IMC_ADS_Speed.uasset

> * `IMC_Default_KBM` / `IMC_Default_Gamepad` / `IMC_Default`
> 	* `IMC_Default_KBM` と `IMC_Default_Gamepad` は統合され、 `IMC_Default` にまとめられました。  
> 	* `IMC_Default_KBM` は `IMC_Default` にリネームされましたが、リダイレクタとしてまだ残っています。
> 	* `IMC_Default_Gamepad` は削除されました。
> * `IMC_ShooterGame` / `IMC_ShooterGame_KBM` / `IMC_ShooterGame_Gamepad`
> 	* これらに関しても同様です。
* IMC_Default のファイル群
	* 追加ファイル
		* Content/Input/Mappings/IMC_Default.uasset
	* リダイレクタ
		* Content/Input/Mappings/IMC_Default_KBM.uasset
	* 削除ファイル
		* Content/Input/Mappings/IMC_Default_Gamepad.uasset
* IMC_ShooterGame のファイル群
	* 追加ファイル
		* Plugins/GameFeatures/ShooterCore/Content/Input/Mappings/IMC_ShooterGame.uasset
	* リダイレクタ
		* Plugins/GameFeatures/ShooterCore/Content/Input/Mappings/IMC_ShooterGame_KBM.uasset
	* 削除ファイル
		* Plugins/GameFeatures/ShooterCore/Content/Input/Mappings/IMC_ShooterGame_Gamepad.uasset

> * `PMI_` で始まる、 `PlayerMappableInputConfig` の 4 ファイルはすべて削除されました。
* Content/Input/Configs/PMI_Default_Gamepad.uasset
* Content/Input/Configs/PMI_Default_KBM.uasset
* Plugins/GameFeatures/ShooterCore/Content/Input/Configs/PMI_ShooterDefaultConfig_Gamepad.uasset
* Plugins/GameFeatures/ShooterCore/Content/Input/Configs/PMI_ShooterDefaultConfig_KBM.uasset

> * 未設定だったのが以下の項目が登録されるように変更されました。
> 	* Native Input Actions
> 		* IA_Move
> 		* IA_Look_Mouse
> 		* IA_Look_Stick
> 		* IA_Crouch
> 		* IA_AutoRun
> 	* Ability Input Actions
> 		* IA_Jump
> 		* IA_Weapon_Reload
> 		* IA_Ability_Heal
> 		* IA_Ability_Dash
> 		* IA_Weapon_Fire
> 		* IA_Weapon_Fire_Auto
* Plugins/GameFeatures/ShooterExplorer/Content/Input/Actions/InputData_InventoryTest.uasset


## 4.3. Character

> * 追加された Interactions/Bench 以下のファイルについて
> 	* これらはベンチに座るためのアニメーションアセットのようです。
> 	* これらはまだ使われていません。
> 	* 追加されたマップ `L_InteractionTestMap` にベンチのようなオブジェクトがあります。
> 	* それに向かって `G` キーを押すとログで `sit` と表示されます。
> 	* いずれそこで使われるのかもしれません。
* 以降は追加ファイル
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_convo_L.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_convo_L_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_convo_R.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_convo_R_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_idle_loop.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_idle_loop_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_idle_twitch_v1.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_idle_twitch_v1_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_idle_twitch_v2.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_idle_twitch_v2_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_idle_twitch_v3.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_idle_twitch_v3_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_L_45.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_L_45_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_L_90.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_L_90_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_R_45.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_R_45_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_R_90.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_R_90_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_fwd.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_into_fwd_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_out_run.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_out_run_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_out_stand.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_out_stand_Montage.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_out_walk.uasset
* Content/Characters/Heroes/Mannequin/Animations/Interactions/Bench/int_sit_bench_sit_out_walk_Montage.uasset

> * 以下のファイルの更新内容は未確認です。
* Content/Characters/Heroes/B_SimpleHeroPawn.uasset
* Content/Characters/Heroes/Mannequin/Animations/ABP_Mannequin_Base.uasset
* Content/Characters/Heroes/Mannequin/Animations/AnimModifiers/FootFXAnimModifier.uasset
* Content/Characters/Heroes/Mannequin/Animations/AnimModifiers/FootstepEffectTagModifier.uasset
* Content/Characters/Heroes/Mannequin/Animations/AnimModifiers/TurnYawAnimModifier.uasset
* Content/Characters/Heroes/Mannequin/Animations/LinkedLayers/ABP_ItemAnimLayersBase.uasset
* Content/Characters/Heroes/Mannequin/Animations/Locomotion/Unarmed/ABP_UnarmedAnimLayers.uasset
* Content/Characters/Heroes/Mannequin/Animations/Locomotion/Unarmed/ABP_UnarmedAnimLayers_Feminine.uasset


## 4.4. etc

> * 以下のファイルの更新内容は未確認です。
* Content/UI/Foundation/Buttons/ButtonStyle-Primary-M.uasset
* Content/UI/Indicators/NameplateManagerComponent.uasset
* Content/UI/Indicators/W_Nameplate.uasset
* Content/UI/Menu/Replays/W_ReplayBrowserScreen.uasset
* Content/UI/Menu/W_LyraFrontEnd.uasset
* Content/UI/Settings/Editors/W_SettingsListEntry_KBMBinding.uasset
* Content/DefaultGame_Label.uasset
* 以降は追加ファイル
* Content/UI/Menu/Art/MI_UI_Settings_ResetArrow.uasset


## 4.5. GameFeatures

### 4.5.1. ShooterCore

> * 以下のファイルの更新内容は未確認です。
* Plugins/GameFeatures/ShooterCore/Content/ControlPoint/UI/W_CPScoreWidget.uasset
* Plugins/GameFeatures/ShooterCore/Content/Elimination/UI/W_ScoreWidget_Elimination.uasset
* Plugins/GameFeatures/ShooterCore/Content/Experiences/LAS_ShooterGame_SharedInput.uasset
* Plugins/GameFeatures/ShooterCore/Content/Game/Respawn/GA_AutoRespawn.uasset
* Plugins/GameFeatures/ShooterCore/Content/Game/Respawn/W_RespawnTimer.uasset
* Plugins/GameFeatures/ShooterCore/Content/ShooterCore.uasset
* Plugins/GameFeatures/ShooterCore/Content/UserInterface/Replays/W_ShooterReplayHUD.uasset
* 以降は追加ファイル
* Plugins/GameFeatures/ShooterCore/Content/Game/B_HandleShooterReplays.uasset
* 以降は削除ファイル
* Plugins/GameFeatures/ShooterCore/Content/Game/B_SpawnShooterReplayHUD.uasset


### 4.5.2. ShooterExplorer

> * 以下のファイルの更新内容は未確認です。
* Plugins/GameFeatures/ShooterExplorer/Content/System/Experiences/B_TestInventoryExperience.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/UserInterface/W_InteractionPrompt.uasset
* 以降は追加ファイル
* Plugins/GameFeatures/ShooterExplorer/Config/Tags/ShooterExplorerTags.ini
* Plugins/GameFeatures/ShooterExplorer/Content/Blueprint/B_Hero_Explorer.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/Game/HeroData_Explorer.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/Interact/GA_Interaction_Sit.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/Items/B_InteractableChair.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/Maps/L_InteractionTestMap.umap
* Plugins/GameFeatures/ShooterExplorer/Content/Meshes/Gyms/SM_ModuleA_090.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/Meshes/Gyms/SM_NavCube.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/Meshes/Gyms/SM_Railing_010.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/Meshes/Gyms/SM_stairs_1.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/System/DataLayers/L_Ai_TestLayer.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/System/DataLayers/L_Ai_TestLayer_BaseContent.uasset
* Plugins/GameFeatures/ShooterExplorer/Content/System/DataLayers/L_Ai_TestLayer_DynamicContent.uasset


### 4.5.3. ShooterMaps

> * 以下のファイルの更新内容は未確認です。
* Plugins/GameFeatures/ShooterMaps/Content/Maps/L_ShooterFrontendBackground.umap
* Plugins/GameFeatures/ShooterMaps/Content/System/Playlists/DA_Convolution_ControlPoint.uasset
* Plugins/GameFeatures/ShooterMaps/Content/\_\_ExternalActors\_\_/Maps/L_Expanse/6A/3K/VE0ZO212Y2CV4LEV16SBD.uasset


### 4.5.4. TopDownArena

> * 以下のファイルの更新内容は未確認です。
* Plugins/GameFeatures/TopDownArena/Content/TopDownArena.uasset


# 5. .umap

> * 以下のファイルの更新内容は未確認です。
* Content/System/DefaultEditorMap/L_DefaultEditorOverview.umap

> * シームレスな移動のためのマップが追加されました。
* 以降は追加ファイル
* Content/System/TransitionMap.umap


# 6. ローカライゼーション

> * 以下のファイルの更新内容は未確認です。
* Content/Localization/EngineOverrides/EngineOverrides.csv
* Content/Localization/EngineOverrides/EngineOverrides.manifest
* Content/Localization/EngineOverrides/ar/EngineOverrides.archive
* Content/Localization/EngineOverrides/ar/EngineOverrides.locres
* Content/Localization/EngineOverrides/ar/EngineOverrides.po
* Content/Localization/EngineOverrides/de/EngineOverrides.archive
* Content/Localization/EngineOverrides/de/EngineOverrides.locres
* Content/Localization/EngineOverrides/de/EngineOverrides.po
* Content/Localization/EngineOverrides/en/EngineOverrides.archive
* Content/Localization/EngineOverrides/en/EngineOverrides.locres
* Content/Localization/EngineOverrides/en/EngineOverrides.po
* Content/Localization/EngineOverrides/es-419/EngineOverrides.archive
* Content/Localization/EngineOverrides/es-419/EngineOverrides.locres
* Content/Localization/EngineOverrides/es-419/EngineOverrides.po
* Content/Localization/EngineOverrides/es/EngineOverrides.archive
* Content/Localization/EngineOverrides/es/EngineOverrides.locres
* Content/Localization/EngineOverrides/es/EngineOverrides.po
* Content/Localization/EngineOverrides/fr/EngineOverrides.archive
* Content/Localization/EngineOverrides/fr/EngineOverrides.locres
* Content/Localization/EngineOverrides/fr/EngineOverrides.po
* Content/Localization/EngineOverrides/it/EngineOverrides.archive
* Content/Localization/EngineOverrides/it/EngineOverrides.locres
* Content/Localization/EngineOverrides/it/EngineOverrides.po
* Content/Localization/EngineOverrides/ja/EngineOverrides.archive
* Content/Localization/EngineOverrides/ja/EngineOverrides.locres
* Content/Localization/EngineOverrides/ja/EngineOverrides.po
* Content/Localization/EngineOverrides/ko/EngineOverrides.archive
* Content/Localization/EngineOverrides/ko/EngineOverrides.locres
* Content/Localization/EngineOverrides/ko/EngineOverrides.po
* Content/Localization/EngineOverrides/pl/EngineOverrides.archive
* Content/Localization/EngineOverrides/pl/EngineOverrides.locres
* Content/Localization/EngineOverrides/pl/EngineOverrides.po
* Content/Localization/EngineOverrides/pt-BR/EngineOverrides.archive
* Content/Localization/EngineOverrides/pt-BR/EngineOverrides.locres
* Content/Localization/EngineOverrides/pt-BR/EngineOverrides.po
* Content/Localization/EngineOverrides/ru/EngineOverrides.archive
* Content/Localization/EngineOverrides/ru/EngineOverrides.locres
* Content/Localization/EngineOverrides/ru/EngineOverrides.po
* Content/Localization/EngineOverrides/tr/EngineOverrides.archive
* Content/Localization/EngineOverrides/tr/EngineOverrides.locres
* Content/Localization/EngineOverrides/tr/EngineOverrides.po
* Content/Localization/EngineOverrides/zh-Hans/EngineOverrides.archive
* Content/Localization/EngineOverrides/zh-Hans/EngineOverrides.locres
* Content/Localization/EngineOverrides/zh-Hans/EngineOverrides.po
* Content/Localization/Game/Game.csv
* Content/Localization/Game/Game.locmeta
* Content/Localization/Game/Game.manifest
* Content/Localization/Game/Game_Conflicts.txt
* Content/Localization/Game/ar/Game.archive
* Content/Localization/Game/ar/Game.po
* Content/Localization/Game/de/Game.archive
* Content/Localization/Game/de/Game.po
* Content/Localization/Game/en/Game.archive
* Content/Localization/Game/en/Game.locres
* Content/Localization/Game/en/Game.po
* Content/Localization/Game/es-419/Game.archive
* Content/Localization/Game/es-419/Game.po
* Content/Localization/Game/es/Game.archive
* Content/Localization/Game/es/Game.po
* Content/Localization/Game/fr/Game.archive
* Content/Localization/Game/fr/Game.po
* Content/Localization/Game/it/Game.archive
* Content/Localization/Game/it/Game.po
* Content/Localization/Game/ja/Game.archive
* Content/Localization/Game/ja/Game.locres
* Content/Localization/Game/ja/Game.po
* Content/Localization/Game/ko/Game.archive
* Content/Localization/Game/ko/Game.locres
* Content/Localization/Game/ko/Game.po
* Content/Localization/Game/pl/Game.archive
* Content/Localization/Game/pl/Game.po
* Content/Localization/Game/pt-BR/Game.archive
* Content/Localization/Game/pt-BR/Game.po
* Content/Localization/Game/ru/Game.archive
* Content/Localization/Game/ru/Game.po
* Content/Localization/Game/tr/Game.archive
* Content/Localization/Game/tr/Game.po
* Content/Localization/Game/zh-Hans/Game.archive
* Content/Localization/Game/zh-Hans/Game.locres
* Content/Localization/Game/zh-Hans/Game.po
* 以降は追加ファイル
* Content/Localization/EngineOverrides/ar/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/de/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/EngineOverrides.locmeta
* Content/Localization/EngineOverrides/EngineOverrides_Conflicts.txt
* Content/Localization/EngineOverrides/es/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/es-419/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/fr/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/it/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/ja/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/ko/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/pl/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/pt-BR/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/ru/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/tr/EngineOverrides_FromXLoc.po
* Content/Localization/EngineOverrides/zh-Hans/EngineOverrides_FromXLoc.po
* Content/Localization/Game/ar/Game.locres
* Content/Localization/Game/ar/Game_FromXLoc.po
* Content/Localization/Game/de/Game.locres
* Content/Localization/Game/de/Game_FromXLoc.po
* Content/Localization/Game/es/Game.locres
* Content/Localization/Game/es/Game_FromXLoc.po
* Content/Localization/Game/es-419/Game.locres
* Content/Localization/Game/es-419/Game_FromXLoc.po
* Content/Localization/Game/fr/Game.locres
* Content/Localization/Game/fr/Game_FromXLoc.po
* Content/Localization/Game/it/Game.locres
* Content/Localization/Game/it/Game_FromXLoc.po
* Content/Localization/Game/ja/Game_FromXLoc.po
* Content/Localization/Game/ko/Game_FromXLoc.po
* Content/Localization/Game/pl/Game.locres
* Content/Localization/Game/pl/Game_FromXLoc.po
* Content/Localization/Game/pt-BR/Game.locres
* Content/Localization/Game/pt-BR/Game_FromXLoc.po
* Content/Localization/Game/ru/Game.locres
* Content/Localization/Game/ru/Game_FromXLoc.po
* Content/Localization/Game/tr/Game.locres
* Content/Localization/Game/tr/Game_FromXLoc.po
* Content/Localization/Game/zh-Hans/Game_FromXLoc.po


# 7. ソースファイル

## 7.1. 更新情報に記載がある項目

### 7.1.1. `Release Notes` より

以下のリンクに説明がある更新内容です。
https://docs.unrealengine.com/5.3/ja/unreal-engine-5.3-release-notes/

>> アビリティシステムが使用されている場合に、 UAbilitySystemGlobals::InitGlobalData が呼び出されるようにしました。  
>> 以前は、ユーザがこれを呼び出さなかった場合、ゲームプレイアビリティシステムは正しく機能しませんでした。
> 
> 上記を受けて、 `UAbilitySystemGlobals::InitGlobalData` を呼び出す処理が削除されました。
* Source/LyraGame/System/LyraAssetManager.cpp
* Source/LyraGame/System/LyraAssetManager.h

### 7.1.2. `Lyra Starter Game を最新エンジン リリースにアップグレードする` より

以下のリンクに説明がある更新内容です。
https://docs.unrealengine.com/5.3/en-US/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine/

>> いくつかのオブジェクトポインタ変数が `TObjectPtr` を使用するように変更されました。
* Plugins/CommonUser/Source/CommonUser/Private/CommonSessionSubsystem.cpp
* Plugins/UIExtension/Source/Public/UIExtensionSystem.h
* Source/LyraGame/UI/IndicatorSystem/SActorCanvas.h

>> いくつかの C++ ラムダが更新され、安全でない使い方に関する警告が修正されました。
* Plugins/AsyncMixin/Source/Private/AsyncMixin.cpp
* Source/LyraGame/GameModes/LyraExperienceManagerComponent.cpp
* Source/LyraGame/Replays/AsyncAction_QueryReplays.cpp
* Source/LyraGame/Settings/LyraSettingsLocal.cpp
* Source/LyraGame/Teams/LyraTeamDisplayAsset.cpp

>> いくつかのヘッダインクルードが更新され、不要なパスが削除されました。
* Plugins/CommonUser/Source/CommonUser/Public/CommonUserSubsystem.h
* Plugins/CommonUser/Source/CommonUser/Public/CommonSessionSubsystem.h
* Plugins/GameplayMessageRouter/Source/GameplayMessageNodes/Public/K2Node_AsyncAction_ListenForGameplayMessages.h

>> Lyra は現在、実験的なクライアントリプレイサポートを含んでいます。  
>> リプレイをサポートしているプラットフォームでは、保存リプレイを設定メニューで有効にし、メインメニューから再生することができます。  
>> 保存されたリプレイには現在、いくつかの視覚効果と音響効果が欠けています。  
>> プラットフォームによっては、クライアントリプレイサポートをサポートしていない場合があります。
* Source/LyraGame/GameModes/LyraUserFacingExperienceDefinition.cpp
* Source/LyraGame/GameModes/LyraGameState.cpp
* Source/LyraGame/GameModes/LyraGameState.h
* Source/LyraGame/Player/LyraPlayerController.cpp
* Source/LyraGame/Player/LyraPlayerController.h
* Source/LyraGame/Replays/LyraReplaySubsystem.cpp
* Source/LyraGame/Replays/LyraReplaySubsystem.h
* Source/LyraGame/Settings/LyraGameSettingRegistry_Gameplay.cpp
* Source/LyraGame/Weapons/LyraWeaponSpawner.cpp

>> 共有ゲームプレイ設定は新しいエンジン LocalPlayerSaveGame クラスを継承し、プラットフォームへのログインが正常に完了するまでロードされません。
* Source/LyraGame/Player/LyraLocalPlayer.cpp
* Source/LyraGame/Player/LyraLocalPlayer.h
* Source/LyraGame/Settings/LyraSettingsShared.cpp
* Source/LyraGame/Settings/LyraSettingsShared.h
* Source/LyraGame/System/LyraGameInstance.cpp
* Source/LyraGame/System/LyraGameInstance.h

>> ShooterExplorer ゲーム機能プラグインは、オープンワールドと AI システムをテストする、いくつかの進行中の実験的なコンテンツを含みます。

ソースコードの変更はありません。

>> Lyra 固有の入力設定は、 enhanced input を扱うために更新されました。
* Source/LyraGame/Character/LyraHeroComponent.cpp
* Source/LyraGame/Character/LyraHeroComponent.h
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputConfig.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputConfig.h
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputContextMapping.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputContextMapping.h
* Source/LyraGame/Input/LyraInputComponent.cpp
* Source/LyraGame/Input/LyraMappableConfigPair.cpp
* Source/LyraGame/Input/LyraMappableConfigPair.h
* Source/LyraGame/Settings/CustomSettings/LyraSettingKeyboardInput.cpp
* Source/LyraGame/Settings/CustomSettings/LyraSettingKeyboardInput.h
* Source/LyraGame/Settings/Widgets/LyraSettingsListEntrySetting_KeyboardInput.cpp
* Source/LyraGame/Settings/Widgets/LyraSettingsListEntrySetting_KeyboardInput.h
* Source/LyraGame/Settings/LyraGameSettingRegistry_MouseAndKeyboard.cpp
* Source/LyraGame/Settings/LyraSettingsLocal.cpp
* Source/LyraGame/Settings/LyraSettingsLocal.h
* Source/LyraGame/Settings/LyraSettingsShared.cpp
* Source/LyraGame/Settings/LyraSettingsShared.h
* Source/LyraGame/UI/LyraSimulatedInputWidget.cpp
* Source/LyraGame/UI/LyraSimulatedInputWidget.h
* 以降は追加ファイル
* Source/LyraGame/Input/LyraInputUserSettings.cpp
* Source/LyraGame/Input/LyraInputUserSettings.h
* Source/LyraGame/Input/LyraPlayerMappableKeyProfile.cpp
* Source/LyraGame/Input/LyraPlayerMappableKeyProfile.h

>> マップに直接配置された NPC キャラクターのゲームプレイアビリティとカスタマイズされたキャラクターパーツの問題を修正しました。
* Source/LyraGame/Cosmetics/LyraPawnComponent_CharacterParts.cpp
* Source/LyraGame/Cosmetics/LyraPawnComponent_CharacterParts.h

>> SyncMarker 、 FootFX 、 FootstepEffectTag アニメーションモディファイアを更新しました。

ソースコードの変更はありません。

>> 隠れている間、タッチベースのジョイスティックが入力に影響するバグを修正しました。

未確認です。

>> リプレイテスト中に発見されたいくつかのネットワークのバグを修正しました。
* Plugins/CommonUser/Source/CommonUser/Private/CommonUserSubsystem.cpp
* Plugins/CommonUser/Source/CommonUser/Private/CommonSessionSubsystem.cpp

>> LyraHealthComponent のヘルスチェンジコールバックは、それが利用可能な場合、インスティゲータを含むようになりました。
* Source/LyraGame/Character/LyraHealthComponent.cpp
* Source/LyraGame/Character/LyraHealthComponent.h

## 7.2. 軽微な変更

### 7.2.1. DEPRECATED 関連

> * 使用していた `IsDataValid()` が DEPRECATED となったのでオーバーロードされている異なる引数の関数に変更されました。
* Source/LyraGame/AbilitySystem/Phases/LyraGamePhaseAbility.cpp
* Source/LyraGame/AbilitySystem/Phases/LyraGamePhaseAbility.h
* Source/LyraGame/Animation/LyraAnimInstance.cpp
* Source/LyraGame/Animation/LyraAnimInstance.h
* Source/LyraGame/Equipment/LyraGameplayAbility_FromEquipment.cpp
* Source/LyraGame/Equipment/LyraGameplayAbility_FromEquipment.h
* Source/LyraGame/GameFeatures/GameFeatureAction_AddAbilities.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddAbilities.h
* Source/LyraGame/GameFeatures/GameFeatureAction_AddGameplayCuePath.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddGameplayCuePath.h
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputBinding.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputBinding.h
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputConfig.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputConfig.h
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputContextMapping.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddInputContextMapping.h
* Source/LyraGame/GameFeatures/GameFeatureAction_AddWidget.cpp
* Source/LyraGame/GameFeatures/GameFeatureAction_AddWidget.h
* Source/LyraGame/GameModes/LyraExperienceActionSet.cpp
* Source/LyraGame/GameModes/LyraExperienceActionSet.h
* Source/LyraGame/GameModes/LyraExperienceDefinition.cpp
* Source/LyraGame/GameModes/LyraExperienceDefinition.h
* Source/LyraGame/Teams/LyraTeamCreationComponent.cpp
* Source/LyraGame/Teams/LyraTeamCreationComponent.h

> * ほぼ空の実装だった `PreProcessDownloadedFileData()` が DEPRECATED となったので削除されました。
* Source/LyraGame/Hotfix/LyraHotfixManager.cpp
* Source/LyraGame/Hotfix/LyraHotfixManager.h

> * 使用していた `IsValid()` が DEPRECATED となったので `IsInitialized()` に変更されました。
* Source/LyraGame/System/LyraAssetManager.cpp
* Source/LyraGame/System/LyraAssetManager.h

> * 使用していた `GetIfValid()` が DEPRECATED となったので `GetIfInitialized()` に変更されました。
* Source/LyraGame/System/LyraSystemStatics.cpp

> * 使用していた `NetServerMaxTickRate` が DEPRECATED となったので `GetNetServerMaxTickRate()` に変更されました。
* Source/LyraGame/System/LyraReplicationGraph.cpp

> * 使用しなくなるため、宣言していたクラスなどに DEPRECATED の指定を追加しました。
* Source/LyraGame/Input/LyraMappableConfigPair.cpp
* Source/LyraGame/Input/LyraMappableConfigPair.h


### 7.2.2. バリデーションチェック関連

> * バリデーションチェックの改善が行われました。
* Plugins/GameSettings/Source/Private/Widgets/GameSettingListEntry.cpp

> * リデーションチェックが追加されました。
* Source/LyraGame/Character/LyraCharacter.cpp
* Source/LyraGame/Cosmetics/LyraPawnComponent_CharacterParts.cpp
* Source/LyraGame/Cosmetics/LyraPawnComponent_CharacterParts.h

> * リプレイ対応の一環でバリデーションチェックが追加されました。
* Source/LyraGame/AbilitySystem/LyraAbilitySystemComponent.cpp


### 7.2.3. その他

> * 整形のみで挙動に係る変更はありません。
* Plugins/GameFeatures/TopDownArena/Source/TopDownArenaRuntime/Private/TopDownArenaPickupUIData.h

> * .cpp 内にあった `#pragma once` を削除しました。
* Plugins/GameFeatures/ShooterTests/Source/ShooterTestsRuntime/Private/ShooterTestsRuntimeModule.cpp

> * override している仮想関数のデフォルト引数が継承元と異なっていたのを合わせるように修正されました。
* Source/LyraGame/AbilitySystem/Abilities/LyraGameplayAbility.h

> * AttributeSet がガベージコレクトされないよう、保持するメンバ変数を追加し、設定するように変更されました。
* Source/LyraGame/Character/LyraCharacterWithAbilities.cpp
* Source/LyraGame/Character/LyraCharacterWithAbilities.h
* Source/LyraGame/Player/LyraPlayerState.cpp
* Source/LyraGame/Player/LyraPlayerState.h

> * オーバーライドした関数で基底の関数を呼び出していなかったのを呼び出すように変更されました。
* Source/LyraGame/Equipment/LyraEquipmentInstance.cpp
* Source/LyraGame/Inventory/LyraInventoryItemInstance.cpp

> * enum の基底の整数型を指定するように変更されました。
* Source/LyraGame/Feedback/ContextEffects/LyraContextEffectsInterface.h

> * オブジェクトの初期化順が調整されました。
* Source/LyraGame/Cosmetics/LyraPawnComponent_CharacterParts.cpp
* Source/LyraGame/Cosmetics/LyraPawnComponent_CharacterParts.h

> * 一部の ensure を使用していた箇所を if の条件判定に変更しました。
* Source/LyraGame/Cosmetics/LyraControllerComponent_CharacterParts.cpp


## 7.3. 大きめな変更

### 7.3.1. アトリビュート関連

> * アトリビュート変更時のデリゲートのパラメータが変更されました。  
> * 新しい値と古い値を渡すようになり、 EffectSpec については参照からポインタに変更されました。
* Source/LyraGame/AbilitySystem/Attributes/LyraAttributeSet.h
* Source/LyraGame/AbilitySystem/Attributes/LyraHealthSet.cpp
* Source/LyraGame/AbilitySystem/Attributes/LyraHealthSet.h

> * ヘルスと最大ヘルスの変更時のデリゲートの仕組みが追加されました。
* Source/LyraGame/AbilitySystem/Attributes/LyraHealthSet.cpp
* Source/LyraGame/AbilitySystem/Attributes/LyraHealthSet.h

> * アトリビュート変更時のデリゲートのパラメータが変更されました。  
> * 新しい値と古い値を渡すようになり、 EffectSpec については参照からポインタに変更されました。
> * ヘルスと最大ヘルスの変更時のデリゲートの仕組みが追加されました。
* Source/LyraGame/Character/LyraHealthComponent.cpp
* Source/LyraGame/Character/LyraHealthComponent.h

### 7.3.2. 観戦関連

> * 観戦実装に向けて、コードの一部が変更されました。
* Source/LyraGame/Character/LyraHeroComponent.cpp
* Source/LyraGame/Character/LyraHeroComponent.h

> * 観戦用に、ビューのローテーションをレプリケーションするように変更されました。
* Source/LyraGame/Player/LyraPlayerState.cpp
* Source/LyraGame/Player/LyraPlayerState.h

### 7.3.3. widget 関連

> * widget のキャンバスの投影領域の計算方法を改善しました。
* Source/LyraGame/UI/IndicatorSystem/IndicatorDescriptor.cpp

> * widget が可視状態のときのみ Tick 処理を行うように変更しました。
* Source/LyraGame/UI/LyraJoystickWidget.cpp


### 7.3.4. その他

> * `UCommonUserSubsystem::OnUserInitializeComplete` を使用するように変更しました。
* Plugins/CommonGame/Source/Private/CommonGameInstance.cpp
* Plugins/CommonGame/Source/Public/CommonGameInstance.h

> * `MutableView` を使用するように変更されました。
* Plugins/GameSettings/Source/Private/Widgets/GameSettingPanel.cpp

> **Note**  
> `MutableView` について  
> 5.3 で追加されたもののようです。  
> `Engine\Source\Runtime\CoreUObject\Public\UObject\ObjectPtr.h` より  
> ```c++
> /*
> 	MutableView: safely obtain temporary mutable access to a TObjectPtr's
> 							 underlying storage.
> 
> 	// Basic Usage:
> 
> 		void MutatingFunc(TArray<UObject*>& MutableArray);
> 
> 		TArray<TObjectPtr<UObject>> Array;
> 		MutatingFunc(Array);							 // unsafe; compile error
> 
> 		MutatingFunc(MutableView(Array));			 // ok; Array will safely "catch up" on TObjectPtr
> 																					 // semantics when MutatingFunc returns.
> 
> 		// it's generally preferable to pass references around (to avoid nullptr),
> 		// but for compat with existing functions that take a pointer:
> 
> 		void NeedsAPointer(TArray<UObject*>* MutableArrayPtr);
> 		NeedsAPointer(ToRawPtr(MutableView(Array)));
> 
> 	// Scoped Usage:
> 
> 		TObjectPtr<UObject> MyPtr;
> 		{
> 			auto MyScopedView = MutableView(MyPtr);
> 			UObject*& MyRawPtrRef = MyScopedView;									 // ok
> 
> 			UObject*& MyHardToFindBug = MutableView(MyPtr);				 // not ok
> 		}
> */
> ```

> * キー設定をデフォルトに戻す機能が追加されました。
* Source/LyraGame/Settings/Widgets/LyraSettingsListEntrySetting_KeyboardInput.cpp
* Source/LyraGame/Settings/Widgets/LyraSettingsListEntrySetting_KeyboardInput.h

> * チーム情報を取得する別の方法が追加されました。
* Source/LyraGame/Teams/LyraTeamSubsystem.cpp

### 7.3.5. Editor

> * `ShutdownModule()` の実装とそれに必要な処理や変数が追加されました。
* Source/LyraEditor/LyraEditor.cpp


# 8. 終わりに

公式ドキュメントでまとめられているとおり、新たに利用する機能が多く、その影響の修正もあちこちで発生しています。  
ゲーム部分の変更は少なめだと思います。
なにかの参考になれば幸いです。

-----
おしまい。

<!--- ページ内のリンク --->
[オーバービュー]: #1-オーバービュー
[ビルド関連]: #2-ビルド関連
[設定ファイル]: #3-設定ファイル
[アセット]: #4-uasset
[マップ]: #5-umap
[ローカライゼーション]: #6-ローカライゼーション
[ソースファイル]: #7-ソースファイル

<!--- 自前の画像へのリンク --->

<!--- generated --->
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.3 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra Starter Game を最新エンジン リリースにアップグレードする]: https://docs.unrealengine.com/5.3/ja/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine/
