# ABP_Mannequin_Base

* 概要
	* キャラクターブループリントに設定する、基本となる ABP です。
* 他のクラスとの関係
	* B_HeroShooterMannyquin の Mesh の AnimClass で指定されています。
* 構成要素
	* [GRAPHS]
		* [EventGraph]
	* [ANIMATION GRAPHS]
		* [AnimGraph]
			* [LocomotionSM]
				* State
					* [Idle (state)]
					* [Start (state)]
					* [Cycle (state)]
					* [Stop (state)]
					* [Pivot (state)]
					* [JumpStart (state)]
					* [JumpStartLoop (state)]
					* [JumpApex (state)]
					* [FallLoop (state)]
					* [FallLand (state)]
				* State Alias
					* [PivotSources]
					* [JumpSources]
					* [JumpFallInterruptSources]
					* [CycleAlias]
					* [IdleAlias]
				* Conduit
					* [JumpSelector (conduit rule)]
					* [EndAir (conduit rule)]
				* Transition Rule Sharing
					* [StopRule (rule)]
				* Rule
					* [Idle to Start (rule)]
					* [Start to Cycle (rule)]
					* [StopRule (rule)]
					* [Stop to Idle (rule)]
					* [Stop to Start (rule)]
					* [PivotSources to Pivot (rule)]
					* [Pivot to Cycle (rule)]
					* [Pivot to Stop (rule)]
					* [JumpSources to JumpSelector (rule)]
					* [JumpSelector to JumpStart (rule)]
					* [JumpStart to JumpStartLoop (rule)]
					* [JumpStartLoop to JumpApex (rule)]
					* [JumpSelector to JumpApex (rule)]
					* [JumpApex to FallLoop (rule)]
					* [FallLoop to FallLand (rule)]
					* [FallLand to EndAir (rule)]
					* [JumpFallInterruptSources to EndAir (rule)]
					* [EndAir to CycleAlias (rule)]
					* [EndAir to IdleAlias (rule)]
	* [ANIMATION LAYERS]
		* [Item Anim Layers]
			* [FullBodyAdditives]
			* [FullBody_IdleState]
			* [FullBody_StartState]
			* [FullBody_CycleState]
			* [FullBody_StopState]
			* [FullBody_PivotState]
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
			* [UpdateIdleState()]
			* [SetUpStartState()]
			* [UpdateStartState()]
			* [UpdateStopState()]
			* [SetUpPivotState()]
			* [UpdatePivotState()]
			* [UpdateLocomotionStateMachine()]
		* [Helper Functions]
			* [SelectCardinalDirectionFromAngle()]
			* [GetOppositeCardinalDirection()]
			* [IsMovingPerpendicularToInitialPivot()]
		* [Blueprint Thread Safe Update Functions]
			* [UpdateLocationData()]
			* [UpdateRotationData()]
			* [UpdateVelocityData()]
			* [UpdateAccelerationData()]
			* [UpdateCharacterStateData()]
			* [UpdateBlendWeightData()]
			* [UpdateAimingData()]
			* [UpdateJumpFallData()]
			* [UpdateWallDetectionHeuristic()]
		* [Turn In Place]
			* [SetRootYawOffset()]
			* [ProcessTurnYawCurve()]
			* [UpdateRootYawOffset()]
		* [Default(FUNCTIONS)]
			* [BlueprintThreadSafeUpdateAnimation()]
			* [GetMovementComponent()]
			* [ShouldEnableControlRig()]
	* [VALIABLES]
		* [Rotation Data]
			* [WorldRotation]
			* [YawDeltaSinceLastUpdate]
			* [AdditiveLeanAngle]
			* [YawDeltaSpeed]
		* [Location Data]
			* [WorldLocation]
			* [DisplacementSinceLastUpdate]
			* [DisplacementSpeed]
		* [Velocity Data]
			* [WorldVelocity]
			* [LocalVelocity2D]
			* [LocalVelocityDirectionAngle]
			* [LocalVelocityDirectionAngleWithOffset]
			* [LocalVelocityDirection]
			* [LocalVelocityDirectionNoOffset]
			* [HasVelocity]
		* [Acceleration Data]
			* [LocalAcceleration2D]
			* [HasAcceleration]
			* [PivotDirection2D]
		* [Character State Data]
			* [IsOnGround]
			* [IsCrouching]
			* [CrouchStateChange]
			* [ADSStateChanged]
			* [WasADSLastUpdate]
			* [TimeSinceFiredWeapon]
			* [IsJumping]
			* [IsFalling]
			* [TimeToJumpApex]
			* [IsRunningIntoWall]
		* [Gameplay Tag Bindings]
			* [GameplayTag_IsADS]
			* [GameplayTag_IsFiring]
			* [GameplayTag_IsReloading]
			* [GameplayTag_IsDashing]
			* [GameplayTag_IsMelee]
		* [Locomotion SM Data]
			* [StartDirection]
			* [PivotInitialDirection]
			* [LastPivotTime]
			* [CardinalDirectionFromAcceleration]
		* [Blend Weight Data]
			* [UpperbodyDynamicAdditiveWeight]
		* [Aiming Data]
			* [AimPitch]
			* [AimYaw]
		* [Settings]
			* [CardinalDirectionDeadZone]
		* [Linked Layer Data]
			* [LinkedLayerChanged]
			* [LastLinkedLayer]
		* [Turn In Place]
			* [RootYawOffset]
			* [RootYawOffsetSpringState]
			* [TurnYawCurveValue]
			* [RootYawOffsetMode]
			* [RootYawOffsetAngleClamp]
			* [RootYawOffsetAngleClampCrouched]
		* [Default(VALIABLES)]
			* [IsFirstUpdate]
			* [EnableControlRig]
			* [UseFootPlacement]
			* [bEnableRootYawOffset]
* グループについて
	* [ANIMATION LAYERS] で使用されているもの。
		* [Item Anim Layers]
			* [ALI_ItemAnimLayers] で定義されている。
	* [FUNCTIONS] で使用されているもの。
		* [State Node Functions]
			* ステート及びステートマシンで使用しているノード関数です。
				* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ブループリントでのグラフ作成 > ノード関数]
			* 命名規則は以下のいずれかです。
				* Update（関数のタイプが On Update） + ステート名 + State
					* 例：UpdateIdleState()
				* SetUp（関数のタイプが On Become Relevant） + ステート名 + State
					* 例：SetUpStartState()
				* その他（LocomotionSM の On Update）
					* UpdateLocomotionStateMachine()
		* [Helper Functions]
			* 他の関数から呼ばれる、計算等を行う補助関数です。
		* [Blueprint Thread Safe Update Functions]
			* [BlueprintThreadSafeUpdateAnimation()] から呼び出される、アニメーショングラフで利用される変数を更新する関数です。
		* [Turn In Place]
			* Turn In Place 処理を行うための関数です。
			* Turn In Place について詳しくは [Comment_TourInPlace.Ja] を参照。
	* [VALIABLES] で使用されているもの。
		* [Rotation Data]
			* 更新は UpdateRotationData() で行われます。
			* Actor の Rotation を元の算出された変数です。
		* [Location Data]
			* 更新は UpdateLocationData() で行われます。
			* Actor の Location を元の算出された変数です。
		* [Velocity Data]
			* 更新は UpdateLocationData() で行われます。
			* Pawn の Velocity を元の算出された変数です。
		* [Acceleration Data]
			* 更新は UpdateAccelerationData() で行われます。
			* MovementComponent の CurrentAcceleration を元の算出された変数です。
		* [Character State Data]
			* 更新は UpdateCharacterStateData() で行われますが、以下の 2 つは例外です。
				* TimeToJumpApex
				* IsRunningIntoWall
			* キャラクターの各種状態（例：立っている、しゃがんでいる、 ADS している、ジャンプしている、落下している等々）を保持しています。
		* [Gameplay Tag Bindings]
			* 更新は [ULyraAnimInstance::GameplayTagPropertyMap] により行われます。
			* GameplayTag を監視し、付与状態と連動します。
		* [Locomotion SM Data]
			* [LocomotionSM] 内で読み書きされる変数です。
		* [Blend Weight Data]
			* 更新は UpdateBlendWeightData() で行われます。
			* アニメーションのブレンドの際のアルファ値を保持する変数です。
		* [Aiming Data]
			* 更新は UpdateAimingData() で行われますが、以下は例外です。
				* AimYaw
					* RootYawOffset と連動するため SetRootYawOffset() で更新されます。
		* [Settings]
			* 定数として扱われている変数です。
		* [Linked Layer Data]
			* 更新は UpdateLocomotionStateMachine() で行われます。
			* Linked Anim Instance に関する変数です。
		* [Turn In Place]
			* Turn In Place 処理を行うための関数です。
			* Turn In Place について詳しくは [Comment_TourInPlace.Ja] を参照。

