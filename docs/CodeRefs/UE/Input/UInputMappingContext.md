## UInputMappingContext

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UInputMappingContext](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UInputMappingContext/)

> UInputMappingContext : A collection of key to action mappings for a specific input context
> Could be used to:
>	Store predefined controller mappings (allow switching between controller config variants). TODO: Build a system allowing redirects of UInputMappingContexts to handle this.
>	Define per-vehicle control mappings
>	Define context specific mappings (e.g. I switch from a gun (shoot action) to a grappling hook (reel in, reel out, disconnect actions).
>	Define overlay mappings to be applied on top of existing control mappings (e.g. Hero specific action mappings in a MOBA)
> 
> ----
> UInputMappingContext : 特定の入力コンテキストに対する、キーとアクションのマッピングのコレクション
> 以下のような用途に使用できます。
> 	定義済みのコントローラマッピングを保存する (コントローラ設定のバリエーションを切り替えることができる)。 TODO: UInputMappingContexts のリダイレクトを可能にするシステムを構築して、これを処理する。
> 	車両ごとの制御マッピングを定義する。
> 	コンテキスト固有のマッピングを定義する（例：銃（撃つアクション）から鉤（巻き取る、巻き戻す、切断するアクション）に切り替える）。
> 	既存のコントロールマッピングの上に適用するオーバーレイマッピングの定義（例：MOBAのヒーロー固有のアクションマッピングなど）

### UInputMappingContext::Mappings

> List of key to action mappings.
> 
> ----
> キーからアクションへのマッピングのリスト。

* 概要
	* [FEnhancedActionKeyMapping] の配列です。
* 適用単位毎に用意している。
* 命名規則は ```IMC_``` で始まる。

| アセット名              | 用途                                                                                   |
|-------------------------|----------------------------------------------------------------------------------------|
| IMC_Default_Gamepad     | デフォルトのキーボードマウス設定                                                       |
| IMC_Default_KBM         | デフォルトのキーボードマウス設定                                                       |
| IMC_ShooterGame_Gamepad | シューターゲームのゲームパッド設定                                                     |
| IMC_ShooterGame_KBM     | シューターゲームのキーボードマウス設定                                                 |
| IMC_ADS_Speed           | ADS の際のマウスとゲームパッドの入力設定を上書きするための設定。設定内容の解説は割愛。 |
| IMC_InventoryTest       | インベントリ操作用の設定？解説は割愛。                                                 |





<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FEnhancedActionKeyMapping]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymapping
