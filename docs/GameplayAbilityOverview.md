# 【UE5】Lyra に学ぶ GAS(概略) <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中では、`Gameplay Ability System` （以降 GAS と略します） が利用されています。  
このドキュメントは GAS について触れられている既存のドキュメントや動画へのリンク集です。  
リンクに併せて内容のメモを記していますので、詳細を知りたい物がありましたらリンク先を参照してください。  

その他、以前からある GAS を使用しているプロジェクト ActionRPG/GASDocumentaion/GASShooter との差についても知っている範囲でまとめておきました。

UE4 からある内容については [【UE4】Gameplay Ability System を使い始めたい人向けの情報] を参照してください。

* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [Lyra を読む前に](#lyra-を読む前に)
	- [総合](#総合)
	- [「 Subsystem 」に関して](#-subsystem-に関して)
	- [「 Modular Game Features 」に関して](#-modular-game-features-に関して)
	- [「 Enhanced Input 」に関して](#-enhanced-input-に関して)
- [参考リンク：公式](#参考リンク公式)
	- [GAS の公式ドキュメント](#gas-の公式ドキュメント)
	- [Lyra サンプル ゲーム](#lyra-サンプル-ゲーム)
- [Lyra のアビリティ 補足](#lyra-のアビリティ-補足)
- [ActionRPG/GASDocumentaion/GASShooter を知っている方向け](#actionrpggasdocumentaiongasshooter-を知っている方向け)
- [終わりに](#終わりに)



# Lyra を読む前に

Lyra では以下の機能を使っています。

* Subsystem
* Modular Game Features
* Enhanced Input

これらについての参考となるリンクを挙げておきます。

## 総合

* [Modular Game Features in UE5: プラグアンドプレイ、 Unreal な方法で]
	* Inside Unreal （動画）の紹介記事。
	* [Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 8:10]
		*  本編開始。
		* 「古代の谷」を使った説明があります。
		* プレビュー版の頃の解説です。
		* アセットマネージャとの連携についても述べられていますので、そちらの知識もあると望ましいです。
* [ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】] 
	* CEDEC 2021 の資料で、 UE5 で追加された機能について書かれています。  
* [ドクセル > 2021/10/2 > 出張ヒストリア！ ゲーム開発勉強会2021 > 目指せ脱UE4初心者！？知ってると開発が楽になる便利機能を紹介 - DataAsset, Subsystem, GameplayAbility編 -]
	* おかずさんのわかりやすい説明で安心です。

## 「 Subsystem 」に関して

* [Unreal Engine 5.0 Documentation > プログラミング サブシステム]
	* 公式ドキュメント。
* [Youtube > Unreal Engine > Programming Subsystems ｜ Live from HQ ｜ Inside Unreal]
	* 2019/10/18 の動画なので古いですが、 Subsystem の解説です。
* [ドクセル > 2021/10/2 > 出張ヒストリア！ ゲーム開発勉強会2021 > 目指せ脱UE4初心者！？知ってると開発が楽になる便利機能を紹介 - DataAsset, Subsystem, GameplayAbility編 - > p46]
	* おかずさんのわかりやすい説明で安心です。

## 「 Modular Game Features 」に関して

* Mod のようにゲームの仕組みを追加するシステム。
* [Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 40:56]
	* Game Feature Module でアビリティの追加を行っている説明
* [Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]
	* Game Feature Module に関する説明。
* [ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]
	* Game Features & Modular Gameplay という題で説明があります。
	* 時間が経っている（2022/04/11 現在）ので、ドクセル内のプレゼン資料から公式ドキュメントへのリンクは無くなっているものが多いので注意です。
		* ```https://docs.unrealengine.com/5.0/ja/GameplayFeatures/``` 以下はまるごと無いですし、「Game Features」等でドキュメントを検索してもほとんどデッドリンクです。
* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]
	* 古代の谷のドキュメント内での説明。

## 「 Enhanced Input 」に関して

* [【UE5】Lyra に学ぶ Enhanced Input] を参照してください。


# 参考リンク：公式

## GAS の公式ドキュメント

* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム]
* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > ゲームプレイ アビリティ]
* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > アビリティ システム コンポーネントと属性]
* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > ゲームプレイ アトリビュートとゲームプレイ エフェクト]
* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > アビリティ タスク]

UE4 の頃からあるドキュメントです。  
内容は 99% UE4 と同じなので、そちらをみたことがある方はみないでも良いと思います。  

> note:  
> 変化があったのは UE4 の頃に存在した ARPG に関するドキュメントのリンクです。  
> UE5 のドキュメントでは存在しなくなっているため、その部分だけ文章とリンク先が変わっています。  

> note:  
> 「アビリティ システム コンポーネントと属性」 だけは 5.0 から新規のドキュメントです。  

内容は同じですが、 URL の命名規則が変わっているらしいので、一応リンクを記載しておきます。  

> note:  
> **命名規則** は、ドキュメント階層を含んだキャメルケースだったものが、ケバブケースになったように見えます。  


## Lyra サンプル ゲーム

[マーケットプレイス > Lyra Starter Game]

UE5 の機能を使った、新しいサンプルプロジェクトです。  
ドキュメント上では 「Lyra サンプル ゲーム」と称され、マーケットプレイス上では「Lyra Starter Game」と称されています。  

* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム]
	* プロジェクトの概要と取扱説明書のような内容です。
	* 子階層には 8 ページほど詳細なドキュメントがあります。  
	* ~~ページ名に **(一部日本語準備中)** とあるとおり、英文のままで翻訳されていない部分、訳が怪しい部分があることを念頭に読む必要があります。~~ 準備中の記述はなくなりました。
* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > ゲームプレイ タグ バインディング]
	* アニメーションと GameplayTag の設定について書かれています。
	* ソースコードの ULyraAnimInstance の GameplayTagPropertyMap やその使われ方なども合わせてみておくと良いと思います。
* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra インタラクション システム]
	* GAS を使用したインタラクションシステムの説明です。
* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ]
	* ~~まだ翻訳されていません。（2022/04/11 現在）~~ 翻訳されました。（2022/04/14 現在）
	* **Lyra のアビリティの概要を知るのに一番良いドキュメント** だと思います。
	* 詳しくは [Lyra のアビリティ 補足] を参照してください。


参考リンクのまとめは以上です。

# Lyra のアビリティ 補足

[Lyra のアビリティ] は Lyra での GAS の情報が濃縮されており、しっかり読み込もうとするとボリュームがあります。  
そこで、見出しをリスト化し、各セクションで扱っている話題の補足を追記したものを以下にまとめました。  

* Gameplay Ability System の内容と使用する理由
* ULyraAbilitySystemComponent
	* ALyraPlayerState
		> PlayerState に ASC を所有させるメリットや関連するコンポーネント（ULyraHeroComponent/ULyraPawnExtensionComponent）等の話。
	* ALyraGameState
	* Game Phase Abilities (ゲーム フェーズ アビリティ)
	* 入力タグ アクティベーション サポート
		> 前述の InputTag によるアビリティのアクティブ化の話。
	* 拡張されたタグ関係システム
		> 元々 GameplayAbility でも存在する、 GameplayTag によるアビリティのアクティブ化のブロック等の定義を別アセットに持たせる仕組み。
* ULyraGlobalAbilitySystem
	> 各 Actor に所有されている ASC 全体に対して処理を行う仕組み等。
* ULyraAbilitySet
	> GameplayAbility/GameplayEffect/AttributeSet を付与する仕組みとその方法。
* ULyraGameplayAbility
	* Activation Group (アクティベーション グループ)
		> 同じグループに所属するアビリティを制御するための仕組み。
	* Activation Policy (アクティベーション ポリシー)
		> アクティブ化に関する設定。具体例の記述あり。
	* K2_CanActivateAbility
	* 追加のコスト
		> 元々 GameplayAbility でも存在する、 Cost の独自拡張の仕組みとその方法。
	* 追加済みイベントと削除済みイベント
		> アビリティの付与や削除の際に発生する独自のイベントの仕組み。
	* カメラ モード
		> デスカメラの仕組み。
	* タイプ タグ
		> GameplayTag の階層の扱いの話。
	* ネイティブ アビリティ サブクラス
		> C++ で実装されているアビリティの話。 5 つの具体例あり。
	* ブループリント アビリティ サブクラス
		> ブループリントで実装されているアビリティの話。 8 つの具体例あり。
* FLyraGameplayEffectContext
	> Gameplay Cue に送るデータの話。
	* 含まれる追加データの種類
	* 追加データのアクセス方法
* ULyraAttributeSet
	* ULyraHealthSet
	* ULyraCombatSet
	* 回復とダメージの仕組み
		* 回復の実行
		* ダメージの実行
* 追加情報
	* ダメージ数の仕組み
		> UGameplayEffectExecutionCalculation の話。
	* Lyra キャラクターを初期化する方法
		> ULyraPawnData/UPawnExtensionComponent/GameFeature によるアビリティ等の付与やアクティブ化等の話。
* ブループリントアセットの命名規則


# ActionRPG/GASDocumentaion/GASShooter を知っている方向け

Lyra での GAS の利用の仕方や拡張部分のうち、 ActionRPG/GASDocumentaion/GASShooter から無くなった・変わったものを挙げます。  
Lyra でどうなったかのみ述べ、以前の方法については触れません（長くなる為）。  
概念自体が新たに追加されているものについてはここでは述べません。  
（私が知っている範囲だけなので、漏れはたくさんあると思います）

* 全般
	* 実装されていない（代替もない）もの
		* FPV 用の仕組み（複数の Mesh のモンタージュ制御やローカル制御等）
	* LooseGameplayTag
		* AbilitySystemBlueprintLibrary で以下の関数が定義されました。
			* AddLooseGameplayTags
			* RemoveLooseGameplayTags
		* これらを利用して、ブループリントから Actor に対してルーズな GameplayTag の追加・削除が可能になりました。
* AbilitySystemComponent
	* 保持する Actor
		* **GameState** も保持しています。 そこでは後述の「ゲームの Phase 制御アビリティ」を制御しています。
* GameplayAbility
	* 実装されていない（代替もない）もの
		* EffectContainerMap
	* アビリティの有効化
		* 付与（スポーン）時、入力時等を指定できるようにしています。
	* 入力
		* GameplayTag(InputTag) を利用しています。
			* 入力自体は Enhanced Input を利用し、その内容を GameplayTag(InputTag) を通じて GameplayAbility に渡しています。
			* つまり、 Enhanced Input と GameplayAbility に直接的な関係はありません。
	* アビリティの種類
		* ゲームの Phase 制御アビリティ（開始前、ゲーム中等）があります。
* Character
	* ULyraPawnExtensionComponent の利用
		* ASC のセットアップや初期化に関する処理をそちらで行うようになっています。
		* その結果、キャラクタークラスでの ASC の利用がスッキリしています。
	* スポーン時のアビリティの付与
		* ULyraPawnData データアセットに従って行うようになっています。


# 終わりに

本当は、 Lyra で実装されているクラス群についてや、各 GameplayAbility で行っていることについて言及しようと考えていました。  
ですが、有益な既存のドキュメントがたくさんありましたので、まずはそちらの紹介を優先しました。
追々、ここで触れなかった、突っ込んだ内容をまとめるかもしれません。


-----
おしまい。

<!--- ページ内のリンク --->
[Lyra を読む前に]: #lyra-を読む前に
[総合]: #総合
[「 Subsystem 」に関して]: #-subsystem-に関して
[「 Modular Game Features 」に関して]: #-modular-game-features-に関して
[「 Enhanced Input 」に関して]: #-enhanced-input-に関して
[参考リンク：公式]: #参考リンク公式
[GAS の公式ドキュメント]: #gas-の公式ドキュメント
[Lyra サンプル ゲーム]: #lyra-サンプル-ゲーム
[Lyra のアビリティ 補足]: #lyra-のアビリティ-補足
[ActionRPG/GASDocumentaion/GASShooter を知っている方向け]: #actionrpggasdocumentaiongasshooter-を知っている方向け
[終わりに]: #終わりに

<!--- 関連ドキュメント --->
<!--- qiita
[【UE5】Lyra に学ぶ Enhanced Input]: https://qiita.com/sentyaanko/items/dd4990d4aa0e84478b59
--->
<!--- github --->
[【UE5】Lyra に学ぶ Enhanced Input]: InputTag.md

<!--- qiita --->
[【UE4】Gameplay Ability System を使い始めたい人向けの情報]: https://qiita.com/sentyaanko/items/314ee39feb62ce67b885

<!--- 公式：5.0/Subsystem --->
[Unreal Engine 5.0 Documentation > プログラミング サブシステム]: https://docs.unrealengine.com/5.0/ja/programming-subsystems/

<!--- 公式：5.0/GAS --->
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-system-for-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > アビリティ システム コンポーネントと属性]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-system-component-and-gameplay-attributes-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > ゲームプレイ アビリティ]: https://docs.unrealengine.com/5.0/ja/using-gameplay-abilities-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > ゲームプレイ アトリビュートとゲームプレイ エフェクト]: https://docs.unrealengine.com/5.0/ja/gameplay-attributes-and-gameplay-effects-for-the-gameplay-ability-system-in-unreal-engine/
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ アビリティ システム > アビリティ タスク]: https://docs.unrealengine.com/5.0/ja/gameplay-ability-tasks-in-unreal-engine/

