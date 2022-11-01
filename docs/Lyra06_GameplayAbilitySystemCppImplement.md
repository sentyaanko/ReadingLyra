# 【UE5】Lyra に学ぶ(06) GameplayAbilitySystem C++ 実装 <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中では、`Gameplay Ability System` (以降 GAS と略します) が利用されています。  
このドキュメントは GAS 関連の C++ で実装されている機能についての解説です。  

* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [Lyra で独自実装してている仕組み](#lyra-で独自実装してている仕組み)
	- [ヘルスの管理方法](#ヘルスの管理方法)
	- [タグリレーションマッピングについて](#タグリレーションマッピングについて)
	- [ULyraPawnExtensionComponent と ULyraHeroComponent と GAS](#ulyrapawnextensioncomponent-と-ulyraherocomponent-と-gas)
- [終わりに](#終わりに)


# Lyra で独自実装してている仕組み

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ネイティブ アビリティ サブクラス]
		* ネイティブで実装された GameplayAbility の一部の解説があります。
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ブループリント アビリティ サブクラス]
		* ブループリントで実装された GameplayAbility の一部の解説があります。
		* ネイティブの方と比較すると、こちらはかなり詳しい内容です。

## ヘルスの管理方法

Lyra のプレイヤーキャラクターはヘルスの値を持っており、 0 になると死亡扱いとなりその後リスポーンが行われたりします。  

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ULyraAttributeSet]
		* [ULyraAttributeSet] / [ULyraHealthSet] / `ULyraCombatSet` などのクラスの解説があります。
		* 「回復とダメージの仕組み」 / 「ダメージ数の仕組み」 の解説もあります。
* 概要
	* ヘルスの値は AttributeSet で保持しています。
		* AttributeSet に関して、詳しくは GameplayAbility のドキュメントを参照してください。
	* Player の場合は PlayerState に AttributeSet を追加しています。
	* Player 以外の場合は [ALyraCharacterWithAbilities] に AttributeSet を追加しています。
		> MEMO: 派生ブループリントとして `B_ShootingTarget` がありますが、それを含めて、このクラスはどのレベルにも配置されていません。
	* AttributeSet を直接参照することは殆どなく、 [ULyraHealthComponent] を介して値の参照等を行います。
		* ExecutionCalculation である [ULyraHealExecution] と [ULyraDamageExecution] が例外的に直接アクセスします。
	* リスポーンに関して
		* `ControlPoints` / `Elimination` ではエクスペリエンスの設定により付与された `GA_AutoRespawn` によって行われています。
		* `TopDownArena` ([UGameFeatureData]) ではこのアビリティが付与されていないため、リスポーンが行われません。
		* `TopDownArena` ([UGameFeatureData]) では爆風で一撃死しますが、特別なことはしておらず、ヘルスの値により死亡判定が行われています。
* Lyra で実装しているクラス
	* [ULyraAttributeSet]
		* `UAttributeSet` の派生クラスで、 Lyra のアトリビュートセットの基底クラスです。
	* [ULyraHealthSet]
		* [ULyraAttributeSet] の派生クラスで、ヘルスアトリビュートセットです。
	* [ALyraPlayerState]
		* プレイヤーは PlayerState クラスに [ULyraHealthSet] を追加しています。
	* [ALyraCharacterWithAbilities]
		* プレイヤー以外のヘルスを持つキャラクターの基底クラスで、 [ULyraHealthSet] を追加しています。
		* 派生クラスに `B_ShootingTarget` があります。
	* [ULyraHealthComponent]
		* プレイヤーのヘルスを制御するためのコンポーネントで、 [ULyraHealthSet] を参照しています。
		* ブループリントでヘルスに関する情報は基本的にここを経由します。
	* [ALyraCharacter]
		* プレイヤー用のキャラクター基底クラスで、 [ULyraHealthComponent] を追加しています。
	* [ULyraHealExecution]
		* ヘルスを回復させる ExecutionCalculation 。
	* [ULyraDamageExecution]
		* ヘルスを減少させる ExecutionCalculation 。


## タグリレーションマッピングについて

Lyra では GameplayAbility のブロックやキャンセルを独自のデータアセットをもとに定義、制御しています。  

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]
		* 公式ドキュメントにも簡潔に説明があります。
* Lyra で実装しているクラス
	* [FLyraAbilityTagRelationship]
		* アビリティの関係を定義するための構造体。
	* [ULyraAbilityTagRelationshipMapping]
		* [FLyraAbilityTagRelationship] の配列を保持するデータアセット。
	* [ULyraPawnData]
		* [ULyraAbilityTagRelationshipMapping] を保持するデータアセット。
	* [ULyraAbilitySystemComponent]
		* [ULyraAbilityTagRelationshipMapping] のキャッシュを保持しています。
			* これはプレイヤーのポーン初期化時に [ULyraPawnData] の内容が設定されています
		* アビリティの有効化判定の処理をオーバーライドし、 [ULyraAbilityTagRelationshipMapping] のチェック関数を利用する拡張をしています。


## ULyraPawnExtensionComponent と ULyraHeroComponent と GAS

Lyra では、 GAS の制御をコンポーネントを利用して行っています。

* 概要
	* GAS の制御は、 [ULyraPawnExtensionComponent] と [ULyraHeroComponent] が連携して動いています。
* Lyra で実装しているクラス
	* [ILyraReadyInterface]
		* コンポーネントの準備状態を判定するための関数を定義した基底クラスです。
	* [ULyraPawnComponent]
		* [ILyraReadyInterface] の基底クラスを持つ、ポーン用のコンポーネント基底クラスです。
	* [ULyraPawnExtensionComponent]
		* ASC の初期化と、他のコンポーネントの初期化状態を管理するコンポーネント。
	* [ULyraHeroComponent]
		* ASC の各種機能の利用、入力制御などを行うコンポーネント。

関係は以下のような形。

![Lyra_CharacterAndComponents]

[ULyraPawnExtensionComponent] / [ULyraHeroComponent] に関しては [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ALyraPlayerState] にて以下の記述があります。

> Lyra ではこれを ULyraHeroComponent および ULyraPawnExtensionComponent を通じて対応します。  
> これらのコンポーネントは、有効なコントローラーで所有されたときに、Abilities、Attributes、Gameplay Effects の特定セットを  
> PlayerState の AbilitySystemComponent に付与する処理を担当します。  
> これらは、ポーンが除外、所有解除、またはプレイから他の方法で削除されたときに、自動的に取り消されます。  

この 2 つのクラスの特徴は概ね以下のようになります。

|                               | [ULyraPawnExtensionComponent]                | [ULyraHeroComponent]                                 |
| ----------------------------- | -------------------------------------------- | ---------------------------------------------------- |
| 他方を参照するか              | 参照しない                                   | 参照する                                             |
| アビリティ関連の役割          | キャラクターに依らない ASC の初期化/終了関連 | キャラクターに依る、アビリティの付与、アクティブ化等 |
| 追加する Pawn                 | [ALyraCharacter]                             | `B_Hero_Default`                                     |
| コンポーネントの動作          | 追加だけでは影響を与えない                   | 追加だけで動作する                                   |
| Pawn からの利用方法           | 必要に応じてメンバ関数を呼び出す             | メンバ関数の呼び出しはしていない                     |
| 参照元クラス                  | [ALyraCharacter]                             | [ULyraGameplayAbility]                               |
|                               | [ULyraHeroComponent]                         | [UGameFeatureAction_AddInputBinding]                 |
|                               | [ALyraGameMode]                              | [UGameFeatureAction_AddInputContextMapping]          |
|                               | [ALyraPlayerState]                           |                                                      |
|                               | [ULyraBotCreationComponent]                  |                                                      |
|                               | [ULyraCheatManager]                          |                                                      |
| [ALyraCharacter] を参照するか | する(`Crouch` 関連)                          | しない                                               |

> note:  
> * キャラクターに依存する/しないでクラスを分けることで、異なる付与ルールのキャラクターを新たに追加しやすくしている。
> * 依存しない部分については [ULyraPawnExtensionComponent] で実装し [ALyraCharacter] に追加している。
> * [ALyraCharacter] を派生することで、その機能を利用できるようにしている。
> 
> 例えば、 Hero とは異なるルールのキャラクターを作りたい場合は以下のようなる。  
> * [ULyraHeroComponent] のようなクラスを別途作る
> * `B_Hero_Default` のような [ALyraCharacter] 派生 BP クラスを別途作り、上記のコンポーネントを追加する


# 終わりに

GAS に関わるネイティブ実装のうち、主に仕組みに関わる部分について大まかにまとめました。  
すべてをまとめきれてはいないドキュメントですが、どなたかの参考になれば幸いです。


-----
おしまい。

<!--- ページ内のリンク --->
[【UE5】Lyra に学ぶ GAS(Blueprint)]: GameplayAbilityBlueprint.md

<!--- 自前の画像へのリンク --->
[Lyra_CharacterAndComponents]: images/Lyra_CharacterAndComponents.png

<!--- generated --->
[ULyraBotCreationComponent]: CodeRefs/Lyra/Etc/ULyraBotCreationComponent.md#ulyrabotcreationcomponent
[ULyraCheatManager]: CodeRefs/Lyra/Etc/ULyraCheatManager.md#ulyracheatmanager
[UGameFeatureAction_AddInputBinding]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md#ugamefeatureaction_addinputbinding
[UGameFeatureAction_AddInputContextMapping]: CodeRefs/Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureaction_addinputcontextmapping
[ALyraCharacterWithAbilities]: CodeRefs/Lyra/GameplayAbility/ALyraCharacterWithAbilities.md#alyracharacterwithabilities
[FLyraAbilityTagRelationship]: CodeRefs/Lyra/GameplayAbility/FLyraAbilityTagRelationship.md#flyraabilitytagrelationship
[ILyraReadyInterface]: CodeRefs/Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterface
[ULyraAbilitySystemComponent]: CodeRefs/Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraAbilityTagRelationshipMapping]: CodeRefs/Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraAttributeSet]: CodeRefs/Lyra/GameplayAbility/ULyraAttributeSet.md#ulyraattributeset
[ULyraDamageExecution]: CodeRefs/Lyra/GameplayAbility/ULyraDamageExecution.md#ulyradamageexecution
[ULyraGameplayAbility]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraHealExecution]: CodeRefs/Lyra/GameplayAbility/ULyraHealExecution.md#ulyrahealexecution
[ULyraHealthComponent]: CodeRefs/Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponent
[ULyraHealthSet]: CodeRefs/Lyra/GameplayAbility/ULyraHealthSet.md#ulyrahealthset
[ULyraHeroComponent]: CodeRefs/Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponent
[ULyraPawnComponent]: CodeRefs/Lyra/GameplayAbility/ULyraPawnComponent.md#ulyrapawncomponent
[ULyraPawnExtensionComponent]: CodeRefs/Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ALyraCharacter]: CodeRefs/Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ALyraGameMode]: CodeRefs/Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraPlayerState]: CodeRefs/Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ULyraPawnData]: CodeRefs/Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[UGameFeatureData]: CodeRefs/UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ALyraPlayerState]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#alyraplayerstate
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ULyraAttributeSet]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#ulyraattributeset
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ネイティブ アビリティ サブクラス]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%82%A2%E3%83%93%E3%83%AA%E3%83%86%E3%82%A3%E3%82%B5%E3%83%96%E3%82%AF%E3%83%A9%E3%82%B9
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ブループリント アビリティ サブクラス]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E3%83%96%E3%83%AB%E3%83%BC%E3%83%97%E3%83%AA%E3%83%B3%E3%83%88%E3%82%A2%E3%83%93%E3%83%AA%E3%83%86%E3%82%A3%E3%82%B5%E3%83%96%E3%82%AF%E3%83%A9%E3%82%B9
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E6%8B%A1%E5%BC%B5%E3%81%95%E3%82%8C%E3%81%9F%E3%82%BF%E3%82%B0%E9%96%A2%E4%BF%82%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0
