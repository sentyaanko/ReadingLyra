## UInputModifier

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UInputModifier](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UInputModifier/)

> Base class for building modifiers.
> 
> ----
> モディファイアを構築するための基本クラスです。

* 概要
	* [UInputAction::Modifiers] で指定する、 Trigger に渡す前に入力値を加工するためのクラスです。
	* エンジン側で用意されている [UInputModifier] 派生クラスは以下の通りです。
		| 表示名                         | クラス名                                   | 概要                                                                                                                                     |
		|--------------------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
		| Dead Zone                      | UInputModifierDeadZone                     | LowerThreshold -> UpperThreshold の範囲内の入力値は、 <br> 0 -> 1にリマップされます。この範囲外の値はクランプされます。                  |
		| Scalar                         | UInputModifierScalar                       | 軸毎に設定された倍率で入力を拡大縮小します。                                                                                             |
		| Negate                         | UInputModifierNegate                       | 軸毎に入力を反転させます。                                                                                                               |
		| Smooth                         | UInputModifierSmooth                       | 複数のフレームに渡って入力を滑らかにします。                                                                                             |
		| Response Curve - Exponential   | UInputModifierResponseCurveExponential     | 入力値に対して、軸毎に単純な指数応答カーブを適用します。                                                                                 |
		| Response Curve - User Defined  | UInputModifierResponseCurveUser            | 入力値に対して、軸毎にカスタム応答カーブを適用します。                                                                                   |
		| FOV Scaling                    | UInputModifierFOVScaling                   | 入力値に対して、軸毎にFOV依存のスケーリングを適用します。                                                                                |
		| To World Space                 | UInputModifierToWorldSpace                 | 入力されたアクションバリュー内の軸をワールド空間に自動変換し、 <br> ワールド空間の値を取る関数に結果を直接プラグインできるようにします。 |
		| Swizzle Input Axis Values      | UInputModifierSwizzleAxis                  | 入力値の軸成分をスウィズルする。 <br> 1次元の入力を2次元のアクションのY軸にマッピングするのに便利です。                                  |
		| Modifier Collection            | UInputModifierCollection                   | 複数のアクションやマッピングに簡単に適用でき、 <br> 重複作業を省くことができるユーザー定義可能なモディファイアのグループです。           |
* Lyra での使われ方
	* Lyra 側で用意されている [UInputModifier] 派生クラスは以下の通りです。
		| 表示名                         | クラス名                                   | 概要                                                                                                                                     |
		|--------------------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
		| Aim Assist Input Modifier      | UAimAssistInputModifier                    | ゲームパッドプレイヤーがより良いターゲティングができるようにするための <br> 入力モディファイアです。                                     |
		| Setting Based Scalar           | ULyraSettingBasedScalar                    | SharedUserSettings の double プロパティに基づき、 <br> 入力をスケーリングします。                                                        |
		| Lyra Settings Driven Dead Zone | ULyraInputModifierDeadZone                 | これはデッドゾーン入力修正で、 <br> Lyra Shared game settings にあるものが閾値となります。                                               |
		| Lyra Gamepad Sensitivity       | ULyraInputModifierGamepadSensitivity       | Lyra Shared game settings の現在のゲームパッド設定に基づく <br> スカラーモディファイアを適用します。                                     |
		| Lyra Aim Inversion Setting     | ULyraInputModifierAimInversion             | Lyra Shared game settings の設定に基づく、 <br> 軸値の反転を適用します。                                                                 |


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UInputAction::Modifiers]: ../../UE/Input/UInputAction.md#uinputactionmodifiers
[UInputModifier]: ../../UE/Input/UInputModifier.md#uinputmodifier