<!--- 公式：5.0/Lyra --->
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > ゲームプレイ タグ バインディング]: https://docs.unrealengine.com/5.0/ja/animation-in-lyra-sample-game-in-unreal-engine/#%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%97%E3%83%AC%E3%82%A4%E3%82%BF%E3%82%B0%E3%83%90%E3%82%A4%E3%83%B3%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra インタラクション システム]: https://docs.unrealengine.com/5.0/ja/lyra-sample-game-interaction-system-in-unreal-engine/

[Lyra のアビリティ]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/


<!--- 公式：5.0/古代の谷 --->
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > 「古代の谷」サンプル > Modular Gameplay を作成する]: https://docs.unrealengine.com/5.0/ja/valley-of-the-ancient-sample-game-for-unreal-engine/#modulargameplay%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B

<!--- 公式：マーケットプレイス --->
[マーケットプレイス > Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[マーケットプレイス > 古代の谷]: https://www.unrealengine.com/marketplace/en-US/product/ancient-game-01

[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra

<!--- 公式：blog --->
[Modular Game Features in UE5: プラグアンドプレイ、 Unreal な方法で]: https://www.unrealengine.com/ja/blog/modular-game-features-in-ue5-plug-n-play-the-unreal-way

<!--- 公式：youtube --->
[Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 8:10]: https://youtu.be/7F28p564kuY?list=PLZlv_N0_O1gbggHiwNP2JBXGeD2h12tbB&t=490
[Youtube > Unreal Engine > Modular Game Features ｜ Inside Unreal > 40:56]: https://youtu.be/7F28p564kuY?list=PLZlv_N0_O1gbggHiwNP2JBXGeD2h12tbB&t=2456
[Youtube > Unreal Engine > Programming Subsystems ｜ Live from HQ ｜ Inside Unreal]: https://www.youtube.com/watch?v=v5b1FvKBYzc
[Youtube > Unreal Engine > Modular Game Features in UE5: plug ‘n play, the Unreal way]: https://www.youtube.com/watch?v=3PBnqC7TxvM

<!--- docswell --->
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2
[ドクセル > 2021/8/26 > CEDEC2021 > Unreal Engine 5 早期アクセスの注目機能総おさらい Part 2【CEDEC 2021】 > p54]: https://www.docswell.com/s/EpicGamesJapan/KDJ34K-UE4_CEDEC2021_UE5EA_Part2#p54
[ドクセル > 2021/10/2 > 出張ヒストリア！ ゲーム開発勉強会2021 > 目指せ脱UE4初心者！？知ってると開発が楽になる便利機能を紹介 - DataAsset, Subsystem, GameplayAbility編 -]: https://www.docswell.com/s/historia_Inc/5WVYJK-ue4-dataasset-subsystem-gameplayability
[ドクセル > 2021/10/2 > 出張ヒストリア！ ゲーム開発勉強会2021 > 目指せ脱UE4初心者！？知ってると開発が楽になる便利機能を紹介 - DataAsset, Subsystem, GameplayAbility編 - > p46]: https://www.docswell.com/s/historia_Inc/5WVYJK-ue4-dataasset-subsystem-gameplayability#p46


