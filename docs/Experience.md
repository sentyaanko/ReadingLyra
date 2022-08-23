# 【UE5】Lyra に学ぶ基礎 <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
自作のアプリケーションのたたき台としても利用できるこのプロジェクトは UE の様々の機能を利用しています。  
このドキュメントは Lyra のゲームロジックを読み解くに当たって基礎となる機能について解説していきます。  
重点を置いているのはエクスペリエンスと呼ばれる仕組みに関する部分となります。

* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [Lyra で使用している UE の機能とその拡張](#lyra-で使用している-ue-の機能とその拡張)
	- [AssetManager に関して](#assetmanager-に関して)
	- [GameFeature に関して](#gamefeature-に関して)
	- [DataRegistry に関して](#dataregistry-に関して)
- [Lyra で独自実装してている仕組み](#lyra-で独自実装してている仕組み)
	- [Enhanced Input と GameFeature](#enhanced-input-と-gamefeature)
	- [エクスペリエンス と GameFeature](#エクスペリエンス-と-gamefeature)
	- [ULyraHeroComponent で設定できる FMappableConfigPair に関して](#ulyraherocomponent-で設定できる-fmappableconfigpair-に関して)
	- [プレイヤーが操作するアクターのについて](#プレイヤーが操作するアクターのについて)
- [終わりに](#終わりに)


# Lyra で使用している UE の機能とその拡張

## AssetManager に関して

GameFeature と絡む部分があります。設定方法は知っておくと良いです。

* 既存のドキュメント
	* [ドクセル > 2017/11/25 > UE4のモバイル開発におけるコンテンツアップデートの話　- Chunk IDとの激闘編 - > p34]
		* 設定方法についてわかりやすい解説
	* [Unreal Engine 5.0 Documentation > プロダクション パイプラインをセットアップする > アセット管理]
		* 公式ドキュメント。
	* [Qiita > (2019/08/15) > 【UE4】 Asset Managerのアセットの非同期ロード機能について その1 ( 非同期ロードの解説 & レベルの裏読み編 )]
	* [Qiita > (2019/12/21) > 【UE4】 Asset Managerのアセットの非同期ロード機能について その2 ( レベルアセット以外の裏読み編 )]
		* AssetManager に関するおかずさんの記事。主な話題は非同期ロードに関してなので、参考までに。
	* [historia > (2021/06/18) > 【UE5】 プレイヤーの技などをプラグインで実装できる！　GameFeaturesプラグインの紹介]
		* **古代の谷** での解説ですが、 GameFeature に関する大まかな説明があります。
* 概要
	* アセットを非同期で読むための仕組みです。
	* *Project Settings > Game - Asset Manager* にて設定を行います。
* GameFeature との関係
	* アセットのロードで使用されます。
	* [UGameFeatureData::PrimaryAssetTypesToScan] にて *Project Settings > Game - Asset Manager* と同様の設定を行います。

## GameFeature に関して

モジュール式に機能追加を可能にするための仕組みです。

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > Game Features と Modular Gameplay]
		* 概念を学べます。
		> Game Features プラグインおよび Modular Gameplay プラグインを使って、デベロッパーはプロジェクトにスタンドアローン機能を作成することができます。  
		> これらのプラグインを使用した機能を作成すると、プロジェクトのコードベースを明確で読み取りやすい状態に維持し、  
		> さらに無関係の機能同士の予期しないインタラクションや依存関係を回避するなど、複数のメリットがあります。  
		> これは、時間の経過とともに機能セットが変化するライブ製品を開発する場合に特に重要です。  
	* [Let's Enjoy Unreal Engine > (2021/11/28) > UE5 Game Featuresで簡単に依存関係なしのコンポーネントを作ってみる]
		* 使用する際の手順やサンプルがまとめられています。
	* [Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 40:56]
		* Game Feature Module でアビリティの追加を行っている説明
	* [Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]
		* Game Feature Module に関する説明。
	* [ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]
		* Game Features & Modular Gameplay という題で説明があります。
		* 時間が経っている(2022/04/11 現在)ので、ドクセル内のプレゼン資料から公式ドキュメントへのリンクは無くなっているものが多いので注意です。
			* `https://docs.unrealengine.com/5.0/ja/GameplayFeatures/` 以下はまるごと無いですし、「Game Features」等でドキュメントを検索してもほとんどデッドリンクです。
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]
		* 古代の谷のドキュメント内での説明。
* 概要
	* 「 GameFutures プラグイン」 と 「 Modular Gameplay プラグイン」 と 「 Modular Gameplay Actors プラグイン」 を利用した、独立した機能を実装する仕組みです。
* UE で用意されているクラス
	| Class                                 | 概要                                                                                                                                                                                                                        | Lyra                                                                                                                  |
	| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
	| [IGameFeatureStateChangeObserver]     | GameFeature 切り替えなどの際の処理をオーバーライドするための基底クラス。                                                                                                                                                    |                                                                                                                       |
	| [UGameFeaturesProjectPolicies]        | GameFeature 挙動を定義するための基底クラス。<br>*Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class* でこの派生クラスを指定する。                                                | [ULyraGameFeaturePolicy] を指定している。                                                                             |
	| [UDefaultGameFeaturesProjectPolicies] | [UGameFeaturesProjectPolicies] 派生クラス。<br>GameFeature のロード時等の挙動のデフォルト実装を定義している。                                                                                                               |                                                                                                                       |
	| [UGameFeatureAction]                  | GameFeature のアクティブ時等に実行されるアクションを定義するための基底クラス。                                                                                                                                              |                                                                                                                       |
	| [UGameFeatureAction_DataRegistry]     | [UGameFeatureAction] 派生クラス。<br>データ レジストリにデータを追加するアクションを定義している。                                                                                                                          |                                                                                                                       |
	| [UGameFeatureAction_AddComponents]    | [UGameFeatureAction] 派生クラス。<br>任意の対象にコンポーネントを追加するアクションを定義している。                                                                                                                         |                                                                                                                       |
	| [UGameFeatureData]                    | GameFeature に関する設定。<br>[UGameFeatureAction] の配列などを保持する。                                                                                                                                                   | * `ShooterCore` ([UGameFeatureData])<br>* `TopDownArena` ([UGameFeatureData])<br>* `ShooterMaps` ([UGameFeatureData]) |
	| [UGameFeaturesSubsystem]              | GameFeature を管理するクラス。<br>[UGameFeatureData] を元に [UGameFeatureAction] の関数を呼び出す。<br>*Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class* に基づいて動作する。 |                                                                                                                       |
* Lyra で実装しているクラス
	| Class                                       | 概要                                                                                                                                                                               |
	| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
	| [ULyraGameFeaturePolicy]                    | [UDefaultGameFeaturesProjectPolicies] 派生クラス。<br>Observers に [ULyraGameFeature_HotfixManager] / [ULyraGameFeature_AddGameplayCuePaths] を追加している。                      |
	| [ULyraGameFeature_HotfixManager]            | [IGameFeatureStateChangeObserver] 派生クラス。<br>[ULyraHotfixManager] を利用している。                                                                                            |
	| [ULyraGameFeature_AddGameplayCuePaths]      | [IGameFeatureStateChangeObserver] 派生クラス。<br>GameFeatureAction に [UGameFeatureAction_AddGameplayCuePath] が含まれていた場合に [ULyraGameplayCueManager] に情報を橋渡しする。 |
	| [UApplyFrontendPerfSettingsAction]          | [UGameFeatureAction] 派生クラス。<br>パフォーマンス設定に関するアクションを定義している。                                                                                          |
	| [UGameFeatureAction_SplitscreenConfig]      | [UGameFeatureAction] 派生クラス。<br>splitscreen の無効化を行うアクションを定義している。                                                                                          |
	| [UGameFeatureAction_AddInputBinding]        | [UGameFeatureAction] 派生クラス。<br>入力バインドの追加を行うアクションを定義している。                                                                                            |
	| [UGameFeatureAction_AddInputContextMapping] | [UGameFeatureAction] 派生クラス。<br>入力マッピングコンテキストの追加を行うアクションを定義している。                                                                              |
	| [UGameFeatureAction_AddInputConfig]         | [UGameFeatureAction] 派生クラス。<br>入力設定の追加を行うアクションを定義している。                                                                                                |
	| [UGameFeatureAction_AddAbilities]           | [UGameFeatureAction] 派生クラス。<br>アビリティの追加を行うアクションを定義している。                                                                                              |
	| [UGameFeatureAction_AddWidgets]             | [UGameFeatureAction] 派生クラス。<br>widget の追加を行うアクションを定義している。                                                                                                 |
	| [UGameFeatureAction_AddGameplayCuePath]     | [UGameFeatureAction] 派生クラス。<br>GameplayCue の検索パスの追加を行うアクションを定義している。                                                                                  |
	| [ULyraExperienceActionSet]                  | エクスペリエンスで利用される GameFeatureAction のセット。                                                                                                                          |
	| [ULyraExperienceDefinition]                 | エクスペリエンスの定義。                                                                                                                                                           |


## DataRegistry に関して

アセットを読み込むための仕組みで、 GameFeature のアセット読み込みでも使用しています。

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]
		* データレジストリの概念について学べます。
	* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ >  データ レジストリのクイック スタート ガイド]
		* プラグインの導入方法やデータレジストリアセットの作成方法が書かれています。
* 概要
	* データレジストリアセットの非同期読み込みを行うための仕組み。
* UE で用意されているクラス
	* [UDataRegistrySubsystem]
		* データレジストリを扱うマネージャクラスです。
	* [UGameFeatureAction_DataRegistry]
		* GameFeature と連動してデータレジストリにデータを追加するクラスです。
		* 内部で [UDataRegistrySubsystem] を使用している。
* Lyra での使われ方
	* [UGameFeatureAction_DataRegistry] の使用
		* `ShooterCore` ([UGameFeatureData]) で `AccoladeDataRegistry` ([UDataRegistry] / [FLyraAccoladeDefinitionRow]) を追加しています。
	* [UDataRegistrySubsystem] の使用
		* [ULyraAccoladeHostWidget::OnNotificationMessage()] 内で [UDataRegistrySubsystem::AcquireItem()] を使用し、 `AccoladeDataRegistry` ([UDataRegistry] / [FLyraAccoladeDefinitionRow]) のデータを参照しています。
		* これは Accolade 発生時に使用する演出のアセットへのソフトリファレンスを取得するのに利用しています。


# Lyra で独自実装してている仕組み

## Enhanced Input と GameFeature

Lyra では、入力をモジュール式に扱うために、 Enhanced Input と GameFeature を組み合わせて利用しています。

* 既存のドキュメント
	* [ReadingLyra > 【UE5】Lyra に学ぶ Enhanced Input]
		* Enhanced Input 自体についてはこちらを参照してください。
* 概要
	* GameFeatureAction を利用し、入力バインディングと入力マッピングコンテキストの追加をフィーチャーの適用時に行えるようにしています。
* Lyra で実装しているクラス
	* [UGameFeatureAction_AddInputBinding]
		* 入力バインディングの追加を行う GameFeatureAction
	* [UGameFeatureAction_AddInputContextMapping]
		* 入力マッピングコンテキストの追加を行う GameFeatureAction


## エクスペリエンス と GameFeature

Lyra ではエクスペリエンスという独自の単位で GameFeature の適用を行う仕組みを実装しています。

* 概要
	* 各レベルの WorldSettings で [ULyraExperienceDefinition] を指定することで、そのレベルで適用するエクスペリエンスを指定しています。
	* エクスペリエンスでは以下を指定できます。
		* 有効にする GameFeatrure
		* 実行する GameFeatureAction
		* Player に使用するポーン情報
* UE で用意されているクラス
	* [UGameFeatureAction]
		* GameFeature のアクティブ時等に実行されるアクションを定義するための基底クラスです。
	* [UGameFeatureData]
		* GameFeature に関する設定。
	* [UGameFeaturesSubsystem]
		* GameFeature の管理を行うサブシステム。
* Lyra で実装しているクラス
	* [ULyraExperienceActionSet]
		* エクスペリエンスで利用される GameFeatureAction のセット。
		* [ULyraExperienceDefinition] から参照される。
	* [ULyraExperienceDefinition]
		* エクスペリエンスの定義。
	* [ALyraWorldSettings]
		* マップの WorldSettings で [ULyraExperienceDefinition] を指定できるように拡張した `AWorldSettings` 派生クラスです。
		* この値は [ALyraGameMode] で参照される。詳しくは以下の関数を参照。
			* [ALyraGameMode::InitGame()]
			* [ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]
	* [ULyraExperienceManagerComponent]
		* [ULyraExperienceDefinition] のロード等を行うコンポーネント。
		* [ALyraGameState] に追加されている。
		* [UGameFeaturesSubsystem] の機能を利用している。
	* [ULyraGameFeaturePolicy]
		* GameFeature のロード時などの挙動を扱う。
			* HotFix に関する処理と、 GameplayCue のパスに関する処理を行うクラスをオブザーバとして登録・解除している。
		* *Project Settings > Game - Game Features > Default Classes > Game Feature Project Policy Class* でこのクラスを指定している。
		* [UGameFeaturesSubsystem] の機能を利用している。


## ULyraHeroComponent で設定できる FMappableConfigPair に関して

[ULyraHeroComponent] は [FMappableConfigPair] をメンバとして持っており、入力設定の初期情報を設定可能です。  
ただし、使われ方が限定的となっています。

* 概要
	* [ULyraHeroComponent::DefaultInputConfigs] は GameFeature を使用できない場合に変わりに使用する項目。
	* 使用可能であるならば [UGameFeatureAction_AddInputConfig] 経由で設定したほうがモジュール式で扱える為好ましい。
	* 詳しくは [ULyraHeroComponent::DefaultInputConfigs] を参照。
* 実際の利用状況は以下のみ。
	* `B_SimpleHeroPawn` ([ALyraCharacter])
		* 以下が設定されている。
			* `PMI_Default_Gamepad` ([UPlayerMappableInputConfig])
			* `PMI_Default_KBM` ([UPlayerMappableInputConfig])
		* このクラスは `L_DefaultEditorOverview` のプレイヤーポーンとして設定されている。
		* 開発用のマップであるため、 GameFeature を使用せずに [ULyraHeroComponent::DefaultInputConfigs] を使用しているものと思われる。


## プレイヤーが操作するアクターのについて

Lyra ではプレイヤーが操作するアクターはエクスペリエンスの設定に従うようにように実装されており、レベル毎に異なるアクターが利用可能です。

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > Lyra キャラクターを初期化する方法]
		* キャラクターの初期化フローに関する解説があります。
* 概要
	* プレイヤーが操作するポーンの情報として、ポーンクラス以外に、キャラクターに付与するアビリティ、入力設定などが含まれています。
	* その結果、モジュール式にアビリティや入力設定を割り当てられるようになっています。
* Lyra で実装しているクラス
	* [ULyraPawnData]
		* プレイヤーのポーンに関する設定を保持するデータアセット。
		* 具体的にはポーンクラスと、以下の4つのクラスを保持します。
			* [ULyraAbilitySet]
				* アビリティに関する情報を保持するデータアセット。
				* 具体的には GameplayAbility 、 GameplayEffect 、 AttributeSet を保持します。
			* [ULyraAbilityTagRelationshipMapping]
				* タグリレーションマッピングを保持するデータアセット。
				* 詳しくは後述します。
			* [ULyraInputConfig]
				* InputAction と InputTag を紐づけるためのデータアセット。
				* 詳しくは [ReadingLyra > 【UE5】Lyra に学ぶ Enhanced Input] / [ReadingLyra > 【UE5】Lyra に学ぶ 入力処理用 GameplayTag(InputTag)] を参照してください。
			* [ULyraCameraMode]
				* カメラの設定用のデータ専用ブループリント。
	* [ULyraExperienceDefinition]
		* エクスペリエンスの定義を保持するデータアセット。
		* 利用する [ULyraPawnData] を保持しています。

# 終わりに

Lyra では実装の広い部分をモジュール式に扱えるようにしており、 Game Feature もしくはエクスペリエンスと関係しているものが非常に多いです。  
すべてをまとめきれてはいないドキュメントですが、どなたかの参考になれば幸いです。


-----
おしまい。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ReadingLyra > 【UE5】Lyra に学ぶ Enhanced Input]: ./EnhancedInput.md
[ReadingLyra > 【UE5】Lyra に学ぶ 入力処理用 GameplayTag(InputTag)]: ./InputTag.md
[ULyraCameraMode]: CodeRefs/Lyra/Etc/ULyraCameraMode.md#ulyracameramode
[ALyraWorldSettings]: CodeRefs/Lyra/Experience/ALyraWorldSettings.md#alyraworldsettings
[ULyraExperienceActionSet]: CodeRefs/Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: CodeRefs/Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceManagerComponent]: CodeRefs/Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[FMappableConfigPair]: CodeRefs/Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpair
[UApplyFrontendPerfSettingsAction]: CodeRefs/Lyra/GameFeature/UApplyFrontendPerfSettingsAction.md#uapplyfrontendperfsettingsaction
[UGameFeatureAction_AddAbilities]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureaction_addabilities
[UGameFeatureAction_AddGameplayCuePath]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddGameplayCuePath.md#ugamefeatureaction_addgameplaycuepath
[UGameFeatureAction_AddInputBinding]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md#ugamefeatureaction_addinputbinding
[UGameFeatureAction_AddInputConfig]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfig
[UGameFeatureAction_AddInputContextMapping]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureaction_addinputcontextmapping
[UGameFeatureAction_AddWidgets]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddWidgets.md#ugamefeatureaction_addwidgets
[UGameFeatureAction_SplitscreenConfig]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_SplitscreenConfig.md#ugamefeatureaction_splitscreenconfig
[ULyraGameFeaturePolicy]: CodeRefs/Lyra/GameFeature/ULyraGameFeaturePolicy.md#ulyragamefeaturepolicy
[ULyraGameFeature_AddGameplayCuePaths]: CodeRefs/Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeature_addgameplaycuepaths
[ULyraGameFeature_HotfixManager]: CodeRefs/Lyra/GameFeature/ULyraGameFeature_HotfixManager.md#ulyragamefeature_hotfixmanager
[ULyraAbilitySet]: CodeRefs/Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraAbilityTagRelationshipMapping]: CodeRefs/Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraHeroComponent]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponent
[ULyraHeroComponent::DefaultInputConfigs]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentdefaultinputconfigs
[ULyraGameplayCueManager]: CodeRefs/Lyra/GameplayCue/ULyraGameplayCueManager.md#ulyragameplaycuemanager
[ALyraCharacter]: CodeRefs/Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ALyraGameMode]: CodeRefs/Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraGameMode::InitGame()]: CodeRefs/Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodeinitgame
[ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]: CodeRefs/Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodehandlematchassignmentifnotexpectingone
[ALyraGameState]: CodeRefs/Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[FLyraAccoladeDefinitionRow]: CodeRefs/Lyra/GameplayMessageAccolade/FLyraAccoladeDefinitionRow.md#flyraaccoladedefinitionrow
[ULyraAccoladeHostWidget::OnNotificationMessage()]: CodeRefs/Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidgetonnotificationmessage
[ULyraHotfixManager]: CodeRefs/Lyra/HotfixManager/ULyraHotfixManager.md#ulyrahotfixmanager
[ULyraInputConfig]: CodeRefs/Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[ULyraPawnData]: CodeRefs/Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[UDataRegistry]: CodeRefs/UE/DataRegistry/UDataRegistry.md#udataregistry
[UDataRegistrySubsystem]: CodeRefs/UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystem
[UDataRegistrySubsystem::AcquireItem()]: CodeRefs/UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystemacquireitem
[IGameFeatureStateChangeObserver]: CodeRefs/UE/GameFeature/IGameFeatureStateChangeObserver.md#igamefeaturestatechangeobserver
[UDefaultGameFeaturesProjectPolicies]: CodeRefs/UE/GameFeature/UDefaultGameFeaturesProjectPolicies.md#udefaultgamefeaturesprojectpolicies
[UGameFeatureAction]: CodeRefs/UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
[UGameFeatureAction_AddComponents]: CodeRefs/UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
[UGameFeatureAction_DataRegistry]: CodeRefs/UE/GameFeature/UGameFeatureAction_DataRegistry.md#ugamefeatureaction_dataregistry
[UGameFeatureData]: CodeRefs/UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UGameFeatureData::PrimaryAssetTypesToScan]: CodeRefs/UE/GameFeature/UGameFeatureData.md#ugamefeaturedataprimaryassettypestoscan
[UGameFeaturesProjectPolicies]: CodeRefs/UE/GameFeature/UGameFeaturesProjectPolicies.md#ugamefeaturesprojectpolicies
[UGameFeaturesSubsystem]: CodeRefs/UE/GameFeature/UGameFeaturesSubsystem.md#ugamefeaturessubsystem
[UPlayerMappableInputConfig]: CodeRefs/UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
[historia > (2021/06/18) > 【UE5】 プレイヤーの技などをプラグインで実装できる！　GameFeaturesプラグインの紹介]: https://historia.co.jp/archives/21145/
[Let's Enjoy Unreal Engine > (2021/11/28) > UE5 Game Featuresで簡単に依存関係なしのコンポーネントを作ってみる]: https://unrealengine.hatenablog.com/entry/2021/11/28/111821
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Qiita > (2019/08/15) > 【UE4】 Asset Managerのアセットの非同期ロード機能について その1 ( 非同期ロードの解説 & レベルの裏読み編 )]: https://qiita.com/EGJ-Kaz_Okada/items/f18bca3fb5c8fc1aea9c
[Qiita > (2019/12/21) > 【UE4】 Asset Managerのアセットの非同期ロード機能について その2 ( レベルアセット以外の裏読み編 )]: https://qiita.com/EGJ-Kaz_Okada/items/7dba130c3641aa456b73
[Unreal Engine 5.0 Documentation > Game Features と Modular Gameplay]: https://docs.unrealengine.com/5.0/ja/game-features-and-modular-gameplay/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ >  データ レジストリのクイック スタート ガイド]: https://docs.unrealengine.com/5.0/ja/quick-start-guide-for-unreal-engine-data-registries/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]: https://docs.unrealengine.com/5.0/ja/valley-of-the-ancient-sample-game-for-unreal-engine/#modulargameplay%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > Lyra キャラクターを初期化する方法]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#lyra%E3%82%AD%E3%83%A3%E3%83%A9%E3%82%AF%E3%82%BF%E3%83%BC%E3%82%92%E5%88%9D%E6%9C%9F%E5%8C%96%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95
[Unreal Engine 5.0 Documentation > プロダクション パイプラインをセットアップする > アセット管理]: https://docs.unrealengine.com/5.0/ja/asset-management-in-unreal-engine/
[Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 40:56]: https://youtu.be/7F28p564kuY?list=PLZlv_N0_O1gbggHiwNP2JBXGeD2h12tbB&t=2456
[Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]: https://www.youtube.com/watch?v=3PBnqC7TxvM
[ドクセル > 2017/11/25 > UE4のモバイル開発におけるコンテンツアップデートの話　- Chunk IDとの激闘編 - > p34]: https://www.docswell.com/s/EpicGamesJapan/5RQMEK-ue4-chunk-id#p34
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2#p54
