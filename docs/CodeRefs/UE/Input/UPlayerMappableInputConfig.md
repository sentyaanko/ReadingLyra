## UPlayerMappableInputConfig

> note: 時期的な問題か、リファレンスが存在しない。
> [Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UInputMappingContext](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UPlayerMappableInputConfig/)

> This represents one set of Player Mappable controller/keymappings.   
> You can use this input config to create the default mappings for your player to start with in your game.  
> It provides an easy way to get only the player mappable key actions, 
> and it can be used to add multiple UInputMappingContext's at once to the player.
> 
> Populate this data asset with Input Mapping Contexts that have player bindable actions in them.   
> 
> ----
> これは、プレイヤーのマッピング可能なコントローラー/キーマッピングの1つのセットを表します。  
> この入力構成を使用して、プレイヤーがゲームを開始するためのデフォルトのマッピングを作成できます。  
> プレイヤーのマッピング可能なキーアクションのみを取得する簡単な方法を提供し、  
> 複数の UInputMappingContext をプレイヤーに一度に追加するために使用できます。  
> 
> このデータアセットに、プレイヤーのバインド可能なアクションを含む入力マッピングコンテキストを入力します。

* 概要
	* [UInputMappingContext] を保持する、
* Lyra での使われ方
	* 操作方法単位で用意している。
	* 命名規則は `PMI_` で始まる。
	* アセット一覧と用途
		| アセット名                       | 用途                                               |
		|----------------------------------|----------------------------------------------------|
		| PMI_Default_Gamepad              | デフォルトのゲームパッド設定                       |
		| PMI_Default_KBM                  | デフォルトのキーボードマウス設定                   |
		| PMI_ShooterDefaultConfig_Gamepad | シューターゲームのデフォルトのゲームパッド設定     |
		| PMI_ShooterDefaultConfig_KBM     | シューターゲームのデフォルトのキーボードマウス設定 |

## UPlayerMappableInputConfig::Contexts

* 概要
	* [UInputMappingContext] と Priority の連想配列で、 EnhancedInput に登録する際などに利用される。
	* Priority は [IEnhancedInputSubsystemInterface::RebuildControlMappings()] にて参照され、値が大きいほど優先的に登録される。
	* 登録の際、指定された `Key` ([UInputMappingContext::Mappings] の [FEnhancedActionKeyMapping::Key]) が既に使われている場合は登録が行われない。
	* 以下は ADS の際のカメラ操作がどの様に優先されるのかの大まかな流れ。
		* `PMI_ShooterDefaultConfig_Gamepad` ([UPlayerMappableInputConfig]) では `IMC_ShooterGame_Gamepad` ([UInputMappingContext]) が Priority 10 で設定している。
		* `GA_ADS` では `IMC_ADS_Speed` ([UInputMappingContext]) を Priority 11 で設定している。
		* `IMC_ShooterGame_Gamepad` / `IMC_ADS_Speed` はどちらも `IA_Look_Stick` ([UInputAction]) に関連付ける `key` に  `Gamepad Right Thumbstick 2D-Axis` を指定している。
		* Priority は `GA_ADS` のほうが大きいため、 `GA_ADS` がアクティブの間は `IMC_ADS_Speed` の設定が有効となる。
		* 要は、 `IA_Look_Stick` の挙動を Priority を利用して一時的に変更している。




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FEnhancedActionKeyMapping::Key]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingkey
[IEnhancedInputSubsystemInterface::RebuildControlMappings()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfacerebuildcontrolmappings
[UInputAction]: ../../UE/Input/UInputAction.md#uinputaction
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
[UInputMappingContext::Mappings]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontextmappings
[UPlayerMappableInputConfig]: ../../UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
