## TurnYawAnimModifier

* 既存のドキュメント
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]
		* Animation Modifier についての解説です。
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション] > 所定の位置での旋回
		* 利用方法についての解説があります。
			> キャラクターがアイドル ステートで、オフセット モードが [AnimEnum_RootYawOffsetMode::Accumulate] に設定されている場合、アニメーションのルート回転を [ABP_Mannequin_Base::RootYawOffset] に適用する必要があります。  
			> この情報は、[TurnYawAnimModifier] を使用してカーブにベイクされるため、ソース アニメーションで Root Motion が有効である必要があります。
* 概要
	* `UAnimationModifier` の派生クラスです。
	* アニメーションカーブを自動生成するためのアニメーションモディファイアです。
	* モンタージュに設定することで、 [RootBoneName] (デフォルト値 `root`) で指定された名前のボーンの Yaw の変化に関する 2 つのアニメーションカーブを生成します。
		| カーブ名を指定するプロパティ<br>(デフォルト値)	| キーを打つフレーム	| 値																																	|
		|----												|----					|----																																	|
		| [TurnYawCurveName]<br>(`RemainingTurnYaw`)		| 全フレーム			| 最終値から現在値を引いた値<br>要は 最終値になった時点で 0 となる																		|
		| [WeightCurveName]<br>(`TurnYawWeight`)			| 3 箇所				| 0 フレーム目に 1<br>最終値と同じになる直前に 1<br>最終値と同じになる直後に 0<br>要は初期が 1 で 値が変化しなくなった時点で 0 となる	|
	* これらは TurnInPlace で利用します。

### RootBoneName

* 概要
	* Yaw の値を調べるボーンの名前です。
	* デフォルト値は `root` です。
		* このモディファイアを利用しているアニメーションでもこの値のまま使用されています。

### TurnYawCurveName

* 概要
	* Yaw の最終値から現在値を引いた値が設定されるアニメーションカーブの名前です。
	* デフォルト値は `RemainingTurnYaw` です。
		* このモディファイアを利用しているアニメーションでもこの値のまま使用されています。

### WeightCurveName

* 概要
	* 初期値 1 で始まり、 Yaw が変化しなくなるフレームから 0 が設定されるアニメーションカーブの名前です。
	* デフォルト値は `TurnYawWeight` です。
		* このモディファイアを利用しているアニメーションでもこの値のまま使用されています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[TurnYawAnimModifier]: #turnyawanimmodifier
[RootBoneName]: #rootbonename
[TurnYawCurveName]: #turnyawcurvename
[WeightCurveName]: #weightcurvename
[ABP_Mannequin_Base::RootYawOffset]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaserootyawoffset
[AnimEnum_RootYawOffsetMode::Accumulate]: ../../Lyra/ABP/AnimEnum_RootYawOffsetMode.md#animenumrootyawoffsetmodeaccumulate
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]: https://docs.unrealengine.com/5.1/ja/animation-modifiers-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