# GRAPHS

## EventGraph

* Tour コメント
	* [Comment_AnimBP_Tour.Ja.1]
* 概要
	* マルチスレッド対応のため、基本的には空っぽ。

# ANIMATION GRAPHS

## AnimGraph

* Tour コメント
	* [Comment_AnimBP_Tour.Ja.3]
	* [Comment_TourInPlace.Ja.1]
* 概要
	* Anim Seaquence
		* 基本的に直接参照しない。
	* Blendspace
		* 例： AnimGraph > LocomotionSM > Cycle (state) にて BS_MM_Rifle_Jog_Leans が直接指定されている。
		* おそらく変わることがないため直接指定されているものと思われる。

### LocomotionSM

* Tour コメント
	* [Comment_AnimBP_Tour.Ja.4]
* ノード関数の使用状況
	| ノード        | 種別      | ノード関数名                   |
	|---------------|-----------|--------------------------------|
	| LocomotionSM  | On Update | UpdateLocomotionStateMachine() |
* 構成要素
	* State
		* Idle (state)
		* Start (state)
		* Cycle (state)
		* Stop (state)
		* Pivot (state)
		* JumpStart (state)
		* JumpStartLoop (state)
		* JumpApex (state)
		* FallLoop (state)
		* FallLand (state)
	* State Alias
		* PivotSources
		* JumpSources
		* JumpFallInterruptSources
		* CycleAlias
		* IdleAlias
	* Conduit
		* JumpSelector (conduit rule)
		* EndAir (conduit rule)
	* Transition Rule Sharing
		* StopRule (rule)
	* Rule
		* Idle to Start (rule)
		* Start to Cycle (rule)
		* StopRule (rule)
		* Stop to Idle (rule)
		* Stop to Start (rule)
		* PivotSources to Pivot (rule)
		* Pivot to Cycle (rule)
		* Pivot to Stop (rule)
		* JumpSources to JumpSelector (rule)
		* JumpSelector to JumpStart (rule)
		* JumpStart to JumpStartLoop (rule)
		* JumpStartLoop to JumpApex (rule)
		* JumpSelector to JumpApex (rule)
		* JumpApex to FallLoop (rule)
		* FallLoop to FallLand (rule)
		* FallLand to EndAir (rule)
		* JumpFallInterruptSources to EndAir (rule)
		* EndAir to CycleAlias (rule)
		* EndAir to IdleAlias (rule)
* State に関して
	* ノード関数の使用状況
		| ノード        | 種別               | ノード関数名                   |
		|---------------|--------------------|--------------------------------|
		| Idle (state)  | On Update          | UpdateIdleState()              |
		| Start (state) | On Become Relevant | SetUpStartState()              |
		| Start (state) | On Update          | UpdateStartState()             |
		| Stop (state)  | On Update          | UpdateStopState()              |
		| Pivot (state) | On Become Relevant | SetUpPivotState()              |
		| Pivot (state) | On Update          | UpdatePivotState()             |
	* ブレンドスペースの使用状況
		| 名前          | 利用しているブレンドスペース |
		|---------------|------------------------------|
		| Start (state) | BS_MM_Rifle_Jog_Leans        |
		| Cycle (state) | BS_MM_Rifle_Jog_Leans        |
		| Pivot (state) | BS_MM_Rifle_Jog_Leans        |
	* その他特記事項
		* Start (state)
			* FullBody_StartState を利用しており、 Tag には StartLayerNode と設定してあります。
			* これにより Start ノードへの参照が取得できるようにしています。
			* 参照の取得は UpdateLocomotionStateMachine() にて行っています。
* State Alias に関して
	* 一覧と主な設定
		| 名前                     | 用途                                                | 含んでいる state                                                                                       |
		|--------------------------|-----------------------------------------------------|--------------------------------------------------------------------------------------------------------|
		| PivotSources             | Pivot (state) に移行できるステート群                | Start (state)<br>Cycle (state)                                                                         |
		| JumpSources              | JumpSelector (conduit rule) に移行できるステート群  | Idle (state)<br>Start (state)<br>Cycle (state)<br>Stop (state)<br>Pivot (state)                        |
		| JumpFallInterruptSources | EndAir (conduit rule) に移行できるステート群        | JumpStart (state)<br>JumpStartLoop (state)<br>JumpApex (state)<br>FallLoop (state)<br>FallLand (state) |
		| CycleAlias               | Cycle (state) のエイリアス                          | Cycle (state)                                                                                          |
		| IdleAlias                | Idle (state) のエイリアス                           | Idle (state)                                                                                           |
	* JumpSources に記載されたコメント
		> This is an example of a State Alias.
		> State Aliases help to reduce the amount of transition lines required.
		> This alias allows multiple states to transition to Jump with the same condition, without having to have explicit transition lines from each source state.
		> 
		> ----
		> これは、ステートエイリアスの例です。
		> ステートエイリアスは、必要なトランジションラインの量を減らすのに役立ちます。
		> このエイリアスを使用すると、各ソースステートから明示的な遷移線を用意しなくても、複数のステートが同じ条件でジャンプに遷移することができます。
* Conduit に関して
	* 一覧と主な設定
		| 名前                        | 遷移元                   | 遷移先                                  |
		|-----------------------------|--------------------------|-----------------------------------------|
		| JumpSelector (conduit rule) | JumpSources              | JumpStart (state)<br>JumpApex (state)   |
		| EndAir (conduit rule)       | JumpFallInterruptSources | CycleAlias (state)<br>IdleAlias (state) |
* Transition Rule Sharing に関して
	* 一覧と主な設定
		| 名前                     | 用途                                                | 遷移元                                                                                       |
		|--------------------------|-----------------------------------------------------|--------------------------------------------------------------------------------------------------------|
		| StopRule (rule)          | Stop (state) への遷移ルール                         | Start (state)<br>Cycle (state)                                                                         |
* Rule に関して
	* Unreal の仕組み関連のメモ
		* Automatic Rule Based on Sequence Player in State について
			* [Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Editor > AnimGraph > UAnimStateTransitionNode] より
				> Try setting the rule automatically based on most relevant player node's remaining time and the CrossfadeDuration of the transition, ignoring the internal time
				> 
				> ----
				> 最も関連性の高いプレイヤーノードの残り時間とトランジションの CrossfadeDuration に基づいて自動的にルールの設定を行い、内部時間は無視します。
			* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > ステートマシン > 遷移ルール]
				> このプロパティを有効にすると、前のステートで最も関連性の高いアニメーションが終了したときに、この遷移が自動的に実行されます。
				> ブレンドの期間も遷移時間に含まれるため、アニメーションが **2.0** 秒で、遷移時間が **0.5** 秒の場合、 **1.5** 秒経過後に遷移が実行されます。
		* Can Enter Transition について
			* true を返すと遷移します。

#### Idle (state)
#### Start (state)
#### Cycle (state)
#### Stop (state)
#### Pivot (state)
#### JumpStart (state)
#### JumpStartLoop (state)
#### JumpApex (state)
#### FallLoop (state)
#### FallLand (state)
#### PivotSources
#### JumpSources
#### JumpFallInterruptSources
#### CycleAlias
#### IdleAlias
#### JumpSelector (conduit rule)
#### EndAir (conduit rule)
#### Idle to Start (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| Idle to Start (rule)                      | 1        | HasAcceleration<br>GameplayTag_IsMelee<br>HasVelocity                                                                                         |                          |

#### Start to Cycle (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| Start to Cycle (rule)                     | 1        | RootYawOffset                                                                                                                                 |                          |
| Start to Cycle (rule)                     | 1        | LinkedLayerChanged                                                                                                                            |                          |
| Start to Cycle (rule)                     | 2        | Automatic Rule Based on Sequence Player in State を true にしている                                                                           |                          |
| Start to Cycle (rule)                     | 3        | StartDirection<br>LocalVelocityDirection<br>CrouchStateChange<br>ADSStateChanged<br>DisplacementSpeed<br>GetInstanceCurrentStateElapsedTime() |                          |

