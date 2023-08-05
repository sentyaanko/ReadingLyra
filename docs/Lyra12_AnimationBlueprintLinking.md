# 【UE5】Lyra に学ぶ(12) Animation Blueprint Linking <!-- omit in toc -->

UE5 の新しい？サンプル [Lyra Starter Game] 。  
このプロジェクトではキャラクターの Animation Blueprint で Animation Blueprint Linking システムを利用しています。  
これを利用することで、武器やスケルタルメッシュ毎に異なるアニメーションの処理を行えるようになっています。  
このドキュメントではどのような実装がされているかを述べていきます。  
話題に上げるのは概ね以下のものです。  
 * [ABP_Mannequin_Base]
 * [ABP_ItemAnimLayersBase] （と、その派生クラス群）
 * [ALI_ItemAnimLayers]

エンジンの機能解説に関しては最低限しか記しませんので詳細はリンク先を参照ください。

* バージョン
	* [Lyra Starter Game]
		* 2022/11/29 版(5.1 用)

# Index <!-- omit in toc -->

- [0. 参考](#0-参考)
- [1. 利用している仕組みや概念など](#1-利用している仕組みや概念など)
	- [1.1. Anim Node の Tag と Anim Node Reference ノード](#11-anim-node-の-tag-と-anim-node-reference-ノード)
	- [1.2. 所定の位置での旋回(TurnInPlace)](#12-所定の位置での旋回turninplace)
		- [1.2.1. 仕組み](#121-仕組み)
		- [1.2.2. TurnYawAnimModifier](#122-turnyawanimmodifier)
- [2. アニメーションレイヤーインターフェイスクラス](#2-アニメーションレイヤーインターフェイスクラス)
	- [2.1 用途](#21-用途)
	- [2.2 アニメーションレイヤーの種類と用途](#22-アニメーションレイヤーの種類と用途)
- [3. ABP\_ItemAnimLayersBase でのアニメーションレイヤーの実装](#3-abp_itemanimlayersbase-でのアニメーションレイヤーの実装)
	- [3.1 FullBody\_IdleState](#31-fullbody_idlestate)
		- [3.1.1 FullBody\_IdleState \> IdleSM](#311-fullbody_idlestate--idlesm)
			- [3.1.1.1 FullBody\_IdleState \> IdleSM \> Idle (state) \> IdleStance](#3111-fullbody_idlestate--idlesm--idle-state--idlestance)
	- [3.2 FullBody\_StartState](#32-fullbody_startstate)
		- [3.2.1 移動速度についての考察](#321-移動速度についての考察)
			- [3.2.1.1 各種設定等](#3211-各種設定等)
			- [3.2.1.1 極端に移動速度が遅い場合](#3211-極端に移動速度が遅い場合)
			- [3.2.1.2 移動速度が下限の場合](#3212-移動速度が下限の場合)
			- [3.2.1.3 移動速度が極端に速い場合](#3213-移動速度が極端に速い場合)
	- [3.3 FullBody\_CycleState](#33-fullbody_cyclestate)
	- [3.4 FullBody\_StopState](#34-fullbody_stopstate)
	- [3.5 FullBody\_PivotState](#35-fullbody_pivotstate)
		- [3.5.1 FullBody\_PivotState \> PivotSM](#351-fullbody_pivotstate--pivotsm)
	- [3.6 FullBody\_JumpStartState](#36-fullbody_jumpstartstate)
	- [3.7 FullBody\_JumpStartLoopState](#37-fullbody_jumpstartloopstate)
	- [3.8 FullBody\_JumpApexState](#38-fullbody_jumpapexstate)
	- [3.9 FullBody\_FallLoopState](#39-fullbody_fallloopstate)
	- [3.10 FullBody\_FallLandState](#310-fullbody_falllandstate)
	- [3.11 LeftHandPose\_OverrideState](#311-lefthandpose_overridestate)
	- [3.12 FullBody\_SkeletalControls](#312-fullbody_skeletalcontrols)
	- [3.13 FullBody\_Aiming](#313-fullbody_aiming)
	- [3.14 FullBodyAdditives](#314-fullbodyadditives)
		- [3.14 FullBodyAdditives \> FullBodyAdditive\_SM](#314-fullbodyadditives--fullbodyadditive_sm)
- [終わりに](#終わりに)




# 0. 参考

* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]
	> Lyra のアニメーションブループリントで使われている機能がまとめられています。
* [Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】]
	> この 2 つを読めば、機能的な話はこれでほぼ網羅されているはずです。  
	> サンプルが必要であれば、以下も合わせておすすめです。
	* [ぼっちプログラマのメモ > 2022/12/13 > 【UE5】UE5のアニメーションに関する新機能をサクッと試せるサンプルを公開しました！]
	* [ぼっちプログラマのメモ > 2022/12/12 > 【UE5】UE5からの新機能「Distance Matching」を使ってみよう！（サンプル配布あり）]
* [技術ブログ > Lyra アニメーションを UE5 ゲームに適応する方法について]
	> Lyra の ABP の改造の手順が解説されています。  
	> アニメーションを置き換えたり、移動方向にアクターが向くような改造通じて ABP で行っていることやパラメータの調整方法など色々なことが学べます。

ブループリントのコメントの中で各機能に関するコメントが複数の場所に連番数字付きで書かれています。  
具体的には以下の 2 種があります。  

* AnimBP Tour
	* [Comment_AnimBP_Tour.Ja] にコメントをまとめて引用しています。
* TurnInPlace
	* [Comment_TurnInPlace.Ja] にコメントをまとめて引用しています。


# 1. 利用している仕組みや概念など

* 汎用的な処理
	* **距離マッチング**
		* 移動開始時、着地時、ピボット時などに **距離マッチング** を行っています。
		* これにより、移動開始時のアニメーションの再生レートを調整し、移動距離とアニメーションの齟齬を減らしています。
		* これは以下などで実装しています。
			* [FullBody_StartState]
			* [FullBody_StopState]
			* [FullBody_PivotState > PivotSM]
			* [FullBody_FallLandState]
			> **Note**  
			> `Advance Time by Distance Matching` / `Advance Time by Distance Matching` の使用箇所がそれに当たります。
	* **ストライド ワーピング**
		* 移動開始時、移動中、ピボット時などに **ストライド ワーピング** を行っています。
		* これにより、移動速度に合わせて歩幅を調整しています。
		* これは以下などで実装しています。
			* [FullBody_StartState]
			* [FullBody_CycleState]
			* [FullBody_PivotState]
			> **Note**  
			> `Stride Warping` の使用箇所がそれに当たります。
	* **オリエンテーション ワープ**
		* 移動開始時、移動中、ピボット時などに **オリエンテーション ワープ** を行っています。
		* これにより、移動方向に合わせて脚の方向を調整しています。
		* これは以下などで実装しています。
			* [FullBody_StartState]
			* [FullBody_CycleState]
			* [FullBody_PivotState > PivotSM]
			> **Note**  
			> `Orientation Warping` の使用箇所がそれに当たります。
	* 銃口を徐々に下げる
		* 移動の際などに銃口を下げるようにしています。
		* これは以下などで実装しています。
			* [FullBody_StartState]
			* [FullBody_CycleState]
			* [FullBody_PivotState]
			* [FullBody_StopState]
			* [FullBody_JumpStartState]
			* [FullBody_JumpStartLoopState]
			* [FullBody_JumpApexState]
			* [FullBody_FallLoopState]
			* [FullBody_FallLandState]
			> **Note**  
			> `Sequence Evaluator` の `OnUpdate` に `UpdateHipFireRaiseWeaponPose` を使用した出力を  
			> `Layered blend per bone` でブレンドしている箇所がそれに当たります。
	* Lean
		* 移動中にカメラを左右に回した際、その方向に頭を向け、体を傾ける処理です。
		* これは [ABP_Mannequin_Base] `> AnimGrap > LocomotionSM` 内の以下などで実装しています。
			* `Start (state)`
			* `Cycle (state)`
			* `Pivot (state)`
			> **Note**  
			> この処理は [ABP_Mannequin_Base] で行われているため、武器に依存しません。  
			> `Blendspace Player` の出力を `Apply Additive` でブレンドしている箇所がそれに当たります。  
			> 使用する `Blend Space 1D` は `BS_MM_Rifle_Jog_Leans` 固定の実装となっています。
* 個別処理
	* 移動していないときの休止アニメーション
		* 立ったまま操作せずに放置していると休止アニメーションが再生されます。  
		* これは以下などで実装しています。
			* [FullBody_IdleState]
	* しゃがみと立ちの遷移
		* 移動せずに立ちとしゃがみを行うと専用の遷移アニメーションが再生されます。
		* これは以下などで実装しています。
			* [FullBody_IdleState]
	* 所定の位置での旋回
		* 移動せずにカメラを動かす際に、足が滑らないようにしています。
		* 詳細は [1.2. 所定の位置での旋回(TurnInPlace)] を参照してください。
		* これは [FullBody_IdleState > IdleSM] 内の以下などで実装しています。
			* `TurnInPlaceRotation (state)`
			* `TurnInPlaceRecovery (state)`
	* Pivot (移動方向を逆方向に変更する)
		* ベロシティとアクセラレーションが反対方向になった際に専用の移動アニメーションが再生されます。
		* これは以下などで実装しています。
			* [FullBody_PivotState]
	* 左手のポーズのブレンド
		* 左手のポーズだけをブレンドする機能が実装されています。
		* これは以下などで実装しています。
			* [LeftHandPose_OverrideState]
	* 2 種の `Aim Offset` のブレンド
		* 銃を狙うものと非武装のものをブレンドしています。
		* これは前述の **銃口を徐々に下げる** と同じような目的です。
		* これは以下などで実装しています。
			* [FullBody_Aiming]
	* 着地時のアニメーション
		* 衝撃を和らげるようなアニメーションをブレンドしています。
		* これは以下などで実装しています。
			* [FullBodyAdditives]
	* IK 等
		* 主に以下のようなことを行っています。
			* Manne と Quin の 比率の差の吸収
			* 手や脚や腰の位置調整
			* 武器切替時などの武器のスケール調整
		* これは以下などで実装しています。
			* [FullBody_SkeletalControls]


## 1.1. Anim Node の Tag と Anim Node Reference ノード

既存のドキュメント
* [Dev Comunity > Forums > How to get a anim layer node reference as shown in the Lyra Example project?]
* [Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p159]

Lyra では [ABP_Mannequin_Base] `> AnimGraph > LocomotionSM > Start (state)` に配置している [FullBody_StartState] のプロパティ Tag に `StartLayerNode` を設定しています。  
この Tag を設定することでノード `StartLayerNode` が利用可能になり、 [ABP_Mannequin_Base] の `UpdateLocomotionStateMachine()` では、いくつかの関数を経て現在設定されている AnimLayer のリファレンスを取得しています。  
このリファレンス先を毎フレームチェックすることで AnimLayer が変更されたかを変数に保存しています。  
この変更されたかを示す変数は [ABP_Mannequin_Base]  `> AnimGraph > LocomotionSM`  内の複数のトランジションから参照されています。  

この変数の利用箇所の例をあげると、 `Pivot` -> `Cycle` のトランジションがあります。  
また、 AnimLayer が変わるタイミングの例をあげると、武器変更時があります。  
ですので、 `Pivot` 中に武器変更すると `Cycle` に移行する、といった処理を行うためにこの Tag の機能を使用していることになります。


## 1.2. 所定の位置での旋回(TurnInPlace)

既存のドキュメント
* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > 所定の位置での旋回]

ここでは Lyra では、キャラクターが移動しない状態でカメラの向きを変えたときにどのような処理を行っているかについて解説します。

### 1.2.1. 仕組み

Lyra ではキャラクターアクタはコントローラーのヨー方向に向いています。（ `UseControllerRotationYaw` が true ）  
ですが、キャラクターが移動していない状態でマウスを動かす等カメラの向きを操作した場合、上半身と下半身の向きが一致していないのが見て取れます。  
もう少し具体的には以下のような見た目になります。 

* 移動しなくなった時点の下半身の向きを維持している。
* カメラの向きを操作しても、下半身の向きとのなす角が 45 度 + αの範囲内では足を動かさずに上半身の向きだけ変えている。
* 45 度 + αを超えると 90 度、下半身の向きを変えている。

> **Note**  
> α は遊びの範囲で、これがあることで 45 度を行き来しただけでアニメーションが再生されないようになります。  
> 実際には [FullBody_IdleState > IdleSM] `> WantsTurnInPlace (rule)` にて、回転角の絶対値が 50 度を超えた際にステートが移行されるようになっています。  
> （よって、上記の説明のαは 5 度で実装しているということになります）

この挙動は、概ね以下のような処理によって実現しています。  

* 上半身の向きだけ変える処理
	* 操作した向きの回転を `AimOffset Player` のパラメータ `Yaw` に与える
	* 操作した向きと逆回転をルートボーンに与える（ `RotateRootBone` を利用）
	* これらが互いに打ち消し合うことで足が回転前の位置のまま滑らないようにしている
* 下半身の向きを変える処理
	* 事前の準備
		* 90 度向きを変えるための、ルートボーンが回転を行うアニメーションシーケンスを用意する
		* アニメーションモディファイア `TurnYawAnimModifier` を利用してフレームごとの回転をアニメーションカーブ `RemainingTurnYaw` にベイクする
			> `TurnYawAnimModifier` については [1.2.2. TurnYawAnimModifier] を参照してください。
	* 上半身だけ動かす範囲を超えた操作を行い、下半身の向きを変える必要がある場合は、上記のアニメーションを再生する
	* アニメーション再生時、ルートボーンに与えていた回転と `AimOffset Player` のパラメータ `Yaw` の回転をアニメーションカーブの値だけ減じる

> 例:  
> 右 55 度の時点で右回転アニメーションシーケンスを再生するとする場合、アニメーションシーケンスの回転ごとに以下のような値が設定される。  
> | アニメーションシーケンスの回転	| ルートボーン	| AimOffset の Yaw	|
> | ----:							| ----:			| ----:				|
> |  0								| -55			|  55				|
> | 45								| -10			|  10				|
> | 90								|  35			| -35				|

「アクターは常に画面正面を向いていて、上半身はそれに追随し、下半身だけ足が滑らないように捻ってる」というのが想像しやすいと思います。

### 1.2.2. TurnYawAnimModifier

既存のドキュメント
* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]
	* Animation Modifier の解説。
	* 以下、説明部分の引用。
		> Animation Modifiers (Anim Modifier) は、ネイティブまたは ブループリント クラス の一種で、  
		> アニメーション シーケンス または スケルトン アセットにアクション シーケンスを適用することができます。  
		> これには、足の自動同期マーカーを作成するなどが考えられます。  
		> 左または右の足が地面に触れるのはどのフレームであるかをピンポイントで示します。  
		> こうした情報を使って、足の骨が最も低いポイント (フロアに接触する) にくる場所に Animation Sync Markers を追加します。


[TurnYawAnimModifier] は Lyra で実装されているアニメーションモディファイアです。  
TurnInPlace では 90 度振り向くアニメーションシーケンスを利用しますが、このアニメーションシーケンスにアニメーションモディファイアを設定しています。
このアニメーションシーケンスではルートモーションで Yaw が変化する様に作られています。  
アニメーションモディファイアでは回転量及び回転量が最終フレームと同値になるタイミングを示すアニメーションカーブを自動生成します。
アニメーションカーブの内容は以下のようになります。

* `RemainingTurnYaw`
	* 30 fps で自動的にキーを打っている。
		* 指定したボーン(`root`)の Yaw の最終値から現在のフレームの値を引いた値
* `TurnYawWeight`
	* 以下の３箇所に自動的にキーを打っている。
		* 0 フレーム目に値 `1`
		* 指定したボーン(`root`)の Yaw の変化が無くなる直前のフレームに値 `1`
		* 指定したボーン(`root`)の Yaw の変化が無くなる直後のフレームに値 `0`

これらの値を利用することで、振り向くアニメーションとエイムの向きに矛盾がなく、スムーズに繋がるように実装されています。



# 2. アニメーションレイヤーインターフェイスクラス

既存のドキュメント
* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]
	> Animation Blueprint Linking の公式のドキュメントです。

## 2.1 用途

| クラス名							| 用途																							|
|----								|----																							|
| [ALI_ItemAnimLayers]				| 武器毎に異なる AnimGrap を実装するためのアニメーションレイヤーインターフェイスクラスです。	|
| [ABP_Mannequin_Base]				| キャラクター用の ABP で [ALI_ItemAnimLayers] の関数を呼び出しをしています。					|
| [ABP_ItemAnimLayersBase]			| 武器用の基底クラスで [ALI_ItemAnimLayers] の関数を実装しています。							|


## 2.2 アニメーションレイヤーの種類と用途

アニメーションレイヤーの種類と用途([ABP_Mannequin_Base] でどの様に呼び出されるか)をまとめると以下のようになります。

| アニメーションレイヤー		| 呼び出し元													| Note	|
|-----							|-----															|----	|
| [FullBody_IdleState]			| `AnimGraph > LocomotionSM > Idle (state)`						| *1	|
| [FullBody_StartState]			| `AnimGraph > LocomotionSM > Start (state)`					| *2	|
| [FullBody_CycleState]			| `AnimGraph > LocomotionSM > Cycle (state)`					| *2	|
| [FullBody_PivotState]			| `AnimGraph > LocomotionSM > Pivot (state)`					| *2	|
| [FullBody_StopState]			| `AnimGraph > LocomotionSM > Stop (state)`						| *1	|
| [FullBody_JumpStartState]		| `AnimGraph > LocomotionSM > JumpStart (state)`				| *1	|
| [FullBody_JumpStartLoopState]	| `AnimGraph > LocomotionSM > JumpStartLoop (state)`			| *1	|
| [FullBody_JumpApexState]		| `AnimGraph > LocomotionSM > JumpApex (state)`					| *1	|
| [FullBody_FallLoopState]		| `AnimGraph > LocomotionSM > FallLoop (state)`					| *1	|
| [FullBody_FallLandState]		| `AnimGraph > LocomotionSM > FallLand (state)`					| *1	|
| [LeftHandPose_OverrideState]	| `AnimGraph`													|		|
| [FullBody_Aiming]				| `AnimGraph`													|		|
| [FullBodyAdditives]			| `AnimGraph`													|		|
| [FullBody_SkeletalControls]	| `AnimGraph`													|		|

> **Note**  
> * *1. 出力がそのままステートの出力となります。
> * *2. 出力と Lean のブレンド結果がステートの出力となります。
> * `LocomotionSM` はステートマシンです。
> * `LocomotionSM > * (state)` はステートです。


# 3. ABP_ItemAnimLayersBase でのアニメーションレイヤーの実装

ここでは [ABP_ItemAnimLayersBase] での各アニメーションレイヤーの実装内容を記述していきます。

## 3.1 FullBody_IdleState

移動していない状態で呼び出される関数です。
しゃがみ、立ち、 ADS 、そして カメラ操作による旋回の処理が行われます。  
ステートマシン [FullBody_IdleState > IdleSM] の出力が `Output Pose` につながります。


### 3.1.1 FullBody_IdleState > IdleSM

このステートマシンは、アイドル、アイドルの休憩、旋回、旋回からの復帰の状態制御を行います。  
ステートマシンが保持するステートの名と状態の内容は以下の通りです。

| ステート名			| 状態の内容																			|
|----					|----																					|
| `Idle`				| 何も操作していない状態。																|
| 						| ステートマシン [FullBody_IdleState > IdleSM > Idle (state) > IdleStance] の出力が		|
|						| `Output Animation Pose` につながります。												|
| `IdleBreak`			| 何も操作していない状態が続いた際に発生する休憩アニメーションを再生している状態。		|
| 						| アニメーションのバリエーションを設定するための配列変数が用意されています。			|
| 						| 休憩用のアニメーションシーケンスを `Sequence Player` で再生します。					|
| 						| `Sequence Player` の出力が `Output Animation Pose` につながります。					|
| `TurnInPlaceRotation`	| 旋回アニメーション再生中で Yaw が変化中の状態。										|
| 						| 旋回アニメーションを `Sequence Evaluator` で再生します。								|
| 						| バリエーションは ((1(しゃがみ) + 1(立ち)) * 2(左右)) = 4 枠の変数が用意されています。	|
| 						| `Sequence Evaluator` の出力が `Output Animation Pose` につながります。				|
| `TurnInPlaceRecovery`	| 旋回アニメーション再生中で Yaw が変化が終わった後の状態。								|
| 						| `TurnInPlaceRotation` で再生していたアニメーション引き続き再生します。				|
| 						| `Sequence Player` の出力が `Output Animation Pose` につながります。					|

状態遷移のルールは概ね以下のようになります。

* `Idle` -> `IdleBreak`
	* 操作が行われないまま一定時間を経過すると移行します。
* `IdleBreak` -> `Idle`
	* アニメーションシーケンスの再生が終わるか、何らかの操作（詳細は省略）をすると移行します。
* `*` -> `TurnInPlaceRotation`
	* 下半身と上半身の向きが 50 度を超えていると移行します。
* `TurnInPlaceRotation` -> `TurnInPlaceRecovery`
	* `TurnInPlaceRotation` で再生したアニメーションの `root` の Yaw の回転が完了すると移行します。
* `TurnInPlaceRecovery` -> `Idle`
	* アニメーションシーケンスの再生が終わると移行します。

#### 3.1.1.1 FullBody_IdleState > IdleSM > Idle (state) > IdleStance

このステートマシンは、アイドル中の立ちとしゃがみの状態制御を行います。  
ステートマシンが保持するステートの名と状態の内容は以下の通りです。

| ステート名			| 状態の内容																			|
|----					|----																					|
| `Idle`				| 何も操作していない状態。																|
| 						| バリエーションは (1(しゃがみ) + 1(立ち) + 1(ADS)) = 3 枠の変数が用意されています。	|
| 						| `Sequence Player` の出力が `Output Animation Pose` につながります。					|
| `StanceTransition`	| 姿勢遷移状態。																		|
| 						| バリエーションは (2(しゃがみ <-> 立ち)) = 2 枠の変数が用意されています。				|
| 						| `Sequence Player` の出力が `Output Animation Pose` につながります。					|

状態遷移のルールは概ね以下のようになります。

* `Idle` -> `StanceTransition`
	* 立ち・しゃがみ状態の変化を検知すると移行します。
* `StanceTransition` -> `Idle`
	* アニメーションシーケンスの再生が終わるか、立ち・しゃがみ状態の変化を検知すると移行します。


## 3.2 FullBody_StartState

移動開始の状態で呼び出される関数です。

このステートを含め、以下のステートは実装がかなり似通っています。
* [FullBody_StartState]
* [FullBody_CycleState]
* [FullBody_StopState]

`しゃがみ or 立ち or ADS` の状態と、 4 方向を掛け合わせた 12 種の **移動開始** のアニメーションのいずれかを基本とし、  
再生位置は **距離マッチング**  (`Advance Time by Distance Matching`) を用いて算出し、  
発砲直後に銃を降ろさないようにするため、`しゃがみ or 立ち` の銃を構えたアニメーションのいずれかを上半身だけブレンドし、  
**オリエンテーション ワープ** を用いて動いている方向に合わせて下半身を回転させ、  
**ストライド ワーピング** を用いて速度に合わせて歩幅を調整した結果が `Output Pose` につながります。

処理毎にもう少し補足を入れると以下のようになります。

1. 基本となるアニメーションシーケンスの決定
	* バリエーションは ((1(しゃがみ) + 1(立ち) + 1(ADS)) * 4(方向))= 12 枠の変数が用意されています。
	* 再生位置は `Advance Time by Distance Matching` を利用し設定します。	
	* これは **距離マッチング** と呼ばれる、アニメーションの再生レートを移動距離に合わせる手法です。
		> **Note**  
		> * パラメータ `Distance Curve Name`
		> 	* `Distance` を指定していますが、これは上記の 12 枠の変数で指定されたアニメーションシーケンスに設定されているアニメーションカーブ名です。
		> 	* このアニメーションカーブはアニメーションモディファイア `DistanceCurveModifier` によって出力される `XY` 平面上の開始地点からの距離です。
		> * パラメータ `Play Rate Clamp`
		> 	* X の値は再生レートの下限値ですが、 `経過時間が 0.15 秒までは 0.2 で、 0.20 秒にかけて 0.6` になるように実装されています。  
		>	* ルートモーションがキャラクターの移動距離より大きくてもアニメーションを停止させることはなく、 0.15 秒までは 0.2 倍速を保つ、ということになります。
		> 	* Y の値は再生レートの上限値で、 `5.0` 固定です。  
		>	* ルートモーションがキャラクターの移動距離より小さくても 5.0 倍速を超えない、ということになります。
2. (銃を構えるための)上半身用のアニメーションシーケンスの決定
	* バリエーションは 1(しゃがみ) + 1(立ち) = 2 枠の変数が用意されています。
	* 再生位置は 0 固定です。
		> **Note**  
		> このポーズは発砲直後しばらくは銃を前方に構えたままにするのに利用しています。
3. 1 と 2 を `Layered blend per bone` でブレンド
	* 1 を Base Pose 、 2 を Blend Pose とします。
	* `Blend Mode` を `Blend Mask` 、`Blend Masks` に `UpperBodyMask` を指定します
	* `Blend Masks` の `UpperBodyMask` は `spine_01` から先だけウェイトが設定されており、つまりは上半身だけブレンドします。
4. 3 の出力を `Orientation Warping` に通します。
	* これは **オリエンテーション ワープ** と呼ばれる、動いている方向に合わせて下半身を回転させる手法です。
5. 4 の出力を `Stride Warping` に通します。
	* これは **ストライド ワーピング** と呼ばれる、速度に合わせて歩幅を調整する手法です。
		> **Note**  
		> * パラメータ `Alpha`
		> 	* `経過時間が 0.15 秒までは 0.0 で、 0.20 秒にかけて 1.0` になるように実装されています。  
		> 	* これにより、歩き始めた直後は **距離マッチング** を、ジョグステートに近づくにつれて **ストライド ワーピング** を使用しています。  
6. 5 の出力が `Output Pose` につながります。


### 3.2.1 移動速度についての考察

**距離マッチング** と **ストライド ワーピング** にて移動距離と経過時間を参照しています。  
これについて、極端な速度（すごく遅い、すごく速い）で動いた場合どうなるのでしょうか？  

ここで [ABP_Mannequin_Base] `> LocomotionSM > Start to Cycle (rule)` を確認すると、以下のように実装されています。
> `ステート開始から 0.15 秒経過` かつ `移動速度が 10 未満` の場合、トランジションが発生

ですので、 `0.15 秒以降については移動速度が 10 以上` として考えて良くなっています。  
それ以外の極端なケースについて考察してみます。


#### 3.2.1.1 各種設定等

関連するパラメータについて、実際にプロジェクトに設定されている値は以下のようになっています。

* 移動速度
	* `B_Hero_ShooterMannequin` の移動速度の設定は以下のようになっています。
		| プロパティ名			| 値  &#91;cm / s&#93;	| 1 / 30 ごとの移動量	|
		|----					|----					|----					|
		| Max Walk Speed		| 600					| 20					|
		| Min Analog Walk Speed	| 200					| 6.66					|
	* 最高速については 600 &#91;cm / s&#93; で考えます。  
	* 最低速については、 Min Analog Walk Speed は Tooltips に以下のように記載されています。
		> the ground speed that we should accelerate up to when walking at minimum analog stick tilt.
		> 
		> ----
		> アナログスティックの傾きを最小にして歩くときに加速すべき地上速度。
	* アナログスティックを最小に入力し続けたときの上限なので、入力開始直後はもっと低い値となります。
* アニメーションシーケンスの設定
	* 使用するアニメーションシーケンスの例として、 `MM_Pistol_Jog_Fwd_Strat` の場合でを見てみましょう。  
	* このアセットのアニメーションカーブ `Distance` の 0 フレーム付近の値の変化は以下のようになっています。
		| フレーム(30fps)	| `Distance` の値	|
		|----				|----				|
		| 0					| -0.439			|
		| 1					| 0.146				|
		| 2					| 2.147				|
		| 3					| 5.471				|
* 確認すべき経過時間
	* 処理が切り替わるタイミングはフレーム換算すると以下のようになります。
		* 0.15 秒 は 30 fps の 4.5 フレーム
		* 0.20 秒 は 30 fps の 6 フレーム
* 下限クランプ値の変化
	* t を時間とすると、 0.15 秒から 0.20 秒にかけての **ストライド ワーピング** のパラメータ `Alpha` は以下のように変化します。
		> **ストライド ワーピング** のパラメータ `Alpha` = (t - 0.15) * 20
	* 下限クランプ値は上記の値に依存し、以下のように変化します。
		> 下限クランプ値 = (0.6 - 0.2) * (**ストライド ワーピング** のパラメータ `Alpha`) + 0.2  
		> = (0.6 - 0.2) * ((t - 0.15) * 20) + 0.2
		> = 8 * t - 1
	* 表にすると以下のようになります。
		| 時間(フレーム)	| 時間(秒)			| 下限クランプ値	|
		|----				|----				|----				|
		| 0					| 0.000				| 0.2				|
		| 4.5				| 0.150				| 0.2				|
		| 5					| 0.167				| 0.336				|
		| 6					| 0.200				| 0.6				|


これらの値を元に以下のケースの考察してみます。

* `0.15 秒未満` で移動速度が極端に遅い場合
* 経過時間に依らず移動速度が下限 `10` の場合
* 経過時間に依らず移動速度が極端に速い場合

> **Warning**  
> 実装を元にした内容ではなく、データやコメントや動きを元にまとめた内容のため、参考程度に考えてください。


#### 3.2.1.1 極端に移動速度が遅い場合

0.15 秒までの間、各フレームでアニメーションシーケンスのどこまで進んでいるかを考えます。

仮に、極端に遅い移動速度を 0.3 とします。  
移動速度 0.3 を 30 fps でのフレーム毎の移動量に換算すると 0.001 となるので、毎フレーム 0.001 ずつ増えていきます。

| 時間(フレーム)	| 起点からの移動量	| アニメーションシーケンスの位置(フレーム)	| 前フレームからの再生レート	| アニメーション上の起点からの移動量	|
|----				|----				|----										|----							|----									|
| 0					| 0.000				| 0.750										|								| 0.000									|
| 1					| 0.001				| 0.950(下限補正前は 0.752)					| 0.200							| 0.116									|
| 2					| 0.002				| 1.150(下限補正前は 0.753)					| 0.200							| 0.446									|
| 3					| 0.003				| 1.350(下限補正前は 0.928)					| 0.200							| 0.846									|
| 4					| 0.004				| 1.550(下限補正前は 0.929)					| 0.200							| 1.246									|
| 5					| 0.005				| 1.750(下限補正前は 0.929)					| 0.200							| 1.646									|

移動速度が 0.3 の場合、 5 フレーム目の (0.15 秒を過ぎた) 段階で、アニメーションのポーズとキャラクターの移動量の差は 1.646 - 0.005 = 1.641 となります。  

1 程度の差なので、気にする必要はないでしょう。


#### 3.2.1.2 移動速度が下限の場合

0.2 秒までの間、各フレームでアニメーションシーケンスのどこまで進んでいるかを考えます。

移動速度 10 を 30 fps でのフレーム毎の移動量に換算すると 0.333 となるので、毎フレーム 0.333 ずつ増えていきます。

| 時間(フレーム)	| 起点からの移動量	| アニメーションシーケンスの位置(フレーム)	| 前フレームからの再生レート	| アニメーション上の起点からの移動量	|
|----				|----				|----										|----							|----									|
| 0					| 0.000				| 0.750										|								| 0.000									|
| 1					| 0.333				| 1.093										| 0.343							| 0.333									|
| 2					| 0.667				| 1.293(下限補正前は 1.260)					| 0.200							| 0.732									|
| 3					| 1.000				| 1.493(下限補正前は 1.426)					| 0.200							| 1.132									|
| 4					| 1.333				| 1.693(下限補正前は 1.593)					| 0.200							| 1.532									|
| 5					| 1.667				| 2.029(下限補正前は 1.760)					| 0.336							| 2.243									|
| 6					| 2.000				| 2.629(下限補正前は 1.926)					| 0.600							| 4.239									|

6 フレーム目の (0.20 秒の) 段階で、アニメーションのポーズとキャラクターの移動量の差は 4.239 - 2.000 = 2.239 となります。  
その後のアニメーションシーケンス側の移動量は増えていくため、その差はどんどん広がります。  
ですが 0.2 秒の段階で、 **ストライド ワーピング** のパラメータ `Alpha` が `1.0` となり、以降はそちらに頼ることになります。


#### 3.2.1.3 移動速度が極端に速い場合

アニメーション開始直後、各フレームでアニメーションシーケンスのどこまで進んでいるかを考えます。

移動速度 600 を 30 fps でのフレーム毎の移動量に換算すると 20 となるので、毎フレーム 20 ずつ増えていきます。

| 時間(フレーム)	| 起点からの移動量	| アニメーションシーケンスの位置(フレーム)	| 前フレームからの再生レート	| アニメーション上の起点からの移動量	|
|----				|----				|----										|----							|----									|
| 0					| 0					| 0.750										|								| 0										|
| 1					| 20				| 5.515										| 4.765							| 20									|
| 2					| 40				| 7.769										| 2.254							| 40									|
| 3					| 60				| 9.498										| 1.729							| 60									|
| 4					| 80				| 10.972									| 1.474							| 80									|

アニメーションの移動速度はアニメーション開始時が最もが遅くなっています。  
移動速度が 600 の場合でも、再生レートが上限の `5.0` を超えることはなく、問題なく動作します。  


## 3.3 FullBody_CycleState

移動中の状態で呼び出される関数です。

このステートは [FullBody_StartState] と実装がかなり似通っているので詳細はそちらを確認してください。

`しゃがみ or 立ち or ADS` の状態と、 4 方向を掛け合わせた 12 種の **移動** のアニメーションのいずれかを基本とし、  
発砲直後に銃を降ろさないようにするため、`しゃがみ or 立ち` の銃を構えたアニメーションのいずれかを上半身だけブレンドし、  
**オリエンテーション ワープ** を用いて動いている方向に合わせて下半身を回転させ、  
**ストライド ワーピング** を用いて速度に合わせて歩幅を調整した結果が `Output Pose` につながります。  
**ストライド ワーピング** のパラメータ `Alpha` は通常は `1.0` で、壁に向かって移動すると `0.5` になるように実装されています。


## 3.4 FullBody_StopState

移動終了の状態で呼び出される関数です。

このステートは [FullBody_StartState] と実装がかなり似通っているので詳細はそちらを確認してください。

`しゃがみ or 立ち or ADS` の状態と、 4 方向を掛け合わせた 12 種の **移動終了** のアニメーションのいずれかを基本とし、  
再生位置は **距離マッチング** (`Distance Match to Target`)を用いて算出し、  
発砲直後に銃を降ろさないようにするため、`しゃがみ or 立ち` の銃を構えたアニメーションのいずれかを上半身だけブレンドした結果が `Output Pose` につながります。  
このステートでは [FullBody_StartState] と異なり、 **オリエンテーション ワープ** と **ストライド ワーピング** は使用しません。


## 3.5 FullBody_PivotState

Pivot (移動方向を逆方向に変更する) の状態で呼び出される関数です。

しゃがみ、立ち、 ADS の Pivot 処理が行われます。  
ステートマシン [FullBody_PivotState > PivotSM] の出力に
発砲直後に銃を降ろさないようにするため、`しゃがみ or 立ち` の銃を構えたアニメーションのいずれかを上半身だけブレンドした結果が `Output Pose` につながります。


### 3.5.1 FullBody_PivotState > PivotSM

このステートマシンは、 Pivot の状態制御を行います。  

Pivot 中に再び Pivot が発生しうるため、実装が全く同じ PivotA / PivotB から成ります。  
ステートマシンが保持するステートの名と状態の内容は以下の通りです。

| ステート名			| 状態の内容																												|
|----					|----																														|
| `PivotA`				| Pivot を行っている状態。																									|
| 						| `しゃがみ or 立ち or ADS` の状態と、 4 方向を掛け合わせた 12 種の **ピボット** の	アニメーションのいずれかを基本とし、	|
| 						| `Sequence Evaluator` の出力に **オリエンテーション ワープ** を用いて動いている方向に合わせて下半身を回転させ、  			|
| 						| **ストライド ワーピング** を用いて速度に合わせて歩幅を調整した結果が `Output Animation Pose` につながります。				|
| `PivotB`				| 同上。																													|

状態遷移のルールは概ね以下のようになります。

* `PivotA` -> `PivotB`
	* Pivot が発生すると遷移します。
* `PivotB` -> `PivotA`
	* 同上。

`PivotA` / `PivotB` ステート内の処理についてもう少し補足します。  

* Pivot 開始直後の向き変更
	* 再生するアニメーションはステート開始時に決定しますが、最初の 0.2 秒間に移動方向が変わった場合、変更後のアニメーションに切り替えるよう実装されています。
		> **Note**  
		> 例えば、前から後に Pivot し、 0.2 秒以内に右に移動すると、 Pivot アニメーションが右用のものに変わっていることが確認できると思います。  
		> （右 Pivot は大きく左足を開くので `Rewind Debugger` 等を使わなくても見分けやすい）  
* 方向転換前
	* 方向転換点に近づいている状況なので、**距離マッチング**には `Distance Match to Target` を使用します。
* 方向転換後
	* 方向転換点から離れている状況なので、**距離マッチング**には `Advance Time by Distance Matching` を使用します。
		> **Note**  
		> 要は Start ステートと同じような計算となります。  


## 3.6 FullBody_JumpStartState

ジャンプ開始の状態で呼び出される関数です。

このステートを含め、以下のステートは実装がかなり似通っています。
* [FullBody_JumpStartState]
* [FullBody_JumpStartLoopState]
* [FullBody_JumpApexState]
* [FullBody_FallLoopState]

1 種（立ちやしゃがみなどのバリエーションを持たない）の **ジャンプ開始** のアニメーションを基本とし、`Sequence Player` で再生し、  
発砲直後に銃を降ろさないようにするため、`しゃがみ or 立ち` の銃を構えたアニメーションのいずれかを上半身だけブレンドした結果が `Output Pose` につながります。


## 3.7 FullBody_JumpStartLoopState

ジャンプ上昇中の状態で呼び出される関数です。

このステートは [FullBody_JumpStartState] と実装がかなり似通っているので詳細はそちらを確認してください。

使用するアニメーションが **ジャンプ上昇中** 用のものである以外はほぼ同じです。

> **Note**  
> ベロシティとアクセラレーションから計算した頂点までの距離が `0.4` 未満になると `JumpApexState` に遷移します。


## 3.8 FullBody_JumpApexState

ジャンプ頂点付近の状態で呼び出される関数です。

このステートは [FullBody_JumpStartState] と実装がかなり似通っているので詳細はそちらを確認してください。

使用するアニメーションが **ジャンプ頂点付近** 用のものである以外はほぼ同じです。


## 3.9 FullBody_FallLoopState

ジャンプ落下中の状態で呼び出される関数です。

このステートは [FullBody_JumpStartState] と実装がかなり似通っているので詳細はそちらを確認してください。

使用するアニメーションが **ジャンプ落下中** 用のものである以外はほぼ同じです。


## 3.10 FullBody_FallLandState

ジャンプ着地直前の状態で呼び出される関数です。

1 種（立ちやしゃがみなどのバリエーションを持たない）の **ジャンプ着地直前** のアニメーションを基本とし、`Sequence Evaluator` で再生し、  
再生位置は **距離マッチング** (`Distance Match to Target`)を用いて算出し、  
発砲直後に銃を降ろさないようにするため、`しゃがみ or 立ち` の銃を構えたアニメーションのいずれかを上半身だけブレンドした結果が `Output Pose` につながります。

> **Note**  
> 地面までの距離は [ULyraCharacterMovementComponent] で算出した値を [ULyraAnimInstance] の `NativeUpdateAnimation()` のタイミングでキャッシュしているものを利用しています。


## 3.11 LeftHandPose_OverrideState

左手のポーズを上書きするための処理を記述するための関数です。

入力されたポーズを基本とし、
1 種（立ちやしゃがみなどのバリエーションを持たない）のアニメーションを左手だけブレンドした結果が `Output Pose` につながります。

> **Note**  
> * 設定用変数 `Enable Left Hand Pose Override` により、有効無効を切り替えられるようになっています。
> 	* プロジェクト初期状態では無効になっています。
> 	* 無効の場合、 `Layered blend per bone` のパラメータ `Blend Weights 0` が `0.0` となります。
> * ブレンドのウェイトはアニメーションカーブ `DisableLeftHandPoseOverride` を利用することで調整可能になっています。
> 	* ですがこのアニメーションカーブを持つアニメーションは存在しません。
> * Shotgun のみアニメーションの指定がされています。


## 3.12 FullBody_SkeletalControls

IK 等の処理を記述するための関数です。

`Hand IK Retargeting` で Manne と Quin の比率差による手の IK ボーンの制御を行い、  
`Copy Bone` で左手の IK ボーンの位置を武器用の仮想ボーンの位置に変更し、  
（ Control Rig による足の位置調整を使用している場合は `Transform (modify) Bone` で腰の FK ボーンの位置調整をし、）  
`Two Bone IK` で左右の手の IK 制御を行い、
`Foot Placement` で 腰の FK ボーンと足の IK ボーンの制御を行い、
`Leg IK` で両足の IK 制御を行い、
`Transform (modify) Bone` で武器切替時などの武器のスケール調整を行った結果が `Output Pose` につながります。

既存のドキュメント
* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > スケルタル制御 > Title:Hand IK Retargeting]
* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > スケルタル制御 > Two Bone IK]
* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > スケルタル制御 > Copy Bone]
* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > スケルトン > 仮想ボーン]
* [ぼっちプログラマのメモ > 2022/12/13 > 【UE5】UE5のアニメーションに関する新機能をサクッと試せるサンプルを公開しました！]
* [twitter > pafuhana1213 > 2022/10/18]


## 3.13 FullBody_Aiming

エイムの処理を記述するための関数です。

渡されたポーズをベースポーズとし、 `AimOffset Player` を 2 つ使い、
それらの出力を `Blend` でブレンドした結果が `Output Pose` につながります。

> **Note**  
> * 二つのエイムオフセット
> 	* 「武器を構えたもの」と、「非武装のもの（武器を構えずに頭の向きだけ変えるもの）」です。
> 	* 銃撃せずに移動している際、両手を徐々に下げるような表現を行うためのものです。  
> * ポーズキャッシュ `BasePose`
> 	* 渡されたポーズを保存しています。
> 	* 2 つのエイムオフセットのベースポーズとして利用します。

既存のドキュメント
* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > エイム オフセットを作成する]
	> Aim Offset アセットの作り方などがまとめられています。


## 3.14 FullBodyAdditives

加算用のポーズを返す処理を記述するための関数です。

ステートマシン [FullBodyAdditives > FullBodyAdditive_SM] の出力が `Output Pose` につながります。


### 3.14 FullBodyAdditives > FullBodyAdditive_SM

このステートマシンは、着地時の状態制御を行います。  

ステートマシンが保持するステートの名と状態の内容は以下の通りです。

| ステート名			| 状態の内容																												|
|----					|----																														|
| `Identity`			| 地上にいる状態。																											|
| 						| 何も返しません。																											|
| `AirIdentity`			| 空中にいる状態。																											|
| 						| 何も返しません。																											|
| `LandRecovery`		| 地上に着いた直後の状態。																									|
| 						| `Additive Identity Pose` のデフォルトの加算ポーズを基本とし、																|
| 						| 1 種（立ちやしゃがみなどのバリエーションを持たない）の **着地復帰** のアニメーションを `Sequence Player` で再生し、  		|
| 						| `Blend` でブレンドした結果が `Output Animation Pose` につながります。														|

状態遷移のルールは概ね以下のようになります。

* `Identity` -> `AirIdentity`
	* 地上を離れると遷移します。
* `AirIdentity` -> `LandRecovery`
	* 地上に着くと遷移します。
* `LandRecovery` -> `Identity`
	* 地上を離れる、もしくはアニメーションの再生が終わると遷移します。

`LandRecovery` ステート内の処理についてもう少し補足します。  

* `Blend` のパラメータ `Alpha`
	* 以下のような値の変化をします。
		| 経過時間	| 立ちの場合	| しゃがみの場合	|
		|----		|----			|----				|
		| 0.0		| 0.1			| 0.05				|
		| 0.4		| 1.0			| 0.50				|
	* しゃがみの場合は立ちの場合の半分の値になります。
	* 0.4 秒で最大値となり以降はその値を維持します。


# 終わりに

どこで何をやっているかを中心にまとめました。  
そのため、やってることが多いところは重めになています。  
具体的には移動開始 [FullBody_StartState] や ピボット [FullBody_PivotState] 、 IK 関連 [FullBody_SkeletalControls] あたりです。  
反対に、やっていることを実現するための変数や関数などは（わかりやすくするのも難しく、きりもないので）解説を省略しています。
なにかの参考になれば幸いです。


-----
おしまい。


<!-- links -->

<!--- ページ内のリンク --->
[FullBody_IdleState]: #31-fullbodyidlestate
[FullBody_IdleState > IdleSM]: #311-fullbodyidlestate--idlesm
[FullBody_IdleState > IdleSM > Idle (state) > IdleStance]: #3111-fullbodyidlestate--idlesm--idle-state--idlestance
[FullBody_StartState]: #32-fullbodystartstate
[FullBody_CycleState]: #33-fullbodycyclestate
[FullBody_StopState]: #34-fullbodystopstate
[FullBody_PivotState]: #35-fullbodypivotstate
[FullBody_PivotState > PivotSM]: #351-fullbodypivotstate--pivotsm
[FullBody_JumpStartState]: #36-fullbodyjumpstartstate
[FullBody_JumpStartLoopState]: #37-fullbodyjumpstartloopstate
[FullBody_JumpApexState]: #38-fullbodyjumpapexstate
[FullBody_FallLoopState]: #39-fullbodyfallloopstate
[FullBody_FallLandState]: #310-fullbodyfalllandstate
[LeftHandPose_OverrideState]: #311-lefthandposeoverridestate
[FullBody_SkeletalControls]: #312-fullbodyskeletalcontrols
[FullBody_Aiming]: #313-fullbodyaiming
[FullBodyAdditives]: #314-fullbodyadditives
[FullBodyAdditives > FullBodyAdditive_SM]: #314-fullbodyadditives--fullbodyadditivesm

<!--- 自前の画像へのリンク --->

<!--- generated --->
[1.2. 所定の位置での旋回(TurnInPlace)]: #12-turninplace
[1.2.2. TurnYawAnimModifier]: #122-turnyawanimmodifier
[ABP_ItemAnimLayersBase]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbase
[ABP_Mannequin_Base]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[ALI_ItemAnimLayers]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayers
[Comment_AnimBP_Tour.Ja]: CodeRefs/Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja
[Comment_TurnInPlace.Ja]: CodeRefs/Lyra/ABP/Comment_TurnInPlace.Ja.md#commentturninplaceja
[TurnYawAnimModifier]: CodeRefs/Lyra/ABP/TurnYawAnimModifier.md#turnyawanimmodifier
[ULyraAnimInstance]: CodeRefs/Lyra/Animation/ULyraAnimInstance.md#ulyraaniminstance
[ULyraCharacterMovementComponent]: CodeRefs/Lyra/GameplayFramework/ULyraCharacterMovementComponent.md#ulyracharactermovementcomponent
[Dev Comunity > Forums > How to get a anim layer node reference as shown in the Lyra Example project?]: https://forums.unrealengine.com/t/how-to-get-a-anim-layer-node-reference-as-shown-in-the-lyra-example-project/663840
[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation
[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p159]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation#p159
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[twitter > pafuhana1213 > 2022/10/18]: https://twitter.com/pafuhana1213/status/1582043354103021569
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]: https://docs.unrealengine.com/5.1/ja/animation-modifiers-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > スケルトン > 仮想ボーン]: https://docs.unrealengine.com/5.1/ja/virtual-bones-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > スケルタル制御 > Copy Bone]: https://docs.unrealengine.com/5.1/ja/animation-blueprint-copy-bone-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > スケルタル制御 > Title:Hand IK Retargeting]: https://docs.unrealengine.com/5.1/ja/animation-blueprint-hand-ik-retargeting-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > スケルタル制御 > Two Bone IK]: https://docs.unrealengine.com/5.1/ja/animation-blueprint-two-bone-ik-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]: https://docs.unrealengine.com/5.1/ja/using-animation-blueprint-linking-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > エイム オフセットを作成する]: https://docs.unrealengine.com/5.1/ja/creating-an-aim-offset-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > 所定の位置での旋回]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/#%E6%89%80%E5%AE%9A%E3%81%AE%E4%BD%8D%E7%BD%AE%E3%81%A7%E3%81%AE%E6%97%8B%E5%9B%9E
[ぼっちプログラマのメモ > 2022/12/12 > 【UE5】UE5からの新機能「Distance Matching」を使ってみよう！（サンプル配布あり）]: https://pafuhana1213.hatenablog.com/entry/2022/12/12/204036
[ぼっちプログラマのメモ > 2022/12/13 > 【UE5】UE5のアニメーションに関する新機能をサクッと試せるサンプルを公開しました！]: https://pafuhana1213.hatenablog.com/entry/2022/12/13/000758
[技術ブログ > Lyra アニメーションを UE5 ゲームに適応する方法について]: https://www.unrealengine.com/ja/tech-blog/adapting-lyra-animation-to-your-ue5-game
