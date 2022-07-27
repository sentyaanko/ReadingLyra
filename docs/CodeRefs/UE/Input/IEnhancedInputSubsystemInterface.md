## IEnhancedInputSubsystemInterface

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > IEnhancedInputSubsystemInterface](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/IEnhancedInputSubsystemInterface/)

> Includes native functionality shared between all subsystems  
> 
> ----
> 全サブシステムで共有されるネイティブ機能を含む

* 概要
	* EnhancedInput を利用するためのサブシステムのための実装クラス。
	* [UEnhancedInputLocalPlayerSubsystem] に持たれる。

### IEnhancedInputSubsystemInterface::GetPlayerInput()

* 概要
	* [UEnhancedPlayerInput] を取得するための純粋仮想関数。

### IEnhancedInputSubsystemInterface::InjectInputForAction()
### IEnhancedInputSubsystemInterface::InjectInputVectorForAction()

> Input simulation via injection. 
> Runs modifiers and triggers delegates as if the input had come through the underlying input system as FKeys.
> Applies action modifiers and triggers on top.
> 
> @param Action			The Input Action to set inject input for
> @param RawValue		The value to set the action to
> @param Modifiers		The modifiers to apply to the injected input.
> @param Triggers		The triggers to apply to the injected input.
> 
> ----
> インジェクションによる入力シミュレーション。
> あたかも入力が FKey として基礎となる入力システムを通ってきたかのように、モディファイアとトリガーのデリゲートを実行します。
> アクションモディファイアとトリガーを上位に適用します。
> 
> @param Action			インジェクション入力に設定する入力アクション。
> @param RawValue		アクションを設定する値。
> @param Modifiers		インジェクションされた入力に適用されるモディファイア。
> @param Triggers		インジェクションされた入力に適用するトリガー。

* 概要
	* キー入力があったかのように入力アクションを発生させる関数。
* Lyra での使われ方
	* `W_QuickBarSlot` ([ULyraTaggedWidget]) で、ボタンをクリックされた際などに利用。






<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraTaggedWidget]: ../../Lyra/Widget/ULyraTaggedWidget.md#ulyrataggedwidget
[UEnhancedInputLocalPlayerSubsystem]: ../../UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystem
[UEnhancedPlayerInput]: ../../UE/Input/UEnhancedPlayerInput.md#uenhancedplayerinput