#### StopRule (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| StopRule (rule)                           | 1        | HasAcceleration<br>GameplayTag_IsMelee<br>HasVelocity                                                                                         |                          |

#### Stop to Idle (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| Stop to Idle (rule)                       | 1        | LinkedLayerChanged                                                                                                                            |                          |
| Stop to Idle (rule)                       | 2        | CrouchStateChange<br>ADSStateChanged                                                                                                          |                          |
| Stop to Idle (rule)                       | 3        | Automatic Rule Based on Sequence Player in State を true にしている                                                                           |                          |

#### Stop to Start (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| Stop to Start (rule)                      | 1        | HasAcceleration                                                                                                                               |                          |

#### PivotSources to Pivot (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| PivotSources to Pivot (rule)              | 1        | LocalVelocity2D<br>LocalAcceleration2D<br>IsRunningIntoWall                                                                                   | XY 平面での移動と加速飲む気が反対かつ壁の中に入っていない場合は true                         |

#### Pivot to Cycle (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| Pivot to Cycle (rule)                     | 1        | LinkedLayerChanged                                                                                                                            |                          |
| Pivot to Cycle (rule)                     | 2        | WasAnimNotifyStateActiveInSourceState()                                                                                                       |                          |
| Pivot to Cycle (rule)                     | 3        | CrouchStateChange<br>ADSStateChanged<br>IsMovingPerpendicularToInitialPivot()<br>LastPivotTime                                                |                          |

#### Pivot to Stop (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| Pivot to Stop (rule)                      | 2        | HasAcceleration                                                                                                                               |                          |

#### JumpSources to JumpSelector (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| JumpSources to JumpSelector (rule)        |          | Can Enter Transition を true にしている                                                                                                       |                          |

#### JumpSelector to JumpStart (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| JumpSelector to JumpStart (rule)          | 1        | IsJumping                                                                                                                                     |                          |

#### JumpStart to JumpStartLoop (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| JumpStart to JumpStartLoop (rule)         | 1        | Automatic Rule Based on Sequence Player in State を true にしている                                                                           |                          |

#### JumpStartLoop to JumpApex (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| JumpStartLoop to JumpApex (rule)          | 1        | TimeToJumpApex                                                                                                                                |                          |

#### JumpSelector to JumpApex (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| JumpSelector to JumpApex (rule)           | 1        | IsFalling                                                                                                                                     |                          |

#### JumpApex to FallLoop (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| JumpApex to FallLoop (rule)               | 1        | Automatic Rule Based on Sequence Player in State を true にしている                                                                           |                          |

#### FallLoop to FallLand (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| FallLoop to FallLand (rule)               | 1        | GroundDistance                                                                                                                                |                          |

#### FallLand to EndAir (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| FallLand to EndAir (rule)                 |          | Can Enter Transition を true にしている                                                                                                       |                          |

#### JumpFallInterruptSources to EndAir (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| JumpFallInterruptSources to EndAir (rule) |          | Can Enter Transition を IsOnGround にしている                                                                                                 |                          |

#### EndAir to CycleAlias (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| EndAir to CycleAlias (rule)               | 1        | HasAcceleration                                                                                                                               |                          |

#### EndAir to IdleAlias (rule)

| 名前                                      | Priority | 参照する変数/関数                                                                                                                             | 概要                     |
|-------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|--------------------------|
| EndAir to IdleAlias (rule)                | 2        | Can Enter Transition を true にしている                                                                                                       |                          |

# ANIMATION LAYERS

## Item Anim Layers

* 概要
	* すべて空の状態。
	* すべて ABP_ItemAnimLayerBase で実装されている。
* 呼び出し元
	| 名前                        | 呼び出し元            |
	|-----------------------------|-----------------------|
	| FullBodyAdditives           | AnimGraph             |
	| FullBody_IdleState          | Idle (state)          |
	| FullBody_StartState         | Start (state)         |
	| FullBody_CycleState         | Cycle (state)         |
	| FullBody_StopState          | Stop (state)          |
	| FullBody_PivotState         | Pivot (state)         |
	| FullBody_Aiming             | AnimGraph             |
	| FullBody_JumpStartState     | JumpStart (state)     |
	| FullBody_JumpApexState      | JumpApex (state)      |
	| FullBody_FallLandState      | FallLand (state)      |
	| FullBody_FallLoopState      | FallLoop (state)      |
	| FullBody_JumpStartLoopState | JumpStartLoop (state) |
	| FullBody_SkeletalControls   | AnimGraph             |
	| LeftHandPose_OverrideState  | AnimGraph             |

### FullBodyAdditives
### FullBody_IdleState
### FullBody_StartState
### FullBody_CycleState
### FullBody_StopState
### FullBody_PivotState
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

### UpdateIdleState()

* FullBody_IdleState から利用される。
* TurnYawCurveValue / RootYawOffsetMode などを更新し、 ProcessTurnYawCurve() を呼び出します。

### SetUpStartState()

* FullBody_StartState から利用される。
* LocalVelocityDirection の値を StartDirection に設定している。
* どういうことか？
	* 移動開始時に Actor から見た移動方向を StartDirection に設定するための関数です。

### UpdateStartState()

* FullBody_StartState から利用される。
* ステートが Blending Out でない場合は RootYawOffsetMode の値を Hold に設定している。
* どういうことか？
	* このステートにいる間、 UpdateRootYawOffset() で行われるヨーオフセットの更新が行われないように RootYawOffsetMode を設定するための関数です。

### UpdateStopState()

* FullBody_StopState から利用される。
* ステートが Blending Out でない場合は RootYawOffsetMode の値を Accumulate に設定している。
* どういうことか？
	* このステートにいる間、 UpdateRootYawOffset() で行われるヨーオフセットの更新が行われるように RootYawOffsetMode を設定するための関数です。

### SetUpPivotState()

* FullBody_PivotState から利用される。
* LocalVelocityDirection の値を PivotInitialDirection に設定している。
* どういうことか？
	* Pivot ステート開始時に Actor から見た移動方向を PivotInitialDirection に設定するための関数です。

### UpdatePivotState()

* FullBody_PivotState から利用される。
* LastPivotTime が 0 より大きい場合は DeltaTime を減じている。
* どういうことか？
	* Pivot に必要な時間が経過したかを判定する変数を更新するための関数です。

### UpdateLocomotionStateMachine()

* コメント
	> We're checking to see if the Start state's layer node linked anim instance has changed.   
	> We don't need to check for other nodes because they're all on the same group and therefore share the same anim instance.  
	> 
	> ----
	> Start ステートのレイヤーノードがリンクしているアニメーションインスタンスが変更されたかどうかをチェックしています。  
	> 他のノードはすべて同じグループであり、同じアニメーションインスタンスを共有しているので、チェックする必要はありません。  
	* StartLayerNode というタグ名を利用して、 AnimGraph > LocomotionSM > Start (state) のリファレンスを取得し、 Linked Anim Instance が直前のフレームから変更があったかを LinkedLayerChanged に設定しています。
* AnimGraph に配置している LocomotionSM の On Update に設定されている。

## Helper Functions
* 概要
	* 引数を元に、 AnimEnum_CardinalDirection を返す。
* 引数
	* 向いている角度（正面を 0 、右を正、背面を 180 とする）
	* 判定の遊び値（現在の向きを考慮する場合、向きが変わったかどうかの判定をゆるくするための角度）
	* 現在の向き
	* 現在の向きを考慮するかどうか
* 呼び出し元
	* UpdateVelocityData()
		* LocalVelocityDirectionAngleWithOffset を元に LocalVelocityDirection を算出するために利用。
		* LocalVelocityDirectionAngle を元に LocalVelocityDirectionNoOffset を算出するために利用。
	* UpdateAccelerationData()
		* PivotDirection2D を元に CardinalDirectionFromAcceleration を算出するために利用。

### GetOppositeCardinalDirection()
* 概要
	* 引数で AnimEnum_CardinalDirection を受け取り、反対向きの AnimEnum_CardinalDirection を返す。
* 呼び出し元
	* UpdateAccelerationData()
		* PivotDirection2D の反対方向 を算出するために利用。

### IsMovingPerpendicularToInitialPivot()

* コメント
	> We stay in a pivot when pivoting along a line (e.g. triggering a left-right pivot while playing a right-left pivot), but break out if the character makes a perpendicular change in direction.  
	> 
	>----
	> 線に沿ったピボット（例：右から左のピボットをしながら左から右のピボットを誘発する）の時はピボットに留まり、キャラクターが垂直に方向転換する場合はブレイクアウトします。  
