# 【UE5】Lyra に学ぶ(08) Update5.1 <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
Unreal Engine 5.1 がリリースされたことで、 5.0 用と 5.1 用の2つのバージョンが存在するようになっています。  
このドキュメントはこれらの違いについてまとめたものですが、公式ドキュメントに詳しい解説があるので、そちらを見るのが一番良いです。
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Upgrading the Lyra Starter Game to the Latest Engine Release]
2022/12/05 時点で翻訳されていないため、こちらで翻訳したものにちょっとした追記をしてまとめています。  
元のドキュメントにあったリンクなどは省略していますので、詳しい情報は上記の公式ドキュメントを参照してください。  
また、追記している情報は .cpp/.h など、テキスト形式で比較可能なもののみとなっています。

* バージョン
	* [Lyra Starter Game]
		* 2022/11/29 版(5.0 用と 5.1 用の 2 種類)

# Index <!-- omit in toc -->

- [ドキュメントの翻訳版](#ドキュメントの翻訳版)
	- [Upgrading the Lyra Starter Game to the Latest Engine Release](#upgrading-the-lyra-starter-game-to-the-latest-engine-release)
	- [最新のエンジンリリースへのアップグレード](#最新のエンジンリリースへのアップグレード)
	- [Unreal Engine 5.1](#unreal-engine-51)
		- [Upgrade Notes for 5.1:](#upgrade-notes-for-51)
		- [Improvements in 5.1:](#improvements-in-51)
		- [Bug Fixes in 5.1:](#bug-fixes-in-51)
	- [Unreal Engine 5.0](#unreal-engine-50)
		- [Bug Fixes in 5.0.2:](#bug-fixes-in-502)
- [追記事項](#追記事項)
	- [IncludeOrderVersion の指定](#includeorderversion-の指定)
	- [UE\_INLINE\_GENERATED\_CPP\_BY\_NAME の利用](#ue_inline_generated_cpp_by_name-の利用)
	- [「 Iris 」 の利用](#-iris--の利用)
	- [「サブオブジェクトのレプリケーションの改善」 の利用](#サブオブジェクトのレプリケーションの改善-の利用)
	- [ウィジェットクラスでの SetVisibility() の呼び出し](#ウィジェットクラスでの-setvisibility-の呼び出し)
	- [LyraEditor の更新点](#lyraeditor-の更新点)
		- [細かな更新](#細かな更新)
	- [LyraGame の更新点](#lyragame-の更新点)
		- [LYRAGAME\_API の記述](#lyragame_api-の記述)
		- [細かな更新](#細かな更新-1)
	- [CommonUser プラグインの更新点](#commonuser-プラグインの更新点)
		- [細かな更新](#細かな更新-2)
	- [GameFeatures/ShooterCore プラグインの更新点](#gamefeaturesshootercore-プラグインの更新点)
		- [細かな更新](#細かな更新-3)
	- [GameSettings プラグインの更新点](#gamesettings-プラグインの更新点)
		- [細かな更新](#細かな更新-4)
- [終わりに](#終わりに)


# ドキュメントの翻訳版

このセクションは、公式ドキュメントの翻訳したものです。  
追記した部分は引用でくくっています。

## Upgrading the Lyra Starter Game to the Latest Engine Release

各エンジン バージョンの Lyra の主な変更点を説明し、既存のゲームをアップグレードして最新の Unreal Engine 5 を活用するのに役立つ情報が記載されています。

Lyra スターター ゲームは、Unreal Engine のメジャー リリースごとに更新されています。
このページでは、各エンジン バージョンの Lyra に加えられた主な変更点を説明し、既存のゲームを Unreal Engine 5 の最新リリースにアップグレードする際に役立つ情報を掲載しています。


## 最新のエンジンリリースへのアップグレード

C++ コードを含む Lyra のようなゲームは、Unreal engine の新しいメジャーリリースで正しく動作させるために、手動でのアップデートが必要になります。  
エンジンの 5.0.x から 5.1.x へのメジャー アップグレードでは、古い機能や設定が非推奨となり、プロジェクトで使用されている既存の関数や変数が変更される可能性があります。  
そのため、ゲーム固有のコードとデータの一部は、アップグレード後に正しく動作するように更新する必要があります。  

Lyra を例にとると、以下の手順でゲームを更新することができます:  

1. 新しいエンジンのバージョンのリリースノートを読み、ゲームに影響を与える可能性のある大きな変更点やアップグレードノートを確実に把握する必要があります。
1. 新しいバージョンのエンジンをダウンロードしてインストールします。(understanding-the-basics/installing-unreal-engine)  
   古いバージョンと新しいバージョンを比較できるように、現在のエンジン バージョンとは別のディレクトリにインストールした方がよいかもしれません。
1. エンジンの新バージョンと一致する Lyra Starter Game sample の新バージョンをダウンロードしてインストールし、どのように更新されたかを確認できるようにします。  
   これを別のディレクトリにインストールすれば、旧バージョンと比較することができます。
1. Unreal Engine 5 移行ガイド を参照し、最新バージョンのエンジンとの互換性を確認します。
1. C++ コードエディターでプロジェクトをロードし、コンパイルを試みます。これはおそらく失敗するでしょう。
1. 非推奨の警告が表示された場合は、非推奨のメッセージに含まれる手順を使用して修正します。
1. クラスや構造体が無効または見つからないというエラーについては、ファイルの先頭に新しい `#include` 行を追加する必要があります。  
   Visual Studio を使用している場合は、 **編集 > 検索と置換 > ファイルの検索** で、不足している型名を検索できます。  
   その型を定義しているヘッダーファイルを探して、新しい `#include`を追加します。
1. 仮想関数のオーバーライドに関するエラーの場合、ヘッダーファイルと `.cpp` ファイルの両方でオーバーライドされた関数のパラメータを更新する必要があります。
1. クラスや構造体の無効な変数に関するエラーは、その変数にアクセスするための別の方法を使用する必要があります。  
   これは通常、実際の値を返す `Get()` や `GetVariableName()` などのアクセッサ関数を呼び出すことで解決します。
1. エラーを修正する方法がわからない場合は、リリースノートを検索するか、コミュニティフォーラムで詳細を確認してください。

Lyra Starter Game の古いバージョンと新しいバージョンを比較することで、ソースコードへの複雑な変更をどのように扱うかを知ることができます。 
以下のバージョン固有の情報は、あなたのゲームに Lyra のコードやコンテンツが含まれている場合、それをアップグレードするのに役立つことでしょう。


## Unreal Engine 5.1

Unreal Engine 5.1 では、 Lyra Sample Game がアップデートされ、サンプルに関する問題の修正とエンジンに追加された最新機能の利用が可能になりました。

### Upgrade Notes for 5.1:

* いくつかのエンジンヘッダは、コンパイル時間を短縮するために再編成されました。  
  これは、 Lyra のソースファイルに関するいくつかの問題を露呈させました。  
  これらの問題は、ヘッダーに `#pragma once` 行を追加し、シンボルがないソースファイルに `#include EditorStyle.h` を追加することで修正することが可能です。
	> * `#include EditorStyle.h` を追加したファイルは存在しません。  
	> * `#pragma once` が追加されたのは 以下の 2 ファイルです。
	> 	* Source/LyraGame/Input/LyraInputModifiers.h
	> 	* Source/LyraGame/UI/LyraSettingScreen.h
* ゲームプレイフレームワーククラスのいくつかの生ポインタプロパティは、 `TObjectPtr` または `TWeakObjectPtr` を使用するように変更されました。  
  生ポインタを必要とするコードは、 `Get()` 関数への呼び出しを追加することで修正できます。
	> * `TWeakObjectPtr` を使用するように変更された箇所はありません。
	> * `TObjectPtr` を使用するように変更された箇所は 230 ほどあります。
* `ENSURE_ABILITY_IS_INSTANTIATED_OR_RETURN` マクロが `GameplayAbility.h` から削除されました。  
  このマクロは `GameplayAbility.cpp` から他のアビリティのソースコードファイルにコピーすることができます。
  > * `LyraGameplayAbility.cpp` 内に該当コードがコピペされています。
* ゲームフィーチャープラグインに関連するいくつかの仮想関数が修正され、新しいパラメータが追加されました。  
  `ULyraGameFeaturePolicy` などのクラスでオーバーライドされた関数は、更新する必要があります。
	> * 関連するクラスは以下のとおりです。
	> 	* `ULyraGameFeaturePolicy`
	> 		* 基底クラス `UDefaultGameFeaturesProjectPolicies` の仮想関数 `GetPreloadAssetListForGameFeature()` の引数が変更されたのでオーバーライド部分も変更されました。
	> 	* `ULyraGameFeature_HotfixManager`
	> 		*  基底クラス `IGameFeatureStateChangeObserver` の仮想関数 `OnGameFeatureLoading()` の引数が変更されたのでオーバーライド部分も変更されました。
	> 	* `ULyraGameFeature_AddGameplayCuePaths`
	> 		* 基底クラス `IGameFeatureStateChangeObserver` の仮想関数 `OnGameFeatureRegistering()` / `OnGameFeatureUnregistering()` の引数が変更されたのでオーバーライド部分も変更されました。
* ジオメトリメッシュブループリント `Tools/BakedGeneratedMeshSystem/BaseClasses/BakedGeneratedMeshActor` は 5.1 用に更新されました。  
  5.0 のアセットも引き続き機能しますが、5.1 バージョンを使用しないと Nanite 設定が正しく設定されません。

### Improvements in 5.1:

* `LyraHeroComponent` と `LyraPawnExtensionComponent` におけるポーン初期化フローは、新しい `IGameFrameworkInitStateInterface` と `GameFrameworkComponentManager` 上の Init State システムを使用するように書き換えられました。 
  これにより、ネットワークレプリケーションにおけるいくつかの競合状態が修正され、新しい機能に特化したコンポーネントで拡張することが容易になりました。
	> * 関連するクラスは以下のとおりです。
	> 	* `ULyraPawnComponent`
	> 		* 削除されました。
	> 	* `ULyraHeroComponent`
	> 		* 基底クラスが `ULyraPawnComponent` から `UPawnComponent` に変更されました。
	> 		* インターフェイス `IGameFrameworkInitStateInterface` も継承するように変更され、関連する処理も変更されました。
	> 	* `ULyraPawnExtensionComponent`
	> 		* 基底クラスが `ULyraPawnComponent` から `UPawnComponent` に変更されました。
	> 		* インターフェイス `IGameFrameworkInitStateInterface` も継承するように変更され、関連する処理も変更されました。
	> 			* その影響で以下のクラスがで呼び出す関数が変更されました。
	> 				* `ALyraPlayerState`
	> 					* `CheckPawnReadyToInitialize()` から `CheckDefaultInitialization()` に変更されました。
	> 				* `ULyraBotCreationComponent`
	> 					* `CheckPawnReadyToInitialize()` から `CheckDefaultInitialization()` に変更されました。
	> 				* `ULyraCheatManager`
	> 					* `IsPawnReadyToInitialize()` から `HasReachedInitState()` に変更されました。
	> 	* `UGameFeatureAction_AddInputConfig`
	> 		* 基底クラスが `UGameFeatureAction` から `UGameFeatureAction_WorldActionBase` に変更されました。
	> 			* これは `AddToWorld()` を使用するためです。
	> 		* `AddToWorld()` にて `UGameFrameworkComponentManager` のイベントに入力設定の登録と破棄を行う関数を登録し、外部から適切なタイミングで呼び出せるようにしています。
	> 	* `ULyraGameInstance`
	> 		* `UGameFrameworkComponentManager` を利用するコードが追加されました。
* 異なる機能を持つデバイスのための Android デバイスプロファイルを追加し、他のプラットフォーム設定を調整しました。
* エディタツールバーに一般的なマップをロードするためのUIを追加しました。
	> * ツールバーは `LyraEditor.cpp` で実装されています。
	> * 表示するマップのリストは `ULyraDeveloperSettings::CommonEditorMaps` で保持されています。
	> 	* このリストは *Editor Preferences > Lyra Starter Game - Lyra Developer Settings > Maps > Common Editor Maps* で設定可能です。
* Epic Online Services を使用したマルチプレイヤーゲームへの招待に関する基本的な処理を追加しました。
	> * Epic Online Services プラグインの更新による変更や追加がされています。
	> 	* 型名の変更の影響を受けています。
	> 		* `FOnlineAccountIdHandle` → `FAccountId` 
	> 		* `FOnlineLobbyIdHandle` → `FLobbyId` 
	> 		* `FLobbyVariant` → `FSchemaVariant` 
	> 		* `ELobbyComparisonOp` → `ESchemaAttributeComparisonOp` 
	> 	* 構造体の変数名の変更の影響を受けています。
	> 		* `FCreateLobby::Params::LocalUserId` → `FCreateLobby::Params::LocalAccountId` 
	> 		* `FCreateLobby::Params::SchemaName` → `FCreateLobby::Params::SchemaId` 
	> 	* 構造体の作りの（単純な置き換えでは済まない）変更の影響を受けています。
	> 		* `FCreateLobby::Params::LocalUsers` → `FCreateLobby::Params::UserAttributes` 
	> 	* 関連しているのは以下のクラスです。
	> 		* `UCommonUserInfo`
	> 		* `FCommonUserInitializeParams`
	> 		* `UCommonSessionSubsystem`
	> 			* プラグインの変更の影響を受けている箇所が多数あります。
	> * マルチプレイヤーゲームへの招待への対応
	> 	* `FOnlineResultInformation`
	> 		* 追加されました。
	> 		* オンライン関連のエラー発生時の情報を格納する構造体です。
	> 	* `ULyraFrontendStateComponent`
	> 		* 要求されたセッションへの参加に関する処理が追加されました。
	> 	* `UCommonGameInstance`
	> 		* セッションの招待に関するデリゲート用の関数やそこから呼ばれる関数が追加されました。
	> 			* `OnUserRequestedSession()`
	> 			* `SetRequestedSession()`
	> 			* `CanJoinRequestedSession()`
	> 			* `JoinRequestedSession()`
	> 			* `ResetGameAndJoinRequestedSession()`
	> 	* `UCommonSessionSubsystem`
	> 		* セッションの作成や招待に関する機能が追加されてます。
	> 		* 成否をデリゲートで通知できるようになっています。
* 新たなプラグイン ShooterExplorer と ShooterTest にプロトタイプとテスト用のコンテンツを追加しました。
	> * `ShooterExplorer`
	> 	* `ShooterMaps` 内に置かれていた InventoryTest 関連のコードやアセットからなります。
	> 		* 以下のフォルダのものが移動されました。
	> 			* `Plugins/GameFeatures/ShooterMaps/Content/PROTO/`
	> 			* `Plugins/GameFeatures/ShooterMaps/Content/System/Experiences/`
	> 	* 新規で追加されたコードやアセットはありません。
	> * `ShooterTests`
	> 	* `AFunctionalTest` を使用した動テスト用のファイルが置かれています。
	> 	* 詳しくは以下などを参照してください。
	> 		* [Unreal Engine 5.1 Documentation > コンテンツをテストおよび最適化する > 自動化システムの概要]
	> 		* [Unreal Engine 5.1 Documentation > コンテンツをテストおよび最適化する > 自動化システムの概要 > 機能テスト]
	> 		* [Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Developer > FunctionalTesting > AFunctionalTest]
* すでに割り当てられているキーをバインドする際に、警告画面を表示するように改善されました。
	> * 関連するクラスは以下のとおりです。
	> 	* `ULyraSettingsListEntrySetting_KeyboardInput`
	> 		* キーバインディングが競合していたときの処理が追加されました。
	> 		* `ULyraSettingsListEntrySetting_KeyboardInput::KeyAlreadyBoundWarningPanelClass` にて `UKeyAlreadyBoundWarning` を保持しています。
	> 	* `UKeyAlreadyBoundWarning`
	> 		* 追加されました。
	> 		* すでにキーがバインドされている際に表示するワーニングのテキストを扱うクラスです。
	> 	* `ULyraSettingKeyboardInput`
	> 		* `GetAllMappedActionsFromKey()` が追加されました。
	> 			* `ULyraSettingsListEntrySetting_KeyboardInput` にてキーバインディングが競合していないかのチェックに利用されています。


### Bug Fixes in 5.1:

* `LyraGame.Target.cs` の `ShouldEnableAllGameFeaturePlugins` 関数は `false` を返すように変更され、これはゲームフィーチャープラグインが通常のプラグインのように有効になることを意味します。 
  これにより、エンジンのカスタムコンパイル版とランチャーインストール版の両方で、プラグインが同じように動作するように修正されました。
	> * `LyraGame.Target.cs` の変更点について
	> 	* `ConfigureGameFeaturePlugins` 関数が変更されました。
	> 		* `ShouldEnableAllGameFeaturePlugins` の戻り値によりプラグインが無効になっているのか、それとも `uplugin` ファイルの設定により無効になっているのかで扱いが変わりました。
	> 		* 詳しくは `LyraGameTarget::ConfigureGameFeaturePlugins()` に追加された変数 `bForceDisabled` を参照してください。
* Lyra を実行すると、他のプロジェクトで Play In Editor を終了するためのキーバインドが変更される問題を修正しました。
	> * `ULyraEditorEngine::FirstTickSetup()` の該当コードが削除されました。
* アビリティが Health にネガティブモディファイアを適用する代わりに、 Healing と Damage のアトリビュートを適切に使用するように変更しました。
	> * `ULyraHealthSet`
	>	 * `Damage` アトリビュートが追加されました。
	> 		* Health を減らす際、一旦 `Damage` アトリビュートを介するように変更されました。
	> * `ULyraDamageExecution`
	> 	* ターゲットの Health アトリビュートのキャプチャを削除されました。
	> 		* Health 以上のダメージを与えない処理のためにキャプチャしていました。
	> 		* `ULyraHealthSet` 側で行うようにして、こちらでは行わないように変更されました。
	> * `ULyraHealExecution`
	> 	* モディファイアのアトリビュートの指定を Health から Healing に変更されました。
	> 	* 直接 Health の変更をかけていたのを Healing を介するように変更されました。
* 非推奨のコントローラ ID の代わりに、新しい PlatformUser と InputDeviceId タイプを使用するようにコードとブループリントを更新しました。
	> * [Unreal Engine 5.1 リリース ノート] より
	> 	> The use of an integer "Controller Id" to refer to both a logical user and a specific input device is being deprecated in favor of the new FPlatformUserId and FInputDeviceId types.
	> 	> 
	> 	> In 5.1 it is possible to convert between those types and the deprecated Controller Id, but this will not be available in a future version of UE when full support is added for multiple input devices under a single user.
	> 	> 
	> 	> ----
	> 	> 論理的なユーザーと特定の入力デバイスの両方を参照するための整数値 "Controller Id" の使用は、新しい FPlatformUserId および FInputDeviceId 型に取って代わられました。
	> 	> 
	> 	> 5.1 では、これらの型と非推奨の Controller Id との間で変換が可能ですが、UE の将来のバージョンでは、1 人のユーザーの下に複数の入力デバイスが存在するため、完全なサポートが追加される際には利用できなくなります。
	> * 以下のクラスが影響を受けています。
	> 	* `UCommonGameInstance`
	> 		* 基底クラス `UGameInstance` の変更により更新されました。
	> 			* `AddLocalPlayer()` が、引数が `FPlatformUserId` のものがオーバーロードされ、以前の引数が `Controller Id` のものが deprecated になりました。
	> 			* 引数が `FPlatformUserId`  のものをオーバーライドするように変更されました。
	> 	* `UAsyncAction_CommonUserInitialize`
	> 		* `InitializeForLocalPlay()` の引数が `FPlatformUserId` に変更されました。
	> 	* `UCommonUserSubsystem`
	> 		* 多くの関数が `FPlatformUserId` を使用するように変更されました。

## Unreal Engine 5.0

Lyra Sample Game の 5.0 バージョンは、オリジナルのリリースにあったいくつかのバグを修正するために 5.0.2 とともにアップデートされました。  
これらの修正は、それ以降のすべてのサンプルのリリースに含まれています。

### Bug Fixes in 5.0.2:

* 異なるインストールディレクトリを扱う自動化スクリプトを修正しました。
* マウスを反転させる設定を修正しました。
* マネキンのリターゲティングとコントロールリグのアセットを更新しました。
* モバイルデバイスプロファイルのアンチエイリアス設定を更新しました。
* 不足していたエディタアイコンを追加しました。

-----

# 追記事項

公式ドキュメントで言及されていない変更点について記載しておきます。

## IncludeOrderVersion の指定

* `*.Target.cs` にて、 IncludeOrderVersion の指定が追記されました。
	* [Unreal Engine 5.1 Documentation > プロダクション パイプラインをセットアップする > Unreal ビルド パイプライン > UnrealBuildTool > モジュールのプロパティ] より
		> IncludeOrderVersion (EngineIncludeOrderVersion)  
		> このモジュールのコンパイル時にどのバージョンのインクルード順序を使用するかを指定します。  
		> コマンドラインまたはモジュールのルールで -ForceIncludeOrder を使用してオーバーライドできます。  
* 以下のファイルが該当します。
	* `LyraClient.Target.cs`
	* `LyraEditor.Target.cs`
	* `LyraGame.Target.cs`
	* `LyraServer.Target.cs`

## UE_INLINE_GENERATED_CPP_BY_NAME の利用

* ほぼすべての .cpp/.h ファイルにて `UE_INLINE_GENERATED_CPP_BY_NAME ` マクロを利用するように更新されました。
* これはコンパイル時間改善のためのものです。
	* [Unreal Engine 5.1 リリース ノート] より
		> Added support to inline the generated cpp files into the module cpp files using a new macro UE_INLINE_GENERATED_CPP_BY_NAME.  
		> This improves compile times because less header parsing is required.  
		> 
		> ----
		> 新しいマクロ UE_INLINE_GENERATED_CPP_BY_NAME を使用して、生成された cpp ファイルをモジュール cpp ファイルにインライン化するサポートが追加されました。  
		> これにより、ヘッダーの解析が少なくなるため、コンパイル時間が改善されます。  
* 330 の .cpp ファイルの更新のうち、 285 ファイルがこの変更を含んでいます。

## 「 Iris 」 の利用

* いくつかのファイル内で、 「 Iris 」 関連のコードが追加されました。
	* [Unreal Engine 5.1 リリース ノート] より
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
		* `NetSerialize` の設定が追加されました。
	* ULyraEquipmentInstance
	* ULyraInventoryItemInstance
		* `RegisterReplicationFragments()` がそれにあたります。

## 「サブオブジェクトのレプリケーションの改善」 の利用

* いくつかのファイル内で、 「サブオブジェクトのレプリケーションの改善」 関連のコードが追加されました。
	* [Unreal Engine 5.1 リリース ノート] より
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
	* `AddReplicatedSubObject()`
	* `RemoveReplicatedSubObject()`
	* `IsUsingRegisteredSubObjectList()`
	* `IsReadyForReplication()`
	* `ReadyForReplication()`
* 具体的には以下のクラス関連です。
	* `ULyraEquipmentManagerComponent`
		* `ReadyForReplication()` のオーバーライドが追加されました。
		* `EquipItem()` / `UnequipItem()` 内で `AddReplicatedSubObject()` / `RemoveReplicatedSubObject()` の呼び出しが追加されました。
	* `ULyraInventoryManagerComponent`
		* `ReadyForReplication()` のオーバーライドが追加されました。
		* `AddItemDefinition()` / `AddItemInstance()` / `RemoveItemInstance()` に関連コードが追加されました。

## ウィジェットクラスでの SetVisibility() の呼び出し

* コンストラクタ内で `UWidget::Visibility` を書き換える際、直接代入していたのが `SetVisibility()` を利用するように変更されました。
* 具体的には以下のクラス関連です。
	* `ULyraBrightnessEditor`
	* `ULyraSafeZoneEditor`
	* `UIndicatorLayer`
	* `UCircumferenceMarkerWidget`
	* `UHitMarkerConfirmationWidget`
	* `UGameResponsivePanel`

## LyraEditor の更新点

### 細かな更新

* `UEditorValidator_MaterialFunctions`
	* `FAssetData::AssetClass` が deprecated になるため実装方法が変更されました。
		* `FAssetData::AssetClassPath` を使用するように変更されました。
* パスの扱い
	* 以下のクラスでパスの扱いに関するコードが変更されました。
		* `UContentValidationCommandlet`
		* `GDiffCollectionReferenceSupport`
		* `UEditorValidator`
	* 詳細はコードを参照してください。

## LyraGame の更新点

### LYRAGAME_API の記述

* いくつかのクラス定義時で `LYRAGAME_API` マクロを記述するように変更されました。
* 具体的には以下のクラスです。
	* `ULyraAbilityCost`
	* `ULyraGameplayAbility`
	* `ULyraAbilitySystemComponent`
	* `ALyraCharacter`
	* `ALyraCharacterWithAbilities`
	* `ULyraHeroComponent`
	* `ALyraPawn`
	* `ULyraPawnData`
	* `ULyraPawnExtensionComponent`
	* `ULyraInventoryItemFragment`
	* `ULyraInventoryManagerComponent`
	* `ALyraPlayerController`

### 細かな更新

* `LyraGameplayAbility.cpp`
	* `EndAbility()` がキャンセルで呼ばれた際、コールスタックを表示する処理が追加されました。
* `ULyraGameplayAbility_Reset`
	* `ActivateAbility()` で行われていた `ChangeActivationGroup(ELyraAbilityActivationGroup::Exclusive_Blocking)` の呼び出しがなくなりました。
* `ULyraGamePhaseSubsystem`
	* フェーズを切り替えるタグの判定式が変更されました。
		* 5.0「実行中のタグが入力されたタグにマッチせず、かつ、実行中のタグが入力されたタグの親タグにマッチする場合」
			* `ShooterGame.GamePhase.PostGame` が入力された場合
				* 実行中の `ShooterGame.GamePhase.Playing` は終了する。
				* 実行中の `ShooterGame.GamePhase` は終了 ***する*** 。※1
				* 実行中の `ShooterGame` は終了しない。
				* 実行中の `ShooterGame.GamePhase.PostGame` は終了しない。
				* 実行中の `ShooterGame.GamePhase.PostGame.Test` は終了 ***しない*** 。
			* ※1 親が実行中に子が実行されると親が止まる。（おそらく想定外）
		* 5.1「入力されたタグが実行中のタグにマッチしない場合」
			* `ShooterGame.GamePhase.PostGame` が入力された場合
				* 実行中の `ShooterGame.GamePhase.Playing` は終了する。
				* 実行中の `ShooterGame.GamePhase` は終了 ***しない*** 。
				* 実行中の `ShooterGame` は終了しない。
				* 実行中の `ShooterGame.GamePhase.PostGame` は終了しない。
				* 実行中の `ShooterGame.GamePhase.PostGame.Test` は終了 ***する*** 。※2
			* ※2 子が実行中に親が実行されると子が止まる。
				* そういう設計である（想定通りもしくはそういう使い方をしない）なら問題ない。
				* コメントを見る限り、そういう用途は想定されていないように見受けられる。
	* フェーズのタグに関するソース内のコメントは以下の通り。
		* `LyraGamePhaseSubsystem.cpp` ファイルのコメントより
			> So if the active phase currently matches the incoming phase tag, we allow it.  
			> i.e. multiple gameplay abilities can all be associated with the same phase tag.  
			> For example,  
			> You can be in the "Game.Playing" phase, and then start a sub-phase, like "Game.Playing.SuddenDeath".  
			> "Game.Playing" phase will still be active, and if someone were to push another one, like "Game.Playing.ActualSuddenDeath", it would end "Game.Playing.SuddenDeath" phase, but "Game.Playing" would continue.  
			> Similarly if we activated "Game.GameOver", all the "Game.Playing*" phases would end.  
			> 
			> ----
			> つまり、現在アクティブなフェーズが、入力されるフェーズタグと一致すれば、それを許可することになります。  
			> すなわち、複数のゲームプレイアビリティをすべて同じフェーズタグに関連付けることができます。  
			> たとえば、次のようになります。  
			> "Game.Playing" フェーズにいるときに、 "Game.Playing.SuddenDeath" のようなサブフェーズを開始することができます。  
			> "Game.Playing" フェーズはまだアクティブで、誰かが "Game.Playing.ActualSuddenDeath" のような別のフェーズをプッシュすると、 "Game.Playing.SuddenDeath" は終了しますが、 "Game.Playing" は続行されるでしょう。  
			> 同様に "Game.GameOver" を起動すると、すべての "Game.Playing*" のフェーズが終了します。
		* `LyraGamePhaseSubsystem.h` ファイルのコメントより
			> Subsystem for managing Lyra's game phases using gameplay tags in a nested manner, which allows parent and child phases to be active at the same time, but not sibling phases.  
			> 
			> Example:  
			> "Game.Playing" and "Game.Playing.WarmUp" can coexist, but "Game.Playing" and "Game.ShowingScore" cannot.  
			> When a new phase is started, any active phases that are not ancestors will be ended.  
			> 
			> Example:  
			> If "Game.Playing" and "Game.Playing.CaptureTheFlag" are active when "Game.Playing.PostGame" is started, "Game.Playing" will remain active, while "Game.Playing.CaptureTheFlag" will end.  
			> 
			> ----
			> ゲームプレイタグを用いたLyraのゲームフェーズを入れ子式に管理するためのサブシステムで、親フェーズと子フェーズを同時にアクティブにすることができるが、兄弟フェーズはできません。  
			> 
			> 例：  
			> "Game.Playing" と "Game.Playing.WarmUp" は共存可能だが、 "Game.Playing" と "Game.ShowingScore" は共存できない。  
			> 新しいフェーズが開始されると、祖で無いアクティブなフェーズは終了する。  
			> 
			> 例：  
			> "Game.Playing" と "Game.Playing.CaptureTheFlag" がアクティブな状態で "Game.Playing.PostGame" が開始されると、 "Game.Playing" はアクティブのまま、 "Game.Playing.CaptureTheFlag" が終了する。
* `FLyraAbilitySet_GrantedHandles`
	* 付与した `AttributeSet` の削除の際に使用していた `GetSpawnedAttributes_Mutable()` が deprecated になるため実装方法が変更されました。
* `ULyraAbilitySystemComponent`
	* `EndPlay()` 内で基底クラスの関数を呼び出すように変更されました。
* `ULyraGameplayCueManager`
	* `RefreshGameplayCuePrimaryAsset()` 内で `AddBundleAssets()` の呼び出しが `AddBundleAssetsTruncated()` を使うように変更されました。
* `ULyraCameraComponent`
	* `GetCameraView()` 内に `XR` 関連のコードが追加されました。
* `ULyraDeveloperSettings`
	* force feedback に関する設定が追加されました。
* `UGameFeatureAction_AddAbilities`
	* 付与した `AttributeSet` の削除の際に使用していた `GetSpawnedAttributes_Mutable()` が deprecated になるため実装方法が変更されました。
* `ULyraExperienceManagerComponent`
	* plugin の url 取得の際に使用していた `UGameFeaturesSubsystem::GetPluginURLForBuiltInPluginByName()` が deprecated になるため実装方法が変更されました。
		* `UGameFeaturesSubsystem::GetPluginURLByName()` を使用するように変更されました。
* `ALyraGameMode`
	* `GetPawnDataForController()`  が `BlueprintCallable` に変更されました。
		* 現状ではブループリントからは呼び出されていないようです。
* `ULyraHotfixManager`
	* `FConfigFile::CombineFromBuffer()` がオーバーロードされ、以前のものが deprecated になったため、新しい引数が増えた方を使用するように変更されました。
* `ULyraInputComponent`
	* `AddInputMappings()` で行っていた `UEnhancedInputLocalPlayerSubsystem::AddPlayerMappableConfig()` の呼び出しがなくなりました。
		* ただ、`RemoveInputMappings()` での `UEnhancedInputLocalPlayerSubsystem::RemovePlayerMappableConfig()` の呼び出しが残っているため非対称になってしまっています。
	* `AddInputConfig()` / `RemoveInputConfig()` は削除されました。
		* もともと `UEnhancedInputLocalPlayerSubsystem::AddPlayerMappableConfig()` / `UEnhancedInputLocalPlayerSubsystem::RemovePlayerMappableConfig()` の呼び出しを行ってただけなので、直接呼ぶように変更されました。
* `ULyraInputComboComponent`
	* 削除されました。
* `FLyraInputAction`
	* `InputAction` / `InputTag` が `BlueprintReadOnly` に変更されました。
* `ULyraInputConfig`
	* `FindNativeInputActionForTag()` / `FindAbilityInputActionForTag()` が `BlueprintCallable` に変更されました。
		* 現状ではブループリントからは呼び出されていないようです。
* `FMappableConfigPair`
	* `ActivatePair()` / `DeactivatePair()` が削除されました。
		* 入力関連の初期化のフローが変わり、不要になったようです。
* `UAbilityTask_GrantNearbyInteraction`
	* `OnDestroy()` が改善されました。
		* 処理の流れを、自身の破棄処理を先に行い、最後に基底クラスの関数を呼ぶように変更されました。
		* タイマー削除の際、事前に `GetWorld()` で有効な値が取れるかのチェックを行うように変更されました。
* `UAbilityTask_WaitForInteractableTargets_SingleLineTrace`
	* `OnDestroy()` が改善されました。
		* 処理の流れを、自身の破棄処理を先に行い、最後に基底クラスの関数を呼ぶように変更されました。
		* タイマー削除の際、事前に `GetWorld()` で有効な値が取れるかのチェックを行うように変更されました。
* `UPickupableStatics`
	* `GetIPickupableFromActorInfo()` の関数名が `GetFirstPickupableFromActor()` に変わり、引数の型も変更されました。
		* もともと *ActorInfo* と関数名についていますが受け取っていたのは `UGameplayAbility` でした。
		* また、受け取っていた `UGameplayAbility` も `AvatorActar` の取得にしか使っていませんでした。
		* そのあたりが整理されました。
	* `AddPickupInventory()` の関数名が `AddPickupToInventory()` に変更されました。
		* 合わせて引数も `Pickupable` から `Pickup` に変更されました。
		* 適切な関数名にリファクタリングされました。
* `ALyraPlayerController`
	* force feedback に関するコンソールコマンド用の変数が追加されました。
		* `UpdateForceFeedback()` にて利用しています。
* `ULyraSettingsLocal`
	* `ActivateInputConfig()` / `DeactivateInputConfig()` が削除されました。
		* 元は `FMappableConfigPair` から呼び出されていましたが、呼び出し元の関数が削除されました。
	* `GetAllMappingNamesFromKey()` が追加されました。
		* `ULyraSettingKeyboardInput` に追加された関数 `GetAllMappedActionsFromKey()` から呼び出されます。
	* `ResetKeybindingToDefault()` / `ResetKeybindingsToDefault()` が追加されました。
		* まだ呼び出されていはいないようです。
* `FindClassByShortName`
	* 型情報を取得する際、エンジンに追加された関数 `UClass::TryFindTypeSlow<>()` を使用するように変更されました。
* `ULyraGameInstance`
	* `UGameFrameworkComponentManager` を利用するコードが追加されました。
	* `CanJoinRequestedSession()` が追加されました。
		* 実装はまだ何もしていない状態です。
* `ULyraActionWidget`
	* 追加されました。
	* コントローラーやマウスのボタン等を UI の上に表示させるためのウィジェットです。
	* 表示させるには UI 上にこれを配置し、 `AssociatedInputAction` に関連付けたい InputAction を指定する必要があります。
		* 現状ではウィジェットに配置だけされているだけで、何も表示されません。

## CommonUser プラグインの更新点

### 細かな更新

* `UCommonUserSubsystem`
	* イベントハンドル `LoginStatusChangedHandle` や `ConnectionStatusChangedHandle` が追加されました。
		* `UE::Online::FOnlineEventDelegateHandle` を利用することで、破棄時に `Unbind` されるようになりました。

## GameFeatures/ShooterCore プラグインの更新点

### 細かな更新

* `UInputTriggerComboAction`
	* 削除されました。

## GameSettings プラグインの更新点

### 細かな更新

* `UGameSettingRegistry`
	* 設定が適用された時に実行する関数 `HandleSettingApplied()` と、その中で呼び出される仮想関数 `OnSettingApplied()` を持つようになりました。
* `UGameSetting`
	* 設定が適用された時に実行するイベント `OnSettingAppliedEvent` を持つようになり、 `Apply()` の中で呼び出すようにました。
* `UGameSettingListEntryBase`
	* 利用するインターフェイスが `IUserListEntry` から `IUserObjectListEntry` に変更されました。
		* `IUserListEntry` のコメント
			> Required interface for any UUserWidget class to be usable as entry widget in a UListViewBase  
			> Provides access to getters and events for changes to the status of the widget as an entry that represents an item in a list.  
			> @see UListViewBase @see ITypedUMGListView  
			> 
			> Note: To be usable as an entry for UListView, UTileView, or UTreeView, implement IUserObjectListEntry instead  
			> 
			> ----
			> UListViewBase のエントリウィジェットとして使用するための UUserWidget クラスの必須インタフェースです。  
			> リストのアイテムを表すエントリとしてのウィジェットのステータスを変更するためのゲッターとイベントへのアクセスを提供します。  
			> @see UListViewBase @see ITypedUMGListView  
			> 
			> 注意：UListView 、UTileView 、または UTreeView のためのエントリとして使用できるようにするには、代わりに IUserObjectListEntry を実装します。
		* `IUserObjectListEntry` のコメント
			> Required interface for any UUserWidget class to be usable as entry widget in a stock UMG list view - ListView, TileView, and TreeView  
			> Provides a change event and getter for the object item the entry is assigned to represent by the owning list view (in addition to functionality from IUserListEntry)  
			> 
			> ----
			> UUserWidget クラスが、 ListView 、 TileView 、 TreeView などの UMG リストビューのエントリウィジェットとして使用できるようにするために必要なインタフェースです。  
			> IUserListEntry の機能に加えて、リストビューでエントリが割り当てられたオブジェクトアイテムの変更イベントとゲッターを提供します。

# 終わりに

公式ドキュメントでまとめられている点以外は基本的に細かな修正が多く、提供されている Lyra をそのまま動かす分には挙動は殆ど変わっていないと思います。  
もし Lyra をベースにして独自の拡張を行っている場合、 `ULyraGameplayAbility_Reset` や `ULyraGamePhaseSubsystem` あたりの更新は影響を受けると思います。  
`UInputTriggerComboAction` についても Lyra では使用されていませんでしたが、独自に使用していた場合は以前のものを自前で追加するなどが必要になります。  

-----
おしまい。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Developer > FunctionalTesting > AFunctionalTest]: https://docs.unrealengine.com/5.1/en-US/API/Developer/FunctionalTesting/AFunctionalTest/
[Unreal Engine 5.1 Documentation > コンテンツをテストおよび最適化する > 自動化システムの概要]: https://docs.unrealengine.com/5.1/ja/automation-system-in-unreal-engine/
[Unreal Engine 5.1 Documentation > コンテンツをテストおよび最適化する > 自動化システムの概要 > 機能テスト]: https://docs.unrealengine.com/5.1/ja/functional-testing-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Upgrading the Lyra Starter Game to the Latest Engine Release]: https://docs.unrealengine.com/5.1/ja/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine/
[Unreal Engine 5.1 Documentation > プロダクション パイプラインをセットアップする > Unreal ビルド パイプライン > UnrealBuildTool > モジュールのプロパティ]: https://docs.unrealengine.com/5.1/ja/module-properties-in-unreal-engine/
[Unreal Engine 5.1 リリース ノート]: https://docs.unrealengine.com/5.1/ja/unreal-engine-5.1-release-notes/
