## ABP_ItemAnimLayersBase

>> 詳細は未確認です。

TODO: 各変数が取る値は各変数の項目に記載するようにする。


* 概要
	* 拳銃等のアニメーションの設定を行う Anim Layer 用の AnimBP の基底クラスです。
* 他のクラスとの関係
	* Anim Layer の主となる AnimBP
		* [GetMainAnimBPThreadSafe()] を経由して、 [ABP_Mannequin_Base] のメンバにプロパティアクセスしています。
* 構成要素
	* [GRAPHS]
		* [EventGraph]
	* [ANIMATION GRAPHS]
		* [AnimGraph]
	* [ANIMATION LAYERS]
		* [Item Anim Layers]
			* [FullBodyAdditives]
				* [FullBodyAdditive_SM]
					* [Identity (state)]
					* [AirIdentity (state)]
					* [LandRecovery (state)]
					* [Identity to AirIdentity (rule)]
					* [AirIdentity to LandRecovery (rule)]
					* [LandRecovery to Identity (rule)]
			* [FullBody_IdleState]
				* [IdleSM]
					* [Idle (state){in IdleSM}]
						* [IdleStance]
							* [Idle (state){in IdleStance}]
							* [StanceTransition (state)]
							* [Idle to StanceTransition (rule)]
							* [StanceTransition to Idle (rule)]
					* [TurnInPlaceRotation (state)]
					* [TurnInPlaceRecovery (state)]
					* [TurnInPlaceRecovery to Idle (rule)]
					* [IdleBreak (state)]
					* [WantsTurnInPlace (rule)]
					* [Idle to IdleBreak (rule)]
					* [IdleBreak to Idle (rule)]
					* [TurnInPlaceRotation to TurnInPlaceRecovery (rule)]
			* [FullBody_StartState]
			* [FullBody_CycleState]
			* [FullBody_StopState]
			* [FullBody_PivotState]
				* [PivotSM]
					* [PivotA (state)]
					* [PivotB (state)]
					* [WantsToRePivit (rule)]
			* [FullBody_Aiming]
			* [FullBody_JumpStartState]
			* [FullBody_JumpApexState]
			* [FullBody_FallLandState]
			* [FullBody_FallLoopState]
			* [FullBody_JumpStartLoopState]
			* [FullBody_SkeletalControls]
			* [LeftHandPose_OverrideState]
	* [FUNCTIONS]
		* [State Node Functions]
			* [SetUpIdleState()]
			* [UpdateIdleState()]
			* [LandRecoveryStart()]
			* [SetupIdleTransition()]
		* [Anim Node Functions]
			* [UpdateIdleAnim()]
			* [SetUpIdleBreakAnim()]
			* [SetUpStartAnim()]
			* [UpdateStartAnim()]
			* [UpdateCycleAnim()]
			* [SetUpStopAnim()]
			* [UpdateStopAnim()]
			* [SetUpPivotAnim()]
			* [UpdatePivotAnim()]
			* [UpdateHipFireRaiseWeaponPose()]
			* [SetUpFallLandAnim()]
			* [UpdateFallLandAnim()]
			* [SetLeftHandPoseOverrideWeight()]
		* [Turn In Place{FUNCTIONS}]
			* [SetupTurnInPlaceAnim()]
			* [UpdateTurnInPlaceAnim()]
			* [SetUpTurnInPlaceRotationState()]
			* [UpdateTurnInPlaceRecoveryState()]
			* [SetUpTurnInPlaceRecoveryState()]
			* [SelectTurnInPlaceAnimation()]
		* [Idle Breaks{FUNCTIONS}]
			* [CanPlayIdleBreak()]
			* [ResetIdleBreakTransitionLogic()]
			* [ProcessIdleBreakTransitionLogic()]
			* [ChooseIdleBreakDelayTime()]
		* [Blueprint Thread Safe Update Functions]
			* [UpdateBlendWeightData()]
			* [UpdateJumpFallData()]
			* [UpdateSkelControlData()]
		* [Distance Matching]
			* [GetPredictedStopDistance()]
			* [ShouldDistanceMatchStop()]
		* [Pivots{FUNCTIONS}]
			* [GetDesiredPivotSequence()]
		* [Default{FUNCTIONS}]
			* [BlueprintThreadSafeUpdateAnimation()]
			* [GetMainAnimBPThreadSafe()]
			* [ShouldEnableFootPlacement()]
			* [GetMovementComponent()]
	* [VALIABLES]
		* [Anim Set - Idle]
			* [Idle_ADS]
			* [Idle_Hipfire]
			* [Idle_Breaks]
			* [Crouch_Idle]
			* [Crouch_Idle_Entry]
			* [Crouch_Idle_Exit]
			* [LeftHandPose_Override]
		* [Anim Set - Starts]
			* [Jog_Start_Cardinals]
			* [ADS_Start_Cardinals]
			* [Crouch_Start_Cardinals]
		* [Anim Set - Stops]
			* [Jog_Stop_Cardinals]
			* [ADS_Stop_Cardinals]
			* [Crouch_Stop_Cardinals]
		* [Anim Set - Pivots]
			* [Jog_Pivot_Cardinals]
			* [ADS_Pivot_Cardinals]
			* [Crouch_Pivot_Cardinals]
		* [Anim Set - Turn in Place]
			* [TurnInPlace_Left]
			* [TurnInPlace_Right]
			* [Crouch_TurnInPlace_Left]
			* [Crouch_TurnInPlace_Right]
		* [Anim Set - Jog]
			* [Jog_Cardinals]
		* [Anim Set - Jump]
			* [Jump_Start]
			* [Jump_Apex]
			* [Jump_FallLand]
			* [Jump_RecoveryAdditive]
			* [Jump_StartLoop]
			* [Jump_FallLoop]
			* [JumpDistanceCurveName]
		* [Anim Set - Walk]
			* [Walk_Cardinals]
			* [Crouch_Walk_Cardinals]
		* [Anim Set - Aiming]
			* [Aim_HipFirePose]
			* [Aim_HipFirePose_Crouch]
			* [IdleAnimOffset]
			* [RelaxedAimOffset]
		* [Settings]
			* [PlayRateClampStarsPivos]
			* [RaiseWeaponAfterFiringWhenCrouched]
			* [DisableHandIK]
			* [EnableLeftHandPoseOverride]
			* [RaiseWeaponAfterFiringDuration]
			* [StrideWarpingBlendInDurationScaled]
			* [StrideWarpingBlendStartOffset]
			* [LocomotionDistanceCurveName]
			* [PlayRateClampCycle]
		* [Blend Weight Data]
			* [HipFireUpperBodyOverrideWeight]
			* [AimOffsetBlendWeight]
		* [Turn In Place{VALIABLES}]
			* [TurnInPlaceAnimTime]
			* [TurnInPlaceRotationDirection]
			* [TurnInPlaceRecoveryDirection]
		* [Idle Breaks{VALIABLES}]
			* [WantsIdleBreak]
			* [TimeUntilNextIdleBreak]
			* [CurrentIdleBreakIndex]
			* [IdleBreakDelayTime]
		* [Pivots{VALIABLES}]
			* [PivotStartingAcceleration]
			* [TimeAtPivotStop]
		* [Jump]
			* [LandRecoveryAlpha]
			* [TimeFalling]
		* [Skel Control Data]
			* [HandIK_Right_Alpha]
			* [HandIK_Left_Alpha]
		* [Stride Warping]
			* [StrideWarpingStartAlpha]
			* [StrideWarpingPivotAlpha]
			* [StrideWarpingCycleAlpha]
		* [Default{VALIABLES}]
			* [LeftHandPoseOverrideWeight]
			* [HandFKWeightWeight]