* 概要
	* Pivot ステート開始時と現在の移動方向が垂直ならば true を返します。
	* PivotInitialDirection / LocalVelocityDirection を元に Pivot ステート開始時と現在の移動方向を比較し、垂直方向になっていたら true を返します。
* 呼び出し元
	* Pivot to Cycle (rule)
		* Pivot が行われたかの判定に利用。

## Blueprint Thread Safe Update Functions

### UpdateLocationData()

* 概要
	* 以下の変数の更新を行う。
		* DisplacementSinceLastUpdate
		* WorldLocation
		* DisplacementSpeed

### UpdateRotationData()

* 概要
	* 以下の変数の更新を行う。
		* WorldRotation
		* YawDeltaSinceLastUpdate
		* AdditiveLeanAngle
		* YawDeltaSpeed

### UpdateVelocityData()

* 概要
	* 以下の変数の更新を行う。
		* WorldVelocity
		* LocalVelocity2D
		* LocalVelocityDirectionAngle
		* LocalVelocityDirectionAngleWithOffset
		* LocalVelocityDirection
		* LocalVelocityDirectionNoOffset
		* HasVelocity

### UpdateAccelerationData()

* コメント
   > Calculate a cardinal direction from acceleration to be used for pivots.  
   > Acceleration communicates player intent better for that purpose than velocity does.  
   > 
   > ----
   > 加速度からピボットに使用するカーディナルディレクションを算出する。  
   > 加速度は、速度よりもプレイヤーの意図がより伝わりやすい。  
* 概要
	* 以下の変数の更新を行う。
		* LocalAcceleration2D
		* HasAcceleration
		* PivotDirection2D
		* CardinalDirectionFromAcceleration
* 備考
	* CardinalDirectionFromAcceleration はカテゴリ LocomotionSMData の変数。

### UpdateCharacterStateData()

* 概要
	* 以下の変数の更新を行う。
		* IsOnGround
		* IsCrouching
		* CrouchStateChange
		* ADSStateChanged
		* WasADSLastUpdate
		* TimeSinceFiredWeapon
		* IsJumping
		* IsFalling
	* 以下の変数はカテゴリ Character State Data に属するが、この関数では更新しない。
		* TimeToJumpApex
			* UpdateJumpFallData() で更新を行う。
		* IsRunningIntoWall
			* UpdateWallDetectionHeuristic() で更新を行う。
* 備考
	* IsJumping / IsFalling の算出
		* WorldVelocity の Z 成分より上昇中か下降中かを判定

### UpdateBlendWeightData()

* 概要
	* 以下の変数の更新を行う。
		* UpperbodyDynamicAdditiveWeight

### UpdateAimingData()

* 概要
	* 以下の変数の更新を行う。
		* AimPitch
	* 以下の変数はカテゴリ Aiming Data に属するが、この関数では更新しない。
		* AimYaw

### UpdateJumpFallData()

* 概要
	* 変数のカテゴリ (Jump Fall Data) は存在しない。
	* 以下の変数の更新を行う。
		* TimeToJumpApex

### UpdateWallDetectionHeuristic()

* コメント
	> This logic guesses if the character is running into a wall by checking if there's a large angle between velocity and acceleration
	> (i.e. the character is pushing towards the wall but actually sliding to the side) 
	> and if the character is trying to accelerate but speed is relatively low.
	> 
	> ----
	> このロジックは、速度と加速度の角度が大きいかどうか、加速しようとしているが速度が相対的に小さいかどうかをチェックすることで、
	> キャラクターが壁にぶつかっているかどうかを推測します。
	> (例：キャラクターが壁に向かって押しているが、実際には横に滑っている)  
* 概要
	* 変数のカテゴリ (Wall Detection Heuristic) は存在しない。
	* 以下の変数の更新を行う。
		* IsRunningIntoWall
* 備考
	* IsRunningIntoWall の算出
		* LocalAcceleration2D の大きさが 0.1 より大きいかを調べている
			* これは加速度が移動しようとしているかを調べている
		* LocalAcceleration2D の大きさが 200 未満かを調べている
			* これは速度が（移動しようとしている割に）低いかを調べている
		* LocalAcceleration2D と LocalVelocity2D の内積が \[-0.6,0.6\] の範囲かを調べている
			* これは移動しようとしている向きと実際の移動方向の成す角がおおよそ 50 度以内かを調べている

## Turn In Place

### SetRootYawOffset()
* Tour コメント
	* [Comment_TourInPlace.Ja.3]
	* [Comment_TourInPlace.Ja.4]
* 概要
	* 以下の変数の更新を行う。
		* RootYawOffset
		* AimYaw
	* 渡された InRootYawOffset を RootYawOffset に設定し、 -1 を掛けたものを AimYaw に設定する。
	* ただし、 EnableRootYawOffset が false の場合はいずれも 0.0 に設定する。
	* また、設定する値には上限があり、設定前に上限値でクランプを行う。
	* 上限値はしゃがんでいるとき/そうでないときで別の値 RootYawOffsetAngleClampCrouched / RootYawOffsetAngleClamp を持つ。
	* しゃがんでいるかは IsCrouching で判定する。
	* 2 回 SetRootYawOffset() を呼び出すケースについて
		* Idle State にいる場合、 ProcessTurnYawCurve() 経由と UpdateRootYawOffset() 経由で同一フレームに 2 回呼び出される。
		* 基本的に SetRootYawOffset() は新しく設定したい値を InRootYawOffset に設定する
		* それぞれ別の由来の変化値の反映のため、 2 回呼び出すことは特に問題ない。
* 呼び出し元
	* ProcessTurnYawCurve()
		* アニメーションに設定されている RemainingTurnYaw / TurnYawWeight 由来の変化を反映するために利用。
	* UpdateRootYawOffset()
		* (Actor Rotation を元にした) YawDeltaSinceLastUpdate 由来の変化を反映するために利用。

### ProcessTurnYawCurve()
* Tour コメント
	* [Comment_TourInPlace.Ja.5]
* コメント：アニメーションに設定されている RemainingTurnYaw / TurnYawWeight を元に TurnYawCurveValue を更新する部分について
	> The "TurnYawWeight" curve is set to 1 in TurnInPlace animations, so its current value from GetCurveValue will be the current weight of the TurnInPlace animation.   
	> We can use this to "unweight" the TurnInPlace animation to get the full RemainingTurnYaw curve value.  
	> 
	> ----
	> TurnInPlace アニメーションでは "TurnYawWeight" カーブが 1 に設定されているため、 GetCurveValue() から得られる現在の値は、 TurnInPlace アニメーションの現在のウェイトとなります。  
	> これを利用して、 TurnInPlace アニメーションのウェイトを "解除" し、 RemainingTurnYaw カーブの値を完全に取得することができます。  
	* RemainingTurnYaw / TurnYawWeight について詳しくは TurnYawAnimModifier を参照。
	* TurnYawWeight は初期値 1.0 でその値を維持し、 Root の Yaw が最終値と同値に至ると 0.0 となる。
	* TurnYawWeight で除算はしているが、 1.0 以下の値を除算することになる為、 0.0 に近づくほど RemainingTurnYaw より大きな値が TurnYawCurveValue に設定される。
		* TODO: 乗算して徐々に影響を減らすほうが正しいのでは？要確認。
* コメント：直前のフレームの TurnYawCurveValue が 0.0 ではないかの分岐について
	> Avoid applying the curve delta when the curve first becomes relevant.   
	> E.g. When a turn animation starts, the previous curve value will be 0 and the current value will be 90, but no actual rotation has happened yet.  
	> 
	> ----
	> カーブが最初に関連するときにカーブデルタを適用しないようにする。  
	> 例：回転アニメーションが始まると、前のカーブ値は0、現在の値は90になるが、実際の回転はまだ起こっていない。  
* コメント：
	> Reduce the root yaw offset by the amount of rotation from the turn animation.  
	> 
	> ----
	> RootYawOffset を、ターンアニメーションの回転量分減らす。  
* 参考
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]
* 概要
	* 以下の変数の更新を行う。
		* TurnYawCurveValue
	* SetRootYawOffset() の呼び出し内で以下も更新する。
		* RootYawOffset
		* AimYaw
	* アニメーションカーブ RemainingTurnYaw / TurnYawWeight を元に RootYawOffset の値を更新します。
	* RootYawOffset は更新の際にクランプ処理や AimYaw の更新も必要になるため SetRootYawOffset() を呼び出すことで更新を行います。
