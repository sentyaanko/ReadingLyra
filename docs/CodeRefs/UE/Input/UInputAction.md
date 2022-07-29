## UInputAction

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UInputAction](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UInputAction/)

> Input action definition. These are instanced per player (via FInputActionInstance)
> 
> ----
> 入力アクションの定義。これらはプレーヤーごとにインスタンス化されます (FInputActionInstance 経由)。

* 概要
	* 物理的な入力に直接は紐付かない、入力の結果発生する事象を仮想的に表現するデータアセット。
* Lyra での使われ方
	* `IA_` のプレフィックスを持つ。
	* 26 種類ある。 `IA_Jump` / `IA_ADS` 等々。
	* widget ではクリックされた際に、 [IEnhancedInputSubsystemInterface::InjectInputForAction()] 等にこのクラスを渡している。
		* これにより仮想的なボタンを物理ボタンと同じように扱っている。

## UInputAction::Triggers

> Trigger qualifiers. If any trigger qualifiers exist the action will not trigger unless:
> - At least one Explicit trigger in this list is be met.
> - All Implicit triggers in this list are met.
> 
> ----
> トリガー条件。いずれかのトリガー修飾子が存在する場合、アクションは以下の場合を除きトリガーされません。
> - このリストにある少なくとも1つの明示的なトリガーが満たされている。
> - このリストのすべての暗黙的トリガが満たされている。

* 概要
	* [UInputTrigger] の配列。

## UInputAction::Modifiers

> Modifiers are applied to the final action value.
> These are applied sequentially in array order.
> They are applied on top of any FEnhancedActionKeyMapping modifiers that drove the initial input
> 
> ----
> 最終的なアクションの値にモディファイアが適用されます。
> これらは配列の順番に適用されます。
> これらは、最初の入力を駆動したすべての [FEnhancedActionKeyMapping] モディファイアの上に適用されます。

* 概要
	* [UInputModifier] の配列。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FEnhancedActionKeyMapping]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymapping
[IEnhancedInputSubsystemInterface::InjectInputForAction()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceinjectinputforaction
[UInputModifier]: ../../UE/Input/UInputModifier.md#uinputmodifier
[UInputTrigger]: ../../UE/Input/UInputTrigger.md#uinputtrigger
