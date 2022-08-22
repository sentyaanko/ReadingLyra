# 【UE5】Lyra に学ぶ Enhanced Input <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中で Enhanced Input プラグインが、どのように利用されているかを読み解いていきます。  
まず始めに Enhanced Input のみについての情報、続いて Lyra の基本的な情報、最後に Lyra での Enhanced Input の情報、という順番で記述していきます。

* 解説しないこと
	* Game Feature/Gameplay Ability に関する詳細な部分
		* Game Feature は、レベル切り替え時に入力の設定の変更などを行っています。
		* Gameplay Ability は、キー入力からアクティブ化などを行っています。
		* ただ、詳細に触れようとするとドキュメントが膨大になるため、解説は割愛します。
	* ウィジェットに絡む部分
	* キャラクターのブループリント内の Enhanced Action Events(EnhancedInputAction ノード) に関する部分
	* キーコンフィグ関連
* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [Enhanced Input](#enhanced-input)
	- [Enhanced Input の基本的な利用方法](#enhanced-input-の基本的な利用方法)
	- [Enhanced Input の参考リンク](#enhanced-input-の参考リンク)
	- [Enhanced Input のコアクラス](#enhanced-input-のコアクラス)
- [Lyra サンプル ゲーム](#lyra-サンプル-ゲーム)
	- [Lyra の参考リンク](#lyra-の参考リンク)
	- [Lyra の前提知識](#lyra-の前提知識)
- [Lyra における Enhanced Input](#lyra-における-enhanced-input)
	- [Lyra における Enhanced Input の参考リンク](#lyra-における-enhanced-input-の参考リンク)
	- [Lyra における Enhanced Input の設定](#lyra-における-enhanced-input-の設定)
	- [Lyra における UInputAction](#lyra-における-uinputaction)
	- [Lyra における UInputMappingContext](#lyra-における-uinputmappingcontext)
	- [Lyra における入力マッピング追加方法](#lyra-における入力マッピング追加方法)
	- [Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由](#lyra-における入力マッピング追加方法-uplayermappableinputconfig-経由)
		- [Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由： B_SimpleHeroPawn の場合](#lyra-における入力マッピング追加方法-uplayermappableinputconfig-経由-b_simpleheropawn-の場合)
		- [Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由： ShooterCore の場合](#lyra-における入力マッピング追加方法-uplayermappableinputconfig-経由-shootercore-の場合)
		- [Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由： TopDownArena の場合](#lyra-における入力マッピング追加方法-uplayermappableinputconfig-経由-topdownarena-の場合)
	- [Lyra における入力マッピング追加方法： ULyraExperienceActionSet 経由](#lyra-における入力マッピング追加方法-ulyraexperienceactionset-経由)
		- [Lyra における入力マッピング追加方法： ULyraExperienceActionSet 経由： LAS_InventoryTest の場合](#lyra-における入力マッピング追加方法-ulyraexperienceactionset-経由-las_inventorytest-の場合)
		- [Lyra における入力マッピング追加方法： ULyraExperienceActionSet 経由： LAS_ShooterGame_SharedInput の場合](#lyra-における入力マッピング追加方法-ulyraexperienceactionset-経由-las_shootergame_sharedinput-の場合)
	- [Lyra における入力アクションのバインド方法](#lyra-における入力アクションのバインド方法)
		- [Lyra における入力アクションのバインド方法：ネイティブにバインドされる関数](#lyra-における入力アクションのバインド方法ネイティブにバインドされる関数)
		- [Lyra における入力アクションのバインド方法：アビリティにバインドされる関数](#lyra-における入力アクションのバインド方法アビリティにバインドされる関数)
- [終わりに](#終わりに)


# Enhanced Input

* 入力をより柔軟に扱う仕組みです。
* これを利用すると、モジュール式に入力処理を付け外しすることもできます。

## Enhanced Input の基本的な利用方法

1. プラグインを有効にする
	* Enhanced Input プラグインを有効化し、エディターを再起動する。
1. Default Classes の設定を変更する
	* *Project Settings > Engine - Input > Default Classes > Default Player Input Class*
		* `EnhancedPlayerInput` （もしくはその派生クラス）に変更する
	* *Project Settings > Engine - Input > Default Classes > Default Input Component Class*
		* `EnhancedInputComponent` （もしくはその派生クラス）に変更する
1. [UInputAction] データアセットを用意する。
	* 例：移動用、ジャンプ用等
1. [UInputMappingContext] データアセットを用意する。
   * 例：デフォルトのキーボードマウス用、シューターゲームのパッド用
1. [UInputMappingContext] をローカルプレイヤーに追加する。
   * C++:
	   * `LocalPlayer->GetSubsystem<UEnhancedInputLocalPlayerSubsystem>()->AddMappingContext(inputMappingContext,priority)`
   * ブループリント:
	   * `GetLocalController->EnhancedInputLocalPlayerSubsystem->AddMappingContext` に [UInputMappingContext] を渡す
1. [UInputAction] に関数をバインドする。
   * C++:
	   * `PlayerEnhancedInputComponent->BindAction(inputAction, ETriggerEvent::Started, this, &AMyPawn::MyInputHandlerFunction)`
   * ブループリント:
	   * 作成した [UInputAction] に対応したイベントノードが使用できるようになっているので、任意の処理につなげる
	   * ただし、これを使うとハード参照が作られる。モジュール式に行うなら別の方法を取る必要がある。

## Enhanced Input の参考リンク

* [Unreal Engine 5.0 Documentation > Enhanced Input プラグイン]
	* 5.0 でもβです。（2022/04/11 現在）
	* ページ左部のドキュメントツリーからのリンクがない（2022/04/11 現在）ので、一時的なページの可能性があります。
	* 基本的な概念やコアクラスの把握にはここを読むのが一番良いと思います。
* [Unreal Engine 5.0 Documentation > 入力値 > RawInput プラグイン]
	* URL を見ると Enhanced Input のページのように見えますが、 RawInput Plugin の説明になっています。
		* （ページ左部のドキュメントツリーからのリンクもないです。）
		* （昔から存在した RawInput Plugin の解説ページと Enhanced Input プラグインの名前が衝突してしまっているのだと思います。）
* [Unreal Engine 4.27 Documentation > インタラクティブな体験をつくりだす > 入力値 > Enhanced Input プラグイン]
	* 4.27 でもβとしてして公開されています。
* [ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p65]
* [Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 1:00:00]
	* Enhanced Input の説明です。
* [Youtube > Genius Slackers > UE4 Enhanced Input in CPP Part 1]
	* 非公式の動画です。
	* 公式ドキュメントにある Enhanced Input のセットアップの手順を動画で確認できます。
* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Enhanced Input System を使用した柔軟なコントロール]
	* 古代の谷のドキュメント内での説明。
* [Let's Enjoy Unreal Engine > (2020/11/28) > UE4.26 Enhanced Inputについて]
	* 4.26 時点での解説ですが殆ど変わっていないはずです。こちらを見れば基本的な使い方はだいたい分かると思います。
* [historia > (2022/05/02) > ［UE5］［C++］EnhancedInputで独自のInputTriggerを作る～UIカーソル高速移動編～]
	* 独自の [UInputTrigger]　派生クラスを自作する解説です。

## Enhanced Input のコアクラス

| クラス名                             | 役割                                                                                    |
|--------------------------------------|-----------------------------------------------------------------------------------------|
| [UInputAction]                       | 入力を行った時に発生しうるアクションの種類を定義するデータアセット。                    |
| [UInputMappingContext]               | [UInputAction] に対して物理的な入力のマッピングをまとめて定義するためのデータアセット。 |
| [UInputTrigger]                      | [UInputAction::Triggers] で指定する、入力がなされたかを判定するためのクラス。           |
| [UInputModifier]                     | [UInputAction::Modifiers] で指定する、 Trigger に渡す前に入力値を加工するためのクラス。 |
| [UEnhancedInputComponent]            | Enhanced Input 用の `UInputComponent` 派生クラス。                                      |
| [UEnhancedPlayerInput]               | Enhanced Input 用の `UPlayerInput` 派生クラス。                                         |
| [UEnhancedInputLocalPlayerSubsystem] | `ULocalPlayer` が所持する Subsystem 。                                                  |

* 詳しくは [Unreal Engine 5.0 Documentation > Enhanced Input プラグイン] 参照。
* [UInputAction] / [UInputMappingContext] / [UInputTrigger] / [UInputModifier] について
	* 入力に関する定義を行うデータアセット/クラスです。
	* [UInputAction] と [UInputMappingContext] は別々に登録します。
		* [UInputAction]
			* 入力アクションが発生した際に呼び出す関数を [UEnhancedInputComponent::BindAction()] 等でバインドします。
			* つまり、１つの入力アクションに対して、１つの関数をバインドする、ということであり、これにより入力アクションに対応する動作を実装することができます。
		* [UInputMappingContext]
			* 物理的な入力が発生した際に入力アクションが発生するように [IEnhancedInputSubsystemInterface::AddMappingContext()] 等で追加します。
		* つまり、物理的な入力に対して直接関数をバインドせず、入力アクションを経由して目的の動作に処理を流しているということです。
	* 別々というのはどういうことか？
		* [UInputAction] が登録済み、 [UInputMappingContext] が未登録の場合
			* 物理的な入力に [UInputMappingContext] が追加されていないため、 [UInputAction] が発生しない。
			* 結果、バインドされた関数が呼び出されない状態となる。
		* [UInputAction] が未登録、 [UInputMappingContext] が登録済みの場合
			* 物理的な入力に [UInputMappingContext] が追加されているため、 [UInputAction] が発生する。
			* だが、 [UInputAction] に対して何もバインドされていないため何も起きない状態となる。
* [UEnhancedInputComponent] / [UEnhancedPlayerInput] / [UEnhancedInputLocalPlayerSubsystem] について
	* 入力制御を行うクラスです。
	* 利用する場合は *Project Settings* の設定を変更する
		* *Project Settings > Engine - Input > Default Classes > Default Player Input Class*
			* [UEnhancedPlayerInput] 派生クラスにする。
			* PlayerController が所持する PlayerInput クラスはここで指定されたクラスになる。
		* *Project Settings > Engine - Input > Default Classes > Default Input Component Class*
			* [UEnhancedInputComponent] 派生クラスにする。
			* Actor が所持する InputComponent クラスはここで指定されたクラスになる。

Enhanced Input についての大まかな説明は以上です。


# Lyra サンプル ゲーム

[マーケットプレイス > Lyra Starter Game]

UE5 の機能を使った、新しいサンプルプロジェクトです。  
ドキュメント上では 「**Lyra サンプル ゲーム**」と称され、マーケットプレイス上では「**Lyra Starter Game**」と称されています。  

## Lyra の参考リンク

* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム]
	* 割と事細かに書かれているので、先ずはざっと目を通すことをおすすめします。
	* 子階層には 7 ページほどドキュメントがあります。  
	* UE5 の新常識的な内容なので、慣れていないのであればそちらも目を通したほうが良いと思います。  
* [Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022]
	* Overview とは言っていますが、かなり限定的な話題しか挙がりません。
* [Youtube > Unreal Engine > Lyra Walkthrough Q&A ｜ Inside Unreal]
	* Lyra を利用する場合の考え方が主な話です。
	* 2022/08/22 日本語字幕が追加されたようです。
* [Let's Enjoy Unreal Engine > (2022/04/24) > UE5 Lyraサンプルゲームの設計を解説してみる]
	* alwei 氏の Lyra の解説。
	* 主に以下の項目を大まかに解説されています	。
		* Game Feature
		* Enhanced Input
		* Gameplay Ability
		* LyraCharacter
		* LayraHeroComponent 
	* 簡潔にまとめられているので、最初に読むと良いです。


## Lyra の前提知識

* Lyra は UE5 のサンプルプロジェクトとして用意されているものですが、特徴的な点は **モジュール式となるように設計** されているところです。
* 入力制御に関してもモジュール式となるように実装されていて、 Game Feature を経由しているため、そちらの知識も必要となります。
	* Game Feature に関して、このドキュメントでは深くは触れません。
	* 「任意のタイミングで入力の設定をつけたり外したりしやすくするための仕組みを使用している」と念頭に置いておけば良いと思います。
* エクスペリエンス
	* ユーザー体験。
	* Lyra では Elimination / Control / Exploader / FrontEnd などがそれに当たります。


Lyra についての大まかな説明は以上です。


# Lyra における Enhanced Input

* 前述のとおり、モジュール式となるように入力設定が定義されています。
* どういうことかというと、 Game Feature を介して入力設定を行えるようにするために、多くのデータアセット型などが定義されています。
* そのため、あちらこちらに設定が散らばっており、参照するデータアセットも多いです。
	* `Class Viewer` / `Content Browser の Search` / `Reference Viewer` 等を利用することで大まかな依存関係など把握できます。
	* 一部はアセットマネージャ経由で名前で処理している部分もあるので、ソースを確認する必要もあります。

## Lyra における Enhanced Input の参考リンク

* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra 入力設定]
	* 特に入力に関する情報がまとまっています。
* [Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 23:47]
	* 入力関連についての解説です。
* [Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 24:22]
	* 入力関連のアセットの依存関係についての解説です。
* [Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 32:47]
	* アビリティと Input Tag の連携についての解説です。
* [Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 34:01]
	* 図で `Dash` の例が解説されています。
		* `GA_HeroDash` は `InputTag.Ability.Dash` にバインドされている
		* InputMapping により `LShift` は `IA_Dash` にマッピングされている
		* InputConfig により `InputTag.Ability.Dash` は `IA_Dash` によってトリガーされる
		* その結果、`LShift` は (`InputTag.Ability.Dash` をトリガーし、それにバインドされた) `GA_HeroDash` をアクティブ化する
* [Youtube > Unreal Engine > Lyra Walkthrough Q&A ｜ Inside Unreal > 1:30:51]
	* Enhanced Input と Ability System を組み合わせることによるメリットとして、アビリティや武器単位で並行作業できることを挙げています。


## Lyra における Enhanced Input の設定

| 項目                                                                                    | 値                     | 補足                  | 
|-----------------------------------------------------------------------------------------|------------------------|-----------------------|
| *Project Settings > Engine - Input > Default Classes > Default Player Input Class*      | [UEnhancedPlayerInput] | Enhanced Input 用     |
| *Project Settings > Engine - Input > Default Classes > Default Input Component Class*   | [ULyraInputComponent]  | Enhanced Input 用     |
| *Project Settings > Engine - General Settings > Default Classes > World Settings Class* | `ULyraWorldSettings`   | Game Feature の指定用 |


## Lyra における UInputAction

`Content Browser の Search` で `Type=InputAction` と記述すると一覧が確認できます。  
![ContentBrowser-Type=DInputAction]

* 各アセットを `Reference Viewer` で確認すると、以下のようなアセットから参照されていることが確認できます。
	* [UInputMappingContext]
		* [UInputAction] に対して物理的な入力を指定しています。
	* [ULyraInputConfig]
		* [UInputAction] と対になる GameplayTag を設定し、 C++ でバインドの際に利用しています。詳しくは後述します。
	* `UUserWidget` 及びその派生クラス（例： `ULyraJoystickWidget` 等）
		* Widget の操作（ボタンを押す等）から発生させる [UInputAction] を指定するのに利用しています。
		* 解説は割愛します。
	* Character クラスの入力イベント（例： `B_HeroShooter_Mannequin` 等）
		* ブループリント内で Enhanced Action Events(EnhancedInputAction ノード) を実装することで [UInputAction] へのバインドを行っています。
		* 解説は割愛します。


## Lyra における UInputMappingContext

`Content Browser の Search` で `Type=InputMappingContext` と記述すると一覧が確認できます。  
![ContentBrowser-Type=DInputMappingContext]

* 各アセットを `Reference Viewer` で確認すると、以下のようなアセットから参照されていることが確認できます。
	* [UPlayerMappableInputConfig]
		* プレイヤーに追加する [UInputMappingContext] を指定しています。詳しくは後述します。
	* `ULyraExperienceActionSet`
		* エクスペリエンスに紐づく入力マッピング追加のパラメータとして [UInputMappingContext] を指定しています。詳しくは後述します。
	* Gameplay Ability
		* `GA_ADS` 内で ADS 用の操作 `IMC_ADS_Speed` を一時的にマッピングするのに利用しています。
		* 解説は割愛します。

図にすると以下のような状況です。  
![UInputMappingContext-Referencing]

また、それぞれ以下の [UInputAction] を参照しています。

| UInputAction               | IMC_Default_<br>Gamepad |<br>KBM | IMC_ShooterGame_<br>Gamepad |<br>KBM | IMC_InventoryTest | IMC_ADS_Speed |
|----------------------------|-------------------------|--------|-----------------------------|--------|-------------------|---------------|
| IA_Move                    | ✔                      |✔      | ✔                          |        |                   | ✔            |
| IA_Look_Stick              | ✔                      |        | ✔                          |        |                   | ✔            |
| IA_Look_Mouse              |                         |✔      |                             |        |                   | ✔            |
| IA_Jump                    | ✔                      |✔      |                             |        |                   |               |
| IA_Crouch                  | ✔                      |✔      |                             |        |                   |               |
| IA_Ability_Dash            | ✔                      |✔      |                             |        |                   |               |
| IA_Weapon_Fire_Auto        | ✔                      |✔      |                             |        |                   |               |
| IA_Weapon_Fire             | ✔                      |✔      |                             |        |                   |               |
| IA_Weapon_Reload           | ✔                      |✔      |                             |        |                   |               |
| IA_AutoRun                 |                         |✔      |                             |        |                   |               |
| IA_QuickSlot1              |                         |        |                             |✔      |                   |               |
| IA_QuickSlot2              |                         |        |                             |✔      |                   |               |
| IA_QuickSlot3              |                         |        |                             |✔      |                   |               |
| IA_ADS                     |                         |        | ✔                          |✔      |                   |               |
| IA_Grenade                 |                         |        | ✔                          |✔      |                   |               |
| IA_Melee                   |                         |        | ✔                          |✔      |                   |               |
| IA_QuickSlot_CycleBackward |                         |        | ✔                          |✔      |                   |               |
| IA_QuickSlot_CycleForward  |                         |        | ✔                          |✔      |                   |               |
| IA_ShowScoreboard          |                         |        | ✔                          |✔      |                   |               |
| IA_Emote                   |                         |        | ✔                          |✔      | ✔                |               |
| IA_Interact                |                         |        |                             |        | ✔                |               |
| IA_ToggleInventory         |                         |        |                             |        | ✔                |               |
| IA_ToggleMap               |                         |        |                             |        | ✔                |               |
| IA_ToggleMarkerInWorld     |                         |        |                             |        | ✔                |               |


## Lyra における入力マッピング追加方法

入力マッピングの追加には [UInputMappingContext] が必要です。  
前述のとおり、 [UPlayerMappableInputConfig] / `ULyraExperienceActionSet` などが保持しており、この2つがどのように利用されているかを解説します。


## Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由

`Content Browser の Search` で `Type=PlayerMappableInputConfig` と記述すると一覧が確認できます。  
![ContentBrowser-Type=DPlayerMappableInputConfig]

* 各アセットを `Reference Viewer` で確認すると、以下のようなアセットから参照されていることが確認できます。
	* `B_SimpleHeroPawn` ( `ULyraCharacter` 派生BP)
	* `ShooterCore/TopDownArena` （ [UGameFeatureData] ）

図にすると以下のような状況です。  
![UPlayerMappableInputConfig-Referencing]

それぞれについて、どのように利用されるかを解説します。


### Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由： B_SimpleHeroPawn の場合

* 設定されている [UPlayerMappableInputConfig]
	* `B_SimpleHeroPawn` を開き、コンポーネント `LyraHero` の `Details` を見ると `Lyra Hero Component > Default Input Configs` で以下が指定されていることを確認できます。
		* `PMI_Default_Gamepad`
		* `PMI_Default_KBM`
* 設定されている [UPlayerMappableInputConfig] の利用のされ方について
	* `ULyraHeroComponent::InitializePlayerInput()` にて参照され、（キーコンフィグ関連を経由し）入力マッピングの追加が行われます。
		* キーコンフィグ関連についての解説は割愛します。
* `B_SimpleHeroPawn` の参照のされ方について
	* `B_SimpleHeroPawn` は `B_LyraDefaultExperience` （ `ULyraExperienceDefinition` ） から参照されています。
		* `B_LyraDefaultExperience` は `ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()` から参照されます。
		* 該当のコードは各レベルの `World Settings > Game Mode > Default Gameplay Experience` が指定されていない場合に利用されます。
		* レベルを開いて確認すると、上記が指定されていないものは具体的には以下となります。
			* `L_DefaultEditorOverview` 
			* `L_ShooterFrontendBackground`
				* フロントエンド画面の背景のアニメーションシーケンスで利用されています。
				* こちらの解説は割愛します。
* 処理の流れのまとめ
	1. レベル `L_DefaultEditorOverview` の初期化を行う。
	1. エクスペリエンス `B_LyraDefaultExperience` を適用する。
	1. プレイヤー用のポーンとして `B_SimpleHeroPawn` が使用される。
	1. ポーンの初期化の際、 `PMI_Default_Gamepad` / `PMI_Default_KBM` が適用される。
	1. その結果、上記で指定されている `IMC_Default_Gamepad` / `IMC_Default_KBM` （ [UInputMappingContext] ）が追加される。


### Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由： ShooterCore の場合

* 設定されている [UPlayerMappableInputConfig]
	* `ShooterCore` ([UGameFeatureData]) を開き、 `Actions > Actions > Index[3]` を見ると `Add Input Config` が指定され、 `Input Configs` で以下が指定されていることを確認できます。
		* `PMI_Default_KBM`
		* `PMI_Default_Gamepad`
		* `PMI_ShooterDefaultConfig_KBM`
		* `PMI_ShooterDefaultConfig_Gamepad`
* 設定されている [UPlayerMappableInputConfig] の利用のされ方について
	* `UGameFeatureAction_AddInputConfig` にて参照され、（キーコンフィグ関連を経由し）入力マッピングの追加が行われます。
		* キーコンフィグ関連についての解説は割愛します。
* `ShooterCore` ([UGameFeatureData]) の参照のされ方について
	* `Reference Viewer` からでは追うことができません。
	* 以下のどちらかで Game Feature の名前を指定します。
		* `ULyraExperienceDefinition::GameFeaturesToEnable`
		* `ULyraExperienceActionSet::GameFeaturesToEnable`
	* そうすることで、 `ULyraExperienceManagerComponent::OnExperienceLoadComplete()` で参照され、 Game Feature のロードとアクティブ化が実行されます。
	* 指定されている場所
		* 以下の 3 つの `ULyraExperienceDefinition`
			* `B_LyraShooterGame_ControlPoints`
			* `B_ShooterGame_Elimination`
			* `B_TestInventoryExperience`
		* 以下の 4 つの `ULyraExperienceActionSet`
			* `LAS_ShooterGame_SharedInput`
			* `LAS_ShooterGame_StandardComponents`
			* `LAS_ShooterGame_StandardHUD`
			* `LAS_InventoryTest`
		* `ULyraExperienceActionSet` は `ULyraExperienceDefinition` から参照されますが、上記 4 つの `ULyraExperienceActionSet` は上記 3 つの `ULyraExperienceDefinition` からのみ参照されています。
			* （注：現状で確認できる範囲では。）
		* つまり、上記 3 つの `ULyraExperienceDefinition` をアクティブ化する際に `ShooterCore` ([UGameFeatureData]) のロードとアクティブ化が実行されます。
	* 各 `ULyraExperienceDefinition` が指定されているレベル
		* `B_LyraShooterGame_ControlPoints`
			* `L_Convolution_Blockout`
		* `B_ShooterGame_Elimination`
			* `L_ShooterGym`
			* `L_Expanse`
			* `L_Expanse_Blockout`
			* `L_FiringRange_WP`
		* `B_TestInventoryExperience`
			* `L_InventoryTestMap`
		* つまりこれら 6 つのレベルをロードする際に `ShooterCore` ([UGameFeatureData]) のロードとアクティブ化が実行されます。
* 処理の流れのまとめ
	1. 以下いずれかのレベルの初期化を行う。
		* `L_Convolution_Blockout`
		* `L_ShooterGym`
		* `L_Expanse`
		* `L_Expanse_Blockout`
		* `L_FiringRange_WP`
		* `L_InventoryTestMap`
	1. レベルで指定された以下いずれかのエクスペリエンスを適用する。
		* `B_LyraShooterGame_ControlPoints`
		* `B_ShooterGame_Elimination`
		* `B_TestInventoryExperience`
	1. エクスペリエンスで指定された Game Feature `ShooterCore` ([UGameFeatureData]) のロードとアクティブ化が実行される。
	1. Game Feature `ShooterCore` ([UGameFeatureData]) で指定された以下の [UPlayerMappableInputConfig] が適用される
		* `PMI_Default_KBM`
		* `PMI_Default_Gamepad`
		* `PMI_ShooterDefaultConfig_KBM`
		* `PMI_ShooterDefaultConfig_Gamepad`
	1. その結果、上記の [UPlayerMappableInputConfig] で指定された以下の [UInputMappingContext] が追加される。
		* `IMC_Default_KBM`
		* `IMC_Default_Gamepad`
		* `IMC_ShooterGame_KBM`
		* `IMC_ShooterGame_Gamepad`


### Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由： TopDownArena の場合

流れは `ShooterCore` ([UGameFeatureData]) とほぼ同じで、参照しているアセットが異なります。

* 設定されている [UPlayerMappableInputConfig]
	* `TopDownArena` ([UGameFeatureData]) を開き、 `Actions > Actions > Index[1]` を見ると `Add Input Config` が指定され、 `Input Configs` で以下が指定されていることを確認できます。
		* `PMI_Default_KBM`
		* `PMI_Default_Gamepad`
* `TopDownArena` ([UGameFeatureData]) の参照のされ方について
	* 指定されている場所
		* `B_TopDownArenaExperience` （ `ULyraExperienceDefinition` ）のみ。
		* つまり、`B_TopDownArenaExperience` （ `ULyraExperienceDefinition`） をアクティブ化する際に `TopDownArena` ([UGameFeatureData]) のロードとアクティブ化が実行されます。
	* `B_TopDownArenaExperience` （ `ULyraExperienceDefinition` ） が指定されているレベル
		* `L_TopDownArenaGym` のみ。
		* つまり `L_TopDownArenaGym` レベルをロードする際に `TopDownArena` ([UGameFeatureData]) のロードとアクティブ化が実行されます。
* 処理の流れのまとめ
	1. 以下のレベルの初期化を行う。
		* `L_TopDownArenaGym`
	1. レベルで指定された以下のエクスペリエンスを適用する。
		* `B_TopDownArenaExperience`
	1. エクスペリエンスで指定された Game Feature `TopDownArena` ([UGameFeatureData]) のロードとアクティブ化が実行される。
	1. Game Feature `TopDownArena` ([UGameFeatureData]) で指定された以下の [UPlayerMappableInputConfig] が適用される
		* `PMI_Default_KBM`
		* `PMI_Default_Gamepad`
	1. その結果、上記の [UPlayerMappableInputConfig] で指定された以下の [UInputMappingContext] が追加される。
		* `IMC_Default_KBM`
		* `IMC_Default_Gamepad`


## Lyra における入力マッピング追加方法： ULyraExperienceActionSet 経由

`Content Browser の Search` で `LyraExperienceActionSet` と記述すると一覧が確認できます。  
![ContentBrowser-LyraExperienceActionSet]

各アセットを開いて確認すると、`Actions To Perform > Actions` にて `Add Input Mapping` を指定しているものがあります。  
`LAS_InventoryTest` / `LAS_ShooterGame_SharedInput` の 2 つです。  
これらが有効化されるタイミングは [Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由： ShooterCore の場合] で記述したとおりです。

### Lyra における入力マッピング追加方法： ULyraExperienceActionSet 経由： LAS_InventoryTest の場合

* 処理の流れのまとめ
	1. 以下のレベルの初期化を行う。
		* `L_InventoryTestMap`
	1. レベルで指定された以下のエクスペリエンスを適用する。
		* `B_TestInventoryExperience`
	1. エクスペリエンスで指定された `LAS_InventoryTest` （ `ULyraExperienceActionSet` ） のロードとアクティブ化が実行される。
	1. `LAS_InventoryTest` （ `ULyraExperienceActionSet` ） で指定された以下の [UInputMappingContext] が追加される。
		* `IMC_InventoryTest`


### Lyra における入力マッピング追加方法： ULyraExperienceActionSet 経由： LAS_ShooterGame_SharedInput の場合

* 処理の流れのまとめ
	1. 以下いずれかのレベルの初期化を行う。
		* `L_Convolution_Blockout`
		* `L_ShooterGym`
		* `L_Expanse`
		* `L_Expanse_Blockout`
		* `L_FiringRange_WP`
		* `L_InventoryTestMap`
	1. レベルで指定された以下いずれかのエクスペリエンスを適用する。
		* `B_LyraShooterGame_ControlPoints`
		* `B_ShooterGame_Elimination`
		* `B_TestInventoryExperience`
	1. エクスペリエンスで指定された `LAS_ShooterGame_SharedInput` （ `ULyraExperienceActionSet`） のロードとアクティブ化が実行される。
	1. `LAS_ShooterGame_SharedInput` （ `ULyraExperienceActionSet` ） で指定された以下の [UInputMappingContext] が追加される。
		* `IMC_ShooterGame_KBM`

> note:  
> つまり、たとえば `IMC_ShooterGame_KBM` は以下の 2 箇所から追加されていることになります。
> * `ShooterCore` ([UGameFeatureData])
> * `LAS_ShooterGame_SharedInput`
> 
> その際に指定しているプライオリティも異なります。（それぞれ 0 と 1 を指定しています。）  
> これが何を意味し、どのような挙動となるかまでは追いかけていません。

入力マッピングの追加方法については以上となります。


## Lyra における入力アクションのバインド方法

* ここでは C++ で行っているバインドについて述べます。
	* `B_HeroShooter_Mannequin` 等の Enhanced Action Events(EnhancedInputAction ノード) についての解説は割愛します。
* C++ でバインドを行う場合、以下の関数を使用します。
	* [UEnhancedInputComponent::BindAction()]
* 上記の関数は以下の関数から呼び出していることが確認できます。
	* `ULyraInputComponent::BindNativeAction()`
	* `ULyraInputComponent::BindAbilityActions()`
* 上記の関数は以下の関数から呼び出していることが確認できます。
	* `ULyraHeroComponent::InitializePlayerInput()`
		* ポーンの初期化の際に呼び出される関数です。
		* 関数の実装を更に読み解いていくと以下のことがわかります。
			* バインドに使用している [UInputAction] は以下で指定している。
				* `FLyraInputAction:::InputAction`
			* `FLyraInputAction` は以下のいずれかで指定している。
				* `ULyraInputConfig::NativeInputActions`
				* `ULyraInputConfig::AbilityInputActions`
			* [ULyraInputConfig] は以下で指定している。
				* `ULyraPawnData::InputConfig`
			* `ULyraPawnData` は以下で指定している。
				* `ULyraExperienceDefinition::DefaultPawnData`
			* `ULyraExperienceDefinition` は以下で指定している。
				* `World Settings > Game Mode > Default Gameplay Experience`
		* つまり、レベルの初期化時にレベル毎の設定に従ってバインド処理がなされる、ということです。
	* `ULyraHeroComponent::AddAdditionalInputConfig()`
		* Game Feature によるバインドの追加の際に呼び出される関数です。
		* 関数の実装を更に読み解いていくと以下のことがわかります。
			* バインドに使用している [UInputAction] は以下で指定している。
				* `FLyraInputAction:::InputAction`
			* `FLyraInputAction` は以下で指定している。
				* `UGameFeatureAction_AddInputBinding::InputConfigs`
			* `UGameFeatureAction_AddInputBinding` は以下で指定している。
				* `ULyraExperienceActionSet::Actions`
			* `ULyraExperienceActionSet` は以下で指定している。
				* `ULyraExperienceDefinition::ActionSets`
			* `ULyraExperienceDefinition` は以下で指定している。
				* `World Settings > Game Mode > Default Gameplay Experience`
		* こちらのケースも前述のものと同じように、レベルの初期化が起点となっています。

`Reference Viewer` で [UInputAction] の依存関係を追うと以下のようになります。  
![ULyraInputConfig-Referenced]

`Reference Viewer` で `ULyraPawnData` 経由の [UInputAction] の依存関係を追うと以下のようになります。  
![ULyraInputConfig-Referencing_PawnData]

`Reference Viewer` で `ULyraExperienceActionSet` 経由の [UInputAction] の依存関係を追うと以下のようになります。  
![ULyraInputConfig-Referencing_ActionSet]

これらの依存関係を見ていくと、どのレベルでどの入力アクションがバインドされているのかがわかります。

* 例：`TopDownArena` ([UGameFeatureData]) をプレイしようとする場合
	* レベル `L_TopDownArenaGym` の初期化を行う。
		* ポーンの情報として `InputData_Arena` が使用される。
			* NativeAction として `IA_Move` が使用される。
			* AbilityAction として `IA_Weapon_Fire` が使用される。
* 例：`ControlPoints` をプレイしようとする場合
	* レベル `L_Convolution_Blockout` の初期化を行う。
		* ポーンの情報として `InputData_Hero` が使用される。
			* NativeAction として `IA_Move/IA_Look_Mouse/IA_Look_Stick/IA_Crouch/IA_AutoRun` が使用される。
			* AbilityAction として `IA_Jump/IA_Weapon_Fire/IA_Weapon_Fire_Auto/IA_Weapon_Reload/IA_Ability_Heal/IA_Ability_Death` が使用される。
		* アクションセット経由で `InputData_ShooterGame_AddOns` が使用される。
			* AbilityAction として `IA_Melee/IA_ADS/IA_Grenade/IA_ShowScoreboard/IA_DropWeapon/IA_Emote` が使用される。

> note:  
> これを見ると `TopDownArena` ([UGameFeatureData]) では `IA_Ability_Death` が使用されていないことがわかり、 `ControlPoints` などとは異なる死亡処理が行われていることが想像できます。  
> （実際の死亡処理はまだ確認していませんので実際の処理は不明です。）


### Lyra における入力アクションのバインド方法：ネイティブにバインドされる関数

* コードでいうと `ULyraHeroComponent::InitializePlayerInput()` の以下の部分です。
	```c++
	LyraIC->BindNativeAction(InputConfig, GameplayTags.InputTag_Move, ETriggerEvent::Triggered, this, &ThisClass::Input_Move, /*bLogIfNotFound=*/ false);
	LyraIC->BindNativeAction(InputConfig, GameplayTags.InputTag_Look_Mouse, ETriggerEvent::Triggered, this, &ThisClass::Input_LookMouse, /*bLogIfNotFound=*/ false);
	LyraIC->BindNativeAction(InputConfig, GameplayTags.InputTag_Look_Stick, ETriggerEvent::Triggered, this, &ThisClass::Input_LookStick, /*bLogIfNotFound=*/ false);
	LyraIC->BindNativeAction(InputConfig, GameplayTags.InputTag_Crouch, ETriggerEvent::Triggered, this, &ThisClass::Input_Crouch, /*bLogIfNotFound=*/ false);
	LyraIC->BindNativeAction(InputConfig, GameplayTags.InputTag_AutoRun, ETriggerEvent::Triggered, this, &ThisClass::Input_AutoRun, /*bLogIfNotFound=*/ false);
	```
* `BindNativeAction()` では `InputConfig->NativeInputActions` （ `FLyraInputAction` ） から第二引数と同じ `InputTag` を探します。
	* あった場合はペアとなる入力アクションに第五引数で渡された関数をバインドします。
	* ない場合はバインドしません。
* つまり、固定の処理を行う関数に直接バインドされています。
* 具体的に行う内容は各関数を参照してください。

前述の [UInputAction] の依存関係の例でいうと以下のようになります。

* 例：`TopDownArena` ([UGameFeatureData]) をプレイしようとする場合
	* ポーンの情報として `InputData_Arena` が使用される。
		* `InputData_Arena` の `NativeInputActions` を確認すると以下の項目のペアが設定されている。
			* `IA_Move` と `InputTag.Move`
		* よって、入力アクション `IA_Move` に `ULyraHeroComponent::Input_Move()` がバインドされる。
		* それ以外は `InputData_Arena` に指定されていないのでバインドされない。
* 例：`ControlPoints` をプレイしようとする場合
	* ポーンの情報として `InputData_Hero` が使用される。
		* `InputData_Arena` の `NativeInputActions` を確認すると以下の項目のペアが設定されている。
			* `IA_Move` と `InputTag.Move`
			* `IA_Look_Mouse` と `InputTag.Look.Mouse`
			* `IA_Look_Stick` と `InputTag.Look.Stick`
			* `IA_Crouch` と `InputTag.Crouch`
			* `IA_AutoRun` と `InputTag.AutoRun`
		* よって、前述のすべての関数がバインドされる。


### Lyra における入力アクションのバインド方法：アビリティにバインドされる関数

* コードでいうと `ULyraHeroComponent::InitializePlayerInput()` / `ULyraHeroComponent::AddAdditionalInputConfig()` の以下の部分です。
	```c++
	LyraIC->BindAbilityActions(InputConfig, this, &ThisClass::Input_AbilityInputTagPressed, &ThisClass::Input_AbilityInputTagReleased, /*out*/ BindHandles);
	```
* `BindAbilityActions()` では `InputConfig->AbilityInputActions` （ `FLyraInputAction` ） の全ての要素に対して以下を行います。
	* 入力アクションに、入力開始/終了時の処理として第三/第四引数で渡された関数を、ペアとなる `InputTag` を含めてバインドします。
* つまり、アビリティに関しては全て同じ関数にバインドされます。
* 上記の関数ではバインドされた引数 `InputTag` を元にアビリティを特定し、アクティブ化などを行います。
* アビリティについて
	* ここで言うアビリティとは、要は Gameplay Ability です。
	* Gameplay Ability についての解説はこのドキュメントでは割愛します。
	* （付与方法、 InputTag から Gameplay Ability の特定方法等々の解説が必要となり、さらにドキュメントが長くなってしまう為。）

前述の [UInputAction] の依存関係の例でいうと以下のようになります。

* 例：`TopDownArena` ([UGameFeatureData]) をプレイしようとする場合
	* ポーンの情報として `InputData_Arena` が使用される。
		* `InputData_Arena` の `AbilityInputActions` を確認すると以下の 1 つのペアが設定されている。
			* `IA_Weapon_Fire` と `InputTag.Weapon.Fire` 
	* よって、前述の関数が上記の 1 つのペアでバインドされる。
* 例：`ControlPoints` をプレイしようとする場合
	* ポーンの情報として `InputData_Hero` が使用される。
		* `InputData_Hero` の `AbilityInputActions` を確認すると以下の 6 つのペアが設定されている。
			* `IA_Jump` と `InputTag.Jump`
			* `IA_Weapon_Fire` と `InputTag.Weapon.Fire`
			* `IA_Weapon_Fire_Auto` と `InputTag.Weapon.FireAuto`
			* `IA_Weapon_Reload` と `InputTag.Weapon.Reload`
			* `IA_Ability_Heal` と `InputTag.Ability.Heal`
			* `IA_Ability_Death` と `InputTag.Ability.Death`
	* アクションセット経由で `InputData_ShooterGame_AddOns` が使用される。
		* `InputData_ShooterGame_AddOns` の `AbilityInputActions` を確認すると以下の 6 つのペアが設定されている。
			* `IA_ShowScoreboard` と `InputTag.Ability.ShowLeaderboard`
			* `IA_ADS` と `InputTag.Weapon.ADS`
			* `IA_Grenade` と `InputTag.Weapon.Grenade`
			* `IA_Emote` と `InputTag.Ability.Emote`
			* `IA_DropWeapon` と `InputTag.Ability.Quickslot.Drop`
			* `IA_Melee` と `InputTag.Ability.Melee`
	* よって、前述の関数が上記の 12 つのペアでバインドされる。


入力アクションのバインド方法については以上となります。

# 終わりに

ここまでで、 Lyra で Enhanced Input がどのように利用されているかや、各アセットの大まかな繋がりが解説できたと思います。  
情報の粒度がまちまちで、分かり難い箇所も多いとは思いますが、どなたかの参考になれば幸いです。


-----
おしまい。

<!--- ページ内のリンク --->
[Lyra における入力マッピング追加方法： UPlayerMappableInputConfig 経由： ShooterCore の場合]: #lyra-における入力マッピング追加方法-uplayermappableinputconfig-経由-shootercore-の場合

<!--- 自前の画像へのリンク --->
[ContentBrowser-Type=DInputAction]: images/ContentBrowser-Type%3DInputAction.png
[ContentBrowser-Type=DInputMappingContext]: images/ContentBrowser-Type%3DInputMappingContext.png
[UInputMappingContext-Referencing]: images/UInputMappingContext-Referencing.png
[ContentBrowser-Type=DPlayerMappableInputConfig]: images/ContentBrowser-Type%3DPlayerMappableInputConfig.png
[UPlayerMappableInputConfig-Referencing]: images/UPlayerMappableInputConfig-Referencing.png
[ContentBrowser-LyraExperienceActionSet]: images/ContentBrowser-LyraExperienceActionSet.png
[ULyraInputConfig-Referenced]: images/ULyraInputConfig-Referenced.png
[ULyraInputConfig-Referencing_PawnData]: images/ULyraInputConfig-Referencing_PawnData.png
[ULyraInputConfig-Referencing_ActionSet]: images/ULyraInputConfig-Referencing_ActionSet.png

<!--- generated --->
[ULyraInputComponent]: CodeRefs/Lyra/Input/ULyraInputComponent.md#ulyrainputcomponent
[ULyraInputConfig]: CodeRefs/Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[UGameFeatureData]: CodeRefs/UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[IEnhancedInputSubsystemInterface::AddMappingContext()]: CodeRefs/UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceaddmappingcontext
[UEnhancedInputComponent]: CodeRefs/UE/Input/UEnhancedInputComponent.md#uenhancedinputcomponent
[UEnhancedInputComponent::BindAction()]: CodeRefs/UE/Input/UEnhancedInputComponent.md#uenhancedinputcomponentbindaction
[UEnhancedInputLocalPlayerSubsystem]: CodeRefs/UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystem
[UEnhancedPlayerInput]: CodeRefs/UE/Input/UEnhancedPlayerInput.md#uenhancedplayerinput
[UInputAction]: CodeRefs/UE/Input/UInputAction.md#uinputaction
[UInputAction::Triggers]: CodeRefs/UE/Input/UInputAction.md#uinputactiontriggers
[UInputAction::Modifiers]: CodeRefs/UE/Input/UInputAction.md#uinputactionmodifiers
[UInputMappingContext]: CodeRefs/UE/Input/UInputMappingContext.md#uinputmappingcontext
[UInputModifier]: CodeRefs/UE/Input/UInputModifier.md#uinputmodifier
[UInputTrigger]: CodeRefs/UE/Input/UInputTrigger.md#uinputtrigger
[UPlayerMappableInputConfig]: CodeRefs/UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
[historia > (2022/05/02) > ［UE5］［C++］EnhancedInputで独自のInputTriggerを作る～UIカーソル高速移動編～]: https://historia.co.jp/archives/26608/
[Let's Enjoy Unreal Engine > (2020/11/28) > UE4.26 Enhanced Inputについて]: https://unrealengine.hatenablog.com/entry/2020/11/28/192500
[Let's Enjoy Unreal Engine > (2022/04/24) > UE5 Lyraサンプルゲームの設計を解説してみる]: https://unrealengine.hatenablog.com/entry/2022/04/24/183000
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 4.27 Documentation > インタラクティブな体験をつくりだす > 入力値 > Enhanced Input プラグイン]: https://docs.unrealengine.com/4.27/ja/InteractiveExperiences/Input/EnhancedInput/
[Unreal Engine 5.0 Documentation > Enhanced Input プラグイン]: https://docs.unrealengine.com/5.0/ja/input/#enhancedinput%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Enhanced Input System を使用した柔軟なコントロール]: https://docs.unrealengine.com/5.0/ja/valley-of-the-ancient-sample-game-for-unreal-engine/#enhancedinputsystem%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%9F%E6%9F%94%E8%BB%9F%E3%81%AA%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%AB
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra 入力設定]: https://docs.unrealengine.com/5.0/ja/lyra-input-settings-in-unreal-engine/
[Unreal Engine 5.0 Documentation > 入力値 > RawInput プラグイン]: https://docs.unrealengine.com/5.0/ja/enhanced-input-in-unreal-engine/
[Youtube > Genius Slackers > UE4 Enhanced Input in CPP Part 1]: https://www.youtube.com/watch?v=gCd_RuRitAs
[Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022]: https://www.youtube.com/watch?v=Fj1zCsYydD8
[Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 23:47]: https://www.youtube.com/watch?v=Fj1zCsYydD8&t=1427
[Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 24:22]: https://www.youtube.com/watch?v=Fj1zCsYydD8&t=1462
[Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 32:47]: https://www.youtube.com/watch?v=Fj1zCsYydD8&t=1967
[Youtube > Unreal Engine > Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 34:01]: https://www.youtube.com/watch?v=Fj1zCsYydD8&t=2041
[Youtube > Unreal Engine > Lyra Walkthrough Q&A ｜ Inside Unreal]: https://www.youtube.com/watch?v=m80NJzUWq8A
[Youtube > Unreal Engine > Lyra Walkthrough Q&A ｜ Inside Unreal > 1:30:51]: https://www.youtube.com/watch?v=m80NJzUWq8A&t=5451
[Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 1:00:00]: https://www.youtube.com/watch?v=7F28p564kuY&t=3600
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p65]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2#p65
[マーケットプレイス > Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