* グループについて
	* [ANIMATION LAYERS] のグループ
		* [Item Anim Layers]
			* [ALI_ItemAnimLayers] で定義されている。
	* [FUNCTIONS] のグループ
		* [State Node Functions]
			* 主に ステートの `Output Animation Pose` ノード及び [AnimGraph] のステートマシンノードで使用しているノード関数です。
				* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ブループリントでのグラフ作成 > ノード関数]
			* 命名規則は以下のいずれかです。
				* Update（関数のタイプが On Update） + ステート名 + State
					* 例：[UpdateIdleState()]
				* SetUp（関数のタイプが On Become Relevant） + ステート名 + State
					* 例：[SetUpIdleState()]
				* 命名規則に沿わないもの
					* [LandRecoveryStart()]
					* [SetupIdleTransition()]
		* [Anim Node Functions]
			* 主に `Sequence Player` ノードまたは `Sequence Evaluator` ノードで使用しいているノード関数です。
				* 主に再生するアニメーションシーケンスの指定を行います。
				* [SetLeftHandPoseOverrideWeight()] は例外で、 `Layered blend per bone` ノードに設定されており、これに渡す `Blend Weights 0` パラメータの計算を行っています。
			* 命名規則は以下のいずれかです。
				* Update（関数のタイプが On Update） + ステート名(またはアニメーションレイヤー名の一部) + Anim
					* 例：[UpdateIdleAnim()] / [UpdateStartAnim()]
				* SetUp（関数のタイプが On Become Relevant） + ステート名(またはアニメーションレイヤー名の一部) + Anim
					* 例：[SetUpIdleBreakAnim()] / [SetUpStartAnim()]
				* 命名規則に沿わないもの
					* [SetLeftHandPoseOverrideWeight()]
		* [Turn In Place{FUNCTIONS}]
			* 所定の位置での旋回処理を行うための関数です。
			* [SelectTurnInPlaceAnimation()] 以外はノード関数として利用されています。
		* [Idle Breaks{FUNCTIONS}]
			* TODO: なにかかく。
		* [Blueprint Thread Safe Update Functions]
			* [BlueprintThreadSafeUpdateAnimation()] から呼び出される、アニメーショングラフで利用される変数を更新する関数です。
		* [Distance Matching]
			* TODO: なにかかく。
		* [Pivots{FUNCTIONS}]
			* TODO: なにかかく。
		* [Default{FUNCTIONS}]
			* TODO: なにかかく。
	* [VALIABLES] のグループ
		* TODO ここから
		* `Anim Set - ???`
			* 以下のグループについて
				* [Anim Set - Idle]
				* [Anim Set - Starts]
				* [Anim Set - Stops]
				* [Anim Set - Pivots]
				* [Anim Set - Turn in Place]
				* [Anim Set - Jog]
				* [Anim Set - Jump]
				* [Anim Set - Walk]
				* [Anim Set - Aiming]
			* 各ステートで使用するアニメーションシーケンスに関するプロパティです。
			* ほぼ、アニメーションシーケンスに関する以下の型です。
				* [UAnimSequence]
				* [UAimOffsetBlendSpace]
				* [AnimStruct_CardinalDirections]
			* それ以外にアニメーションカーブ名を指定する [JumpDistanceCurveName] があります。
		* [Settings]
			* 定数として扱われている変数です。
		* [Blend Weight Data]
			* アニメーションのブレンドの際のアルファ値を保持する変数です。
			* 更新は [UpdateBlendWeightData()] で行われます。
		* [Turn In Place{VALIABLES}]
			* 所定の位置での旋回処理を行うための変数です。
		* [Idle Breaks{VALIABLES}]
			* TODO: なにかかく。
		* [Pivots{VALIABLES}]
			* TODO: なにかかく。
		* [Jump]
			* TODO: なにかかく。
		* [Skel Control Data]
			* TODO: なにかかく。
		* [Stride Warping]
			* TODO: なにかかく。