* 呼び出し元
	* UpdateIdleState()
		* State Blending Out 中でない場合にアニメーションに設定されている Yaw の値を反映するために利用。

### UpdateRootYawOffset()

* Tour コメント
	* [Comment_TourInPlace.Ja.2]
* コメント
	> 1. When the feet aren't moving (e.g. during Idle), offset the root in the opposite direction to the Pawn owner's rotation to keep the mesh from rotating with the Pawn.  
	> 1. When in motion, smoothly blend out the offset.  
	> 1. Reset to blending out the yaw offset.   
	>    Each update, a state needs to request to accumulate or hold the offset.   
	>    Otherwise, the offset will blend out.  
	>    This is primarily because the majority of states want the offset to blend out, so this saves on having to tag each state.  
	> 
	> ----
	> 1. 足が動いていないとき（アイドル時など）、ポーンオーナーの回転とは逆方向にルートをオフセットして、メッシュがポーンと一緒に回転しないようにします。  
	> 1. 動いているときは、オフセットを滑らかにブレンドアウトします。  
	> 1. ヨーオフセットのブレンドアウトにリセットする。  
	>    更新のたびに、オフセットを蓄積または保持するようステートが要求する必要があります。  
	>    そうしないと、オフセットがブレンドアウトされます。  
	>    これは主に、大多数の状態がオフセットをブレンドアウトすることを望んでいるためで、これにより各状態にタグを付ける手間が省けます。  
	* 補足： RootYawOffsetMode
		* Accumulate
			* 足が動いていないとき（アイドル時など）にこの値に設定します。
			* 具体的には UpdateIdleState() / UpdateStopState() にて、 State の BlendingOut 中でない場合にこの値に設定しています。
			* この値の場合、 SetRootYawOffset() の InRootYawOffset には RootYawOffset - YawDeltaSinceLastUpdate を渡します。
				* Actor の Rotation の Delta 値を引いた値をそのまま使用するということです。
				* つまり、ユーザーの入力により変化した Rotation をそのまま RootYawOffset / AimYaw に反映させる、ということです。
		* BlendOut
			* 本関数 UpdateRootYawOffset() の最後に設定している初期値で、ステートで設定していない場合はこの値となります。
			* この値の場合、 SetRootYawOffset() の InRootYawOffset には FloatSpringInterp() の計算結果を渡します。
				* FloatSpringInterp() は Current に RootYawOffset 、 Target に 0.0 を指定しています。
				* つまり、徐々に 0.0 に BlendOut する値を RootYawOffset / AimYaw に反映させる、ということです。
		* Hold
			* Accumulate / BlendOut のいずれの処理も行いたくない場合は、この値を設定します。
			* 具体的には UpdateStartState() にて、 State の BlendingOut 中でない場合にこの値に設定しています。
			* この値の場合、 SetRootYawOffset() の呼び出しを行わず、 RootYawOffset / AimYaw の更新が行われません。
				* つまり、 Start State 中は RootYawOffset / AimYaw が変化しないということです。
* 概要
	* 以下の変数の更新を行う。
		* RootYawOffsetMode
	* SetRootYawOffset() の呼び出し内で以下も更新する。
		* RootYawOffset
		* AimYaw
	* RootYawOffsetMode に従って SetRootYawOffset() を呼びだし、 RootYawOffset / AimYaw を更新します。
	* 最後に RootYawOffsetMode を BlendOut に再設定します。

## Default(FUNCTIONS)

### BlueprintThreadSafeUpdateAnimation()

* Tour コメント
	* [Comment_AnimBP_Tour.Ja.2]
* 以下の関数を呼び出している。
	* UpdateLocationData()
	* UpdateRotationData()
	* UpdateVelocityData()
	* UpdateAccelerationData()
	* UpdateWallDetectionHeuristic()
	* UpdateCharacterStateData()
	* UpdateBlendWeightData()
	* UpdateRootYawOffset()
	* UpdateAimingData()
	* UpdateJumpFallData()

### GetMovementComponent()

* (BlueprintThreadSafeUpdateAnimation() から呼ばれる) Update 系関数から呼び出される、 MovementComponent のプロパティのアクセスに利用する関数。

### ShouldEnableControlRig()

* AnimGraph から呼び出されている、 ControlRig の enable を決める関数。
* 使用する変数
	* UseFootPlacement
* 使用するカーブ
	* DisableLegIK
		* 例： AM_MM_Dash_Forward で足が浮いている間 0 より大きい値が設定される。
* 実装概要
	* DisableLegIK の値が 0.0 以下かつ UseFootPlacement が false のときに true を返す。
	* つまり、足が浮いていて、 UseFootPlacement が false になっているとき、 ControlRig が enable となる。
		* TODO: UseFootPlacement の初期値が true であり、値を変更する箇所が検索にかからない。要調査。

# VALIABLES

## Rotation Data

### WorldRotation

* 型
	* Rotator
* 概要
	* Actor の Rotation
	* ワールド座標系の Vector をローカル座標系に変換するのに利用
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateRotationData()							| 直前のフレームの値と比較し YawDeltaSinceLastUpdate の算出に利用			|
	| UpdateVelocityData()							| LocalVelocity2D / LocalVelocityDirectionAngle の算出に利用				|
	| UpdateAccelerationData()						| LocalAcceleration2D / CardinalDirectionFromAcceleration の算出に利用		|

### YawDeltaSinceLastUpdate

* 型
	* float
* 概要
	* WorldRotation の Yaw の直前のフレームとの Delta
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateRootYawOffset()							| RootYawOffset の更新に利用												|

### AdditiveLeanAngle

* 型
	* float
* 概要
	* 体の傾き角度
	* しゃがみや ADS 状態による定数と YawDeltaSpeed の乗算で求める
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| Start (state)									| BS_MM_Rifle_Jog_Leans の LeanAngle に利用									|
	| Cycle (state)									| 同上																		|
	| Pivot (state)									| 同上																		|

### YawDeltaSpeed

* 型
	* float
* 概要
	* 時間あたりの YawDeltaSinceLastUpdate
	* YawDeltaSinceLastUpdate を DeltaTime で割った値
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateRotationData()							| AdditiveLeanAngle の算出に利用											|

## Location Data

* 概要
	* 共通して、更新は UpdateLocationData() で行われる。

### WorldLocation

* 型
	*  Vector
* 概要
	* Actor の Location
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| WorldLocation の算出に利用												|

### DisplacementSinceLastUpdate

* 型
	* float
* 概要
	* WorldLocation の XY 平面での大きさ
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| DisplacementSpeed の算出に利用											|

### DisplacementSpeed

* 型
	*  float
* 概要
	* XY 平面での速度
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| Start to Cycle (rule)							| 速度が一定を超えているかの判定に利用										|

## Velocity Data

* 概要
	* 共通して、更新は UpdateLocationData() で行われる。

### WorldVelocity

* 型
	* Vector
* 概要
	* Pawn の Velocity
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| ローカル変数 WorldVelocit2D の算出に利用									|
	| UpdateCharacterStateData()					| IsJumping / IsFalling の算出に利用										|
	| UpdateJumpFallData()							| TimeToJumpApex の算出に利用												|

### LocalVelocity2D

* 型
	* Vector
* 概要
	* WorldVelocity から算出したローカル座標系での Velocity
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| ローカル変数 WasMovingLastUpdate の算出に利用								|
	|												| (WasMovingLastUpdate は直前のフレームに移動下かを示す)					|
	|												| HasVelocity の算出に利用													|
	| UpdateWallDetectionHeuristic()				| IsRunningIntoWall の算出に利用											|
	| PivotSources to Pivot (rule)					| LocalVelocity2D と LocalAcceleration2D が逆向きかを調べる際に利用			|

### LocalVelocityDirectionAngle

* 型
	* float
* 概要
	* LocalVelocity2D から算出した \[-180,180\] の値を取る向き
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| LocalVelocityDirectionNoOffset の算出に利用								|
	|												| LocalVelocityDirectionAngleWithOffset の算出に利用						|

### LocalVelocityDirectionAngleWithOffset

* 型
	* float
* 概要
	* LocalVelocityDirectionAngle に RootYawOffset を加えた値
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| LocalVelocityDirection の算出に利用										|

### LocalVelocityDirection

* 型
	* AnimEnum_CardinalDirection
