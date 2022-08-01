## UInputTrigger

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UEnhancedPlayerInput](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UEnhancedPlayerInput/)

> Base class for building triggers.
> Transitions to Triggered state once the input meets or exceeds the actuation threshold.
> 
> ----
> トリガーを構築するための基本クラスです。
> 入力が作動閾値以上になるとトリガー状態に遷移する。

* 概要
	* [UInputAction::Triggers] で指定する、入力がなされたかを判定するためのクラスです。
	* エンジン側で用意されている [UInputTrigger] 派生クラスは以下の通りです。
		| 表示名           | クラス名                    | 概要                                                                                                                       |
		|------------------|-----------------------------|----------------------------------------------------------------------------------------------------------------------------|
		| Down             | UInputTriggerDown           | 入力が作動閾値を超えるとトリガーがかかります。                                                                             |
		| Pressed          | UInputTriggerPressed        | 入力が作動閾値を超えたときに1回だけトリガがかかります。 <br> 入力を維持すると、それ以上トリガはかかりません。              |
		| Released         | UInputTriggerReleased       | 入力が作動閾値を超える間、トリガは継続的に復帰します。 <br> 入力が作動閾値を下回ると1度だけトリガがかかります。            |
		| Hold             | UInputTriggerHold           | 入力が HoldTimeThreshold 秒間し続けると、トリガがかかります。 <br> トリガは1回だけ、または繰り返し起動させることができる。 |
		| Hold And Release | UInputTriggerHoldAndRelease | 入力が少なくとも HoldTimeThreshold 秒以上し続けた後、  <br>  入力が解放されたときにトリガがかかります。                    |
		| Tap              | UInputTriggerTap            | 入力が作動した後、 TapReleaseTimeThreshold 秒以内に解放されないとトリガーしません。                                        |
		| Pulse            | UInputTriggerPulse          | 入力が作動している間、秒単位のインターバルで発火するトリガー。                                                             |
		| Chorded Action   | UInputTriggerChordAction    | このトリガーのアクションがトリガーされるために必要なコードアクションを適用します。                                         |
* Lyra での使われ方
	* Lyra 側で用意されている [UInputTrigger] 派生クラスは以下の通りです。
		| 表示名           | クラス名                    | 概要                                                                                                                       |
		|------------------|-----------------------------|----------------------------------------------------------------------------------------------------------------------------|
		| Combo Action     | UInputTriggerComboAction    | すべての従属アクションが順番にトリガーされたときにトリガーされます。                                                       |


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UInputAction::Triggers]: ../../UE/Input/UInputAction.md#uinputactiontriggers
[UInputTrigger]: ../../UE/Input/UInputTrigger.md#uinputtrigger
