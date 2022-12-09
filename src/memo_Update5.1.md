# 【UE5】Lyra に学ぶ(08) Update5.1 <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
Unreal Engine 5.1 がリリースされたことで、 5.0 用と 5.1 用の2つのバージョンが存在するようになっています。
このドキュメントはこれらの違いについてまとめたものです。

* バージョン
	* [Lyra Starter Game]
		* 2022/11/29 版(5.0 用と 5.1 用の 2 種類)

# Index <!-- omit in toc -->

- [公式ドキュメント](#公式ドキュメント)
- [.cs ファイルについて](#cs-ファイルについて)
	- [\*.Target.cs の更新点](#targetcs-の更新点)
	- [LyraGame.Target.cs の更新点](#lyragametargetcs-の更新点)
- [.cpp/.h ファイルに全般について](#cpph-ファイルに全般について)
	- [UE\_INLINE\_GENERATED\_CPP\_BY\_NAME の利用](#ue_inline_generated_cpp_by_name-の利用)
	- [TObjectPtr の利用](#tobjectptr-の利用)
	- [「 Iris 」 の利用](#-iris--の利用)
	- [「サブオブジェクトのレプリケーションの改善」 の利用](#サブオブジェクトのレプリケーションの改善-の利用)
	- [ウィジェットクラスでの SetVisibility() の呼び出し](#ウィジェットクラスでの-setvisibility-の呼び出し)
- [LyraEditor の更新点](#lyraeditor-の更新点)
	- [.cpp/.h ファイル関連](#cpph-ファイル関連)
		- [LyraEditor.cpp](#lyraeditorcpp)
		- [UContentValidationCommandlet](#ucontentvalidationcommandlet)
		- [GDiffCollectionReferenceSupport](#gdiffcollectionreferencesupport)
		- [UEditorValidator](#ueditorvalidator)
		- [ULyraEditorEngine](#ulyraeditorengine)
		- [UEditorValidator\_MaterialFunctions](#ueditorvalidator_materialfunctions)
- [LyraGame の更新点](#lyragame-の更新点)
	- [.cpp/.h ファイル関連](#cpph-ファイル関連-1)
		- [LYRAGAME\_API の記述](#lyragame_api-の記述)
		- [入力関連の初期化処理](#入力関連の初期化処理)
		- [LyraGameplayAbility.cpp](#lyragameplayabilitycpp)
		- [ULyraGameplayAbility\_Reset](#ulyragameplayability_reset)
		- [ULyraHealthSet](#ulyrahealthset)
		- [ULyraDamageExecution](#ulyradamageexecution)
		- [ULyraHealExecution](#ulyrahealexecution)
		- [ULyraGamePhaseSubsystem](#ulyragamephasesubsystem)
		- [FLyraAbilitySet\_GrantedHandles](#flyraabilityset_grantedhandles)
		- [ULyraAbilitySystemComponent](#ulyraabilitysystemcomponent)
		- [ULyraGameplayCueManager](#ulyragameplaycuemanager)
		- [FLyraGameplayEffectContext](#flyragameplayeffectcontext)
		- [ULyraCameraComponent](#ulyracameracomponent)
		- [ULyraPawnComponent](#ulyrapawncomponent)
		- [ULyraHeroComponent](#ulyraherocomponent)
		- [ULyraPawnExtensionComponent](#ulyrapawnextensioncomponent)
		- [ULyraDeveloperSettings](#ulyradevelopersettings)
		- [ULyraEquipmentInstance](#ulyraequipmentinstance)
		- [ULyraEquipmentManagerComponent](#ulyraequipmentmanagercomponent)
		- [UGameFeatureAction\_AddAbilities](#ugamefeatureaction_addabilities)
		- [UGameFeatureAction\_AddInputConfig](#ugamefeatureaction_addinputconfig)
		- [ULyraGameFeaturePolicy](#ulyragamefeaturepolicy)
		- [ULyraGameFeature\_HotfixManager](#ulyragamefeature_hotfixmanager)
		- [ULyraGameFeature\_AddGameplayCuePaths](#ulyragamefeature_addgameplaycuepaths)
		- [ULyraBotCreationComponent](#ulyrabotcreationcomponent)
		- [ULyraExperienceManagerComponent](#ulyraexperiencemanagercomponent)
		- [ALyraGameMode](#alyragamemode)
		- [ULyraExperienceManagerComponent](#ulyraexperiencemanagercomponent-1)
		- [ULyraInputComponent](#ulyrainputcomponent)
		- [ULyraInputComboComponent](#ulyrainputcombocomponent)
		- [FLyraInputAction](#flyrainputaction)
		- [ULyraInputConfig](#ulyrainputconfig)
		- [FMappableConfigPair](#fmappableconfigpair)
		- [UAbilityTask\_GrantNearbyInteraction](#uabilitytask_grantnearbyinteraction)
		- [UAbilityTask\_WaitForInteractableTargets\_SingleLineTrace](#uabilitytask_waitforinteractabletargets_singlelinetrace)
		- [UPickupableStatics](#upickupablestatics)
		- [ULyraInventoryItemInstance](#ulyrainventoryiteminstance)
		- [ULyraInventoryManagerComponent](#ulyrainventorymanagercomponent)
		- [ULyraCheatManager](#ulyracheatmanager)
		- [ALyraPlayerController](#alyraplayercontroller)
		- [ALyraPlayerState](#alyraplayerstate)
		- [ULyraSettingKeyboardInput](#ulyrasettingkeyboardinput)
		- [ULyraSettingsListEntrySetting\_KeyboardInput](#ulyrasettingslistentrysetting_keyboardinput)
		- [ULyraSettingsLocal](#ulyrasettingslocal)
		- [FindClassByShortName](#findclassbyshortname)
		- [ULyraGameInstance](#ulyragameinstance)
		- [ULyraActionWidget](#ulyraactionwidget)
		- [ULyraFrontendStateComponent](#ulyrafrontendstatecomponent)
- [CommonGame プラグインの更新点](#commongame-プラグインの更新点)
	- [.cpp/.h ファイル関連](#cpph-ファイル関連-2)
		- [CommonUser プラグインの更新による影響](#commonuser-プラグインの更新による影響)
		- [UCommonGameInstance](#ucommongameinstance)
- [CommonUser プラグインの更新点](#commonuser-プラグインの更新点)
	- [.cpp/.h ファイル関連](#cpph-ファイル関連-3)
		- [Online Services プラグインの更新](#online-services-プラグインの更新)
		- [UCommonSessionSubsystem](#ucommonsessionsubsystem)
		- [UCommonUserSubsystem](#ucommonusersubsystem)
		- [FOnlineResultInformation](#fonlineresultinformation)
- [GameFeatures/ShooterCore プラグインの更新点](#gamefeaturesshootercore-プラグインの更新点)
	- [.cpp/.h ファイル関連](#cpph-ファイル関連-4)
		- [UInputTriggerComboAction](#uinputtriggercomboaction)
	- [.uasset ファイル関連](#uasset-ファイル関連)
		- [B\_ControlPointVolume](#b_controlpointvolume)
		- [B\_ControlPointScoring](#b_controlpointscoring)
		- [NS\_CapturePoint](#ns_capturepoint)
		- [NS\_CapturePointCounter](#ns_capturepointcounter)
		- [LAS\_ShooterGame\_SharedInput](#las_shootergame_sharedinput)
		- [GA\_AutoRespawn](#ga_autorespawn)
		- [B\_Hero\_ShooterMannequin](#b_hero_shootermannequin)
		- [WeaponAudioFunctions](#weaponaudiofunctions)
		- [W\_QuickBarSlot](#w_quickbarslot)
		- [B\_Grenade](#b_grenade)
		- [GE\_Damage\_Grenade](#ge_damage_grenade)
		- [W\_GrenadeCooldown](#w_grenadecooldown)
		- [GCN\_Weapon\_Pistol\_Fire](#gcn_weapon_pistol_fire)
		- [GCN\_Weapon\_Rifle\_Fire](#gcn_weapon_rifle_fire)
		- [GE\_Damage\_RifleAuto](#ge_damage_rifleauto)
		- [GE\_Damage\_Shotgun](#ge_damage_shotgun)
		- [GE\_Damage\_Melee](#ge_damage_melee)
		- [ShooterCore](#shootercore)
- [GameFeatures/ShooterExplorer の追加](#gamefeaturesshooterexplorer-の追加)
	- [.uasset ファイル関連](#uasset-ファイル関連-1)
- [GameFeatures/ShooterMaos の変更点](#gamefeaturesshootermaos-の変更点)
	- [.uasset ファイル関連](#uasset-ファイル関連-2)
- [GameFeatures/ShooterTests の追加](#gamefeaturesshootertests-の追加)
	- [.uasset ファイル関連](#uasset-ファイル関連-3)
- [GameFeatures/TopDownArena の変更点](#gamefeaturestopdownarena-の変更点)
	- [.uasset ファイル関連](#uasset-ファイル関連-4)
		- [NS\_BombExplosion.uasset](#ns_bombexplosionuasset)
		- [NS\_TopDownArenaPickupBomb.uasset](#ns_topdownarenapickupbombuasset)
		- [NS\_TopDownArenaPickupRange.uasset](#ns_topdownarenapickuprangeuasset)
		- [B\_TopDownArena\_GameComponent\_SpawnLocalPlayers.uasset](#b_topdownarena_gamecomponent_spawnlocalplayersuasset)
		- [B\_Hero\_Arena.uasset](#b_hero_arenauasset)
		- [L\_TopDown\_LocalMultiplayer.umap](#l_topdown_localmultiplayerumap)
		- [B\_TopDownArena\_Multiplayer\_Experience.uasset](#b_topdownarena_multiplayer_experienceuasset)
		- [DA\_TopDownArena\_Multiplayer.uasset](#da_topdownarena_multiplayeruasset)
- [GameSettings プラグインの更新点](#gamesettings-プラグインの更新点)
	- [.cpp/.h ファイル関連](#cpph-ファイル関連-5)
		- [UGameSettingRegistry](#ugamesettingregistry)
		- [UGameSetting](#ugamesetting)
		- [UKeyAlreadyBoundWarning](#ukeyalreadyboundwarning)
- [LyraExampleContent プラグインの更新点](#lyraexamplecontent-プラグインの更新点)
	- [.uasset ファイル関連](#uasset-ファイル関連-5)
		- [MF\_2DGrid](#mf_2dgrid)
- [終わりに](#終わりに)




TODO: 長いので色々まとめる。
TODO：TODOの処理
TODO: エディタ立ち上げ前にリポジトリの方にぶちこむ
TODO: エディタ立ち上げて色々確認する
TODO：その後、 Content 内の比較。





# 公式ドキュメント

* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Upgrading the Lyra Starter Game to the Latest Engine Release]
	* こちらにアップデートの情報がまとまっています。
	* まだ翻訳されていませんが、そんなに長くなく、要点もまとめられているので読みやすいです。










# .cs ファイルについて

## *.Target.cs の更新点

* IncludeOrderVersion の指定が追記されています。
	[Unreal Engine 5.1 Documentation > プロダクション パイプラインをセットアップする > Unreal ビルド パイプライン > UnrealBuildTool > モジュールのプロパティ] より  
	> IncludeOrderVersion (EngineIncludeOrderVersion)  
	> このモジュールのコンパイル時にどのバージョンのインクルード順序を使用するかを指定します。  
	> コマンドラインまたはモジュールのルールで -ForceIncludeOrder を使用してオーバーライドできます。  

## LyraGame.Target.cs の更新点

* `GameFeaturePlugin` に関するビルドスクリプトが更新されています。

# .cpp/.h ファイルに全般について

## UE_INLINE_GENERATED_CPP_BY_NAME の利用

* ほぼすべての .cpp/.h ファイルにて ```UE_INLINE_GENERATED_CPP_BY_NAME ``` マクロを利用するように更新されています。
	* これはコンパイル時間改善のためのものです。
	[Unreal Engine 5.1 リリース ノート] より  
	> Added support to inline the generated cpp files into the module cpp files using a new macro UE_INLINE_GENERATED_CPP_BY_NAME.  
	> This improves compile times because less header parsing is required.  
	> 
	> ----
	> 新しいマクロ UE_INLINE_GENERATED_CPP_BY_NAME を使用して、生成された cpp ファイルをモジュール cpp ファイルにインライン化するサポートが追加されました。  
	> これにより、ヘッダーの解析が少なくなるため、コンパイル時間が改善されます。  

## TObjectPtr の利用

* 様々なクラスで、メンバ変数の型が生ポインタだったものが ```TObjectPtr``` を使用するように変更されています。  

## 「 Iris 」 の利用

* いくつかのファイル内で、 「 Iris 」 関連のコードが追加されています。
	[Unreal Engine 5.1 リリース ノート] より  
	> Iris (実験的機能)  
	> Iris とは、Unreal Engine の新しいレプリケーション システムの実験的実装です。  
	> Iris の目標は、大規模でよりインタラクティブなワールドで、多数のプレイヤーとともにサーバーの負荷を削減して、リッチなマルチプレイヤー エクスペリエンスを実現することです。  
	> Iris は、次のとおり、現在のレプリケーション システムに対して、レプリケーション パフォーマンスの向上を実現します。
	> 
	> + コンストレイントがあるアンチパターンを除外することで、スケーラビリティの制限を解消
	> + レプリケーションとゲーム スレッド データの分離を通じて、同時並行性を実現
	> + 複数のオブジェクトとつながりに対してできる限り対象を共有することで、効率性を向上
	> 
	> Iris はオプトイン システムで、近い将来まで現在のレプリケーション システムと並存します。  
	> 既存のゲーム コードは、引き続きこれまでと同様に動作します。  
	> Iris にオプトインするには、ゲーム コードで新しいエンジン API を使用する必要がありますが、既存のレプリケートされたプロパティと Remote Procedure Call (RPC) 定義は、C++ とブループリントで互換性が確保されています。
* 具体的には以下のクラス関連です。
	* FLyraGameplayEffectContext
		* `NetSerialize` の設定が追加されています。
	* ULyraEquipmentInstance
	* ULyraInventoryItemInstance
		* ```RegisterReplicationFragments()``` がそれにあたります。


## 「サブオブジェクトのレプリケーションの改善」 の利用

* いくつかのファイル内で、 「サブオブジェクトのレプリケーションの改善」 関連のコードが追加されています。
	[Unreal Engine 5.1 リリース ノート] より  
	> サブオブジェクトのレプリケーションの改善  
	> Unreal Engine の Replicated Subobject には、UObject 派生クラスとそれらが含むレプリケートされたプロパティをレプリケートする方法が用意されています。  
	> コンポーネントとサブオブジェクトをレプリケートする以前のシステムは、仮想関数 AActor::ReplicateSubobjects を使用します。
	> 
	> 新しいシステムでは、アクタが、所有している アクタ や アクタ コンポーネント のリストにサブオブジェクトを登録するメソッドを持つようになり、それらの登録済みサブオブジェクトのレプリケーションはアクタ チャンネルによって自動的に処理されるようになっています。  
	> このプロセスでは、サブオブジェクトをレプリケートするタイミングと場所をさらに細かくコントロールできます。
	> 
	> Registered Subobject リストはオプトイン機能です。  
	> Registered Subobject リストを有効にするには、アクタまたはアクタ コンポーネント クラスで、プロパティを bReplicateUsingRegisteredSubObjectList = true に設定します。  
	> 次に AddReplicatedSubObject を、ReadyForReplication または BeginPlay で呼び出すか、新しいサブオブジェクトの作成時に呼び出します。  
	> 最後に、サブオブジェクトを変更または削除するときは必ず RemoveReplicatedSubObject を呼び出します。
	> 
	> 古いシステムはしばらくの間、新しいシステムと並存します。
	> Registered Subobject リストの有効化と新しいシステムでの作業の詳細については、「Registered Subobject」のドキュメントを参照してください。  
* 完全な対応というわけではなく、以下の関数を呼んでいる箇所もある、という状況のようです。
	* ```AddReplicatedSubObject()```
	* ```RemoveReplicatedSubObject()```
	* ```IsUsingRegisteredSubObjectList()```
	* ```IsReadyForReplication()```
	* ```ReadyForReplication()```
* 具体的には以下のクラス関連です。
	* `ULyraEquipmentManagerComponent`
	* `ULyraInventoryManagerComponent`

## ウィジェットクラスでの SetVisibility() の呼び出し

* コンストラクタ内で ```UWidget::Visibility``` を書き換える際、直接代入していたのが ```SetVisibility()``` を利用するように変更されました。
* 具体的には以下のクラス関連です。
	* ```ULyraBrightnessEditor```
	* ```ULyraSafeZoneEditor```
	* ```UIndicatorLayer```
	* ```UCircumferenceMarkerWidget```
	* ```UHitMarkerConfirmationWidget```
	* ```UGameResponsivePanel```

# LyraEditor の更新点

## .cpp/.h ファイル関連

### LyraEditor.cpp

* ツールバーに "Common Maps" の項目を追加するように変更されています。
TODO エディタで確認

### UContentValidationCommandlet

* ```GetAllPackagesOfType()``` の第一引数 ```OfTypeString``` の内容が `class path name` であるかのチェックを行うようになりました。

### GDiffCollectionReferenceSupport

* パスに関する情報を ```FNmae``` から ```FSoftObjectPath``` で扱うように変更されています。

### UEditorValidator

* パスに関する情報を ```FNmae``` から ```FTopLevelAssetPath``` で扱うように変更されています。

### ULyraEditorEngine

* PIE 実行時、 `Shift + Esc` で実行を停止する処理が追加されています。
TODO: 動作確認

### UEditorValidator_MaterialFunctions

* ```FAssetData::AssetClass``` が deprecated になるため実装方法が変更されました。
	* ```FAssetData::AssetClassPath``` を使用するように変更されています。


# LyraGame の更新点

## .cpp/.h ファイル関連

### LYRAGAME_API の記述

* いくつかのクラス定義時で `LYRAGAME_API` マクロを記述するように変更されています。

### 入力関連の初期化処理

* 以下のクラスが整理され、入力関連の初期化処理が変更されています。
	* ```ULyraHeroComponent```
	* ```ULyraInputComponent```
	* ```UGameFeatureAction_AddInputConfig```
* やっていることはだいたい変わっていませんが、リファクタリングにより処理が移動したような感じです。

### LyraGameplayAbility.cpp

* `GameplayAbility.cpp` で定義されている ```ENSURE_ABILITY_IS_INSTANTIATED_OR_RETURN``` マクロをこのソースにコピーするように変更されています。
	* これはもともと `GameplayAbility.h` で定義されていたマクロが `GameplayAbility.cpp` に移動され利用できなくなったためです。
* `EndAbility` がキャンセルで呼ばれた際、コールスタックを表示する機能が追加されています。

### ULyraGameplayAbility_Reset

* ```ActivateAbility()``` で行われていた ```ChangeActivationGroup(ELyraAbilityActivationGroup::Exclusive_Blocking)``` の呼び出しがなくなりました。
	* TODO: それはなに？
	* 多分ソースで無理やり変えるんじゃなくて、定義に従うようになったとかそんな漢字じゃないのかな

### ULyraHealthSet

* `Damage` アトリビュートの追加。
	* Health を減らす際、一旦 `Damage` アトリビュートを介するように変更されました。

### ULyraDamageExecution

* ターゲットの Health アトリビュートのキャプチャを削除。
	* Health 以上のダメージを与えない処理のためにキャプチャしていました。
	* `ULyraHealthSet` 側で行うようにして、こちらでは行わないように変更されました。

### ULyraHealExecution

* モディファイアのアトリビュートの指定を Health から Healing に変更。
	* 直接 Health の変更をかけていたのを Healing を解するように変更されました。

### ULyraGamePhaseSubsystem

* フェーズを切り替えるタグの判定式が変更されました。
	* 5.0「実行中のタグが入力されたタグにマッチせず、かつ、実行中のタグが入力されたタグの親タグにマッチする場合」
		* `ShooterGame.GamePhase.PostGame` が入力された場合
			* 実行中の `ShooterGame.GamePhase.Playing` は終了する。
			* 実行中の `ShooterGame.GamePhase` は終了 ***する*** 。
			* 実行中の `ShooterGame` は終了しない。
			* 実行中の `ShooterGame.GamePhase.PostGame` は終了しない。
			* 実行中の `ShooterGame.GamePhase.PostGame.Test` は終了 ***しない*** 。
		* 親が実行中に子が実行されると親が止まる。（おそらく間違い）
	* 5.1「入力されたタグが実行中のタグにマッチしない場合」
		* `ShooterGame.GamePhase.PostGame` が入力された場合
			* 実行中の `ShooterGame.GamePhase.Playing` は終了する。
			* 実行中の `ShooterGame.GamePhase` は終了 ***しない*** 。
			* 実行中の `ShooterGame` は終了しない。
			* 実行中の `ShooterGame.GamePhase.PostGame` は終了しない。
			* 実行中の `ShooterGame.GamePhase.PostGame.Test` は終了 ***する*** 。
		* 子が実行中に親が実行されると子が止まる。（そういう設計である（想定通りもしくはそういう使い方をしない）なら問題ない）

So if the active phase currently matches the incoming phase tag, we allow it.
i.e. multiple gameplay abilities can all be associated with the same phase tag.
For example,
You can be in the "Game.Playing" phase, and then start a sub-phase, like "Game.Playing.SuddenDeath".
"Game.Playing" phase will still be active, and if someone were to push another one, like "Game.Playing.ActualSuddenDeath", it would end "Game.Playing.SuddenDeath" phase, but "Game.Playing" would continue.  
Similarly if we activated "Game.GameOver", all the "Game.Playing*" phases would end.

Subsystem for managing Lyra's game phases using gameplay tags in a nested manner, which allows parent and child phases to be active at the same time, but not sibling phases.

Example:
"Game.Playing" and "Game.Playing.WarmUp" can coexist, but "Game.Playing" and "Game.ShowingScore" cannot. 
When a new phase is started, any active phases that are not ancestors will be ended.

Example:
If "Game.Playing" and "Game.Playing.CaptureTheFlag" are active when "Game.Playing.PostGame" is started, "Game.Playing" will remain active, while "Game.Playing.CaptureTheFlag" will end.


そのため、現在アクティブなフェイズが入力されるフェイズ・タグと一致する場合、それを許可する。
すなわち、複数のゲームプレイ能力をすべて同じフェイズ・タグに関連付けることができる。
たとえば、次のようになります。
"Game.Playing "フェーズにいるときに、"Game.Playing.SuddenDeath "のようなサブフェーズを開始することができる。
「Game.Playing」フェーズはまだアクティブで、誰かが「Game.Playing.ActualSuddenDeath」のような別のフェーズを押すと、「Game.Playing.SuddenDeath」は終了しますが、「Game.Playing」は続行されるでしょう。 
同様に「Game.GameOver」を起動すると、すべての「Game.Playing*」のフェーズが終了します。

ゲームプレイタグを用いたLyraのゲームフェイズを入れ子式に管理するためのサブシステムで、親フェイズと子フェイズを同時にアクティブにすることができるが、兄弟フェイズはできない。

例：「Game.Playing」と「Game.Playing.WarmUp」は共存可能だが、「Game.Playing」と「Game.ShowingScore」は共存できない。
新しいフェーズが開始されると、祖で無いアクティブなフェーズは終了する。

例：「Game.Playing」と「Game.Playing.CaptureTheFlag」がアクティブな状態で「Game.Playing.PostGame」が開始されると、「Game.Playing」はアクティブのまま、「Game.Playing.CaptureTheFlag」が終了します。

### FLyraAbilitySet_GrantedHandles

* 付与した `AttributeSet` の削除の際に使用していた ```GetSpawnedAttributes_Mutable()``` が deprecated になるため実装方法が変更されました。

### ULyraAbilitySystemComponent

* クラスの定義時、`LYRAGAME_API` が指定されました。
* ```EndPlay()``` 内で基底クラスの関数を呼び出すように変更されました。

### ULyraGameplayCueManager

* ```RefreshGameplayCuePrimaryAsset()``` 内で ```AddBundleAssets()``` の呼び出しが ```AddBundleAssetsTruncated()``` を使うように変更されました。

### FLyraGameplayEffectContext

* `NetSerialize` の設定が追加されています。
* 「 Iris 」 の利用

### ULyraCameraComponent

* ```GetCameraView()` 内に `XR` 関連のコードが追加されました。

### ULyraPawnComponent

* 削除されました。

### ULyraHeroComponent

* 基底クラスが ```ULyraPawnComponent``` から ```UPawnComponent``` に変更されました。
* インターフェイス ```IGameFrameworkInitStateInterface``` も継承するように変更されました。
	* その関係上か、半分ぐらいが書き換わっています。詳しくはコードを参照してください。
TODO コードを詳しく追わないとよくわからん。

### ULyraPawnExtensionComponent

* 基底クラスが ```ULyraPawnComponent``` から ```UPawnComponent``` に変更されました。
* インターフェイス ```IGameFrameworkInitStateInterface``` も継承するように変更されました。
	* その関係上か、半分ぐらいが書き換わっています。詳しくはコードを参照してください。
TODO コードを詳しく追わないとよくわからん。

### ULyraDeveloperSettings

* force feedback に関する設定が追加されました。
* エディタ時にアクセス可能な共通マップのリストが追加されました。

### ULyraEquipmentInstance

* レプリケーションに関する関数が追加されています。
	* 「 Iris 」 の利用
	* ```RegisterReplicationFragments()``` がそれにあたります。

### ULyraEquipmentManagerComponent

* 「サブオブジェクトのレプリケーションの改善」の利用（の準備？）がされています。
	* ```ReadyForReplication()``` をオーバーライドしています。
	* ```EquipItem()``` / ```UnequipItem()``` 内で ```AddReplicatedSubObject()``` / ```RemoveReplicatedSubObject()``` の呼び出しが追加されました。。

### UGameFeatureAction_AddAbilities

* 付与した `AttributeSet` の削除の際に使用していた ```GetSpawnedAttributes_Mutable()``` が deprecated になるため実装方法が変更されました。

### UGameFeatureAction_AddInputConfig

* 基底クラスが ```UGameFeatureAction``` から ```UGameFeatureAction_WorldActionBase``` に変更されました。
	* そうすることで ```AddToWorld()``` にて ```UGameFrameworkComponentManager``` のイベントに入力設定の登録と破棄を行う関数を登録し、外部から適切なタイミングで呼び出せるようにしています。

### ULyraGameFeaturePolicy

* 基底クラス ```UDefaultGameFeaturesProjectPolicies``` の仮想関数 ```GetPreloadAssetListForGameFeature()``` の引数が変更されたのでオーバーライド部分が修正されています。

### ULyraGameFeature_HotfixManager

* 基底クラス ```IGameFeatureStateChangeObserver``` の仮想関数 ```OnGameFeatureLoading()``` の引数が変更されたのでオーバーライド部分が修正されています。

### ULyraGameFeature_AddGameplayCuePaths

* 基底クラス ```IGameFeatureStateChangeObserver``` の仮想関数 ```OnGameFeatureRegistering()``` / ```OnGameFeatureUnregistering()``` の引数が変更されたのでオーバーライド部分が修正されています。

### ULyraBotCreationComponent

* ```ULyraPawnExtensionComponent``` の基底クラス変更による呼び出し関数の変更がされています。
	* ```CheckPawnReadyToInitialize()``` から ```CheckDefaultInitialization()``` に変更されています。

### ULyraExperienceManagerComponent

* plugin の url 取得の際に使用していた ```UGameFeaturesSubsystem::GetPluginURLForBuiltInPluginByName()``` が deprecated になるため実装方法が変更されました。
	* ```UGameFeaturesSubsystem::GetPluginURLByName()``` を使用するように変更されています。

### ALyraGameMode

* ```GetPawnDataForController()``` がブループリントから呼び出せるように変更されています。
TODO ue で検索して状況確認

### ULyraExperienceManagerComponent

* ```FConfigFile::CombineFromBuffer()``` が deprecated になるため引数が増えたバージョンを使用するように変更されています。

### ULyraInputComponent

* ```AddInputMappings()``` で行っていた ```UEnhancedInputLocalPlayerSubsystem::AddPlayerMappableConfig()``` の呼び出しがなくなりました。
	* ただ、```RemoveInputMappings()``` での ```UEnhancedInputLocalPlayerSubsystem::RemovePlayerMappableConfig()``` の呼び出しが残っているため非対称になってしまっています。
* ```AddInputConfig()``` / ```RemoveInputConfig()``` はなくなりました。
	* もともと ```UEnhancedInputLocalPlayerSubsystem::AddPlayerMappableConfig()``` / ```UEnhancedInputLocalPlayerSubsystem::RemovePlayerMappableConfig()``` の呼び出しを行ってただけなので、直接呼ぶように変更されました。

### ULyraInputComboComponent

* 削除されました。

### FLyraInputAction

* ```InputAction``` / ```InputTag``` が ```BlueprintReadOnly``` に変更されました。

### ULyraInputConfig

* ```FindNativeInputActionForTag()``` / ```FindAbilityInputActionForTag()``` が ```BlueprintCallable``` に変更されました。
	* TODO 呼び出し状況の確認

### FMappableConfigPair

* ```ActivatePair()``` / ```DeactivatePair()``` が削除されました。
	* 入力関連の初期化のフローが変わり、不要になったようです。

### UAbilityTask_GrantNearbyInteraction

* ```OnDestroy()``` が改善されました。
	* 処理の流れを、自身の破棄処理を先に行い、最後に基底クラスの関数を呼ぶように変更されています。
	* タイマー削除の際、事前に ```GetWorld()``` で有効な値が取れるかのチェックを行うように変更されています。

### UAbilityTask_WaitForInteractableTargets_SingleLineTrace

* ```OnDestroy()``` が改善されました。
	* 処理の流れを、自身の破棄処理を先に行い、最後に基底クラスの関数を呼ぶように変更されています。
	* タイマー削除の際、事前に ```GetWorld()``` で有効な値が取れるかのチェックを行うように変更されています。

### UPickupableStatics

* ```GetIPickupableFromActorInfo()``` の関数名が ```GetFirstPickupableFromActor()``` に変わり、引数の型も変更されています。
	* もともと *ActorInfo* と関数名についていますが受け取っていたのは ```UGameplayAbility``` でした。
	* また、受け取っていた ```UGameplayAbility``` も `AvatorActar` の取得にしか使っていませんでした。
	* そのあたりが整理されています。
* ```AddPickupInventory()``` の関数名が ```AddPickupToInventory()``` に変更されています。
	* 合わせて引数も ```Pickupable``` から ```Pickup``` に変更されています。
	* 適切な関数名にリファクタリングされています。

### ULyraInventoryItemInstance

* レプリケーションに関する関数が追加されています。
	* 「 Iris 」 の利用
	* ```RegisterReplicationFragments()``` がそれにあたります。

### ULyraInventoryManagerComponent

* アイテム追加、削除の関数内で「サブオブジェクトのレプリケーションの改善」の利用（の準備？）がされています。
	* ```ReadyForReplication()``` をオーバーライドしています。
	* ```AddItemDefinition()``` / ```AddItemInstance()``` / ```RemoveItemInstance()``` に関連コードが追加されています。

### ULyraCheatManager

* ```ULyraPawnExtensionComponent``` の基底クラス変更による呼び出し関数の変更がされています。
	* ```IsPawnReadyToInitialize()``` から ```HasReachedInitState()``` に変更されています。

### ALyraPlayerController

* force feedback に関するコンソールコマンド用の変数が追加されています。
	* ```UpdateForceFeedback()``` にて利用しています。

### ALyraPlayerState

* ```ULyraPawnExtensionComponent``` の基底クラス変更による呼び出し関数の変更がされています。
	* ```CheckPawnReadyToInitialize()``` から ```CheckDefaultInitialization()``` に変更されています。

### ULyraSettingKeyboardInput

* ```GetAllMappedActionsFromKey()``` が追加されています。
	* ```ULyraSettingsListEntrySetting_KeyboardInput``` にてキーバインディングが競合していないかのチェックに利用されています。

### ULyraSettingsListEntrySetting_KeyboardInput

* キーバインディングが競合していたときの処理が追加されています。

### ULyraSettingsLocal

* ```ActivateInputConfig()``` / ```DeactivateInputConfig()``` が削除されています。
	* 元は ```FMappableConfigPair``` から呼び出されていましたが、呼び出し元の関数が削除されました。
* ```GetAllMappingNamesFromKey()``` が追加されています。
	* ```ULyraSettingKeyboardInput``` に追加された関数 ```GetAllMappedActionsFromKey()``` から呼び出されます。
* ```ResetKeybindingToDefault()``` / ```ResetKeybindingsToDefault()``` が追加されています。
	* まだ呼び出されていはいないようです。

### FindClassByShortName

* 型情報を取得する際、エンジンに追加された関数 ```UClass::TryFindTypeSlow<>()``` を使用するように変更されています。

### ULyraGameInstance

* ```UGameFrameworkComponentManager``` を利用するコードが追加されています。
* ```CanJoinRequestedSession()``` が追加されています。
	* 実装はまだ何もしていない状態です。

### ULyraActionWidget

* 追加されています。
	TODO 内容確認。

### ULyraFrontendStateComponent

* 要求されたセッションへの参加に関する処理が追加されました。


# CommonGame プラグインの更新点

## .cpp/.h ファイル関連

### CommonUser プラグインの更新による影響

* 整数値 "Controller Id" を使用しないようにしている影響を受けています。
* セッションの招待に関するデリゲート用の関数やそこから呼ばれる関数が追加されています。
	* ```OnUserRequestedSession()```
	* ```SetRequestedSession()```
	* ```CanJoinRequestedSession()```
	* ```JoinRequestedSession()```
	* ```ResetGameAndJoinRequestedSession()```

### UCommonGameInstance

* ```Requested Session Flow``` に関する実装が追加されています。
* 基底クラス ```UGameInstance``` の変更による更新がされています。
	* ```AddLocalPlayer()``` の引数が変わり、以前のものが deprecated になり、引数の型が変わったものを使うように変更されています。

# CommonUser プラグインの更新点

## .cpp/.h ファイル関連

* 差分が多いです。

### Online Services プラグインの更新

* Online Services プラグインの更新による変更や追加がされているようです。
	* 型名のリファクタリングの影響を受けているようです。
		* ```FOnlineAccountIdHandle``` → ```FAccountId``` 
		* ```FOnlineLobbyIdHandle``` → ```FLobbyId``` 
		* ```FLobbyVariant``` → ```FSchemaVariant``` 
		* ```ELobbyComparisonOp``` → ```ESchemaAttributeComparisonOp``` 
	* 構造体の変数名のリファクタリングの影響を受けているようです。
		* ```FCreateLobby::Params::LocalUserId``` → ```FCreateLobby::Params::LocalAccountId``` 
		* ```FCreateLobby::Params::SchemaName``` → ```FCreateLobby::Params::SchemaId``` 
	* 構造体の作りが変わっている（単純な置き換えでは済まない）影響を受けているようです。
		* ```FCreateLobby::Params::LocalUsers``` → ```FCreateLobby::Params::UserAttributes``` 
	* 整数値 "Controller Id" を使用しないように更新されているようです。
		[Unreal Engine 5.1 リリース ノート] より  
		> The use of an integer "Controller Id" to refer to both a logical user and a specific input device is being deprecated in favor of the new FPlatformUserId and FInputDeviceId types.
		> 
		> In 5.1 it is possible to convert between those types and the deprecated Controller Id, but this will not be available in a future version of UE when full support is added for multiple input devices under a single user.
		> 
		> ----
		> 論理的なユーザーと特定の入力デバイスの両方を参照するための整数値 "Controller Id" の使用は、新しい FPlatformUserId および FInputDeviceId 型に取って代わられました。
		> 
		> 5.1 では、これらの型と非推奨のコントローラ ID との間で変換が可能ですが、UE の将来のバージョンでは、1 人のユーザーの下に複数の入力デバイスが存在するため、完全なサポートが追加される際には利用できなくなります。
* 関連しているのは以下のクラスです。
	* ```UCommonUserInfo```
	* ```FCommonUserInitializeParams```
	* ```UCommonUserSubsystem```
	* ```UCommonSessionSubsystem```

### UCommonSessionSubsystem

* Online Services プラグインの更新による変更や追加がされているようです。
	* プラグインの変更の影響を受けている箇所が多数あります。
* セッションの作成や招待に関する機能が追加されているようです。
	* 成否をデリゲートで通知できるようにしたようです。

### UCommonUserSubsystem

* Online Services プラグインの更新による変更や追加がされているようです。
	* ```LoginStatusChangedHandle``` や ```ConnectionStatusChangedHandle``` が追加されています。
	* プラグインの変更の影響を受けている箇所が多数あります。

### FOnlineResultInformation

* 追加されました。
* オンライン関連のエラー発生時の情報を格納する構造体です。


# GameFeatures/ShooterCore プラグインの更新点

## .cpp/.h ファイル関連

### UInputTriggerComboAction

* 削除されました。

## .uasset ファイル関連

### B_ControlPointVolume
### B_ControlPointScoring
### NS_CapturePoint
### NS_CapturePointCounter
### LAS_ShooterGame_SharedInput
### GA_AutoRespawn
### B_Hero_ShooterMannequin
### WeaponAudioFunctions
### W_QuickBarSlot
### B_Grenade
### GE_Damage_Grenade
### W_GrenadeCooldown
### GCN_Weapon_Pistol_Fire
### GCN_Weapon_Rifle_Fire
### GE_Damage_RifleAuto
### GE_Damage_Shotgun
### GE_Damage_Melee
### ShooterCore

TODO

# GameFeatures/ShooterExplorer の追加

* この GameFeature は新規で追加されています。
TODO

## .uasset ファイル関連

# GameFeatures/ShooterMaos の変更点

## .uasset ファイル関連

* マップが更新されています。
* InventoryTest 関連のコードが置かれていた以下のフォルダが削除されました。
	* `Content/PROTO`
	* `Content/System/Experiences`

# GameFeatures/ShooterTests の追加

* この GameFeature は新規で追加されています。
TODO

## .uasset ファイル関連


# GameFeatures/TopDownArena の変更点

## .uasset ファイル関連

### NS_BombExplosion.uasset
### NS_TopDownArenaPickupBomb.uasset
### NS_TopDownArenaPickupRange.uasset
### B_TopDownArena_GameComponent_SpawnLocalPlayers.uasset
追加
### B_Hero_Arena.uasset
### L_TopDown_LocalMultiplayer.umap
追加
### B_TopDownArena_Multiplayer_Experience.uasset
追加
### DA_TopDownArena_Multiplayer.uasset
追加


# GameSettings プラグインの更新点

## .cpp/.h ファイル関連

### UGameSettingRegistry

* 設定が適用された時に実行する関数 ```HandleSettingApplied()``` と、その中で呼び出される仮想関数 ```OnSettingApplied()``` を持つようになりました。

### UGameSetting

* 設定が適用された時に実行するイベント ```OnSettingAppliedEvent``` を持つようになり、 ```Apply()``` の中で呼び出すようにました。

### UKeyAlreadyBoundWarning

* 追加されました。
* すでにキーがバインドされている際に表示するワーニングのテキストを扱うクラスのようです。

# LyraExampleContent プラグインの更新点

## .uasset ファイル関連

### MF_2DGrid
TODO



# 終わりに


-----
おしまい。

<!--- ページ内のリンク --->
[Unreal Engine 5.1 リリース ノート]: https://docs.unrealengine.com/5.1/ja/unreal-engine-5.1-release-notes/
[Unreal Engine 5.1 Documentation > プロダクション パイプラインをセットアップする > Unreal ビルド パイプライン > UnrealBuildTool > モジュールのプロパティ]: https://docs.unrealengine.com/5.1/ja/module-properties-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Upgrading the Lyra Starter Game to the Latest Engine Release]: https://docs.unrealengine.com/5.1/ja/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine/

<!--- 自前の画像へのリンク --->

<!--- generated --->
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Upgrading the Lyra Starter Game to the Latest Engine Release]: https://docs.unrealengine.com/5.1/ja/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine/
[Unreal Engine 5.1 Documentation > プロダクション パイプラインをセットアップする > Unreal ビルド パイプライン > UnrealBuildTool > モジュールのプロパティ]: https://docs.unrealengine.com/5.1/ja/module-properties-in-unreal-engine/
[Unreal Engine 5.1 リリース ノート]: https://docs.unrealengine.com/5.1/ja/unreal-engine-5.1-release-notes/
