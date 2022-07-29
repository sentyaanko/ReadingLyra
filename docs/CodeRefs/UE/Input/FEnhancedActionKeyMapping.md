## FEnhancedActionKeyMapping

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > FEnhancedActionKeyMapping](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/FEnhancedActionKeyMapping/)

> Defines a mapping between a key activation and the resulting enhanced action  
> An key could be a button press, joystick axis movement, etc.  
> An enhanced action could be MoveForward, Jump, Fire, etc.
> 
> ----
> キー操作とその結果の拡張アクションの間のマッピングを定義します。  
> キーは、ボタン操作、ジョイスティック軸の移動などが考えられます。  
> 拡張アクションは、MoveForward、Jump、Fireなどです。

* 概要
	* 物理的なキー [FEnhancedActionKeyMapping::Key] と仮想的な入力アクション [FEnhancedActionKeyMapping::Action] の関連付けを設定するための構造体です。
	* [UInputMappingContext::Mappings] によって保持されています。

### FEnhancedActionKeyMapping::Action

> Action to be affected by the key
> 
> ----
> キーによって影響を受けるアクション

* 概要
	* [UInputAction] です。
	* キーがどの様になったら発生するかは [FEnhancedActionKeyMapping::Triggers] で定義します。

### FEnhancedActionKeyMapping::Key

> Key that affect the action.
> 
> ----
> アクションに影響を与えるキー。

### FEnhancedActionKeyMapping::bIsPlayerMappable
> If true than this ActionKeyMapping will be exposed as a player bindable key
> 
> ----
> true の場合、この ActionKeyMapping はプレイヤーバインディング可能なキーとして公開されます。

### FEnhancedActionKeyMapping::PlayerMappableOptions
> Options for making this a player mappable keymapping
> 
> ----
> プレーヤーがマッピング可能なキーマッピングにするためのオプション

* 概要
	* 名前やカテゴリなどが指定でき、オプション画面等で任意に利用可能です。

### FEnhancedActionKeyMapping::bShouldBeIgnored
> If true, then this Key Mapping should be ignored. 
> This is set to true if the key is down during a rebuild of it's owning PlayerInput ControlMappings.
> 
> @see IEnhancedInputSubsystemInterface::RebuildControlMappings
> 
> ----
> true の場合、このKey Mappingは無視される。
> これは、所有している PlayerInput ControlMappings の再構築中にキーがダウンした場合に true に設定されます。
> [IEnhancedInputSubsystemInterface::RebuildControlMappings()] を参照してください。

### FEnhancedActionKeyMapping::Triggers
> Trigger qualifiers. If any trigger qualifiers exist the mapping will not trigger unless:
> If there are any Explicit triggers in this list at least one of them must be met.
> All Implicit triggers in this list must be met.
> 
> ----
> トリガー修飾子。トリガー修飾子が存在する場合、マッピングはトリガーされません。
> このリストに明示的なトリガーがある場合、そのうちの少なくとも1つを満たす必要があります。
> このリスト内のすべての暗黙的トリガーを満たす必要があります。

* 概要
	* [UInputTrigger] の配列です。

### FEnhancedActionKeyMapping::Modifiers
> Modifiers applied to the raw key value.
> These are applied sequentially in array order.
> 
> ----
> 生のキー値に適用されるモディファイア。
> これらは、配列の順番に適用されます。

* 概要
	* [UInputModifier] の配列です。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FEnhancedActionKeyMapping::Action]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingaction
[FEnhancedActionKeyMapping::Key]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingkey
[FEnhancedActionKeyMapping::Triggers]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymappingtriggers
[IEnhancedInputSubsystemInterface::RebuildControlMappings()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfacerebuildcontrolmappings
[UInputAction]: ../../UE/Input/UInputAction.md#uinputaction
[UInputMappingContext::Mappings]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontextmappings
[UInputModifier]: ../../UE/Input/UInputModifier.md#uinputmodifier
[UInputTrigger]: ../../UE/Input/UInputTrigger.md#uinputtrigger