* ノード関数の利用状況
	| グループ						| ノード関数名							| グラフ								| ノード					| 種別					|
	| ----							| ----									| ----									| ----						| ----					|
	| [State Node Functions]		| [UpdateIdleState()]					| [Idle (state){in IdleSM}]				| `Output Animation Pose`	| On Update				|
	| [State Node Functions]		| [SetUpIdleState()]					| [Idle (state){in IdleSM}]				| `Output Animation Pose`	| On Become Relevant	|
	| [State Node Functions]		| [LandRecoveryStart()]					| [LandRecovery (state)]				| `Output Animation Pose`	| On Become Relevant	|
	| [State Node Functions]		| [SetupIdleTransition()]				| [StanceTransition (state)]			| `Sequence Player`			| On Become Relevant	|
	| [Anim Node Functions]			| [UpdateIdleAnim()]					| [Idle (state){in IdleStance}]			| `Sequence Player`			| On Update				|
	| [Anim Node Functions]			| [SetUpIdleBreakAnim()]				| [IdleBreak (state)]					| `Sequence Player`			| On Become Relevant	|
	| [Anim Node Functions]			| [SetUpStartAnim()]					| [FullBody_StartState]					| `Sequence Evaluator`		| On Become Relevant	|
	| [Anim Node Functions]			| [UpdateStartAnim()]					| [FullBody_StartState]					| `Sequence Evaluator`		| On Update				|
	| [Anim Node Functions]			| [UpdateCycleAnim()]					| [FullBody_CycleState]					| `Sequence Player`			| On Update				|
	| [Anim Node Functions]			| [SetUpStopAnim()]						| [FullBody_StopState]					| `Sequence Evaluator`		| On Become Relevant	|
	| [Anim Node Functions]			| [UpdateStopAnim()]					| [FullBody_StopState]					| `Sequence Evaluator`		| On Update				|
	| [Anim Node Functions]			| [SetUpPivotAnim()]					| [PivotA (state)]<br>[PivotB (state)]	| `Sequence Evaluator`		| On Become Relevant	|
	| [Anim Node Functions]			| [UpdatePivotAnim()]					| [PivotA (state)]<br>[PivotB (state)]	| `Sequence Evaluator`		| On Update				|
	| [Anim Node Functions]			| [UpdateHipFireRaiseWeaponPose()]		| [FullBody_StartState]<br>[FullBody_CycleState]<br>[FullBody_StopState]<br>[FullBody_PivotState]<br>[FullBody_JumpStartState]<br>[FullBody_JumpApexState]<br>[FullBody_FallLandState]<br>[FullBody_FallLoopState]<br>[FullBody_JumpStartLoopState]	| `Sequence Evaluator`		| On Update				|
	| [Anim Node Functions]			| [SetUpFallLandAnim()]					| [FullBody_FallLandState]				| `Sequence Evaluator`		| On Become Relevant	|
	| [Anim Node Functions]			| [UpdateFallLandAnim()]				| [FullBody_FallLandState]				| `Sequence Evaluator`		| On Update				|
	| [Anim Node Functions]			| [SetLeftHandPoseOverrideWeight()]		| [LeftHandPose_OverrideState]			| `Layered blend per bone`	| On Update				|
	| [Turn In Place{FUNCTIONS}]	| [SetupTurnInPlaceAnim()]				| [TurnInPlaceRotation (state)]			| `Sequence Evaluator`		| On Become Relevant	|
	| [Turn In Place{FUNCTIONS}]	| [UpdateTurnInPlaceAnim()]				| [TurnInPlaceRotation (state)]			| `Sequence Evaluator`		| On Update				|
	| [Turn In Place{FUNCTIONS}]	| [SetUpTurnInPlaceRotationState()]		| [TurnInPlaceRotation (state)]			| `Output Animation Pose`	| On Become Relevant	|
	| [Turn In Place{FUNCTIONS}]	| [UpdateTurnInPlaceRecoveryState()]	| [TurnInPlaceRecovery (state)]			| `Sequence Player`			| On Update				|
	| [Turn In Place{FUNCTIONS}]	| [SetUpTurnInPlaceRecoveryState()]		| [TurnInPlaceRecovery (state)]			| `Output Animation Pose`	| On Become Relevant	|


# GRAPHS

## EventGraph

* Tour コメント
	* [Comment_AnimBP_Tour.Ja::5]
	* [Comment_AnimBP_Tour.Ja::6]
* 概要
	* マルチスレッド対応のため、基本的には空っぽ。

# ANIMATION GRAPHS

## AnimGraph

* 概要
	* Animation Layer 用の Animation Blueprint なので、空っぽ。

# ANIMATION LAYERS

* 概要
	* すべて基本的な実装をしている。

## Item Anim Layers

### FullBodyAdditives

* 概要
	* ステートマシン [FullBodyAdditive_SM] の結果を `Output Pose` に接続しています。

#### FullBodyAdditive_SM

* 構成要素
	* State
		* [Identity (state)]
		* [AirIdentity (state)]
		* [LandRecovery (state)]
	* Rule
		* [Identity to AirIdentity (rule)]
		* [AirIdentity to LandRecovery (rule)]
		* [LandRecovery to Identity (rule)]
* State に関して
	* ノード関数の使用状況
		| グラフ					| ノード					| 種別					| ノード関数名				|
		|----						|----						|----					|----						|
		| [LandRecovery (state)]	| `Output Animation Pose`	| On Become Relevant	| [LandRecoveryStart()]		|
	* アニメーションシーケンスの使用状況
		| 名前						| アニメーションシーケンス		|
		|----						|								|
		| [LandRecovery (state)]	| [Jump_RecoveryAdditive]		|

##### Identity (state)

* 地上に居るステートです。
* 特に追加のアニメーションが存在せず、アニメーションシーケンスを出力しません。

##### AirIdentity (state)

* 空中に居るステートです。
* 特に追加のアニメーションが存在せず、アニメーションシーケンスを出力しません。

##### LandRecovery (state)

* 空中から地上に移ったときのステートです。
* [Jump_RecoveryAdditive] に設定された、アニメーションシーケンスを出力します。
* 要は着地時のアニメーションを設定するためのステートです。

##### Identity to AirIdentity (rule)

* Priority.1
	* Not( [ABP_Mannequin_Base::IsOnGround] ) を `Can Enter Transition` に設定します。
	* つまり地面から離れたら遷移します。

##### AirIdentity to LandRecovery (rule)

* Priority.1
	* [ABP_Mannequin_Base::IsOnGround] を `Can Enter Transition` に設定します。
	* つまり地面に着いたら遷移します。