* 概要
	* LocalVelocityDirectionAngleWithOffset から算出した、移動方向
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| LocalVelocityDirection の算出に利用										|
	| SetUpStartState()								| StartDirection ヘ値の複製に利用											|
	| SetUpPivotState()								| PivottInitialDirection ヘ値の複製に利用									|
	| IsMovingPerpendicularToInitialPivot()			| 戻り値の算出に利用														|
	| Start to Cycle (rule)							| StartDirection との比較に利用												|
	|												| Start ステートの初期 Direction と現在の Direction が異なるかの判定に利用	|

### LocalVelocityDirectionNoOffset

* 型
	* AnimEnum_CardinalDirection
* 概要
	* LocalVelocityDirectionAngle から算出した、移動方向
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| LocalVelocityDirectionNoOffset の算出に利用								|

### HasVelocity

* 型
	* bool
* 概要
	* LocalVelocity2D が 0 に近くないか
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| AnimGraph										| ControlRig の Enabled に利用												|
	| Idle to Start (rule)							| トランジションの判定の一部で利用											|
	| StopRule (rule)								| トランジションの判定の一部で利用											|

## Acceleration Data

* 概要
	* 共通して、更新は UpdateAccelerationData() で行われる。

### LocalAcceleration2D

* 型
	* Vector
* 概要
	* ローカル座標系での Acceleration
	* MovementComponent の CurrentAcceleration の XY 成分から算出
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateAccelerationData()						| HasAcceleration の算出に利用												|
	| UpdateWallDetectionHeuristic()				| IsRunningIntoWall の算出に利用											|
	| PivotSources to Pivot (rule)					| Velocity と Acceleration の向きが逆かを調べる際に利用						|

### HasAcceleration

* 型
	* bool
* 概要
	* LocalAcceleration2D が 0 に近くないか
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| Idle to Start (rule)							| トランジションの判定の一部で利用											|
	| StopRule (rule)								| トランジションの判定の一部で利用											|
	| Pivot to Stop (rule)							| トランジションの判定の一部で利用											|
	| Stop to Start (rule)							| トランジションの判定の一部で利用											|
	| EndAir tot CycleAlias (rule)					| トランジションの判定の一部で利用											|

### PivotDirection2D

* 型
	* Vector
* 概要
	* MovementComponent の CurrentAcceleration の XY 成分の Vector のと直前のフレームの値を 0.5 で lerp したワールド座標系の Vector
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateAccelerationData()						| CardinalDirectionFromAcceleration の算出に利用							|

## Character State Data

* 概要
	* 共通して、更新は UpdateCharacterStateData() で行われる。
		* ただし、以下の変数はカテゴリ Character State Data に属するが、この関数では更新しない。
			* TimeToJumpApex
			* IsRunningIntoWall

### IsOnGround

* 型
	* bool
* 概要
	* MovementComponent の IsMovingOnGround
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateBlendWeightData()						| UpperbodyDynamicAdditiveWeight の算出に利用								|
	| FallLand to EndInAir (rule)					| トランジションの判定の一部で利用											|
	| JumpFallInterruptSources to EndInAir (rule)	| トランジションの判定の一部で利用											|

### IsCrouching

* 型
	* bool
* 概要
	* MovementComponent の IsCrouching
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateCharacterStateData()					| CrouchStateChange / WasCrouchingLastUpdate の算出に利用					|
	| AnimGraph										| ControlRig の IsCrouching に利用											|
	| UpdateRotationData()							| AdditiveLeanAngle の算出に利用											|
	| SetRootYawOffset()							| RootYawOffset の算出に利用												|

### CrouchStateChange

* 型
	* bool
* 概要
	* IsCrouching が直前のフレームから変わっているか
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| Start to Cycle (rule)							| トランジションの判定の一部で利用											|
	| Pivot to Cycle (rule)							| トランジションの判定の一部で利用											|
	| Stop to Idle (rule)							| トランジションの判定の一部で利用											|

### ADSStateChanged

* 型
	* bool
* 概要
	* ADS の状態が直前のフレームから変わっているか
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| Start to Cycle (rule)							| トランジションの判定の一部で利用											|
	| Pivot to Cycle (rule)							| トランジションの判定の一部で利用											|
	| Stop to Idle (rule)							| トランジションの判定の一部で利用											|

### WasADSLastUpdate

* 型
	* bool
* 概要
	* GameplayTagIsADS の直前のフレームの値の参照用
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateCharacterStateData()					| ADSStateChanged の算出に利用												|

### TimeSinceFiredWeapon

* 型
	* float
* 概要
	* GameplayTagIsFiring が false になってからの時間
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateCharacterStateData()					| TimeSinceFiredWeapon の算出に利用											|

### IsJumping

* 型
	* bool
* 概要
	* WorldVelocity の Z 値が 0 より小さいか
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateJumpFallData()							| TimeToJumpApex の算出に利用												|
	| JumpSelector to JumpStart (rule)				| トランジションの判定の一部で利用											|

### IsFalling

* 型
	* bool
* 概要
	* WorldVelocity の Z 値が 0 以上か
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| JumpSelector to JumpStart (rule)				| トランジションの判定の一部で利用											|

### TimeToJumpApex

* 型
	* float
* 概要
	* UpdateJumpFallData() で更新する、ジャンプの頂点までの時間
	* IsJumping でジャンプしているかを判定
		* ジャンプしていない場合は 0.0 を設定
		* ジャンプしている場合は WorldVelocity の Z 成分に重力加速度を割ることで算出
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| JumpStartLoop to JumpApex (rule)				| トランジションの判定の一部で利用											|

### IsRunningIntoWall
* 型
	* bool
* 概要
	* UpdateWallDetectionHeuristic() で更新する、壁にめり込むように移動しようとしているか
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| PivotSources to Pivot (rule)					| トランジションの判定の一部で利用											|

## Gameplay Tag Bindings

* TODO:未整備

### GameplayTag_IsADS

* TODO:未整備

### GameplayTag_IsFiring

* TODO:未整備

### GameplayTag_IsReloading

* TODO:未整備

### GameplayTag_IsDashing

* TODO:未整備

### GameplayTag_IsMelee

* TODO:未整備

## Locomotion SM Data

* TODO:未整備

### StartDirection

* 型
	* AnimEnum_CardinalDirection
* 概要
	* LocalVelocityDirection のコピー
* read
	* Start to Cycle (rule)
* write
	* SetUpStartState()

### PivotInitialDirection

* 型
	* AnimEnum_CardinalDirection
* 概要
	* LocalVelocityDirection のコピー
* read
	* IsMovingPerpendicularToInitialPivot()
* write
	* SetUpPivotState()

### LastPivotTime

* 型
	* float
* 概要
	* Pivot から Cycle に移る際に Pivot を行うのに十分な時間が経過したか判定するための時間計測用の変数です。<br>値の初期化は派生クラス(ABP_ItemAnimLayerBase)でのみ行われています。
* read
	* Pivot to Cycle (rule)
* write
	* UpdatePivotState()<br>SetUpPivotAnim()(ABP_ItemAnimLayerBase)

### CardinalDirectionFromAcceleration
* 型
	* AnimEnum_CardinalDirection
* 概要
	* PivotDirection2D から算出し、反対にした方向。このクラスでは設定のみで、利用は派生クラスでのみ行なわれています。
* read
	* SetUpPivotAnim()(ABP_ItemAnimLayerBase)<br>UpdatePivotAnim()(ABP_ItemAnimLayerBase)
* write
	* UpdateAccelerationData()

## Blend Weight Data

* 概要
	* 共通して、更新は UpdateBlendWeightData() で行われる。

### UpperbodyDynamicAdditiveWeight

* 型
	* float
* 概要
	* スロット UpperBodyAdditive のアニメーションモンタージュを ApplyAdditive() する際の Alpha
	* IsOnGround かつ UAnimInstance::IsAnyMontagePlaying() により値が決まる
		* true の場合： 1.0
		* false の場合： 現在値から 0.0 に向けて FInterpTo した値
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateBlendWeightData()						| UpperbodyDynamicAdditiveWeight の算出に利用								|
	| AnimGraph										| ApplyAdditive() の Alpha に利用											|

## Aiming Data

* 概要
	* AimPitch の更新は UpdateAimingData() で行われる。
	* AimYaw の更新は RootYawOffset と連動するため SetRootYawOffset() で行われる。

### AimPitch

* 型
	* float
