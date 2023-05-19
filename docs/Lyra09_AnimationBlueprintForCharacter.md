# 【UE5】Lyra に学ぶ(09) AnimationBlueprint for Character <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
そこでの AniamtionBlueprint がどのように実装されているかを見ていきます。  
扱うのはキャラクター用の AnimationBlueprint で、すなわち以下のものです。  
 * [ABP_Mannequin_Base]
 * [ABP_ItemAnimLayersBase] （と、その派生クラス群）

* バージョン
	* [Lyra Starter Game]
		* 2022/11/29 版(5.1 用)


# 参考

* Unreal Engine の機能解説
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > レイヤー化されたアニメーションを使用する]
		* Locomotion と Aim を例にした基本的なモーションブレンドの解説
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > エイム オフセットを作成する]
		* エイムオフセットアセットの解説
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]
		* Animation Layer Interface などの解説
* Lyra の解説
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]
		* Lyra のアニメーションブループリントについてまとめられています。項目としては以下の通り。
			* スレッドセーフなアニメーションブループリント
			* ノード関数
			* ステートエイリアス
			* ブレンドノードによる上半身と下半身のレイヤー化
			* アニメーション ブループリント リンク システム(Linked Layer Animation Blueprint)
			* アニメーションレイヤーインターフェイス(Animation Layer Interface)
			* [ABP_ItemAnimLayersBase] の派生ブループリント
			* 距離マッチング(移動開始時の再生レート調整)とストライド ワープ(ジョグ移行後の再生レート調整ができない場合の歩幅調整)
			* オリエンテーション ワープ(下半身をルートモーションに合わせて回転している)
			* 所定の位置での旋回(Turn In Place)
			* ([ULyraAnimInstance::GameplayTagPropertyMap] による)ゲームプレイタグバインディング
			* ブレンド プロファイル と Inertialization
			* ステートマシンの遷移ルール内でのアニメーション通知情報の利用
	* [Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】]



# ABP 共通のお話

* AnimGraph
	* Anim Seaquence
		* 基本的に直接参照しない。
	* Blendspace
		* 一部で直接参照している。
* ツアーコメントについて
	* ブループリントのコメントの中で各機能に関するコメントが複数の場所に連番数字付きで書かれています。
	* 具体的には以下の 2 種があります。
		* AnimBP Tour
			* [Comment_AnimBP_Tour.Ja] にコメントをまとめて引用しています。
		* TurnInPlace
			* [Comment_TurnInPlace.Ja] にコメントをまとめて引用しています。



## BS_MM_Rifle_Jog_Leans

* ライフルを持って走るポーズ（１フレームしか無い）が基本となっている BlendSpace です。
* 渡された値は左右に傾き具合として利用されます。
* 以下を利用しています。
	* MM_Rifle_Jog_Lean_Center
	* MM_Rifle_Jog_Lean_Left
	* MM_Rifle_Jog_Lean_Right

## MM_Rifle_Jog_Lean_Center
## MM_Rifle_Jog_Lean_Left
## MM_Rifle_Jog_Lean_Right

* BS_MM_Rifle_Jog_Leans で利用される、銃を持って走るポーズです。
* Center は正面、 Left/Right は進行方向右/左に体を傾け顔を向けています。
* MM_Rifle_Jog_Fwd とブレンドすることで旋回時方向に顔を向け体を傾けるのに利用しています。


# TurnYawAnimModifier

* TurnInPlace で利用する、ルートモーションで Yaw が変化するモンタージュに対し、回転量及び回転量が最終フレームと同値になるタイミングを示すアニメーションカーブを自動生成するためのモディファイアです。
* アニメーションカーブを 2 つ(RemainingTurnYaw/TurnYawWeight)作り、以下のキーを設定する。
	* RemainingTurnYaw
		* 全フレームに自動的にキーを打っている。
			* 指定したボーン(root)の Yaw の最終フレームの値から現在のフレームの値を引いた値
	* TurnYawWeight
		* 以下の３箇所に自動的にキーを打っている。
			* 0 フレーム目に値 1
			* 指定したボーン(root)の Yaw の最終フレームの値と同じになる前に値 1
			* 指定したボーン(root)の Yaw の最終フレームの値と同じになる後に値 0