##### LandRecovery to Identity (rule)

* Priority.1
	* Not( [ABP_Mannequin_Base::IsOnGround] ) を `Can Enter Transition` に設定します。
	* つまり地面から離れたら遷移します。
* Priority.2
	* `Automatic Rule Base on Aequence` に true が設定されています。
	* つまり、 [LandRecovery (state)] で設定されたアニメーションシーケンスの再生が終わり次第遷移します。

### FullBody_IdleState

* Tour コメント
	* [Comment_AnimBP_Tour.Ja::7]
* 概要
	* ステートマシン [Idle (state){in IdleSM}] の結果を `Output Pose` に接続しています。

#### IdleSM

* 構成要素
	* State
		* [Idle (state){in IdleSM}]
		* [IdleBreak (state)]
		* [TurnInPlaceRotation (state)]
		* [TurnInPlaceRecovery (state)]
	* Transition Rule Sharing
		* [WantsTurnInPlace (rule)]
	* Rule
		* [Idle to IdleBreak (rule)]
		* [IdleBreak to Idle (rule)]
		* [TurnInPlaceRotation to TurnInPlaceRecovery (rule)]
		* [TurnInPlaceRecovery to Idle (rule)]
* State に関して
	* ノード関数の使用状況
		| グラフ						| ノード					| 種別					| ノード関数名							|
		|----							|----						|----					|----									|
		| [Idle (state){in IdleSM}]		| `Output Animation Pose`	| On Become Relevant	| [SetUpIdleState()]					|
		| [Idle (state){in IdleSM}]		| `Output Animation Pose`	| On Update				| [UpdateIdleState()]					|
		| [IdleBreak (state)]			| `Sequence Player`			| On Become Relevant	| [SetUpIdleBreakAnim()]				|
		| [TurnInPlaceRotation (state)]	| `Sequence Evaluator`		| On Become Relevant	| [SetupTurnInPlaceAnim()]				|
		| [TurnInPlaceRotation (state)]	| `Sequence Evaluator`		| On Update				| [UpdateTurnInPlaceAnim()]				|
		| [TurnInPlaceRotation (state)]	| `Output Animation Pose`	| On Become Relevant	| [SetUpTurnInPlaceRotationState()]		|
		| [TurnInPlaceRecovery (state)]	| `Sequence Player`			| On Update				| [UpdateTurnInPlaceRecoveryState()]	|
		| [TurnInPlaceRecovery (state)]	| `Output Animation Pose`	| On Become Relevant	| [LandRecoveryStart()]					|
	* アニメーションシーケンスの使用状況
		| 名前							| アニメーションシーケンス								|
		|----							|----													|
		| [Idle (state){in IdleSM}]		| ステートマシン [IdleStance] に従う					|
		| [IdleBreak (state)]			| ノード関数 [SetUpIdleBreakAnim()] に従う				|
		| [TurnInPlaceRotation (state)]	| ノード関数 [UpdateTurnInPlaceAnim()] に従う			|
		| [TurnInPlaceRecovery (state)]	| ノード関数 [UpdateTurnInPlaceRecoveryState()] に従う	|
* Transition Rule Sharing に関して
	* 一覧と主な設定
		| 名前							| 用途													| 遷移元																				|
		|----							|----													|----																					|
		| [WantsTurnInPlace (rule)]		| [TurnInPlaceRotation (state)] への遷移ルール			| [Idle (state){in IdleSM}]<br>[IdleBreak (state)]<br>[TurnInPlaceRecovery (state)]		|


##### Idle (state){in IdleSM}

* 概要
	* 立っているだけの状態です。
	* ステート内でステートマシン [IdleStance] を利用しています。
	* 以下のノード関数を利用しています。
		| ノード					| 種別					| ノード関数名							|
		|----						|----					|----									|
		| `Output Animation Pose`	| On Become Relevant	| [SetUpIdleState()]					|
		| `Output Animation Pose`	| On Update				| [UpdateIdleState()]					|

##### IdleBreak (state)

* 概要
	* 立っているだけの状態がしばらく続いた後にあたりを見渡すなどをする状態です。
	* 以下のノード関数を利用しています。
		| ノード					| 種別					| ノード関数名							|
		|----						|----					|----									|
		| `Sequence Player`			| On Become Relevant	| [SetUpIdleBreakAnim()]				|

##### TurnInPlaceRotation (state)

* Tour コメント
	* [Comment_TourInPlace.Ja::6]
* 概要
	* `Turn In Place` のうち、転回を行う状態です。
	* 以下のノード関数を利用しています。
		| ノード					| 種別					| ノード関数名							|
		|----						|----					|----									|
		| `Sequence Evaluator`		| On Become Relevant	| [SetupTurnInPlaceAnim()]				|
		| `Sequence Evaluator`		| On Update				| [UpdateTurnInPlaceAnim()]				|
		| `Output Animation Pose`	| On Become Relevant	| [SetUpTurnInPlaceRotationState()]		|


##### TurnInPlaceRecovery (state)

* Tour コメント
	* [Comment_TourInPlace.Ja::6]
* 概要
	* `Turn In Place` のうち、転回を行った後の、 [Idle (state){in IdleSM}] に戻る前の一時的な状態です。
	* 以下のノード関数を利用しています。
		| ノード					| 種別					| ノード関数名							|
		|----						|----					|----									|
		| `Sequence Player`			| On Update				| [UpdateTurnInPlaceRecoveryState()]	|
		| `Output Animation Pose`	| On Become Relevant	| [LandRecoveryStart()]					|

##### WantsTurnInPlace (rule)

* 概要
	* `Turn In Place` の転回を行うためのルールです。
	* つまり、 [TurnInPlaceRotation (state)] 以外のステートから [TurnInPlaceRotation (state)] に移るための共通のルールです。
	* [TurnInPlaceRecovery (state)] からの設定では `Blend Logic` に `Inertialization` が指定されています。


##### Idle to IdleBreak (rule)

