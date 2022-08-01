## UInputMappingContext

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UInputMappingContext](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UInputMappingContext/)

> UInputMappingContext : A collection of key to action mappings for a specific input context
> Could be used to:
>	- Store predefined controller mappings (allow switching between controller config variants). TODO: Build a system allowing redirects of UInputMappingContexts to handle this.
>	- Define per-vehicle control mappings
>	- Define context specific mappings (e.g. I switch from a gun (shoot action) to a grappling hook (reel in, reel out, disconnect actions).
>	- Define overlay mappings to be applied on top of existing control mappings (e.g. Hero specific action mappings in a MOBA)
> 
> ----
> UInputMappingContext : 特定の入力コンテキストに対する、キーとアクションのマッピングのコレクションです。
> 以下のような用途に使用できます。
> 	- 定義済みのコントローラマッピングを保存する (コントローラ設定のバリエーションを切り替えることができる)。 TODO: UInputMappingContexts のリダイレクトを可能にするシステムを構築して、これを処理する。
> 	- 車両ごとの制御マッピングを定義する。
> 	- コンテキスト固有のマッピングを定義する（例：銃（撃つアクション）から鉤（巻き取る、巻き戻す、切断するアクション）に切り替える）。
> 	- 既存のコントロールマッピングの上に適用するオーバーレイマッピングの定義（例：MOBAのヒーロー固有のアクションマッピングなど）

* 概要
	* [UInputAction] に対して物理的な入力のマッピングをまとめて作成するためのデータアセットです。
	* 物理的な入力が発生した際に入力アクションが発生するように [IEnhancedInputSubsystemInterface::AddMappingContext()] 等で追加します。
* Lyra での使われ方
	* 適用単位毎に用意しています。
	* 命名規則は `IMC_` で始まります。
	* アセット一覧と用途は以下の通りです。
		| アセット名              | 用途                                                             |
		|-------------------------|------------------------------------------------------------------|
		| IMC_Default_Gamepad     | デフォルトのキーボードマウス設定。                               |
		| IMC_Default_KBM         | デフォルトのキーボードマウス設定。                               |
		| IMC_ShooterGame_Gamepad | シューターゲームのゲームパッド設定。                             |
		| IMC_ShooterGame_KBM     | シューターゲームのキーボードマウス設定。                         |
		| IMC_ADS_Speed           | ADS の際のマウスとゲームパッドの入力設定を上書きするための設定。 |
		| IMC_InventoryTest       | インベントリ操作用の設定？解説は割愛。                           |
	* このクラスを参照しているクラスは以下の通りです。
		* [UPlayerMappableInputConfig]
			* プレイヤーに追加する [UInputMappingContext] を指定しています。
		* [ULyraExperienceActionSet]
			* エクスペリエンスに紐づく入力マッピング追加のパラメータとして [UInputMappingContext] を指定しています。
		* Gameplay Ability
			* `GA_ADS` 内で ADS 用の操作 `IMC_ADS_Speed` を一時的にマッピングするのに利用しています。

### UInputMappingContext::Mappings

> List of key to action mappings.
> 
> ----
> キーからアクションへのマッピングのリストです。

* 概要
	* [FEnhancedActionKeyMapping] の配列です。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[FEnhancedActionKeyMapping]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymapping
[IEnhancedInputSubsystemInterface::AddMappingContext()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceaddmappingcontext
[UInputAction]: ../../UE/Input/UInputAction.md#uinputaction
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
[UPlayerMappableInputConfig]: ../../UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