* 概要
	* Owner の BaseAimRotation の Pitch
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| AnimGrap										| Fullbody_Aiming の AimPitch として利用									|

### AimYaw
* 型
	* float
* 概要
	* RootYawOffset に -1 をかけた値。
	* 以下の 2 箇所で更新を行う
		* BlueprintThreadSafeUpdateAnimation() > UpdateRootYawOffset() > SetRootYawOffset()
		* UpdateIdleState() > ProcessTurnYawCurve() > SetRootYawOffset()
	* 詳しくは SetRootYawOffset() を参照。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| AnimGrap										| Fullbody_Aiming の AimYaw として利用										|

## Settings

* TODO:未整備

### CardinalDirectionDeadZone

* TODO:未整備

## Linked Layer Data

* 概要
	* 共通して、更新は UpdateLocomotionStateMachine() で行われる。

### LinkedLayerChanged

* 型
	* bool
* 概要
	* AnimGraph > LocomotionSM > Start (state) の Linked Anim Instance が直前のフレームから変更されているか 
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| Start to Cycle (rule)							| TODO																		|
	| Pivot to Cycle (rule)							| TODO																		|
	| Stop to Idle (rule)							| TODO																		|

### LastLinkedLayer

* TODO:未整備

## Turn In Place

* 概要
	* 更新は UpdateRootYawOffset() で行われるものとそうでないものがある。
		* UpdateRootYawOffset() で更新するもの
			* RootYawOffset
		* UpdatIdleState() で更新するもの
			* TurnYawCurveValue
		* UpdateRootYawOffset() で基本の値を設定し、 Update...State() で特定の値を設定するもの
			* RootYawOffsetMode
		* 値を外出しするための定数
			* RootYawOffsetAngleClamp
			* RootYawOffsetAngleClampCrouched
		* FloatSpringInterp() 用の構造体
			* RootYawOffsetSpringState

### RootYawOffset

* 型
	* float
* 概要
	* RotateRootBone() の Yaw で使用する値。
	* SetRootYawOffset() にて設定され、以下から呼び出される。
		* UpdateRootYawOffset()
		* ProcessTurnYawOffset()
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| AnimGraph										| RotateRootBone() の Yaw に利用											|
	| UpdateVelocityData()							| LocalVelocityDirectionAngleWithOffset の算出に利用						|
	| ProcessTurnYawOffset()						| SetRootYawOffset() に渡す値の算出に利用									|
	| UpdateRootYawOffset()							| SetRootYawOffset() に渡す値の算出に利用									|
	| Start to Cycle (rule)							| トランジションの判定の一部で利用											|

### RootYawOffsetSpringState

* 型
	* FloatSpringState
* 概要
	* UpdateRootYawOffset() 内で FloatSpringInterp() のステートを保持するための構造体

### TurnYawCurveValue

* 型
	* float
* 概要
	* UpdatIdleState() で以下の二通りで更新が行われる。
		* 直接 0.0 に更新
		* ProcessTurnYawCurve() を呼び出しての更新
	* 直前のフレームとの Delta 値を SetRootYawOffset() にわたす値の算出に必要なため、値をフレームを超えて記憶するための変数。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| ProcessTurnYawCurve()							| SetRootYawOffset() に渡す値の算出に利用									|

### RootYawOffsetMode

* 型
	* AnimEnum_RootYawOffsetMode
* 概要
	* Turn In Place の挙動を決めるための変数
	* enum の各値は以下の関数で設定している
		* BlendOut
			* UpdateRootYawOffset()
		* Hold
			* UpdateStartState()
		* Accumulate
			* UpdateIdleState()
			* UpdateStopState()
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateRootYawOffset()							| SetRootYawOffset() を呼び出す条件に利用									|

### RootYawOffsetAngleClamp

* TODO:未整備

### RootYawOffsetAngleClampCrouched

* コメント
	> Limit for how much we can offset the root's yaw during turn in place.  
	> X = left limit  
	> Y = right limit  
	> 
	> ----
	> Tune In Place 時に Root の Yaw をどれだけオフセットできるかという制限。  
	> X = 左リミット
	> Y = 右リミット
* 型
	* Vector2D
* 概要
	* SetRootYawOffset() で利用される、 RootYawOffset の設定前に適用するクランプ値。
		* 詳しくは [Comment_TourInPlace.Ja.3] を参照。
	* RootYawOffsetAngleClamp はしゃがんで **いない** ときに使用する。
	* RootYawOffsetAngleClampCrouched はしゃがんで **いる** ときに使用する。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| SetRootYawOffset()							| RootYawOffset の算出に利用												|

## Default(VALIABLES)

* 概要
	* 「初回アップデートが済んでいるか」と、「各種の実装を有効にするか」と言うカテゴリに属さない設定関連の変数からなる。

### IsFirstUpdate

* 型
	* bool
* 概要
	* BlueprintThreadSafeUpdateAnimation() の呼び出しが一度も完了していないかを返す
	* 初期値 true
	* BlueprintThreadSafeUpdateAnimation() の最後で false に設定される
	* 主に直前のフレームとの Delta 値を用いる値の算出時に参照し、 true の場合は無効な値を設定するのに利用している。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| UpdateLocationData()							| DisplacementSinceLastUpdate / DisplacementSpeed の算出に利用				|
	| UpdateRotationData()							| YawDeltaSinceLastUpdate / AdditiveLeanAngle の算出に利用					|
	| UpdateLocomotionStateMachine()				| LinkedLayerChanged の算出に利用											|

### EnableControlRig

* 型
	* bool
* 概要
	* 用途不明。
	* 初期値 false のまま変更されない。
	* このクラスでは使用されていない。
	* ABP_ItemAnimLayersBase の FullBody_SkeletalControls の Transform (Modify) Bone ノードの Enable の値として利用。

### UseFootPlacement

* 型
	* bool
* 概要
	* 足の位置を調整するか。 
		* ShouldEnableControlRig() の戻り値の算出に影響を及ぼす。
			* true の場合、常に false を返す。
			* false の場合、 アニメーションカーブ DisableLegIK が 0.0 以下の場合 true を返す。
		* ABP_ItemAnimLayerBase の ShouldEnableFootPlacement() の戻り値の算出に影響を及ぼす。
			* true の場合、アニメーションカーブ DisableLegIK が 0.0 以下の場合 true を返す。
			* false の場合、 常に false を返す。
		* つまり実装が逆になっている。
			* TODO: これが排他的に制御するために意図してそうなっているのかどうか要確認。
	* 初期値 true のまま変更されない。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| ShouldEnableControlRig()						| 戻り値の算出に利用														|

### bEnableRootYawOffset

* 型
	* bool
* 概要
	* RootYawOffset の機能を使用するか。
		* SetRootYawOffset() の挙動に影響を及ぼす。
			* true の場合、 RootYawOffset / AimYaw の値が状況によって変化する
			* false の場合、 RootYawOffset / AimYaw の値が常に 0.0 となる
	* 初期値 true のまま変更されない。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| SetRootYawOffset()							| RootYawOffset / AimYaw の算出に利用										|



<!--- ------------------------------------------------------------------ --->

[Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Editor > AnimGraph > UAnimStateTransitionNode]: https://docs.unrealengine.com/5.1/en-US/API/Editor/AnimGraph/UAnimStateTransitionNode/

[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > ステートマシン > 遷移ルール]: https://docs.unrealengine.com/5.1/ja/transition-rules-in-unreal-engine/