* Priority.1
	* [TimeUntilNextIdleBreak] がマイナスかどうかを `Can Enter Transition` に設定します。
	* [TimeUntilNextIdleBreak] は [ResetIdleBreakTransitionLogic()] で初期化され、 [ProcessIdleBreakTransitionLogic()] で毎フレーム減算されます。
	* つまり一定時間経過したら遷移します。


##### IdleBreak to Idle (rule)

* Priority.1
	* [ABP_Mannequin_Base::GameplayTag_IsFiring] を `Can Enter Transition` に設定します。
	* つまり地面発砲中は遷移します。
* Priority.2
	* Not( [CanPlayIdleBreak()] ) を `Can Enter Transition` に設定します。
	* つまり、何ら頭の操作を行うなどした場合に遷移します。
* Priority.2
	* `Automatic Rule Base on Aequence` に true が設定されています。
	* つまり、 [IdleBreak (state)] で設定されたアニメーションシーケンスの再生が終わり次第遷移します。
	> Priority が重複している理由は不明です。


##### TurnInPlaceRotation to TurnInPlaceRecovery (rule)

* Priority.1
	* アニメーションカーブ `TurnYawWeight` がほぼ 0.0 かを `Can Enter Transition` に設定します。
		* `TurnYawWeight` については [TurnYawAnimModifier] を参照してください。
	* つまりアニメーションシーケンスで設定されてる Yaw の回転が終わった際に遷移します
	* `Blend Logic` に `Inertialization` が指定されています。


##### TurnInPlaceRecovery to Idle (rule)

* Priority.1
	* `Automatic Rule Base on Aequence` に true が設定されています。
	* つまり、 [TurnInPlaceRecovery (state)] で設定されたアニメーションシーケンスの再生が終わり次第遷移します。


#### IdleStance

* 概要
	* [Idle (state){in IdleSM}] で利用されているステートマシンです。
	* しゃがみの開始と終了のアニメーションシーケンスの再生を制御します。
* 構成要素
	* State
		* [Idle (state){in IdleStance}]
		* [StanceTransition (state)]
	* Rule
		* [Idle to StanceTransition (rule)]
		* [StanceTransition to Idle (rule)]
* State に関して
	* ノード関数の使用状況
		| グラフ						| ノード					| 種別					| ノード関数名							|
		|----							|----						|----					|----									|
		| [Idle (state){in IdleStance}]	| `Sequence Player`			| On Update				| [UpdateIdleAnim()]					|
		| [StanceTransition (state)]	| `Sequence Player`			| On Become Relevant	| [SetupIdleTransition()]				|
	* アニメーションシーケンスの使用状況
		| 名前							| アニメーションシーケンス								|
		|----							|----													|
		| [Idle (state){in IdleStance}]	| ノード関数 [UpdateIdleAnim()] に従う					|
		| [StanceTransition (state)]	| ノード関数 [SetupIdleTransition()] に従う				|


##### Idle (state){in IdleStance}

* 概要
	* しゃがみの開始と終了をしていない、通常の待機状態です。
	* キャラクターの状態により、腰撃ち、 ADS 、しゃがみのいずれかの待機アニメーションシーケンスの設定を行います。
* ノード関数の使用状況
	| ノード					| 種別					| ノード関数名							|
	|----						|----					|----									|
	| `Sequence Player`			| On Update				| [UpdateIdleAnim()]					|


##### StanceTransition (state)

* 概要
	* しゃがみの開始と終了のいずれかをしている状態です。
	* キャラクターの状態により、「立ちからしゃがみ」「しゃがみから立ち」のいずれかのアニメーションシーケンスの設定を行います。
* ノード関数の使用状況
	| ノード					| 種別					| ノード関数名							|
	|----						|----					|----									|
	| `Sequence Player`			| On Become Relevant	| [SetupIdleTransition()]				|


##### Idle to StanceTransition (rule)

* Priority.1
	* [ABP_Mannequin_Base::CrouchStateChange] を `Can Enter Transition` に設定します。
	* つまり立ったりしゃがんだりしたら遷移します。

##### StanceTransition to Idle (rule)

* Priority.1
	* [ABP_Mannequin_Base::CrouchStateChange] を `Can Enter Transition` に設定します。
	* つまり立ったりしゃがんだりしたら遷移します。
* Priority.2
	* `Automatic Rule Base on Aequence` に true が設定されています。
	* つまり、 [StanceTransition (state)] で設定されたアニメーションシーケンスの再生が終わり次第遷移します。


### FullBody_StartState

TODO このへんから

* Tour コメント
	* [Comment_AnimBP_Tour.Ja::8]
	* [Comment_AnimBP_Tour.Ja::10]

### FullBody_CycleState
### FullBody_StopState
### FullBody_PivotState
#### PivotSM
##### PivotA (state)
##### PivotB (state)
##### WantsToRePivit (rule)
### FullBody_Aiming
### FullBody_JumpStartState
### FullBody_JumpApexState
### FullBody_FallLandState
### FullBody_FallLoopState
### FullBody_JumpStartLoopState
### FullBody_SkeletalControls
### LeftHandPose_OverrideState
# FUNCTIONS
## State Node Functions
### SetUpIdleState()
### UpdateIdleState()

### LandRecoveryStart()

* [LandRecovery (state)] の On Become Relevant
* 命名規則に合わせると `SetUpLandRecoveryState` のほうが妥当

### SetupIdleTransition()

* [StanceTransition (state)] の `Sequence Player` ノードの On Become Relevant
* これは、 [Anim Node Functions] グループに所属させ、名前を `SetUpStanceTransitionAnim` にするほうが妥当

## Anim Node Functions
### UpdateIdleAnim()
### SetUpIdleBreakAnim()
### SetUpStartAnim()
### UpdateStartAnim()

* Tour コメント
	* [Comment_AnimBP_Tour.Ja::9]

### UpdateCycleAnim()
### SetUpStopAnim()
### UpdateStopAnim()
### SetUpPivotAnim()
### UpdatePivotAnim()
### UpdateHipFireRaiseWeaponPose()
### SetUpFallLandAnim()
### UpdateFallLandAnim()
### SetLeftHandPoseOverrideWeight()
## Turn In Place{FUNCTIONS}