# AimOffset

* AO_MF_Pistol_Idle_ADS
* AO_MM_Pistol_Idle_ADS
* AO_MM_Rifle_Crouch_Idle
* AO_MM_Rifle_Idle_ADS
* AO_MM_Rifle_Idle_Hipfire
* AO_MM_Unarmed_Idle_Ready


ABP_ItemAnimLayersBase の Anim Node Functions とは？

Pivot とは？


# Anim Node の Tag と Anim Node Reference ノード

* [Dev Comunity > Forums > How to get a anim layer node reference as shown in the Lyra Example project?]
* [Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p159]




# AnimGrap とアニメーションレイヤーの解説

`ABP_PistolAnimLayers` の場合のアセット名をレイとして書いておきます。

1. [ABP_Mannequin_Base::LocomotionSM]
	* 移動に関する状態制御を行う。
	* [ABP_Mannequin_Base::Idle (state)]
		* アイドル状態。
			* 移動していない状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_IdleState] の出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_IdleState]
			* 移動と干渉しない状態として立ち、 ADS 中 、しゃがみ、そして Aim 操作による転換がある。
			* これらの処理が Animation Layer 側で行われる。
			* 処理の流れ
				1. [ABP_ItemAnimLayersBase::IdleSM] の出力が `OutputPose()` につながる。
			* [ABP_ItemAnimLayersBase::IdleSM]
				* アイドル、アイドルの休憩、転換、転換からの復帰の状態制御を行う。
				* [ABP_ItemAnimLayersBase::Idle (state){in IdleSM}]
					* アイドル状態。
					* 処理の流れ
						1. [ABP_ItemAnimLayersBase::IdleStance] の出力が `OutputAnimationPose()` につながる。
					* [ABP_ItemAnimLayersBase::IdleStance]
						* アイドルに関する状態制御を行う。
						* [ABP_ItemAnimLayersBase::Idle (state){in IdleStance}]
							* アイドル状態。立ち、 ADS 中、しゃがみの状態により異なるアニメーションを返す。
							* 処理の流れ
								1. `Sequence Player()` の出力が `OutputAnimationPose()` につながる。
								> * 立ち: `MM_Pistol_Idle_Hipfire`
								> * ADS 中: `MM_Pistol_Idle_ADS`
								> * しゃがみ中: `MM_Pistol_Crouch_Idle`
						* [ABP_ItemAnimLayersBase::StanceTransition (state)]
							* 姿勢繊維状態。しゃがみ開始、しゃがみ終了の状態により異なるアニメーションを返す。
							* 処理の流れ
								1. `Sequence Player()` の出力が `OutputAnimationPose()` につながる。
								> * しゃがみ開始: `MM_Pistol_Crouch_Entry`
								> * しゃがみ終了: `MM_Pistol_Crouch_Entry`
				* [ABP_ItemAnimLayersBase::IdleBreak (state)]
					* アイドルの休憩状態。
					* 処理の流れ
						1. `Sequence Player()` の出力が `OutputAnimationPose()` につながる。
						> * アイドルの休憩: `MM_Pistol_IdleBreak_Scan`
				* [ABP_ItemAnimLayersBase::TurnInPlaceRotation (state)]
					* 転換（左右、しゃがみ左右）状態。
					* 処理の流れ
						1. `Sequence Evaluator()` の出力が `OutputAnimationPose()` につながる。
						> * 転換左: `MM_Pistol_TunrLeft_90`
						> * 転換右: `MM_Pistol_TunrRight_90`
						> * 転換しゃがみ左: `MM_Pistol_Crouch_TunrLeft_90`
						> * 転換右しゃがみ: `MM_Pistol_Crouch_TunrRight_90`
				* [ABP_ItemAnimLayersBase::TurnInPlaceRecovery (state)]
					* 転換からの復帰状態。
					* 処理の流れ
						1. `Sequence Player()` の出力が `OutputAnimationPose()` につながる。
						> * 転換左: `MM_Pistol_TunrLeft_90`
						> * 転換右: `MM_Pistol_TunrRight_90`
						> * 転換しゃがみ左: `MM_Pistol_Crouch_TunrLeft_90`
						> * 転換右しゃがみ: `MM_Pistol_Crouch_TunrRight_90`
	* [ABP_Mannequin_Base::Start (state)]
		* 移動開始状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_StartState]
			2. `BS_MM_RifleJog_Leans` 
				> **Note**  
				> `BS_MM_RifleJog_Leans` は移動方向に顔を向けつつ体を傾ける表現を行うためのブレンドスペースです。  
			3. 1 と 2 を`ApplyAdditive()` した出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_StartState]
			* 処理の流れ
				1. 立ち、 ADS 中、しゃがみで異なる **移動開始** アニメーション
					> * 立ち
					> 	* 前: `MM_Pisol_Jog_Fwd_Start`
					> 	* 後: `MM_Pisol_Jog_Bwd_Start`
					> 	* 左: `MM_Pisol_Jog_Left_Start`
					> 	* 右: `MM_Pisol_Jog_Right_Start`
					> * ADS 中
					> 	* 前: `MM_Pisol_Walk_Fwd_Start`
					> 	* 後: `MM_Pisol_Walk_Bwd_Start`
					> 	* 左: `MM_Pisol_Walk_Left_Start`
					> 	* 右: `MM_Pisol_Walk_Right_Start`
					> * しゃがみ
					> 	* 前: `MM_Pisol_Crouch_Walk_Fwd_Start`
					> 	* 後: `MM_Pisol_Crouch_Walk_Bwd_Start`
					> 	* 左: `MM_Pisol_Crouch_Walk_Left_Start`
					> 	* 右: `MM_Pisol_Crouch_Walk_Right_Start`
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				4. 3 の出力を `OrientationWarping()` と `StrideWarping()` に通した結果が `OutputPose()` につながる。
				> **Note**  
				> 2 は発砲直後しばらくは銃を前方に構えたままにするのに利用しています。
	* [ABP_Mannequin_Base::Cycle (state)]
		* 移動状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_CycleState]
			2. `BS_MM_RifleJog_Leans`
			3. 1 と 2 を `ApplyAdditive()` した出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_CycleState]
			* 処理の流れ
				1. 立ち、 ADS 中、しゃがみで異なる **移動** アニメーション
					> * 立ち
					> 	* 前: `MM_Pisol_Jog_Fwd`
					> 	* 後: `MM_Pisol_Jog_Bwd`
					> 	* 左: `MM_Pisol_Jog_Left`
					> 	* 右: `MM_Pisol_Jog_Right`
					> * ADS 中
					> 	* 前: `MM_Pisol_Walk_Fwd`
					> 	* 後: `MM_Pisol_Walk_Bwd`
					> 	* 左: `MM_Pisol_Walk_Left`
					> 	* 右: `MM_Pisol_Walk_Right`
					> * しゃがみ
					> 	* 前: `MM_Pisol_Crouch_Walk_Fwd`
					> 	* 後: `MM_Pisol_Crouch_Walk_Bwd`
					> 	* 左: `MM_Pisol_Crouch_Walk_Left`
					> 	* 右: `MM_Pisol_Crouch_Walk_Right`
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				4. 3 の出力を `OrientationWarping()` と `StrideWarping()` に通した結果が `OutputPose()` につながる。
	* [ABP_Mannequin_Base::Stop (state)]
		* 移動終了状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_StopState] の出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_StopState]
			* 処理の流れ
				1. 立ち、 ADS 中、しゃがみで異なる **移動終了** アニメーション
					> * 立ち
					> 	* 前: `MM_Pisol_Jog_Fwd_Stop`
					> 	* 後: `MM_Pisol_Jog_Bwd_Stop`
					> 	* 左: `MM_Pisol_Jog_Left_Stop`
					> 	* 右: `MM_Pisol_Jog_Right_Stop`
					> * ADS 中
					> 	* 前: `MM_Pisol_Walk_Fwd_Stop`
					> 	* 後: `MM_Pisol_Walk_Bwd_Stop`
					> 	* 左: `MM_Pisol_Walk_Left_Stop`
					> 	* 右: `MM_Pisol_Walk_Right_Stop`
					> * しゃがみ
					> 	* 前: `MM_Pisol_Crouch_Walk_Fwd_Stop`
					> 	* 後: `MM_Pisol_Crouch_Walk_Bwd_Stop`
					> 	* 左: `MM_Pisol_Crouch_Walk_Left_Stop`
					> 	* 右: `MM_Pisol_Crouch_Walk_Right_Stop`
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				4. 3 の出力が `OutputPose()` につながる。
	* [ABP_Mannequin_Base::Pivot (state)]
		* 移動方向転換状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_PivotState]
			2. `BS_MM_RifleJog_Leans`
			3. 1 と 2 を `ApplyAdditive()` した出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_PivotState]
			* ピボット中にさらにピボットが発生することがある。
			* 処理の流れ
				1. [ABP_ItemAnimLayersBase::PivotSM]
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				3.  の出力が `OutputPose()` につながる。
			* [ABP_ItemAnimLayersBase::PivotSM]
				* ステートの再入の仕組みがないため、同じ処理を行う2つのステートを利用して状態制御を行う。
				* [ABP_ItemAnimLayersBase::PivotA (state)] / [ABP_ItemAnimLayersBase::PivotB (state)]
					* ピボット状態。
					* 処理の流れ
						1. 立ち、 ADS 中、しゃがみで異なる **ピボット** アニメーション
							> * 立ち
							> 	* 前: `MM_Pisol_Jog_Pivot_Fwd`
							> 	* 後: `MM_Pisol_Jog_Pivot_Bwd`
							> 	* 左: `MM_Pisol_Jog_Pivot_Left`
							> 	* 右: `MM_Pisol_Jog_Pivot_Right`
							> * ADS 中
							> 	* 前: `MM_Pisol_Walk_Fwd_Pivot`
							> 	* 後: `MM_Pisol_Walk_Bwd_Pivot`
							> 	* 左: `MM_Pisol_Walk_Left_Pivot`
							> 	* 右: `MM_Pisol_Walk_Right_Pivot`
							> * しゃがみ
							> 	* 前: `MM_Pisol_Crouch_Walk_Fwd_Pivot`
							> 	* 後: `MM_Pisol_Crouch_Walk_Bwd_Pivot`
							> 	* 左: `MM_Pisol_Crouch_Walk_Left_Pivot`
							> 	* 右: `MM_Pisol_Crouch_Walk_Right_Pivot`
						2. 1 を `OrientationWarping()` と `StrideWarping()` に通した結果が `OutputAnimationPose()` につながる。
	* [ABP_Mannequin_Base::JumpStart (state)]
		* ジャンプ開始状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_JumpStartState] の出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_JumpStartState]
			* 処理の流れ
				1. **ジャンプ開始** アニメーション
					> * ジャンプ開始: `MM_Pisol_Jump_Start`
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				4. 3 の出力が `OutputPose()` につながる。
	* [ABP_Mannequin_Base::JumpStartLoop (state)]
		* ジャンプ開始後頂点まで状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_JumpStartLoopState] の出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_JumpStartLoopState]
			* 処理の流れ
				1. **ジャンプ開始後頂点まで** アニメーション
					> * ジャンプ開始後頂点まで: `MM_Pisol_Jump_Apex`
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				4. 3 の出力が `OutputPose()` につながる。
	* [ABP_Mannequin_Base::JumpApex (state)]
		* ジャンプ頂点付近状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_JumpApexState] の出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_JumpApexState]
			* 処理の流れ
				1. **ジャンプ頂点付近** アニメーション
					> * ジャンプ頂点付近: `MM_Pisol_Jump_Start_Loop`
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				4. 3 の出力が `OutputPose()` につながる。
	* [ABP_Mannequin_Base::FallLoop (state)]
		* ジャンプ落下中状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_FallLoopState] の出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_FallLoopState]
			* 処理の流れ
				1. **ジャンプ落下中** アニメーション
					> * ジャンプ落下中: `MM_Pisol_Jump_Fall_Loop`
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				4. 3 の出力が `OutputPose()` につながる。
	* [ABP_Mannequin_Base::FallLand (state)]
		* ジャンプ着地付近状態。
		* 処理の流れ
			1. [ALI_ItemAnimLayers::FullBody_FallLandState] の出力が `OutputAnimationPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBody_FallLandState]
			* 処理の流れ
				1. **ジャンプ着地付近** アニメーション
					> * ジャンプ落下中: `MM_Pisol_Jump_Fall_Land`
				2. 立ち、しゃがみで異なる上半身の基本アニメーション（ 0 フレーム目固定）
					> * 立ち: `MM_Pistol_Idle_Hipfire`
					> * しゃがみ: `MM_Pistol_Crouch_OverridePose`
				3. 1 と 2 を `LayeredBlendPerBone()` で上半身のみブレンドする。
					> Blend Mask で `UpperBodyMask` を使用。
				4. 3 の出力が `OutputPose()` につながる。
	> * ジャンプ中の処理の流れは、使用するアニメーションが異なるだけで、主な流れは全く同じです。
2. `LeftHandPose_OverrideState`
TODO: このへんから




各関数で何をやっているのかの解説




* [ALI_ItemAnimLayers::FullBody_Aiming]
	* AnimGraph で使用。
* [ALI_ItemAnimLayers::FullBodyAdditives]
* [ALI_ItemAnimLayers::FullBody_IdleState]
* [ALI_ItemAnimLayers::FullBody_StartState]
* [ALI_ItemAnimLayers::FullBody_CycleState]
* [ALI_ItemAnimLayers::FullBody_StopState]
* [ALI_ItemAnimLayers::FullBody_PivotState]
* [ALI_ItemAnimLayers::FullBody_Aiming]
* [ALI_ItemAnimLayers::FullBody_JumpStartState]
* [ALI_ItemAnimLayers::FullBody_JumpApexState]
* [ALI_ItemAnimLayers::FullBody_FallLandState]
* [ALI_ItemAnimLayers::FullBody_FallLoopState]
* [ALI_ItemAnimLayers::FullBody_JumpStartLoopState]
* [ALI_ItemAnimLayers::FullBody_SkeletalControls]
* [ALI_ItemAnimLayers::LeftHandPose_OverrideState]






[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]: https://docs.unrealengine.com/5.1/ja/using-animation-blueprint-linking-in-unreal-engine/

[技術ブログ > Lyra アニメーションを UE5 ゲームに適応する方法について]: https://www.unrealengine.com/ja/tech-blog/adapting-lyra-animation-to-your-ue5-game


<!-- links -->

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ABP_ItemAnimLayersBase]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbase
[ABP_ItemAnimLayersBase::FullBody_IdleState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyidlestate
[ABP_ItemAnimLayersBase::IdleSM]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidlesm
[ABP_ItemAnimLayersBase::Idle (state){in IdleSM}]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidle-statein-idlesm
[ABP_ItemAnimLayersBase::IdleBreak (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidlebreak-state
[ABP_ItemAnimLayersBase::TurnInPlaceRotation (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseturninplacerotation-state
[ABP_ItemAnimLayersBase::TurnInPlaceRecovery (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseturninplacerecovery-state
[ABP_ItemAnimLayersBase::IdleStance]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidlestance
[ABP_ItemAnimLayersBase::Idle (state){in IdleStance}]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidle-statein-idlestance
[ABP_ItemAnimLayersBase::StanceTransition (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasestancetransition-state
[ABP_ItemAnimLayersBase::FullBody_StartState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodystartstate
[ABP_ItemAnimLayersBase::FullBody_CycleState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodycyclestate
[ABP_ItemAnimLayersBase::FullBody_StopState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodystopstate
[ABP_ItemAnimLayersBase::FullBody_PivotState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodypivotstate
[ABP_ItemAnimLayersBase::PivotSM]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasepivotsm
[ABP_ItemAnimLayersBase::PivotA (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasepivota-state
[ABP_ItemAnimLayersBase::PivotB (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasepivotb-state
[ABP_ItemAnimLayersBase::FullBody_JumpStartState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyjumpstartstate
[ABP_ItemAnimLayersBase::FullBody_JumpApexState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyjumpapexstate
[ABP_ItemAnimLayersBase::FullBody_FallLandState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyfalllandstate
[ABP_ItemAnimLayersBase::FullBody_FallLoopState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyfallloopstate
[ABP_ItemAnimLayersBase::FullBody_JumpStartLoopState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyjumpstartloopstate
[ABP_Mannequin_Base]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[ABP_Mannequin_Base::LocomotionSM]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaselocomotionsm
[ABP_Mannequin_Base::Idle (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaseidle-state
[ABP_Mannequin_Base::Start (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasestart-state
[ABP_Mannequin_Base::Cycle (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasecycle-state
[ABP_Mannequin_Base::Stop (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasestop-state
[ABP_Mannequin_Base::Pivot (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasepivot-state
[ABP_Mannequin_Base::JumpStart (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasejumpstart-state
[ABP_Mannequin_Base::JumpStartLoop (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasejumpstartloop-state
[ABP_Mannequin_Base::JumpApex (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasejumpapex-state
[ABP_Mannequin_Base::FallLoop (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasefallloop-state
[ABP_Mannequin_Base::FallLand (state)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasefallland-state
[ALI_ItemAnimLayers::FullBodyAdditives]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyadditives
[ALI_ItemAnimLayers::FullBody_IdleState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyidlestate
[ALI_ItemAnimLayers::FullBody_StartState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodystartstate
[ALI_ItemAnimLayers::FullBody_CycleState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodycyclestate
[ALI_ItemAnimLayers::FullBody_StopState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodystopstate
[ALI_ItemAnimLayers::FullBody_PivotState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodypivotstate
[ALI_ItemAnimLayers::FullBody_Aiming]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyaiming
[ALI_ItemAnimLayers::FullBody_JumpStartState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyjumpstartstate
[ALI_ItemAnimLayers::FullBody_JumpApexState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyjumpapexstate
[ALI_ItemAnimLayers::FullBody_FallLandState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyfalllandstate
[ALI_ItemAnimLayers::FullBody_FallLoopState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyfallloopstate
[ALI_ItemAnimLayers::FullBody_JumpStartLoopState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyjumpstartloopstate
[ALI_ItemAnimLayers::FullBody_SkeletalControls]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayersfullbodyskeletalcontrols
[ALI_ItemAnimLayers::LeftHandPose_OverrideState]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayerslefthandposeoverridestate
[Comment_AnimBP_Tour.Ja]: CodeRefs/Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja
[Comment_TurnInPlace.Ja]: CodeRefs/Lyra/ABP/Comment_TurnInPlace.Ja.md#commentturninplaceja
[ULyraAnimInstance::GameplayTagPropertyMap]: CodeRefs/Lyra/Animation/ULyraAnimInstance.md#ulyraaniminstancegameplaytagpropertymap
[Dev Comunity > Forums > How to get a anim layer node reference as shown in the Lyra Example project?]: https://forums.unrealengine.com/t/how-to-get-a-anim-layer-node-reference-as-shown-in-the-lyra-example-project/663840
[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation
[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p159]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation#p159
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]: https://docs.unrealengine.com/5.1/ja/using-animation-blueprint-linking-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > エイム オフセットを作成する]: https://docs.unrealengine.com/5.1/ja/creating-an-aim-offset-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > レイヤー化されたアニメーションを使用する]: https://docs.unrealengine.com/5.1/ja/using-layered-animations-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