[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]: https://docs.unrealengine.com/5.1/ja/animation-modifiers-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ブループリントでのグラフ作成 > ノード関数]: https://docs.unrealengine.com/5.1/ja/graphing-in-animation-blueprints-in-unreal-engine/#%E3%83%8E%E3%83%BC%E3%83%89%E9%96%A2%E6%95%B0

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[GRAPHS]: #graphs
[EventGraph]: #eventgraph
[ANIMATION GRAPHS]: #animation-graphs
[AnimGraph]: #animgraph
[LocomotionSM]: #locomotionsm
[Idle (state)]: #idle-state
[Start (state)]: #start-state
[Cycle (state)]: #cycle-state
[Stop (state)]: #stop-state
[Pivot (state)]: #pivot-state
[JumpStart (state)]: #jumpstart-state
[JumpStartLoop (state)]: #jumpstartloop-state
[JumpApex (state)]: #jumpapex-state
[FallLoop (state)]: #fallloop-state
[FallLand (state)]: #fallland-state
[PivotSources]: #pivotsources
[JumpSources]: #jumpsources
[JumpFallInterruptSources]: #jumpfallinterruptsources
[CycleAlias]: #cyclealias
[IdleAlias]: #idlealias
[JumpSelector (conduit rule)]: #jumpselector-conduit-rule
[EndAir (conduit rule)]: #endair-conduit-rule
[Idle to Start (rule)]: #idle-to-start-rule
[Start to Cycle (rule)]: #start-to-cycle-rule
[StopRule (rule)]: #stoprule-rule
[Stop to Idle (rule)]: #stop-to-idle-rule
[Stop to Start (rule)]: #stop-to-start-rule
[PivotSources to Pivot (rule)]: #pivotsources-to-pivot-rule
[Pivot to Cycle (rule)]: #pivot-to-cycle-rule
[Pivot to Stop (rule)]: #pivot-to-stop-rule
[JumpSources to JumpSelector (rule)]: #jumpsources-to-jumpselector-rule
[JumpSelector to JumpStart (rule)]: #jumpselector-to-jumpstart-rule
[JumpStart to JumpStartLoop (rule)]: #jumpstart-to-jumpstartloop-rule
[JumpStartLoop to JumpApex (rule)]: #jumpstartloop-to-jumpapex-rule
[JumpSelector to JumpApex (rule)]: #jumpselector-to-jumpapex-rule
[JumpApex to FallLoop (rule)]: #jumpapex-to-fallloop-rule
[FallLoop to FallLand (rule)]: #fallloop-to-fallland-rule
[FallLand to EndAir (rule)]: #fallland-to-endair-rule
[JumpFallInterruptSources to EndAir (rule)]: #jumpfallinterruptsources-to-endair-rule
[EndAir to CycleAlias (rule)]: #endair-to-cyclealias-rule
[EndAir to IdleAlias (rule)]: #endair-to-idlealias-rule
[ANIMATION LAYERS]: #animation-layers
[Item Anim Layers]: #item-anim-layers
[FullBodyAdditives]: #fullbodyadditives
[FullBody_IdleState]: #fullbodyidlestate
[FullBody_StartState]: #fullbodystartstate
[FullBody_CycleState]: #fullbodycyclestate
[FullBody_StopState]: #fullbodystopstate
[FullBody_PivotState]: #fullbodypivotstate
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
[UpdateIdleState()]: #updateidlestate
[SetUpStartState()]: #setupstartstate
[UpdateStartState()]: #updatestartstate
[UpdateStopState()]: #updatestopstate
[SetUpPivotState()]: #setuppivotstate
[UpdatePivotState()]: #updatepivotstate
[UpdateLocomotionStateMachine()]: #updatelocomotionstatemachine
[Helper Functions]: #helper-functions
[GetOppositeCardinalDirection()]: #getoppositecardinaldirection
[IsMovingPerpendicularToInitialPivot()]: #ismovingperpendiculartoinitialpivot
[Blueprint Thread Safe Update Functions]: #blueprint-thread-safe-update-functions
[UpdateLocationData()]: #updatelocationdata
[UpdateRotationData()]: #updaterotationdata
[UpdateVelocityData()]: #updatevelocitydata
[UpdateAccelerationData()]: #updateaccelerationdata
[UpdateCharacterStateData()]: #updatecharacterstatedata
[UpdateBlendWeightData()]: #updateblendweightdata
[UpdateAimingData()]: #updateaimingdata
[UpdateJumpFallData()]: #updatejumpfalldata
[UpdateWallDetectionHeuristic()]: #updatewalldetectionheuristic
[SetRootYawOffset()]: #setrootyawoffset
[ProcessTurnYawCurve()]: #processturnyawcurve
[UpdateRootYawOffset()]: #updaterootyawoffset
[Default(FUNCTIONS)]: #defaultfunctions
[BlueprintThreadSafeUpdateAnimation()]: #blueprintthreadsafeupdateanimation
[GetMovementComponent()]: #getmovementcomponent
[ShouldEnableControlRig()]: #shouldenablecontrolrig
[VALIABLES]: #valiables
[Rotation Data]: #rotation-data
[WorldRotation]: #worldrotation
[YawDeltaSinceLastUpdate]: #yawdeltasincelastupdate
[AdditiveLeanAngle]: #additiveleanangle
[YawDeltaSpeed]: #yawdeltaspeed
[Location Data]: #location-data
[WorldLocation]: #worldlocation
[DisplacementSinceLastUpdate]: #displacementsincelastupdate
[DisplacementSpeed]: #displacementspeed
[Velocity Data]: #velocity-data
[WorldVelocity]: #worldvelocity
[LocalVelocity2D]: #localvelocity2d
[LocalVelocityDirectionAngle]: #localvelocitydirectionangle
[LocalVelocityDirectionAngleWithOffset]: #localvelocitydirectionanglewithoffset
[LocalVelocityDirection]: #localvelocitydirection
[LocalVelocityDirectionNoOffset]: #localvelocitydirectionnooffset
[HasVelocity]: #hasvelocity
[Acceleration Data]: #acceleration-data
[LocalAcceleration2D]: #localacceleration2d
[HasAcceleration]: #hasacceleration
[PivotDirection2D]: #pivotdirection2d
[Character State Data]: #character-state-data
[IsOnGround]: #isonground
[IsCrouching]: #iscrouching
[CrouchStateChange]: #crouchstatechange
[ADSStateChanged]: #adsstatechanged
[WasADSLastUpdate]: #wasadslastupdate
[TimeSinceFiredWeapon]: #timesincefiredweapon
[IsJumping]: #isjumping
[IsFalling]: #isfalling
[TimeToJumpApex]: #timetojumpapex
[IsRunningIntoWall]: #isrunningintowall
[Gameplay Tag Bindings]: #gameplay-tag-bindings
[GameplayTag_IsADS]: #gameplaytagisads
[GameplayTag_IsFiring]: #gameplaytagisfiring
[GameplayTag_IsReloading]: #gameplaytagisreloading
[GameplayTag_IsDashing]: #gameplaytagisdashing
[GameplayTag_IsMelee]: #gameplaytagismelee
[Locomotion SM Data]: #locomotion-sm-data
[StartDirection]: #startdirection
[PivotInitialDirection]: #pivotinitialdirection
[LastPivotTime]: #lastpivottime
[CardinalDirectionFromAcceleration]: #cardinaldirectionfromacceleration
[Blend Weight Data]: #blend-weight-data
[UpperbodyDynamicAdditiveWeight]: #upperbodydynamicadditiveweight
[Aiming Data]: #aiming-data
[AimPitch]: #aimpitch
[AimYaw]: #aimyaw
[Settings]: #settings
[CardinalDirectionDeadZone]: #cardinaldirectiondeadzone
[Linked Layer Data]: #linked-layer-data
[LinkedLayerChanged]: #linkedlayerchanged
[LastLinkedLayer]: #lastlinkedlayer
[Turn In Place]: #turn-in-place
[RootYawOffset]: #rootyawoffset
[RootYawOffsetSpringState]: #rootyawoffsetspringstate
[TurnYawCurveValue]: #turnyawcurvevalue
[RootYawOffsetMode]: #rootyawoffsetmode
[RootYawOffsetAngleClamp]: #rootyawoffsetangleclamp
[RootYawOffsetAngleClampCrouched]: #rootyawoffsetangleclampcrouched
[Default(VALIABLES)]: #defaultvaliables
[IsFirstUpdate]: #isfirstupdate
[EnableControlRig]: #enablecontrolrig
[UseFootPlacement]: #usefootplacement
[bEnableRootYawOffset]: #benablerootyawoffset
[ULyraAnimInstance::GameplayTagPropertyMap]: ../../Lyra/Animation/ULyraAnimInstance.md#ulyraaniminstancegameplaytagpropertymap
[Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Editor > AnimGraph > UAnimStateTransitionNode]: https://docs.unrealengine.com/5.1/en-US/API/Editor/AnimGraph/UAnimStateTransitionNode/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]: https://docs.unrealengine.com/5.1/ja/animation-modifiers-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ブループリントでのグラフ作成 > ノード関数]: https://docs.unrealengine.com/5.1/ja/graphing-in-animation-blueprints-in-unreal-engine/#%E3%83%8E%E3%83%BC%E3%83%89%E9%96%A2%E6%95%B0
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > ステートマシン > 遷移ルール]: https://docs.unrealengine.com/5.1/ja/transition-rules-in-unreal-engine/