### SetupTurnInPlaceAnim()

* 命名規則に従うならば `SetUpTurnInPlaceAnim()` のほうが妥当。
* [TurnInPlaceAnimTime] に 0 を設定している。
* `SetExplicitTime` に 0 を指定している。（アニメーション再生位置を 0 に設定）

### UpdateTurnInPlaceAnim()

* `SetSequenceWithInertialBlending` で使用するシーケンスと慣性ブレンドにかかる時間 0.2 の指定をしている
* [TurnInPlaceAnimTime] に DeltaTime を加算している。
* `SetExplicitTime` に [TurnInPlaceAnimTime] を指定している。（アニメーション再生位置を [TurnInPlaceAnimTime] に設定）

### SetUpTurnInPlaceRotationState()

* [TurnInPlaceRotationDirection] に [ABP_Mannequin_Base::RootYawOffset] の `Sign` (sin 値)を設定しています。
	* どちらに向いているかを正負で判断できるようにしています。

### UpdateTurnInPlaceRecoveryState()
### SetUpTurnInPlaceRecoveryState()
### SelectTurnInPlaceAnimation()
## Idle Breaks{FUNCTIONS}
### CanPlayIdleBreak()
### ResetIdleBreakTransitionLogic()
### ProcessIdleBreakTransitionLogic()
### ChooseIdleBreakDelayTime()
## Blueprint Thread Safe Update Functions
### UpdateBlendWeightData()
### UpdateJumpFallData()
### UpdateSkelControlData()
## Distance Matching
### GetPredictedStopDistance()
### ShouldDistanceMatchStop()
## Pivots{FUNCTIONS}
### GetDesiredPivotSequence()
## Default{FUNCTIONS}
### BlueprintThreadSafeUpdateAnimation()

### GetMainAnimBPThreadSafe()

* ます、 [UAnimInstance::GetOwningComponent()] にてこの AnimBP を所有している `USkeletalMeshComponent` を取得します
	* これは要は `B_HeroShooterMannyquin` の Mesh コンポーネントです。
* 次に  `USkeletalMeshComponent::GetAnimInstance()` にてこのスケルタルメッシュを駆動している [UAnimInstance] を取得します。
	* これは要は [ABP_Mannequin_Base] です。
* 要は [ABP_Mannequin_Base] を取得する関数です。

### ShouldEnableFootPlacement()
### GetMovementComponent()

# VALIABLES

## Anim Set - Idle
### Idle_ADS
### Idle_Hipfire
### Idle_Breaks
### Crouch_Idle
### Crouch_Idle_Entry
### Crouch_Idle_Exit
### LeftHandPose_Override
## Anim Set - Starts
### Jog_Start_Cardinals
### ADS_Start_Cardinals
### Crouch_Start_Cardinals
## Anim Set - Stops
### Jog_Stop_Cardinals
### ADS_Stop_Cardinals
### Crouch_Stop_Cardinals
## Anim Set - Pivots
### Jog_Pivot_Cardinals
### ADS_Pivot_Cardinals
### Crouch_Pivot_Cardinals
## Anim Set - Turn in Place
### TurnInPlace_Left
### TurnInPlace_Right
### Crouch_TurnInPlace_Left
### Crouch_TurnInPlace_Right
## Anim Set - Jog
### Jog_Cardinals
## Anim Set - Jump
### Jump_Start
### Jump_Apex
### Jump_FallLand
### Jump_RecoveryAdditive
### Jump_StartLoop
### Jump_FallLoop
### JumpDistanceCurveName
## Anim Set - Walk
### Walk_Cardinals
### Crouch_Walk_Cardinals
## Anim Set - Aiming
### Aim_HipFirePose
### Aim_HipFirePose_Crouch
### IdleAnimOffset
### RelaxedAimOffset
## Settings
### PlayRateClampStarsPivos
### RaiseWeaponAfterFiringWhenCrouched
### DisableHandIK
### EnableLeftHandPoseOverride
### RaiseWeaponAfterFiringDuration
### StrideWarpingBlendInDurationScaled
### StrideWarpingBlendStartOffset
### LocomotionDistanceCurveName
### PlayRateClampCycle
## Blend Weight Data
### HipFireUpperBodyOverrideWeight
### AimOffsetBlendWeight
## Turn In Place{VALIABLES}
### TurnInPlaceAnimTime
### TurnInPlaceRotationDirection
### TurnInPlaceRecoveryDirection
## Idle Breaks{VALIABLES}
### WantsIdleBreak

* 使用されていないようです。

### TimeUntilNextIdleBreak
### CurrentIdleBreakIndex
### IdleBreakDelayTime
## Pivots{VALIABLES}
### PivotStartingAcceleration
### TimeAtPivotStop
## Jump
### LandRecoveryAlpha
### TimeFalling
## Skel Control Data
### HandIK_Right_Alpha
### HandIK_Left_Alpha
## Stride Warping
### StrideWarpingStartAlpha
### StrideWarpingPivotAlpha
### StrideWarpingCycleAlpha
## Default{VALIABLES}
### LeftHandPoseOverrideWeight
### HandFKWeightWeight


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[GRAPHS]: #graphs
[EventGraph]: #eventgraph
[ANIMATION GRAPHS]: #animation-graphs
[AnimGraph]: #animgraph
[ANIMATION LAYERS]: #animation-layers
[Item Anim Layers]: #item-anim-layers
[FullBodyAdditives]: #fullbodyadditives
[FullBodyAdditive_SM]: #fullbodyadditivesm
[Identity (state)]: #identity-state
[AirIdentity (state)]: #airidentity-state
[LandRecovery (state)]: #landrecovery-state
[Identity to AirIdentity (rule)]: #identity-to-airidentity-rule
[AirIdentity to LandRecovery (rule)]: #airidentity-to-landrecovery-rule
[LandRecovery to Identity (rule)]: #landrecovery-to-identity-rule
[FullBody_IdleState]: #fullbodyidlestate
[IdleSM]: #idlesm
[Idle (state){in IdleSM}]: #idle-statein-idlesm
[IdleBreak (state)]: #idlebreak-state
[TurnInPlaceRotation (state)]: #turninplacerotation-state
[TurnInPlaceRecovery (state)]: #turninplacerecovery-state
[WantsTurnInPlace (rule)]: #wantsturninplace-rule
[Idle to IdleBreak (rule)]: #idle-to-idlebreak-rule
[IdleBreak to Idle (rule)]: #idlebreak-to-idle-rule
[TurnInPlaceRotation to TurnInPlaceRecovery (rule)]: #turninplacerotation-to-turninplacerecovery-rule
[TurnInPlaceRecovery to Idle (rule)]: #turninplacerecovery-to-idle-rule
[IdleStance]: #idlestance
[Idle (state){in IdleStance}]: #idle-statein-idlestance
[StanceTransition (state)]: #stancetransition-state
[Idle to StanceTransition (rule)]: #idle-to-stancetransition-rule
[StanceTransition to Idle (rule)]: #stancetransition-to-idle-rule
[FullBody_StartState]: #fullbodystartstate
[FullBody_CycleState]: #fullbodycyclestate
[FullBody_StopState]: #fullbodystopstate
[FullBody_PivotState]: #fullbodypivotstate
[PivotSM]: #pivotsm
[PivotA (state)]: #pivota-state
[PivotB (state)]: #pivotb-state
[WantsToRePivit (rule)]: #wantstorepivit-rule
[FullBody_Aiming]: #fullbodyaiming
[FullBody_JumpStartState]: #fullbodyjumpstartstate
[FullBody_JumpApexState]: #fullbodyjumpapexstate
[FullBody_FallLandState]: #fullbodyfalllandstate
[FullBody_FallLoopState]: #fullbodyfallloopstate
[FullBody_JumpStartLoopState]: #fullbodyjumpstartloopstate
[FullBody_SkeletalControls]: #fullbodyskeletalcontrols
[LeftHandPose_OverrideState]: #lefthandposeoverridestate
[FUNCTIONS]: #functions
[State Node Functions]: #state-node-functions
[SetUpIdleState()]: #setupidlestate
[UpdateIdleState()]: #updateidlestate
[LandRecoveryStart()]: #landrecoverystart
[SetupIdleTransition()]: #setupidletransition
[Anim Node Functions]: #anim-node-functions
[UpdateIdleAnim()]: #updateidleanim
[SetUpIdleBreakAnim()]: #setupidlebreakanim
[SetUpStartAnim()]: #setupstartanim
[UpdateStartAnim()]: #updatestartanim
[UpdateCycleAnim()]: #updatecycleanim
[SetUpStopAnim()]: #setupstopanim
[UpdateStopAnim()]: #updatestopanim
[SetUpPivotAnim()]: #setuppivotanim
[UpdatePivotAnim()]: #updatepivotanim
[UpdateHipFireRaiseWeaponPose()]: #updatehipfireraiseweaponpose
[SetUpFallLandAnim()]: #setupfalllandanim
[UpdateFallLandAnim()]: #updatefalllandanim
[SetLeftHandPoseOverrideWeight()]: #setlefthandposeoverrideweight
[Turn In Place{FUNCTIONS}]: #turn-in-placefunctions
[SetupTurnInPlaceAnim()]: #setupturninplaceanim
[UpdateTurnInPlaceAnim()]: #updateturninplaceanim
[SetUpTurnInPlaceRotationState()]: #setupturninplacerotationstate
[UpdateTurnInPlaceRecoveryState()]: #updateturninplacerecoverystate
[SetUpTurnInPlaceRecoveryState()]: #setupturninplacerecoverystate
[SelectTurnInPlaceAnimation()]: #selectturninplaceanimation
[Idle Breaks{FUNCTIONS}]: #idle-breaksfunctions
[CanPlayIdleBreak()]: #canplayidlebreak
[ResetIdleBreakTransitionLogic()]: #resetidlebreaktransitionlogic
[ProcessIdleBreakTransitionLogic()]: #processidlebreaktransitionlogic
[ChooseIdleBreakDelayTime()]: #chooseidlebreakdelaytime
[Blueprint Thread Safe Update Functions]: #blueprint-thread-safe-update-functions
[UpdateBlendWeightData()]: #updateblendweightdata
[UpdateJumpFallData()]: #updatejumpfalldata
[UpdateSkelControlData()]: #updateskelcontroldata
[Distance Matching]: #distance-matching
[GetPredictedStopDistance()]: #getpredictedstopdistance
[ShouldDistanceMatchStop()]: #shoulddistancematchstop
[Pivots{FUNCTIONS}]: #pivotsfunctions
[GetDesiredPivotSequence()]: #getdesiredpivotsequence
[Default{FUNCTIONS}]: #defaultfunctions
[BlueprintThreadSafeUpdateAnimation()]: #blueprintthreadsafeupdateanimation
[GetMainAnimBPThreadSafe()]: #getmainanimbpthreadsafe
[ShouldEnableFootPlacement()]: #shouldenablefootplacement
[GetMovementComponent()]: #getmovementcomponent
[VALIABLES]: #valiables
[Anim Set - Idle]: #anim-set--idle
[Idle_ADS]: #idleads
[Idle_Hipfire]: #idlehipfire
[Idle_Breaks]: #idlebreaks
[Crouch_Idle]: #crouchidle
[Crouch_Idle_Entry]: #crouchidleentry
[Crouch_Idle_Exit]: #crouchidleexit
[LeftHandPose_Override]: #lefthandposeoverride
[Anim Set - Starts]: #anim-set--starts
[Jog_Start_Cardinals]: #jogstartcardinals
[ADS_Start_Cardinals]: #adsstartcardinals
[Crouch_Start_Cardinals]: #crouchstartcardinals
[Anim Set - Stops]: #anim-set--stops
[Jog_Stop_Cardinals]: #jogstopcardinals
[ADS_Stop_Cardinals]: #adsstopcardinals
[Crouch_Stop_Cardinals]: #crouchstopcardinals
[Anim Set - Pivots]: #anim-set--pivots
[Jog_Pivot_Cardinals]: #jogpivotcardinals
[ADS_Pivot_Cardinals]: #adspivotcardinals
[Crouch_Pivot_Cardinals]: #crouchpivotcardinals
[Anim Set - Turn in Place]: #anim-set--turn-in-place
[TurnInPlace_Left]: #turninplaceleft
[TurnInPlace_Right]: #turninplaceright
[Crouch_TurnInPlace_Left]: #crouchturninplaceleft
[Crouch_TurnInPlace_Right]: #crouchturninplaceright
[Anim Set - Jog]: #anim-set--jog
[Jog_Cardinals]: #jogcardinals
[Anim Set - Jump]: #anim-set--jump
[Jump_Start]: #jumpstart
[Jump_Apex]: #jumpapex
[Jump_FallLand]: #jumpfallland
[Jump_RecoveryAdditive]: #jumprecoveryadditive
[Jump_StartLoop]: #jumpstartloop
[Jump_FallLoop]: #jumpfallloop
[JumpDistanceCurveName]: #jumpdistancecurvename
[Anim Set - Walk]: #anim-set--walk
[Walk_Cardinals]: #walkcardinals
[Crouch_Walk_Cardinals]: #crouchwalkcardinals
[Anim Set - Aiming]: #anim-set--aiming
[Aim_HipFirePose]: #aimhipfirepose
[Aim_HipFirePose_Crouch]: #aimhipfireposecrouch
[IdleAnimOffset]: #idleanimoffset
[RelaxedAimOffset]: #relaxedaimoffset
[Settings]: #settings
[PlayRateClampStarsPivos]: #playrateclampstarspivos
[RaiseWeaponAfterFiringWhenCrouched]: #raiseweaponafterfiringwhencrouched
[DisableHandIK]: #disablehandik
[EnableLeftHandPoseOverride]: #enablelefthandposeoverride
[RaiseWeaponAfterFiringDuration]: #raiseweaponafterfiringduration
[StrideWarpingBlendInDurationScaled]: #stridewarpingblendindurationscaled
[StrideWarpingBlendStartOffset]: #stridewarpingblendstartoffset
[LocomotionDistanceCurveName]: #locomotiondistancecurvename
[PlayRateClampCycle]: #playrateclampcycle
[Blend Weight Data]: #blend-weight-data
[HipFireUpperBodyOverrideWeight]: #hipfireupperbodyoverrideweight
[AimOffsetBlendWeight]: #aimoffsetblendweight
[Turn In Place{VALIABLES}]: #turn-in-placevaliables
[TurnInPlaceAnimTime]: #turninplaceanimtime
[TurnInPlaceRotationDirection]: #turninplacerotationdirection
[TurnInPlaceRecoveryDirection]: #turninplacerecoverydirection
[Idle Breaks{VALIABLES}]: #idle-breaksvaliables
[WantsIdleBreak]: #wantsidlebreak
[TimeUntilNextIdleBreak]: #timeuntilnextidlebreak
[CurrentIdleBreakIndex]: #currentidlebreakindex
[IdleBreakDelayTime]: #idlebreakdelaytime
[Pivots{VALIABLES}]: #pivotsvaliables
[PivotStartingAcceleration]: #pivotstartingacceleration
[TimeAtPivotStop]: #timeatpivotstop
[Jump]: #jump
[LandRecoveryAlpha]: #landrecoveryalpha
[TimeFalling]: #timefalling
[Skel Control Data]: #skel-control-data
[HandIK_Right_Alpha]: #handikrightalpha
[HandIK_Left_Alpha]: #handikleftalpha
[Stride Warping]: #stride-warping
[StrideWarpingStartAlpha]: #stridewarpingstartalpha
[StrideWarpingPivotAlpha]: #stridewarpingpivotalpha
[StrideWarpingCycleAlpha]: #stridewarpingcyclealpha
[Default{VALIABLES}]: #defaultvaliables
[LeftHandPoseOverrideWeight]: #lefthandposeoverrideweight
[HandFKWeightWeight]: #handfkweightweight
[ABP_Mannequin_Base]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[ABP_Mannequin_Base::IsOnGround]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaseisonground
[ABP_Mannequin_Base::CrouchStateChange]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasecrouchstatechange
[ABP_Mannequin_Base::GameplayTag_IsFiring]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasegameplaytagisfiring
[ABP_Mannequin_Base::RootYawOffset]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaserootyawoffset
[ALI_ItemAnimLayers]: ../../Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayers
[AnimStruct_CardinalDirections]: ../../Lyra/ABP/AnimStruct_CardinalDirections.md#animstructcardinaldirections
[Comment_AnimBP_Tour.Ja::5]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja5
[Comment_AnimBP_Tour.Ja::6]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja6
[Comment_AnimBP_Tour.Ja::7]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja7
[Comment_AnimBP_Tour.Ja::8]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja8
[Comment_AnimBP_Tour.Ja::9]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja9
[Comment_AnimBP_Tour.Ja::10]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja10
[Comment_TourInPlace.Ja::6]: ../../Lyra/ABP/Comment_TourInPlace.Ja.md#commenttourinplaceja6
[TurnYawAnimModifier]: ../../Lyra/ABP/TurnYawAnimModifier.md#turnyawanimmodifier
[UAimOffsetBlendSpace]: ../../UE/Animation/UAimOffsetBlendSpace.md#uaimoffsetblendspace
[UAnimInstance]: ../../UE/Animation/UAnimInstance.md#uaniminstance
[UAnimInstance::GetOwningComponent()]: ../../UE/Animation/UAnimInstance.md#uaniminstancegetowningcomponent
[UAnimSequence]: ../../UE/Animation/UAnimSequence.md#uanimsequence
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ブループリントでのグラフ作成 > ノード関数]: https://docs.unrealengine.com/5.1/ja/graphing-in-animation-blueprints-in-unreal-engine/#%E3%83%8E%E3%83%BC%E3%83%89%E9%96%A2%E6%95%B0
