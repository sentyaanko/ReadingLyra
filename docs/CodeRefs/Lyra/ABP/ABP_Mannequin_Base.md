# ABP_Mannequin_Base

* 概要
	* キャラクターブループリントに設定する、基本となる ABP です。
* 他のクラスとの関係
	* `B_HeroShooterMannyquin` の Mesh の AnimClass で指定されています。
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
					* [EndInAir (conduit rule)]
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
					* [FallLand to EndInAir (rule)]
					* [JumpFallInterruptSources to EndInAir (rule)]
					* [EndInAir to CycleAlias (rule)]
					* [EndInAir to IdleAlias (rule)]
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
		* [Turn In Place{FUNCTIONS}]
			* [SetRootYawOffset()]
			* [ProcessTurnYawCurve()]
			* [UpdateRootYawOffset()]
		* [Default{FUNCTIONS}]
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
		* [Turn In Place{VALIABLES}]
			* [RootYawOffset]
			* [RootYawOffsetSpringState]
			* [TurnYawCurveValue]
			* [RootYawOffsetMode]
			* [RootYawOffsetAngleClamp]
			* [RootYawOffsetAngleClampCrouched]
		* [Default{VALIABLES}]
			* [IsFirstUpdate]
			* [EnableControlRig]
			* [UseFootPlacement]
			* [bEnableRootYawOffset]
* グループについて
	* [ANIMATION LAYERS] のグループ
		* [Item Anim Layers]
			* [ALI_ItemAnimLayers] で定義されているグループです。
	* [FUNCTIONS] / [VALIABLES] のグループ
		* [State Node Functions]
			* ステートの `Output Animation Pose` ノード及び [AnimGraph] のステートマシンノードで使用しているノード関数です。
				* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ブループリントでのグラフ作成 > ノード関数]
			* 命名規則は以下のいずれかです。
				* Update（関数のタイプが On Update） + ステート名 + State
					* 例：[UpdateIdleState()]
				* SetUp（関数のタイプが On Become Relevant） + ステート名 + State
					* 例：[SetUpStartState()]
				* その他（ステートマシン [LocomotionSM] の On Update）
					* [UpdateLocomotionStateMachine()]
		* [Helper Functions]
			* 他の関数から呼ばれる、計算等を行う補助関数です。
		* [Blueprint Thread Safe Update Functions]
			* [BlueprintThreadSafeUpdateAnimation()] から呼び出される、変数を更新する関数です。
		* [Turn In Place{FUNCTIONS}] / [Turn In Place{VALIABLES}]
			* 所定の位置での旋回処理を行うための関数 / 変数です。
			* [所定の位置での旋回について(about Turn In Place)] を参照。
		* [Rotation Data]
			* Actor の Rotation を元の算出された変数です。
			* 更新は [UpdateRotationData()] で行われます。
		* [Location Data]
			* Actor の Location を元の算出された変数です。
			* 更新は [UpdateLocationData()] で行われます。
		* [Velocity Data]
			* Pawn の Velocity を元の算出された変数です。
			* 更新は [UpdateLocationData()] で行われます。
		* [Acceleration Data]
			* MovementComponent の CurrentAcceleration を元の算出された変数です。
			* 更新は [UpdateAccelerationData()] で行われます。
		* [Character State Data]
			* キャラクターの各種状態（例：立っている、しゃがんでいる、 ADS している、ジャンプしている、落下している等々）を保持しています。
			* 更新は [UpdateCharacterStateData()] で行われますが、以下の 2 つは例外です。
				* [TimeToJumpApex]
				* [IsRunningIntoWall]
		* [Gameplay Tag Bindings]
			* GameplayTag を監視し、付与状態と連動します。
			* 更新は [ULyraAnimInstance::GameplayTagPropertyMap] により行われます。
		* [Locomotion SM Data]
			* [LocomotionSM] 内で読み書きされる変数です。
		* [Blend Weight Data]
			* アニメーションのブレンドの際のアルファ値を保持する変数です。
			* 更新は [UpdateBlendWeightData()] で行われます。
		* [Aiming Data]
			* キャラクターの向いている方向に関する変数です。
			* 更新は [UpdateAimingData()] で行われますが、以下は例外です。
				* [AimYaw]
					* [RootYawOffset] と連動するため [SetRootYawOffset()] で更新されます。
		* [Settings]
			* 定数として扱われている変数です。
		* [Linked Layer Data]
			* Linked Anim Instance に関する変数です。
			* 更新は [UpdateLocomotionStateMachine()] で行われます。

# アニメーションスロットについて(about Animation Slot)

* DefaultGroup
	* FullBody
	* DefaultSlot
	* UpperBody
	* FullBodyAdditivePreAim
	* UpperBodyAdditive
	* UpperBodyDynAdditiveBase
	* UpperBodyDynAdditive
* AdditiveGroup
	* AdditiveHitReact

使用状況

* AdditiveGroup.AdditiveHitReact
	* 被ダメージ時のモンタージュ再生用グループ。
	* AM_MM_HitReact_&#91;Back|Front|Left|Right&#93;_&#91;Lgt|Med|Hvy&#93;&#95;&#91;01|02|03|04&#93;
		* AdditiveGroup.AdditiveHitReact
			* MM_HitReact_&#91;Back|Front|Left|Right&#93;_&#91;Lgt|Med|Hvy&#93;&#95;&#91;01|02|03|04&#93;
		* 最後の数字はバリエーションですが、物によりバリエーション数は異なります。
* DefaultGroup.FullBodyAdditivePreAim
	* 発砲時のモンタージュ再生用グループ。
	* AM_MM_&#91;Pistol|Rifle|Shotgun&#93;_Fire
		* DefaultGroup.FullBodyAdditivePreAim
			* MM_&#91;Pistol|Rifle|Shotgun&#93;_Fire
* DefaultGroup.UpperBody と DefaultGroup.UpperBodyAdditive
	* 武器装備、解除、近接攻撃、リロード、空打ち、グレネード投擲のモンタージュ再生用グループ。
	* AM_MM_&#91;Pistol|Rifle|Shotgun&#93;_&#91;DryFire|Equip|Reload|Melee&#93;
		* DefaultGroup.UpperBody
			* MM_&#91;Pistol|Rifle|Shotgun&#93;_&#91;DryFire|Equip|Reload|Melee&#93;
		* DefaultGroup.UpperBodyAdditive
			* MM_&#91;Pistol|Rifle|Shotgun&#93;_&#91;DryFire|Equip|Reload|Melee&#93;_Additive
		* AM_MM_Shotgun_DryFire は例外的に存在しません。
	* AM_MM_Generic_Unequip
		* DefaultGroup.UpperBody
			* MM_Pistol_Equip
		* DefaultGroup.UpperBodyAdditive
			* MM_Pistol_Equip_Additive
	* AM_MM_Rifle_GrenadeToss
		* DefaultGroup.UpperBody
			* MM_Rifle_GrenadeToss
		* DefaultGroup.UpperBodyAdditive
			* MM_Rifle_GrenadeToss_Additive
* DefaultGroup.UpperBody
	* DropBomb_Montage
		* DefaultGroup.UpperBody
			* MM_Rifle_GrenadeToss
* DefaultGroup.FullBody
	* 上記以外。


# Additive Anim Type について(about Additive Anim Type)

アニメーションスロット名に `Additive` がつくものの殆どは、設定されているアニメーションシーケンスの `Additive Anim Type` に `Local Space Base` が設定されています。
例外として `DefaultGroup.FullBodyAdditivePreAim` に設定されているアニメーションシーケンスでは `Rotation Offset Mesh Space` が設定されています。

* Local Space Base
	* MM_&#91;Pistol|Rifle&#93;_Jump_RecoveryAdditive
	* MM_Rifle_Jog_Lean_&#91;Center|Left|Right&#93;
	* MM_HitReact_&#91;Back|Front|Left|Right&#93;_&#91;Lgt|Med|Hvy&#93;&#95;&#91;01|02|03|04&#93;
	* MM_&#91;Pistol|Rifle|Shotgun&#93;_&#91;DryFire|Equip|Reload|Melee&#93;_Additive
	* MM_Rifle_GrenadeToss_Additive
* Rotation Offset Mesh Space
	* Manny_Upperarm_r_anim
	* &#91;MM|MF&#93;_&#91;Pistol|Rifle|Shotgun&#93;&#91;_Crouch|_Hipfire&#93;*_Idle_ADS_AO&#95;&#91;CC|CD|CU|LBC|LBD|LBU|LC|LD|LU|RBC|RBD|RBU|RC|RD|RU&#93;
	* MM_Unarmed_Idle_Ready_AO&#95;&#91;CC|CD|CU|LBC|LBD|LBU|LC|LD|LU|RBC|RBD|RBU|RC|RD|RU&#93;
	* MM_&#91;Pistol|Rifle|Shotgun&#93;_Fire



# キャッシュポーズについて(about Cache Pose)

* Locomotion
* UpperbodyLowerbodySplit



# 所定の位置での旋回について(about Turn In Place)

* 既存のドキュメント
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション] > 所定の位置での旋回
		* `Turn In Place` に関する情報や [AnimEnum_RootYawOffsetMode] の各値の説明などがまとめられています。
* Tour コメント
	* [Comment_TourInPlace.Ja]

# GRAPHS

## EventGraph

* Tour コメント
	* [Comment_AnimBP_Tour.Ja::1]
* 概要
	* マルチスレッド対応のため、基本的には空っぽ。

# ANIMATION GRAPHS

## AnimGraph

* Tour コメント
	* [Comment_AnimBP_Tour.Ja::3]
	* [Comment_TourInPlace.Ja::1]
* 概要
	* Anim Seaquence
		* 基本的に直接参照しない。
	* Blendspace
		* 例： [Cycle (state)] にて BS_MM_Rifle_Jog_Leans が直接指定されている。
		* おそらく変わることがないため直接指定されているものと思われる。
* グラフの流れ
	* コメント `Locomition` 部分
		1. [LocomotionSM] で出力されたポーズをノード [LeftHandPose_OverrideState] のパラメータ `Input Poes` で渡し、その結果をポーズキャッシュ `Locomotion` に設定します。
			* [LeftHandPose_OverrideState] について詳しくは [ABP_ItemAnimLayersBase::LeftHandPoseOverride について(about LeftHandPoseOverride)] を参照してください。
			* ポーズキャッシュ `Locomotion` はコメント `Upperbody/lowerbody split.` 内で 2 箇所で使われます。
	* コメント `Upperbody/lowerbody split.` 部分
		1. ポーズキャッシュ `Locomotion` / スロット `UpperBodyAdditive` をノード `ApplyAdditive` のパラメータ `Base` / `Additive` でそれぞれ渡し、加算します。
			* スロット `UpperBodyAdditive` を使用するアニメーションシーケンスは以下のとおりです。
				* AM_MM_&#91;Pistol|Rifle|Shotgun&#93;_&#91;DryFire|Equip|Reload|Melee&#93;
					* MM_&#91;Pistol|Rifle|Shotgun&#93;_&#91;DryFire|Equip|Reload|Melee&#93;_Additive
				* AM_MM_Generic_Unequip
					* MM_Pistol_Equip_Additive
				* AM_MM_Rifle_GrenadeToss
					* MM_Rifle_GrenadeToss_Additive
				* 要約すると、各種武器の装備、リロード、近接攻撃、空打ち、及びグレネードの投擲用のアニメーションです。
			* パラメータ `Alpha` には [UpperbodyDynamicAdditiveWeight] を設定します。
		2. ポーズキャッシュ `Locomotion` をスロット `UpperBody` のパラメータ `Source` で渡します。
			* スロット `UpperBody` を使用するアニメーションシーケンスは以下のとおりです。
				* AM_MM_&#91;Pistol|Rifle|Shotgun&#93;_&#91;DryFire|Equip|Reload|Melee&#93;
					* MM_&#91;Pistol|Rifle|Shotgun&#93;_&#91;DryFire|Equip|Reload|Melee&#93;
				* AM_MM_Generic_Unequip
					* MM_Pistol_Equip
				* AM_MM_Rifle_GrenadeToss
					* MM_Rifle_GrenadeToss
				* DropBomb_Montage
					* MM_Rifle_GrenadeToss
				* 要約すると、各種武器の装備、リロード、近接攻撃、空打ち、及びグレネードの当適用にアニメーションです。
		3. 1 の出力 / 2 の出力 をノード `Layered blend per bone`  のパラメータ `Base Pose` / `Blend Pose 0` でそれぞれ渡し、ブレンドします。
			* パラメータ `Blend Weights 0` は常に 1.0 を設定しています。
			* パラメータ `Blend Mode` は `Blend Mask` を設定しています。
			* パラメータ `Blend Masks` は `UpperBodyLowerBodySplitMask` を設定します。
				* `UpperBodyLowerBodySplitMask` は上半身を見るためのマスクです。
				* 上半身はボーン `spine_01` で 0.2 で、末端に行くほど 1.0 になります。
				* 下半身はボーン `thigh_l` / `thigh_r` から先が全て 0.0 となります。
		4. 3 の出力をスロット `FullBodyAdditivePreAim` のパラメータ `Source` で渡し、出力をポーズキャッシュ `UpperbodyLowerbodySplit` に設定します。
			* スロット `FullBodyAdditivePreAim` を使用するアニメーションシーケンスは以下のとおりです。
				* AM_MM_&#91;Pistol|Rifle|Shotgun&#93;_Fire
					* MM_&#91;Pistol|Rifle|Shotgun&#93;_Fire
				* 要約すると、各種武器の発砲用アニメーションです。
			* ポーズキャッシュ `UpperbodyLowerbodySplit` はノード `Output Pose` の大本に使われます。
				* 移動に関する下半身と各種武器の基本的なアクションに関する上半身のアニメーションがブレンドされた状態になっています。
	* ノード `Output Pose` まで繋がる部分
		1. ポーズキャッシュ `UpperbodyLowerbodySplit` をノード [FullBody_Aiming] のパラメータ `Pre Aim Pose` で渡します。
			* 上半身のエイムに関するアニメーションがブレンドされます。
			* [FullBody_Aiming] について詳しくは [ABP_ItemAnimLayersBase::FullBody_Aiming] を参照してください。
		2. 1 の出力をスロット `AdditiveHitReact` のパラメータ `Source` で渡します。
			* スロット `AdditiveHitReact` を使用するアニメーションシーケンスは以下のとおりです。
				* AM_MM_HitReact_&#91;Back|Front|Left|Right&#93;_&#91;Lgt|Med|Hvy&#93;&#95;&#91;01|02|03|04&#93;
					* MM_HitReact_&#91;Back|Front|Left|Right&#93;_&#91;Lgt|Med|Hvy&#93;&#95;&#91;01|02|03|04&#93;
				* 要約すると、被ダメージ用アニメーションです。
		3. 2 の出力 / ノード [FullBodyAdditives] の出力をそれぞれノード `ApplyAdditive()` のパラメータ `Base` / `Additive` でそれぞれ渡し、加算します。
			* [FullBodyAdditives] について詳しくは [ABP_ItemAnimLayersBase::FullBodyAdditives] を参照してください。
				* 使用するアニメーションシーケンスは以下のとおりです。
					* MM_&#91;Unarmed|Pistol|Rifle&#93;_Jump_RecoveryAdditive
				* 要約すると、着地後の復帰用アニメーションです。
			* パラメータ `Alpha` は 0.65 固定となっています。
		4. 3 の出力をスロット `FullBody` のパラメータ `Source` で渡します。
			* スロット `FullBody` を使用するアニメーションシーケンスは以下のとおりです。
				* AM_MF_Emote_FingerGuns
					* MF_Emote_FingerGuns
				* AM_MM_Dash_&#91;Backward|Forward|Left|Right&#93;
					* MM_Dash_&#91;Backward|Forward|Left|Right&#93;
				* AM_MM_Death_&#91;Back|Front|Left|Right&#93;&#91;_01|_02|_03&#93;
					* MM_Death_&#91;Back|Front|Left|Right&#93;&#91;_01|_02|_03&#93;
				* AM_MM_Pistol_Spawn
			* 全身を使うワンショット用アニメーションです。
		4. 4 の出力をノード `Inertialization` のパラメータ `Source` で渡します。
			* これは `Inertialization` (慣性化) を使う際に必要なノードです。
				* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > Blend ノード > Inertialization]
			* `Inertialization` は以下で使用しています。
				* [LocomotionSM] 内の以下のルール
					* [Start to Cycle (rule)]
					* [Pivot to Cycle (rule)]
					* [Stop to Idle (rule)]
				* [ABP_ItemAnimLayersBase::IdleSM] 内の以下のルール
					* [ABP_ItemAnimLayersBase::TurnInPlaceRecovery to Idle (rule)]
					* [ABP_ItemAnimLayersBase::WantsTurnInPlace (rule)]
					* [ABP_ItemAnimLayersBase::TurnInPlaceRotation to TurnInPlaceRecovery (rule)]
				* [ABP_ItemAnimLayersBase::IdleStance] 内の以下のルール
					* [ABP_ItemAnimLayersBase::Idle to StanceTransition (rule)]
					* [ABP_ItemAnimLayersBase::StanceTransition to Idle (rule)]
				* [ABP_ItemAnimLayersBase::PivotSM] 内の以下のルール
					* [ABP_ItemAnimLayersBase::WantsToRePivit (rule)]
TODO このへんから

### LocomotionSM

* Tour コメント
	* [Comment_AnimBP_Tour.Ja::4]
* ノード関数の使用状況
	| ノード          | 種別      | ノード関数名                     |
	|-----------------|-----------|----------------------------------|
	| [LocomotionSM]  | On Update | [UpdateLocomotionStateMachine()] |
* 構成要素
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
		* [EndInAir (conduit rule)]
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
		* [FallLand to EndInAir (rule)]
		* [JumpFallInterruptSources to EndInAir (rule)]
		* [EndInAir to CycleAlias (rule)]
		* [EndInAir to IdleAlias (rule)]
* State に関して
	* ノード関数の使用状況
		| ノード          | 種別               | ノード関数名         |
		|-----------------|--------------------|----------------------|
		| [Idle (state)]  | On Update          | [UpdateIdleState()]  |
		| [Start (state)] | On Become Relevant | [SetUpStartState()]  |
		| [Start (state)] | On Update          | [UpdateStartState()] |
		| [Stop (state)]  | On Update          | [UpdateStopState()]  |
		| [Pivot (state)] | On Become Relevant | [SetUpPivotState()]  |
		| [Pivot (state)] | On Update          | [UpdatePivotState()] |
	* ブレンドスペースの使用状況
		| 名前            | 利用しているブレンドスペース |
		|-----------------|------------------------------|
		| [Start (state)] | BS_MM_Rifle_Jog_Leans        |
		| [Cycle (state)] | BS_MM_Rifle_Jog_Leans        |
		| [Pivot (state)] | BS_MM_Rifle_Jog_Leans        |
	* その他特記事項
		* [Start (state)]
			* [FullBody_StartState] を利用しており、 Tag には `StartLayerNode` と設定してあります。
			* これにより Start ノードへの参照が取得できるようにしています。
			* 参照の取得は [UpdateLocomotionStateMachine()] にて行っています。
* State Alias に関して
	* 一覧と主な設定
		| 名前                       | 用途                                                  | 含んでいる state                                                                                                 |
		|----------------------------|-------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
		| [PivotSources]             | [Pivot (state)] に移行できるステート群                | [Start (state)]<br>[Cycle (state)]                                                                               |
		| [JumpSources]              | [JumpSelector (conduit rule)] に移行できるステート群  | [Idle (state)]<br>[Start (state)]<br>[Cycle (state)]<br>[Stop (state)]<br>[Pivot (state)]                        |
		| [JumpFallInterruptSources] | [EndInAir (conduit rule)] に移行できるステート群      | [JumpStart (state)]<br>[JumpStartLoop (state)]<br>[JumpApex (state)]<br>[FallLoop (state)]<br>[FallLand (state)] |
		| [CycleAlias]               | [Cycle (state)] のエイリアス                          | [Cycle (state)]                                                                                                  |
		| [IdleAlias]                | [Idle (state)] のエイリアス                           | [Idle (state)]                                                                                                   |
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
		| 名前                          | 遷移元                     | 遷移先                                      |
		|-------------------------------|----------------------------|---------------------------------------------|
		| [JumpSelector (conduit rule)] | [JumpSources]              | [JumpStart (state)]<br>[JumpApex (state)]   |
		| [EndInAir (conduit rule)]     | [JumpFallInterruptSources] | [CycleAlias]<br>[IdleAlias]                 |
* Transition Rule Sharing に関して
	* 一覧と主な設定
		| 名前                     | 用途                                                | 遷移元                                                                                       |
		|--------------------------|-----------------------------------------------------|----------------------------------------------------------------------------------------------|
		| [StopRule (rule)]        | [Stop (state)] への遷移ルール                       | [Start (state)]<br>[Cycle (state)]                                                           |
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
		* `Blend Logic` について
			* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > ステートマシン > 遷移ルール >  遷移ブレンドのタイプ]
			* `Stamdard Blemd` が規定値で、 `Inertialization` (慣性化) が数か所指定されています。具体的には以下の通り。
				* [Start to Cycle (rule)] の Priority.1
				* [Stop to Idle (rule)] の Priority.1 と 2
				* [Pivot to Cycle (rule)] の Priority.1
			* `Inertialization` (慣性化) について
				* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > Blend ノード > Inertialization]


#### Idle (state)

* 立ち止まっている時のステートです。

#### Start (state)

* 移動開始直後のステートです。
* [FullBody_StartState] ノードに `StartLayerNode` というタグ名を設置しています。
* このタグ名は [UpdateLocomotionStateMachine()] で利用されています。

#### Cycle (state)

* 移動中のステートです。

#### Stop (state)

* 移動を停止する時のステートです。

#### Pivot (state)

* 方向転換時のステートです。

#### JumpStart (state)

* ジャンプ開始時のステートです。

#### JumpStartLoop (state)

* ジャンプしてから頂点付近に至るまでのステートです。

#### JumpApex (state)

* ジャンプの頂点付近のステートです。

#### FallLoop (state)

* 落下時のステートです。

#### FallLand (state)

* 着地付近のステートです。

#### PivotSources

* Pivot に遷移可能なステート群を示すステートエイリアスです。

#### JumpSources

* Jump に遷移可能なステート群を示すステートエイリアスです。

#### JumpFallInterruptSources

* 落下を中断して地上のステートに遷移可能なステート群を示すステートエイリアスです。

#### CycleAlias

* [Cycle (state)] に遷移するためのステートエイリアスです。

#### IdleAlias

* [Idle (state)] に遷移するためのステートエイリアスです。

#### JumpSelector (conduit rule)

* ジャンプか落下か分岐するためのコンジットルールです。

#### EndInAir (conduit rule)

* 立ち止まるか移動中か分岐するためのコンジットルールです。

#### Idle to Start (rule)

TODO: ルール全般、コード化して、何を意図しているかの説明を書く。

* 参照する変数/関数
	* Priority.1
		* [HasAcceleration]
		* [GameplayTag_IsMelee]
		* [HasVelocity]

#### Start to Cycle (rule)

* 参照する変数/関数
	* Priority.1
		* [RootYawOffset]
	* Priority.1
		* [LinkedLayerChanged]
		* `Blend Logic` に `Inertialization` を指定している。
	* Priority.2
		* Automatic Rule Based on Sequence Player in State を true にしている
	* Priority.3
		* [StartDirection]
		* [LocalVelocityDirection]
		* [CrouchStateChange]
		* [ADSStateChanged]
		* [DisplacementSpeed]
		* [UAnimInstance::GetInstanceCurrentStateElapsedTime()]

#### StopRule (rule)

* 参照する変数/関数
	* Priority.1
		* [HasAcceleration]
		* [GameplayTag_IsMelee]
		* [HasVelocity]

#### Stop to Idle (rule)

* 参照する変数/関数
	* Priority.1
		* [LinkedLayerChanged]
		* `Blend Logic` に `Inertialization` を指定している。
	* Priority.2
		* [CrouchStateChange]
		* [ADSStateChanged]
		* `Blend Logic` に `Inertialization` を指定している。
	* Priority.3
		* Automatic Rule Based on Sequence Player in State を true にしている

#### Stop to Start (rule)

* 参照する変数/関数
	* Priority.1
		* [HasAcceleration]

#### PivotSources to Pivot (rule)

* 参照する変数/関数
	* Priority.1
		* [LocalVelocity2D]
		* [LocalAcceleration2D]
		* [IsRunningIntoWall]
		* XY 平面での移動と加速飲む気が反対かつ壁の中に入っていない場合は true

#### Pivot to Cycle (rule)

* 参照する変数/関数
	* Priority.1
		* [LinkedLayerChanged]
		* `Blend Logic` に `Inertialization` を指定している。
	* Priority.2
		* [UAnimInstance::WasAnimNotifyStateActiveInSourceState()]
	* Priority.3
		* [CrouchStateChange]
		* [ADSStateChanged]
		* [IsMovingPerpendicularToInitialPivot()]
		* [LastPivotTime]

#### Pivot to Stop (rule)

* 参照する変数/関数
	* Priority.2
		* [HasAcceleration]

#### JumpSources to JumpSelector (rule)

* 参照する変数/関数
	* Priority は conduit への遷移なのでありません。
	* Can Enter Transition を true にしている

#### JumpSelector to JumpStart (rule)

* 参照する変数/関数
	* Priority.1
		* [IsJumping]

#### JumpStart to JumpStartLoop (rule)

* 参照する変数/関数
	* Priority.1
		* Automatic Rule Based on Sequence Player in State を true にしている

#### JumpStartLoop to JumpApex (rule)

* 参照する変数/関数
	* Priority.1
		* [TimeToJumpApex]

#### JumpSelector to JumpApex (rule)

* 参照する変数/関数
	* Priority.1
		* [IsFalling]

#### JumpApex to FallLoop (rule)

* 参照する変数/関数
	* Priority.1
		* Automatic Rule Based on Sequence Player in State を true にしている

#### FallLoop to FallLand (rule)

* 参照する変数/関数
	* Priority.1
		* [ULyraAnimInstance::GroundDistance]

#### FallLand to EndInAir (rule)

* 参照する変数/関数
	* Priority は conduit への遷移なのでありません。
	* Can Enter Transition を true にしている

#### JumpFallInterruptSources to EndInAir (rule)

* 参照する変数/関数
	* Priority は conduit への遷移なのでありません。
	* Can Enter Transition を [IsOnGround] にしている

#### EndInAir to CycleAlias (rule)

* 参照する変数/関数
	* Priority.1
		* [HasAcceleration]

#### EndInAir to IdleAlias (rule)

* 参照する変数/関数
	* Priority.2
		* Can Enter Transition を true にしている

# ANIMATION LAYERS

## Item Anim Layers

* 概要
	* すべて空の状態です。
	* すべて [ABP_ItemAnimLayersBase] で実装されています。
* 呼び出し元
	| 名前                          | 呼び出し元              |
	|-------------------------------|-------------------------|
	| [FullBodyAdditives]           | [AnimGraph]             |
	| [FullBody_IdleState]          | [Idle (state)]          |
	| [FullBody_StartState]         | [Start (state)]         |
	| [FullBody_CycleState]         | [Cycle (state)]         |
	| [FullBody_StopState]          | [Stop (state)]          |
	| [FullBody_PivotState]         | [Pivot (state)]         |
	| [FullBody_Aiming]             | [AnimGraph]             |
	| [FullBody_JumpStartState]     | [JumpStart (state)]     |
	| [FullBody_JumpApexState]      | [JumpApex (state)]      |
	| [FullBody_FallLandState]      | [FallLand (state)]      |
	| [FullBody_FallLoopState]      | [FallLoop (state)]      |
	| [FullBody_JumpStartLoopState] | [JumpStartLoop (state)] |
	| [FullBody_SkeletalControls]   | [AnimGraph]             |
	| [LeftHandPose_OverrideState]  | [AnimGraph]             |

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

* [FullBody_IdleState] 内の `Output Animation Pose` ノードの On Update ノード関数です。
* [TurnYawCurveValue] / [RootYawOffsetMode] などを更新し、 [ProcessTurnYawCurve()] を呼び出します。

### SetUpStartState()

* [FullBody_StartState] 内の `Output Animation Pose` ノードの On Become Relevant ノード関数です。
* [LocalVelocityDirection] の値を [StartDirection] に設定しています。
	* Start ステート開始時に Actor から見た移動方向を [StartDirection] に設定するための関数です。

### UpdateStartState()

* [FullBody_StartState] 内の `Output Animation Pose` ノードの On Update ノード関数です。
* ステートが Blending Out でない場合は [RootYawOffsetMode] の値を [AnimEnum_RootYawOffsetMode::Hold] に設定します。
	* Start ステートにいる間、 [UpdateRootYawOffset()] で行われるヨーオフセットの更新が行われないように [RootYawOffsetMode] を設定するための関数です。

### UpdateStopState()

* [FullBody_StopState] 内の `Output Animation Pose` ノードの On Update ノード関数です。
* ステートが Blending Out でない場合は [RootYawOffsetMode] の値を [AnimEnum_RootYawOffsetMode::Accumulate] に設定します。
	* Stop ステートにいる間、 [UpdateRootYawOffset()] で行われるヨーオフセットの更新が行われるように [RootYawOffsetMode] を設定するための関数です。

### SetUpPivotState()

* [FullBody_PivotState] 内の `Output Animation Pose` ノードの On Become Relevant ノード関数です。
* [LocalVelocityDirection] の値を [PivotInitialDirection] に設定している。
	* Pivot ステート開始時に Actor から見た移動方向を [PivotInitialDirection] に設定するための関数です。

### UpdatePivotState()

* [FullBody_PivotState] 内の `Output Animation Pose` ノードの On Update ノード関数です。
* [LastPivotTime] が 0 より大きい場合は DeltaTime を減じている。
	* Pivot に必要な時間が経過したかを判定する変数を更新するための関数です。

### UpdateLocomotionStateMachine()

* コメント
	> We're checking to see if the Start state's layer node linked anim instance has changed.   
	> We don't need to check for other nodes because they're all on the same group and therefore share the same anim instance.  
	> 
	> ----
	> Start ステートのレイヤーノードがリンクしているアニメーションインスタンスが変更されたかどうかをチェックしています。  
	> 他のノードはすべて同じグループであり、同じアニメーションインスタンスを共有しているので、チェックする必要はありません。  
* [AnimGraph] 内の [LocomotionSM] ノードの On Update ノード関数です。
* `StartLayerNode` というタグ名を利用して、 [Start (state)] の [FullBody_StartState] の `FAnimNodeReference` を取得しています。
* `FAnimNodeReference` は `ULinkedAnimGraphLibrary::ConvertToLinkedAnimGraph()` を使用して `FLinkedAnimGraphReference` を取得できます。
* `FLinkedAnimGraphReference` は `ULinkedAnimGraphLibrary::GetLinkedAnimInstance()` を使用して [UAnimInstance] を取得できます。
* 取得した [UAnimInstance] は [LastLinkedLayer] に設定しておき、直前のフレームと異なるかを [LinkedLayerChanged] に設定する際に利用しています。


## Helper Functions

### SelectCardinalDirectionFromAngle()

* 概要
	* 引数を元に、 [AnimEnum_CardinalDirection] を返します。
* 引数
	* `Angle`: 向いている角度（正面を 0 、右を正、背面を 180 とする）
	* `DeadZone`: 判定の遊び値（現在の向きを考慮する場合、向きが変わったかどうかの判定をゆるくするための角度）
	* `CurrentDirection`: 現在の向き
	* `UseCurrentDirection`: 現在の向きを考慮するかどうか
* 呼び出し元は以下の通り。
	* [UpdateVelocityData()]
		* [LocalVelocityDirectionAngleWithOffset] を元に [LocalVelocityDirection] を算出するために利用。
		* [LocalVelocityDirectionAngle] を元に [LocalVelocityDirectionNoOffset] を算出するために利用。
	* [UpdateAccelerationData()]
		* [PivotDirection2D] を元に [CardinalDirectionFromAcceleration] を算出するために利用。

### GetOppositeCardinalDirection()

* 概要
	* 引数で [AnimEnum_CardinalDirection] を受け取り、反対向きの [AnimEnum_CardinalDirection] を返します。
* 呼び出し元
	* [UpdateAccelerationData()]
		* [PivotDirection2D] の反対方向 を算出するために利用。

### IsMovingPerpendicularToInitialPivot()

* コメント
	> We stay in a pivot when pivoting along a line (e.g. triggering a left-right pivot while playing a right-left pivot), but break out if the character makes a perpendicular change in direction.  
	> 
	> ----
	> 線に沿ったピボット（例：右から左のピボットをしながら左から右のピボットを誘発する）の時はピボットに留まり、キャラクターが垂直に方向転換する場合はブレイクアウトします。  
* 概要
	* Pivot ステート開始時と現在の移動方向が垂直ならば true を返します。
	* [PivotInitialDirection] / [LocalVelocityDirection] を元に Pivot ステート開始時と現在の移動方向を比較し、垂直方向になっていたら true を返します。
* 呼び出し元
	* [Pivot to Cycle (rule)]
		* Pivot が行われたかの判定に利用。


## Blueprint Thread Safe Update Functions

### UpdateLocationData()

* カテゴリ [Location Data] に属する全ての変数を更新します。具体的には以下の変数です。
	* [DisplacementSinceLastUpdate]
	* [WorldLocation]
	* [DisplacementSpeed]


### UpdateRotationData()

* カテゴリ [Rotation Data] に属する全ての変数を更新します。具体的には以下の変数です。
	* [WorldRotation]
	* [YawDeltaSinceLastUpdate]
	* [AdditiveLeanAngle]
	* [YawDeltaSpeed]

### UpdateVelocityData()

* カテゴリ [Velocity Data] に属する全ての変数を更新します。具体的には以下の変数です。
	* [WorldVelocity]
	* [LocalVelocity2D]
	* [LocalVelocityDirectionAngle]
	* [LocalVelocityDirectionAngleWithOffset]
	* [LocalVelocityDirection]
	* [LocalVelocityDirectionNoOffset]
	* [HasVelocity]

### UpdateAccelerationData()

* コメント
   > Calculate a cardinal direction from acceleration to be used for pivots.  
   > Acceleration communicates player intent better for that purpose than velocity does.  
   > 
   > ----
   > 加速度からピボットに使用するカーディナルディレクションを算出する。  
   > 加速度は、速度よりもプレイヤーの意図がより伝わりやすい。  
* カテゴリ [Acceleration Data] に属する全ての変数を更新します。具体的には以下の変数です。
	* [LocalAcceleration2D]
	* [HasAcceleration]
	* [PivotDirection2D]
* また、それ以外のカテゴリの変数も更新します。具体的には以下の変数です。
	| カテゴリ                | 変数名                                  |
	|-------------------------|-----------------------------------------|
	| [Locomotion SM Data]    | [CardinalDirectionFromAcceleration]     |

### UpdateCharacterStateData()

* カテゴリ [Character State Data] に属する一部の変数を更新します。具体的には以下の変数です。
	* [IsOnGround]
	* [IsCrouching]
	* [CrouchStateChange]
	* [ADSStateChanged]
	* [WasADSLastUpdate]
	* [TimeSinceFiredWeapon]
	* [IsJumping]
	* [IsFalling]
* 以下の変数はカテゴリ [Character State Data] に属するが、この関数では更新しません。
	* [TimeToJumpApex]
		* [UpdateJumpFallData()] で更新を行う。
	* [IsRunningIntoWall]
		* [UpdateWallDetectionHeuristic()] で更新を行う。

### UpdateBlendWeightData()

* カテゴリ [Blend Weight Data] に属する全ての変数を更新します。具体的には以下の変数です。
	* [UpperbodyDynamicAdditiveWeight]

### UpdateAimingData()

* カテゴリ [Aiming Data] に属する一部の変数を更新します。具体的には以下の変数です。
	* [AimPitch]
* 以下の変数はカテゴリ [Aiming Data] に属するが、この関数では更新しません。
	* [AimYaw]
		* [SetRootYawOffset()] で更新を行う。

### UpdateJumpFallData()

* カテゴリ `Jump Fall Data` は存在しません。
* それ以外のカテゴリの変数を更新します。具体的には以下の変数です。
	| カテゴリ                | 変数名                                  |
	|-------------------------|-----------------------------------------|
	| [Character State Data]  | [TimeToJumpApex]                        |

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
* カテゴリ `Wall Detection Heuristic` は存在しません。
* それ以外のカテゴリの変数を更新します。具体的には以下の変数です。
	| カテゴリ                | 変数名                                  |
	|-------------------------|-----------------------------------------|
	| [Character State Data]  | [IsRunningIntoWall]                     |

## Turn In Place{FUNCTIONS}

### SetRootYawOffset()

* Tour コメント
	* [Comment_TourInPlace.Ja::3]
	* [Comment_TourInPlace.Ja::4]
* 以下の変数の更新を行います。
	| カテゴリ                   | 変数名                                  |
	|----------------------------|-----------------------------------------|
	| [Aiming Data]              | [AimYaw]                                |
	| [Turn In Place{VALIABLES}] | [RootYawOffset]                         |
* 概要
	* 渡されたパラメータ `InRootYawOffset` を [RootYawOffset] に設定し、 -1 を掛けたものを [AimYaw] に設定する。
	* ただし、 [bEnableRootYawOffset] が false の場合はいずれも 0.0 に設定する。
	* また、設定する値には上限があり、設定前に上限値でクランプを行う。
	* 上限値はしゃがんでいるとき/そうでないときで別の値 [RootYawOffsetAngleClampCrouched] / [RootYawOffsetAngleClamp] を持つ。
	* しゃがんでいるかは [IsCrouching] で判定する。
	* 2 回 [SetRootYawOffset()] を呼び出すケースについて
		* Idle State にいる場合、 [ProcessTurnYawCurve()] 経由と [UpdateRootYawOffset()] 経由で同一フレームに 2 回呼び出される。
		* 基本的に [SetRootYawOffset()] は新しく設定したい値をパラメータ `InRootYawOffset` に設定する
		* それぞれ別の由来の変化値の反映のため、 2 回呼び出すことは特に問題ない。
* 呼び出し元
	* [ProcessTurnYawCurve()]
		* アニメーションカーブ `RemainingTurnYaw` / `TurnYawWeight` 由来の変化を反映するために利用。
	* [UpdateRootYawOffset()]
		* (Actor Rotation を元にした) [YawDeltaSinceLastUpdate] 由来の変化を反映するために利用。

### ProcessTurnYawCurve()

* Tour コメント
	* [Comment_TourInPlace.Ja::5]
* コメント：アニメーションカーブ `RemainingTurnYaw` / `TurnYawWeight` を元に [TurnYawCurveValue] を更新する部分について
	> The `TurnYawWeight` curve is set to 1 in TurnInPlace animations, so its current value from `GetCurveValue()` will be the current weight of the TurnInPlace animation.   
	> We can use this to "unweight" the TurnInPlace animation to get the full `RemainingTurnYaw` curve value.  
	> 
	> ----
	> TurnInPlace アニメーションでは `TurnYawWeight` カーブが 1 に設定されているため、 `GetCurveValue()` から得られる現在の値は、 TurnInPlace アニメーションの現在のウェイトとなります。  
	> これを利用して、 TurnInPlace アニメーションのウェイトを "解除" し、 `RemainingTurnYaw` カーブの値を完全に取得することができます。  
	* アニメーションカーブ `RemainingTurnYaw` / `TurnYawWeight` について詳しくは [TurnYawAnimModifier] を参照。
	* `TurnYawWeight` は初期値 1.0 で、 root の Yaw が最終値と同値に至ると 0.0 となる。
	* `TurnYawWeight` で除算はしているが、 1.0 以下の値を除算することになる為、 0.0 に近づくほど `RemainingTurnYaw` より大きな値が [TurnYawCurveValue] に設定される。
		> Memo: 乗算して徐々に影響を減らすほうが正しいのでは？要確認。
* コメント：直前のフレームの [TurnYawCurveValue] が 0.0 ではないかの分岐について
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
* 関数内および [SetRootYawOffset()] の呼び出しにより、以下の変数の更新を行います。
	| カテゴリ                   | 変数名                                  |
	|----------------------------|-----------------------------------------|
	| [Aiming Data]              | [AimYaw]                                |
	| [Turn In Place{VALIABLES}] | [RootYawOffset]                         |
	| [Turn In Place{VALIABLES}] | [TurnYawCurveValue]                     |
* 概要
	* アニメーションカーブ `RemainingTurnYaw` / `TurnYawWeight` を元に [RootYawOffset] の値を更新します。
	* [RootYawOffset] は更新の際にクランプ処理や [AimYaw] の更新も必要になるため [SetRootYawOffset()] を呼び出すことで更新を行います。
* 呼び出し元
	* [UpdateIdleState()]
		* State Blending Out 中でない場合にアニメーションに設定されている Yaw の値を反映するために利用。

### UpdateRootYawOffset()

* Tour コメント
	* [Comment_TourInPlace.Ja::2]
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
	* 補足： [RootYawOffsetMode]
		* [AnimEnum_RootYawOffsetMode::Accumulate]
			* 足が動いていないとき（アイドル時など）にこの値に設定します。
			* 具体的には [UpdateIdleState()] / [UpdateStopState()] にて、 State の Blending Out 中でない場合にこの値に設定しています。
			* この値の場合、 [SetRootYawOffset()] のパラメータ `InRootYawOffset` には [RootYawOffset] - [YawDeltaSinceLastUpdate] を渡します。
				* Actor の Rotation の Delta 値を引いた値をそのまま使用するということです。
				* つまり、ユーザーの入力により変化した Rotation をそのまま [RootYawOffset] / [AimYaw] に反映させる、ということです。
		* [AnimEnum_RootYawOffsetMode::BlendOut]
			* 本関数 [UpdateRootYawOffset()] の最後に設定している初期値で、ステートで設定していない場合はこの値となります。
			* この値の場合、 [SetRootYawOffset()] のパラメータ `InRootYawOffset` には `FloatSpringInterp()` の計算結果を渡します。
				* `FloatSpringInterp()` は `Current` に [RootYawOffset] 、 `Target` に 0.0 を指定しています。
				* つまり、徐々に 0.0 に Blend Out する値を [RootYawOffset] / [AimYaw] に反映させる、ということです。
		* [AnimEnum_RootYawOffsetMode::Hold]
			* [AnimEnum_RootYawOffsetMode::Accumulate] / [AnimEnum_RootYawOffsetMode::BlendOut] のいずれの処理も行いたくない場合は、この値を設定します。
			* 具体的には [UpdateStartState()] にて、 State の Blending Out 中でない場合にこの値に設定しています。
			* この値の場合、 [SetRootYawOffset()] の呼び出しを行わず、 [RootYawOffset] / [AimYaw] の更新が行われません。
				* つまり、 Start State 中は [RootYawOffset] / [AimYaw] が変化しないということです。
* 関数内および [SetRootYawOffset()] の呼び出しにより、以下の変数の更新を行います。
	| カテゴリ                   | 変数名                                  |
	|----------------------------|-----------------------------------------|
	| [Aiming Data]              | [AimYaw]                                |
	| [Turn In Place{VALIABLES}] | [RootYawOffset]                         |
	| [Turn In Place{VALIABLES}] | [RootYawOffsetMode]                     |
* 概要
	* [RootYawOffsetMode] に従って [SetRootYawOffset()] を呼びだし、 [RootYawOffset] / [AimYaw] を更新します。
	* 最後に [RootYawOffsetMode] を [AnimEnum_RootYawOffsetMode::BlendOut] に再設定します。
		* 理由については前述のコメントのとおりです。

## Default{FUNCTIONS}

### BlueprintThreadSafeUpdateAnimation()

* ヘッダファイルコメント
	> Executed when the Animation Blueprint is updated on a worker thread, just prior to graph update
	> 
	> ----
	> ワーカースレッドで Animation Blueprint が更新されたとき、グラフ更新の直前に実行されます。
* Tour コメント
	* [Comment_AnimBP_Tour.Ja::2]
* 参考
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > ブループリントのスレッドセーフな更新アニメーション]
		> ## スレッド セーフな更新アニメーション
		> 
		> アニメーション ブループリントのパフォーマンスを向上させるには、Update Animation イベントのスレッドセーフな代替手段として  
		> Blueprint Thread Safe Update Animation を使用することができます。  
		> この代替手段は、ブループリントに追加するためにオーバーライドする必要のある関数です。  
		> Event Graph Update Animation イベントは常にゲーム スレッドで実行されるため、  
		> マルチスレッドを活用して全体のフレームレートを向上させることができません。  
		> そのため、この代替手段が役立ちます。  
		> 
		> これを実行するには、My Blueprint (マイ ブループリント) パネルの Functions カテゴリで Override (オーバーライド) ドロップダウン メニューをクリックし、  
		> Blueprint Thread Safe Update Animation を選択します。
		> これで関数のリストに追加されました。これを開くと、関数のエントリ ポイントと、  
		> EventGraph Update Animation ノードの Delta Time X ピンと類似した Delta Time ピンが表示されます。  
		> これで、イベント グラフで行う場合と同じように、この関数で Update Animation ロジックを作成することができます。  
		> ただし、この関数は、ゲーム スレッドではなくワーカー スレッドで実行されます。
	* [Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p.156]
		> 全ての処理をワーカースレッドで Anim Node 関数, Property Access, 
		> BlueprintThreadsafeUpdateAnimation 関数 により 
		> Event Graph を空にし、（ほぼ）全ての処理をワーカースレッドで実行可能！ 
		> Lyra における AnimBP では、ゲームスレッドで動く Event Graph の実装は完全に空！
* 以下の関数を呼び出しています。
	* [UpdateLocationData()]
	* [UpdateRotationData()]
	* [UpdateVelocityData()]
	* [UpdateAccelerationData()]
	* [UpdateWallDetectionHeuristic()]
	* [UpdateCharacterStateData()]
	* [UpdateBlendWeightData()]
	* [UpdateRootYawOffset()]
	* [UpdateAimingData()]
	* [UpdateJumpFallData()]

### GetMovementComponent()

* 概要
	* ([BlueprintThreadSafeUpdateAnimation()] から呼ばれる) Update 系関数から呼び出される、 MovementComponent のプロパティのアクセスに利用する関数です。

### ShouldEnableControlRig()

* 概要
	* [AnimGraph] にてノード `ControlRig` のパラメータ `Enabled` に利用されます。
* 使用する変数
	* [UseFootPlacement]
* 使用するアニメーションカーブ
	* `DisableLegIK`
		* 例： `AM_MM_Dash_Forward` で足が浮いている間 0 より大きい値が設定される。
			> Memo: `AM_MM_Dash_Forward` には AnimationModifier が設定されていないので、おそらく手で付けられている。
* 実装概要
	* `DisableLegIK` の値が 0.0 以下かつ [UseFootPlacement] が false のときに true を返す。
	* つまり、足が浮いていて、 [UseFootPlacement] が false になっているとき、 `ControlRig` が enable となる。

# VALIABLES

## Rotation Data

* 概要
	* ここに分類されているのは Actor の Rotation を元に算出される値です。
	* このカテゴリの変数の更新は [UpdateRotationData()] で行われます。

### WorldRotation

* 型
	* Rotator
* 概要
	* Actor の Rotation です。
	* ワールド座標系の Vector をアクターのローカル座標系に変換するのに利用しています。
* 用途
	| 利用箇所											| 目的																		|
	|----												|----																		|
	| [UpdateRotationData()]							| 直前のフレームの値と比較し [YawDeltaSinceLastUpdate] の算出に利用			|
	| [UpdateVelocityData()]							| [LocalVelocity2D] / [LocalVelocityDirectionAngle] の算出に利用			|
	| [UpdateAccelerationData()]						| [LocalAcceleration2D] / [CardinalDirectionFromAcceleration] の算出に利用	|

### YawDeltaSinceLastUpdate

* 型
	* float
* 概要
	* Actor の Yaw の Delta 値で、 Actor の Rotation の Yaw から直前のフレームの値([WorldRotation] に設定している値)を引くことで求めます。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateRotationData()]						| [YawDeltaSpeed] の算出に利用												|
	| [UpdateRootYawOffset()]						| [RootYawOffset] の更新に利用												|

### AdditiveLeanAngle

* 型
	* float
* 概要
	* [YawDeltaSpeed] に *状態による係数* を掛けた値で、 `BS_MM_Rifle_Jog_Leans` の `LeanAngle` に利用します。
		> 係数は「しゃがみや ADS 状態」のときは 0.025　、それ以外「通常状態」のときは 0.0375 (1.5 倍)としています。
		> `BS_MM_Rifle_Jog_Leans` の `LeanAngle` は &#91;-20, 20&#93; が有効範囲となっています。
		> 各状態の時に最大の値 (20) となるのは以下の角速度を超えて動かした場合となります。
		> | 状態					| 角速度 &#91;rad / s&#93;	|							|
		> |----						|----						|----						|
		> | 通常状態				| 533 						| 秒間 1.5 周ほど			|
		> | はしゃがみや ADS 状態	| 800 						| 秒間 2.3 周ほど			|
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [Start (state)]								| `BS_MM_Rifle_Jog_Leans` の `LeanAngle` に利用								|
	| [Cycle (state)]								| 同上																		|
	| [Pivot (state)]								| 同上																		|

### YawDeltaSpeed

* 型
	* float
* 概要
	* Actor の Yaw の 角速度で、 [YawDeltaSinceLastUpdate] を Delta 時間で割ることで求めます。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateRotationData()]						| [AdditiveLeanAngle] の算出に利用											|

## Location Data

* 概要
	* ここに分類されているのは Actor の Location を元に算出される値です。
	* このカテゴリの変数の更新は [UpdateLocationData()] で行われます。

### WorldLocation

* 型
	*  Vector
* 概要
	* Actor の Location です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| [DisplacementSinceLastUpdate] の算出に利用								|

### DisplacementSinceLastUpdate

* 型
	* float
* 概要
	* [WorldLocation] の XY 平面での大きさです。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| [DisplacementSpeed] の算出に利用											|

### DisplacementSpeed

* 型
	*  float
* 概要
	* [DisplacementSinceLastUpdate] を `De;taTime` で割った、 XY 平面での速度です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [Start to Cycle (rule)]						| 速度が一定を超えているかの判定に利用										|

## Velocity Data

* 概要
	* ここに分類されているのは Pawn の Velocity を元に算出される値です。
	* このカテゴリの変数の更新は [UpdateLocationData()] で行われます。

### WorldVelocity

* 型
	* Vector
* 概要
	* Pawn の Velocity です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| ローカル変数 `WorldVelocity2D` の算出に利用								|
	| [UpdateCharacterStateData()]					| [IsJumping] / [IsFalling] の算出に利用									|
	| [UpdateJumpFallData()]						| [TimeToJumpApex] の算出に利用												|

### LocalVelocity2D

* 型
	* Vector
* 概要
	* [WorldVelocity] の XY 平面のベクトルと [WorldRotation] から算出した、アクターのローカル座標系での XY 平面の Velocity です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| ローカル変数 `WasMovingLastUpdate` の算出に利用							|
	|												| (`WasMovingLastUpdate` は直前のフレームに移動したかを示す)				|
	|												| [HasVelocity] の算出に利用												|
	| [UpdateWallDetectionHeuristic()]				| [IsRunningIntoWall] の算出に利用											|
	| [PivotSources to Pivot (rule)]				| [LocalVelocity2D] と [LocalAcceleration2D] が逆向きかを調べる際に利用		|

### LocalVelocityDirectionAngle

* 型
	* float
* 概要
	* [WorldVelocity] の XY 平面のベクトルと [WorldRotation] から算出した、 Actor の Forward 方向と移動方向のなす角度です。
	*  &#91;-180,180&#93; の値を取ります。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| [LocalVelocityDirectionNoOffset] の算出に利用								|
	|												| [LocalVelocityDirectionAngleWithOffset] の算出に利用						|

### LocalVelocityDirectionAngleWithOffset

* 型
	* float
* 概要
	* [LocalVelocityDirectionAngle] に [RootYawOffset] を減じた角度です。
	* つまり、 `Root Bone` の Forward 方向と移動方向のなす角度です。
		> この値は (`Turn In Place` によって Yaw が回転された)見た目上の正面方向と移動方向のなす角を示しています。
		> 例：移動方向が左に 45 度の方向で、 Yaw が右に 10 度回転した場合
		> [LocalVelocityDirectionAngle] - [RootYawOffset] = -45 - -10 = -35
		> となり、左に 35 度、となります。
		> この時以下のような状況となっています。
		> * `Turn In Place` の処理によって、 `Rotate Root Bone` の Yaw に -10 が設定されている。
		> 	* つまり Actor の Forward 方向から左に 10 度 `Root Bone` の Yaw が回転している。
		> * 左に 35 度というのは、 `Root Bone` の向きと移動方向のなす角、ということになります。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| [LocalVelocityDirection] の算出に利用										|

### LocalVelocityDirection

* 型
	* [AnimEnum_CardinalDirection]
* 概要
	* [LocalVelocityDirectionAngleWithOffset] から算出した、前後左右いずれかの値です。
	* つまり、 `Root Bone` の Forward 方向を前とする、移動方向の値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| [LocalVelocityDirection] の算出に利用										|
	| [SetUpStartState()]							| [StartDirection] ヘ値の複製に利用											|
	| [SetUpPivotState()]							| [PivotInitialDirection] ヘ値の複製に利用									|
	| [IsMovingPerpendicularToInitialPivot()]		| 戻り値の算出に利用														|
	| [Start to Cycle (rule)]						| [StartDirection] との比較に利用											|
	|												| Start ステートの初期 Direction と現在の Direction が異なるかの判定に利用	|

### LocalVelocityDirectionNoOffset

* 型
	* [AnimEnum_CardinalDirection]
* 概要
	* [LocalVelocityDirectionAngle] から算出した、前後左右いずれかの値です。
	* つまり、 Actor の Forward 方向を前とする、移動方向の値です。
	* このクラスでは設定だけで、参照は [ABP_ItemAnimLayersBase] で行われます。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| [LocalVelocityDirectionNoOffset] の算出に利用								|
	| [ABP_ItemAnimLayersBase::UpdateCycleAnim()]	| 使用するアニメーションシーケンスの決定に利用								|

### HasVelocity

* 型
	* bool
* 概要
	* [LocalVelocity2D] が 0 に近くないかの真偽値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [AnimGraph]									| `ControlRig` のパラメータ `IsMoving2D` に利用								|
	| [Idle to Start (rule)]						| トランジションの判定の一部で利用											|
	| [StopRule (rule)]								| トランジションの判定の一部で利用											|

## Acceleration Data

* 概要
	* ここに分類されているのは Pawn の MovementComponent の CurrentAcceleration を元に算出される値です。
	* このカテゴリの変数の更新は [UpdateAccelerationData()] で行われます。

### LocalAcceleration2D

* 型
	* Vector
* 概要
	* Pawn の MovementComponent の CurrentAcceleration から算出した、アクターのローカル座標系での XY  平面の Acceleration です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateAccelerationData()]					| [HasAcceleration] の算出に利用											|
	| [UpdateWallDetectionHeuristic()]				| [IsRunningIntoWall] の算出に利用											|
	| [PivotSources to Pivot (rule)]				| Velocity と Acceleration の向きが逆かを調べる際に利用						|

### HasAcceleration

* 型
	* bool
* 概要
	* [LocalAcceleration2D] が 0 に近くないかの真偽値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [Idle to Start (rule)]						| トランジションの判定の一部で利用											|
	| [StopRule (rule)]								| トランジションの判定の一部で利用											|
	| [Pivot to Stop (rule)]						| トランジションの判定の一部で利用											|
	| [Stop to Start (rule)]						| トランジションの判定の一部で利用											|
	| [EndInAir to CycleAlias (rule)]				| トランジションの判定の一部で利用											|

### PivotDirection2D

* 型
	* Vector
* 概要
	* [LocalAcceleration2D] と、直前のフレームの [PivotDirection2D] の値を 0.5 で lerp しノーマライズしたワールド座標系の Vector です。
	* つまり、直前のフレームと今回のフレームの加速度ベクトルの中間を向く単位ベクトルです。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateAccelerationData()]					| [CardinalDirectionFromAcceleration] の算出に利用							|

## Character State Data

* 概要
	* ここに分類されているのはキャラクターの状態を示す値です。
	* このカテゴリの変数の更新は [UpdateCharacterStateData()] で行われます。
		* ただし、以下の変数はカテゴリ [Character State Data] に属するが、この関数では更新しません。
			* [TimeToJumpApex]
			* [IsRunningIntoWall]

### IsOnGround

* 型
	* bool
* 概要
	* Pawn の MovementComponent の IsMovingOnGround です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateBlendWeightData()]						| [UpperbodyDynamicAdditiveWeight] の算出に利用								|
	| [FallLand to EndInAir (rule)]					| トランジションの判定の一部で利用											|
	| [JumpFallInterruptSources to EndInAir (rule)]	| トランジションの判定の一部で利用											|

### IsCrouching

* 型
	* bool
* 概要
	* Pawn の MovementComponent の IsCrouching です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateCharacterStateData()]					| [CrouchStateChange] / ローカル変数 `WasCrouchingLastUpdate` の算出に利用	|
	| [AnimGraph]									| `ControlRig` の `IsCrouching` に利用										|
	| [UpdateRotationData()]						| [AdditiveLeanAngle] の算出に利用											|
	| [SetRootYawOffset()]							| [RootYawOffset] の算出に利用												|

### CrouchStateChange

* 型
	* bool
* 概要
	* [IsCrouching] が直前のフレームから変わっているかの真偽値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [Start to Cycle (rule)]						| トランジションの判定の一部で利用											|
	| [Pivot to Cycle (rule)]						| トランジションの判定の一部で利用											|
	| [Stop to Idle (rule)]							| トランジションの判定の一部で利用											|

### ADSStateChanged

* 型
	* bool
* 概要
	* ADS の状態が直前のフレームから変わっているかの真偽値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [Start to Cycle (rule)]						| トランジションの判定の一部で利用											|
	| [Pivot to Cycle (rule)]						| トランジションの判定の一部で利用											|
	| [Stop to Idle (rule)]							| トランジションの判定の一部で利用											|

### WasADSLastUpdate

* 型
	* bool
* 概要
	* [GameplayTag_IsADS] の直前のフレームの値を参照するためのコピーです。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateCharacterStateData()]					| [ADSStateChanged] の算出に利用											|

### TimeSinceFiredWeapon

* 型
	* float
* 概要
	* [GameplayTag_IsFiring] が false になってからの時間です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateCharacterStateData()]					| [TimeSinceFiredWeapon] の算出に利用										|

### IsJumping

* 型
	* bool
* 概要
	* [WorldVelocity] の Z 値が 0 より小さいかの真偽値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateJumpFallData()]						| [TimeToJumpApex] の算出に利用												|
	| [JumpSelector to JumpStart (rule)]			| トランジションの判定の一部で利用											|
* 備考
	* [UpdateCharacterStateData()] で更新。
	* [WorldVelocity] の Z 成分より上昇中か下降中かを設定。
	* [IsJumping] / [IsFalling] の算出

### IsFalling

* 型
	* bool
* 概要
	* WorldVelocity の Z 値が 0 以上かの真偽値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [JumpSelector to JumpStart (rule)]			| トランジションの判定の一部で利用											|
* 備考
	* [UpdateCharacterStateData()] で更新。
	* [WorldVelocity] の Z 成分より上昇中か下降中かを設定。
	* [IsJumping] / [IsFalling] の算出

### TimeToJumpApex

* 型
	* float
* 概要
	* ジャンプの頂点までの時間です。
	* 更新は [UpdateJumpFallData()] で以下のように行います。
		* [IsJumping] でジャンプしているかを判定
			* ジャンプしていない場合は 0.0 を設定
			* ジャンプしている場合は [WorldVelocity] の Z 成分に重力加速度を割ることで算出
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [JumpStartLoop to JumpApex (rule)]			| トランジションの判定の一部で利用											|

### IsRunningIntoWall
* 型
	* bool
* 概要
	* 壁にめり込むように移動しようとしているかの真偽値です。
	* 更新は [UpdateWallDetectionHeuristic()] で以下のように行います。
		* 以下の 3 つの条件が真かを設定します。
			* [LocalAcceleration2D] の大きさが 0.1 より大きいか
				* 移動しようとしているか
			* [LocalVelocity2D] の大きさが 200 未満か
				* 速度が（移動しようとしている割に）低いかを調べている
			* [LocalAcceleration2D] と [LocalVelocity2D] の内積が &#91;-0.6,0.6&#93; の範囲か
				* 移動しようとしている向きと実際の移動方向の成す角がおおよそ 50 度以内かを調べている
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [PivotSources to Pivot (rule)]				| トランジションの判定の一部で利用											|


## Gameplay Tag Bindings

* 概要
	* このカテゴリの変数の更新は [ULyraAnimInstance::GameplayTagPropertyMap] の機能を利用して行われます。
	* [ULyraAnimInstance::GameplayTagPropertyMap] の設定は以下の通り。
		| 変数                      | GameplayTag                 | 付与を行う GameplayAbility                            |
		|----                       |----                         |----                                                   |
		| [GameplayTag_IsADS]       | `Event.Movement.ADS`        | `GA_ADS`                                              |
		| [GameplayTag_IsFiring]    | `Event.Movement.WeaponFire` | `GA_Weapon_Fire` とその派生クラス及び `GA_HealPickup` |
		| [GameplayTag_IsReloading] | `Event.Movement.Reload`     | `GA_WeaponReloadMagazine`                             |
		| [GameplayTag_IsDashing]   | `Event.Movement.Dash`       | `GA_Hero_Dash`                                        |
		| [GameplayTag_IsMelee]     | `Event.Movement.Melee`      | `GA_Melee`                                            |
		> * [GameplayTag_IsFiring] を付与する GameplayAbility クラスの継承関係
		> 	* `LyraGameplayAbility_RangeWepon`
		>		* `GA_HealPickUp`
		>		* `GA_Weapon_Fire`
		>			* `GA_Weapon_Fire_Pistol`
		>			* `GA_Weapon_Fire_Rifle_Auto`
		>			* `GA_Weapon_Fire_Shotgun`
		>			* `GA_WeaponNetShooter`
		> * つまり、全て `LyraGameplayAbility_RangeWepon` の派生クラスである。
		> * `LyraGameplayAbility_RangeWepon` について
		> 	* しかし、 `LyraGameplayAbility_RangeWepon` は c++ のクラスであり、汎用的に作られている。
		> 	* そのため、特定の GameplayTag の付与はしていない。
		> * `GA_Weapon_Fire` とその派生クラスについて
		>	* `GA_Weapon_Fire` で GameplayTag の付与の設定を行っている。
		>	* 派生クラスではその設定をそのまま利用している。

### GameplayTag_IsADS
### GameplayTag_IsFiring
### GameplayTag_IsReloading
### GameplayTag_IsDashing
### GameplayTag_IsMelee


## Locomotion SM Data

* 概要
	* [LocomotionSM] 内で読み書きされる変数です。

### StartDirection

* 型
	* [AnimEnum_CardinalDirection]
* 概要
	* [LocalVelocityDirection] のコピーです。
	* Start ステート開始時に呼び出される [SetUpStartState()] で設定されます。
* read
	* [Start to Cycle (rule)]
		* [LocalVelocityDirection] と比較することで、 Start ステート開始時から移動方向が変わっているかの判定に利用されます。
* write
	* [SetUpStartState()]

### PivotInitialDirection

* 型
	* [AnimEnum_CardinalDirection]
* 概要
	* [LocalVelocityDirection] のコピーです。
	* Pivot ステート開始時に呼び出される [SetUpPivotState()] で設定されます。
* read
	* [IsMovingPerpendicularToInitialPivot()]
		* [LocalVelocityDirection] と比較することで、 Pivot ステート開始時から移動方向が垂直方向に変わっているかの判定に利用されます。
* write
	* [SetUpPivotState()]

### LastPivotTime

* 型
	* float
* 概要
	* Pivot から Cycle に移る際に Pivot を行うのに十分な時間が経過したか判定するための時間計測用の変数です。
	* 値の初期化は派生クラス [ABP_ItemAnimLayersBase] でのみ行われています。
* read
	* [Pivot to Cycle (rule)]
* write
	* [UpdatePivotState()]
	* [ABP_ItemAnimLayersBase::SetUpPivotAnim()]

### CardinalDirectionFromAcceleration

* 型
	* [AnimEnum_CardinalDirection]
* 概要
	* [PivotDirection2D] から算出し、反対にした方向です。
	* つまり、直前のフレームと今回のフレームの加速度の向きの中間方向の逆向きを前後左右で表した値です。
	* このクラスでは設定のみで、利用は派生クラスでのみ行なわれています。
* read
	* [ABP_ItemAnimLayersBase::SetUpPivotAnim()]
		* [FullBody_PivotState] が返すアニメーションシーケンスの決定に利用します。
	* [ABP_ItemAnimLayersBase::UpdatePivotAnim()]
		* [FullBody_PivotState] が返すアニメーションシーケンスの決定に利用します。
* write
	* [UpdateAccelerationData()]

## Blend Weight Data

* 概要
	* モーションブレンドの係数です。
	* このカテゴリの変数の更新は [UpdateBlendWeightData()] で行われます。
	* ここに分類されているのは [UpperbodyDynamicAdditiveWeight] のみです。

### UpperbodyDynamicAdditiveWeight

* 型
	* float
* 概要
	* [AnimGraph] にてノード `ApplyAdditive()` のパラメータ `Alpha` に利用されます。
		* そこでは `Locomotion` のポーズキャッシュにスロット `UpperBodyAdditive` のアニメーションモンタージュをブレンドしています。
	* [IsOnGround] かつ [UAnimInstance::IsAnyMontagePlaying()] により値が決まります。
		* true の場合： 1.0
		* false の場合： 現在値から 0.0 に向けて `FInterpTo` した値
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateBlendWeightData()]						| [UpperbodyDynamicAdditiveWeight] の算出に利用								|
	| [AnimGraph]									| ノード `ApplyAdditive()` のパラメータ `Alpha` に利用						|

## Aiming Data

* 概要
	* ピットとヨーです。
	* このカテゴリの変数の更新は [UpdateAimingData()] で行われます。
		* ただし、以下の変数はカテゴリ [Aiming Data] に属するが、この関数では更新しません。
			* [AimYaw]

### AimPitch

* 型
	* float
* 概要
	* Owner の BaseAimRotation の Pitch の値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [AnimGraph]									| ノード [Fullbody_Aiming] のパラメータ `AimPitch` に利用					|

### AimYaw

* 型
	* float
* 概要
	* この変数の更新は [RootYawOffset] と連動するため [SetRootYawOffset()] で行われます。
	* 設定される値は [RootYawOffset] に -1 をかけた値となります。
	* [SetRootYawOffset()] の呼び出しは以下の 2 箇所から行われます。
		* [BlueprintThreadSafeUpdateAnimation()] > [UpdateRootYawOffset()] > [SetRootYawOffset()]
			* [YawDeltaSinceLastUpdate] を元に設定します。
		* [UpdateIdleState()] > [ProcessTurnYawCurve()] > [SetRootYawOffset()]
			* [TurnYawCurveValue] を元に設定します。
	* 詳しくは [SetRootYawOffset()] を参照ください。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [AnimGraph]									| ノード [Fullbody_Aiming] のパラメータ `AimYaw` に利用						|

## Settings

* 概要
	* このカテゴリの変数は挙動の調整のため変数です。
	* 固定値で、更新はされません。
	* ここに分類されているのは [CardinalDirectionDeadZone] のみです。

### CardinalDirectionDeadZone

* 型
	* float
* 概要
	* この変数の更新はノード [SelectCardinalDirectionFromAngle()] のパラメータ `DeadZone` に利用されます。
	* 挙動を調整するための定数で、デフォルトで 10.0 が設定されており、変更されません。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateVelocityData()]						| [LocalVelocityDirection] / [LocalVelocityDirectionNoOffset] の算出に利用	|
	| [UpdateAccelerationData()]					| [CardinalDirectionFromAcceleration] の算出に利用							|

## Linked Layer Data

* 概要
	* `Linked Anim Layer` の状態です。
	* このカテゴリの変数の更新は [UpdateLocomotionStateMachine()] で行われます。

### LinkedLayerChanged

* 型
	* bool
* 概要
	* [Start (state)] の [FullBody_StartState] が示す `Linked Anim Instance` が直前のフレームから変更されているかの真偽値です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [Start to Cycle (rule)]						| トランジションの判定で直接利用											|
	| [Pivot to Cycle (rule)]						| トランジションの判定で直接利用											|
	| [Stop to Idle (rule)]							| トランジションの判定で直接利用											|

### LastLinkedLayer

* 型
	* [UAnimInstance]
* 概要
	* [Start (state)] の [FullBody_StartState] が示す `Linked Anim Instance` の直前のフレームの値で、今回のフレームで変化があったかを判定するための変数です。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [Start to Cycle (rule)]						| トランジションの判定で直接利用											|

## Turn In Place{VALIABLES}

* 概要
	* [所定の位置での旋回について(about Turn In Place)] の処理で利用する変数です。
	* このカテゴリの変数の更新は [UpdateRootYawOffset()] で行われるものとそうでないものがあります。
		* [UpdateRootYawOffset()] で更新するもの
			* [RootYawOffset]
		* [UpdateIdleState()] で更新するもの
			* [TurnYawCurveValue]
		* [UpdateRootYawOffset()] で基本の値を設定し、 `Update...State()` で特定の値を設定するもの
			* [RootYawOffsetMode]
		* 値を外出しするための定数
			* [RootYawOffsetAngleClamp]
			* [RootYawOffsetAngleClampCrouched]
		* `FloatSpringInterp()` 用の構造体
			* [RootYawOffsetSpringState]

### RootYawOffset

* 型
	* float
* 概要
	* [AnimGraph] にてノード `RotateRootBone()` のパラメータ `Yaw` に利用されます。
	* つまり、 Yaw が回転した際、それを打ち消すような回転を `Root Bone` の Yaw に設定します。
		*  これにより、 Yaw の変化が一定範囲内の間は初期の方向に足が向いたままになるようにしています。
	* [SetRootYawOffset()] にて設定されます。
	* [SetRootYawOffset()] 以下から呼び出されます。
		* [UpdateRootYawOffset()]
		* [ProcessTurnYawCurve()]
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [AnimGraph]									| ノード `RotateRootBone()` のパラメータ `Yaw` に利用						|
	| [UpdateVelocityData()]						| [LocalVelocityDirectionAngleWithOffset] の算出に利用						|
	| [ProcessTurnYawCurve()]						| [SetRootYawOffset()] に渡す値の算出に利用									|
	| [UpdateRootYawOffset()]						| [SetRootYawOffset()] に渡す値の算出に利用									|
	| [Start to Cycle (rule)]						| トランジションの判定の一部で利用											|

### RootYawOffsetSpringState

* 型
	* `FloatSpringState`
* 概要
	* [UpdateRootYawOffset()] にてノード `FloatSpringInterp()` のパラメータ `SpringState` に利用されます。
	* `FloatSpringInterp()` のステートを保持するための構造体です。
	* [RootYawOffsetMode] が [AnimEnum_RootYawOffsetMode::BlendOut] である時に、徐々に [RootYawOffset] を 0.0 に Interp するために利用しています。

### TurnYawCurveValue

* 型
	* float
* 概要
	* 以下の 2 箇所で更新が行われます。
		* [UpdateIdleState()] で直接 0.0 に更新
		* [ProcessTurnYawCurve()] で更新
			* 2 つのアニメーションカーブ `RemainingTurnYaw` と `TurnYawWeight` の値を取得し、前者を後者で割った値を設定します。
			* この変数は [SetRootYawOffset()] のパラメータ `InRootYawOffset` の算出の際に利用されます。
				* パラメータ `InRootYawOffset` の算出では直前のフレームとの Delta 値を利用するため、フレームを超えて記憶する為、変数に保存しています。
	* [ProcessTurnYawCurve()] の呼び出しも [UpdateIdleState()] から行われるため、実質的には [UpdateIdleState()] からのみ更新されることになります。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [ProcessTurnYawCurve()]						| [SetRootYawOffset()] に渡す値の算出に利用									|

### RootYawOffsetMode

* 型
	* [AnimEnum_RootYawOffsetMode]
* 概要
	* `Turn In Place` の挙動を決めるための変数です。
	* enum の各値は以下の関数で設定しています。
		* [AnimEnum_RootYawOffsetMode::BlendOut]
			* [UpdateRootYawOffset()]
		* [AnimEnum_RootYawOffsetMode::Hold]
			* [UpdateStartState()]
		* [AnimEnum_RootYawOffsetMode::Accumulate]
			* [UpdateIdleState()]
			* [UpdateStopState()]
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateRootYawOffset()]						| [SetRootYawOffset()] を呼び出す条件に利用									|

### RootYawOffsetAngleClamp
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
	* [SetRootYawOffset()] で利用される、 [RootYawOffset] の設定前に適用するクランプ値です。
		* 詳しくは [Comment_TourInPlace.Ja::3] を参照ください。
	* [RootYawOffsetAngleClamp] はしゃがんで **いない** ときに使用します。
	* [RootYawOffsetAngleClampCrouched] はしゃがんで **いる** ときに使用します。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [SetRootYawOffset()]							| [RootYawOffset] の算出に利用												|

## Default{VALIABLES}

* 概要
	* 「初回アップデートが済んでいるか」や、「各種の実装を有効にするか」など、カテゴリに属さない設定関連の変数からなります。
	* [IsFirstUpdate] 以外は初期値のまま変更されません。

### IsFirstUpdate

* 型
	* bool
* 概要
	* [BlueprintThreadSafeUpdateAnimation()] の呼び出しが一度も完了していないかを返します。
	* 初期値は true となります。
	* [BlueprintThreadSafeUpdateAnimation()] の最後で false に設定されます。
	* 主に直前のフレームとの Delta 値を用いる値の算出時に参照し、 true の場合は無効な値を設定するのに利用しています。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [UpdateLocationData()]						| [DisplacementSinceLastUpdate] / [DisplacementSpeed] の算出に利用			|
	| [UpdateRotationData()]						| [YawDeltaSinceLastUpdate] / [AdditiveLeanAngle] の算出に利用				|
	| [UpdateLocomotionStateMachine()]				| [LinkedLayerChanged] の算出に利用											|

### EnableControlRig

* 型
	* bool
* 概要
	* 変数名からするとノード `ControlRig` を有効にするかを示す値のようですが、ノード `ControlRig` のパラメータ `Enabled` は関数 [ShouldEnableControlRig()] が指定されており、またこの変数はその関数内で使用されていません。
	* そもそもこのクラスでは使用されていません。
	* [ABP_ItemAnimLayersBase::FullBody_SkeletalControls] にてノード `Transform (Modify) Bone` のパラメータ `Enable` として利用しています。
		* 意図としてはノード `ControlRig` が無効の場合は Z 軸 -2.0 平行移動させることで床から足が浮いているように見えないようにしているものと思われます。
	* 初期値 false のまま変更されません。
		* 設定、もしくは動作確認のためのフラグ的な変数と思われます。
* 用途
	| 利用箇所												| 目的																		|
	|----													|----																		|
	| [ABP_ItemAnimLayersBase::FullBody_SkeletalControls]	| ノード `Transform (Modify) Bone` のパラメータ `Enable` に利用				|

### UseFootPlacement

* 型
	* bool
* 概要
	* ノード `FootPlacement` を使用するかを示します。
	* また、ノード `FootPlacement` を使用する場合(つまりは [UseFootPlacement] が true の場合)、 [AnimGraph] のノード `ControlRig` のパラメータ `Enabled` が [ShouldEnableControlRig()] を通じて false となります。
	* 以下の 3 箇所で利用されています。
		* [ShouldEnableControlRig()]
			* 戻り値の算出に影響を及ぼします。
				* true の場合、常に false を返す。
				* false の場合、 アニメーションカーブ `DisableLegIK` が 0.0 以下の場合 true を返す。
		* [ABP_ItemAnimLayersBase::ShouldEnableFootPlacement()]
			* 戻り値の算出に影響を及ぼします。
				* true の場合、アニメーションカーブ `DisableLegIK` が 0.0 以下の場合 true を返す。
				* false の場合、 常に false を返す。
		* [ABP_ItemAnimLayersBase::FullBody_SkeletalControls]
			* ノード `FootPlacement` のパラメータ `Enabled` として利用しています。
	* [ShouldEnableControlRig()] と [ABP_ItemAnimLayersBase::ShouldEnableFootPlacement()] は扱いが逆になっています。
		* これは排他的に制御するために意図してそうなっているのものと思われます。
	* 初期値 true のまま変更されません。
		* 設定、もしくは動作確認のためのフラグ的な変数と思われます。
* 用途
	| 利用箇所												| 目的																		|
	|----													|----																		|
	| [ShouldEnableControlRig()]							| 戻り値の算出に利用														|
	| [ABP_ItemAnimLayersBase::ShouldEnableFootPlacement()]	| 戻り値の算出に利用														|
	| [ABP_ItemAnimLayersBase::FullBody_SkeletalControls]	| ノード `FootPlacement` のパラメータ `Enabled` に利用						|

### bEnableRootYawOffset

* 型
	* bool
* 概要
	* `RootYawOffset` の機能を使用するか。
		* [SetRootYawOffset()] の挙動に影響を及ぼす。
			* true の場合、 [RootYawOffset] / [AimYaw] の値が状況によって変化する
			* false の場合、 [RootYawOffset] / [AimYaw] の値が常に 0.0 となる
	* 初期値 true のまま変更されません。
		* 設定、もしくは動作確認のためのフラグ的な変数と思われます。
* 用途
	| 利用箇所										| 目的																		|
	|----											|----																		|
	| [SetRootYawOffset()]							| [RootYawOffset] / [AimYaw] の算出に利用									|



<!--- ------------------------------------------------------------------ --->

[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p.156]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation#p156

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[所定の位置での旋回について(about Turn In Place)]: #about-turn-in-place
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
[EndInAir (conduit rule)]: #endinair-conduit-rule
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
[FallLand to EndInAir (rule)]: #fallland-to-endinair-rule
[JumpFallInterruptSources to EndInAir (rule)]: #jumpfallinterruptsources-to-endinair-rule
[EndInAir to CycleAlias (rule)]: #endinair-to-cyclealias-rule
[EndInAir to IdleAlias (rule)]: #endinair-to-idlealias-rule
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
[SelectCardinalDirectionFromAngle()]: #selectcardinaldirectionfromangle
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
[Turn In Place{FUNCTIONS}]: #turn-in-placefunctions
[SetRootYawOffset()]: #setrootyawoffset
[ProcessTurnYawCurve()]: #processturnyawcurve
[UpdateRootYawOffset()]: #updaterootyawoffset
[Default{FUNCTIONS}]: #defaultfunctions
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
[Turn In Place{VALIABLES}]: #turn-in-placevaliables
[RootYawOffset]: #rootyawoffset
[RootYawOffsetSpringState]: #rootyawoffsetspringstate
[TurnYawCurveValue]: #turnyawcurvevalue
[RootYawOffsetMode]: #rootyawoffsetmode
[RootYawOffsetAngleClamp]: #rootyawoffsetangleclamp
[RootYawOffsetAngleClampCrouched]: #rootyawoffsetangleclampcrouched
[Default{VALIABLES}]: #defaultvaliables
[IsFirstUpdate]: #isfirstupdate
[EnableControlRig]: #enablecontrolrig
[UseFootPlacement]: #usefootplacement
[bEnableRootYawOffset]: #benablerootyawoffset
[ABP_ItemAnimLayersBase]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbase
[ABP_ItemAnimLayersBase::LeftHandPoseOverride について(about LeftHandPoseOverride)]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaselefthandposeoverride-about-lefthandposeoverride
[ABP_ItemAnimLayersBase::FullBodyAdditives]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyadditives
[ABP_ItemAnimLayersBase::WantsTurnInPlace (rule)]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasewantsturninplace-rule
[ABP_ItemAnimLayersBase::TurnInPlaceRotation to TurnInPlaceRecovery (rule)]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseturninplacerotation-to-turninplacerecovery-rule
[ABP_ItemAnimLayersBase::TurnInPlaceRecovery to Idle (rule)]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseturninplacerecovery-to-idle-rule
[ABP_ItemAnimLayersBase::Idle to StanceTransition (rule)]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidle-to-stancetransition-rule
[ABP_ItemAnimLayersBase::StanceTransition to Idle (rule)]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasestancetransition-to-idle-rule
[ABP_ItemAnimLayersBase::WantsToRePivit (rule)]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasewantstorepivit-rule
[ABP_ItemAnimLayersBase::FullBody_Aiming]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyaiming
[ABP_ItemAnimLayersBase::FullBody_SkeletalControls]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyskeletalcontrols
[ABP_ItemAnimLayersBase::UpdateCycleAnim()]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseupdatecycleanim
[ABP_ItemAnimLayersBase::SetUpPivotAnim()]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasesetuppivotanim
[ABP_ItemAnimLayersBase::UpdatePivotAnim()]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseupdatepivotanim
[ABP_ItemAnimLayersBase::ShouldEnableFootPlacement()]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseshouldenablefootplacement
[ALI_ItemAnimLayers]: ../../Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayers
[AnimEnum_CardinalDirection]: ../../Lyra/ABP/AnimEnum_CardinalDirection.md#animenumcardinaldirection
[AnimEnum_RootYawOffsetMode]: ../../Lyra/ABP/AnimEnum_RootYawOffsetMode.md#animenumrootyawoffsetmode
[AnimEnum_RootYawOffsetMode::BlendOut]: ../../Lyra/ABP/AnimEnum_RootYawOffsetMode.md#animenumrootyawoffsetmodeblendout
[AnimEnum_RootYawOffsetMode::Hold]: ../../Lyra/ABP/AnimEnum_RootYawOffsetMode.md#animenumrootyawoffsetmodehold
[AnimEnum_RootYawOffsetMode::Accumulate]: ../../Lyra/ABP/AnimEnum_RootYawOffsetMode.md#animenumrootyawoffsetmodeaccumulate
[Comment_AnimBP_Tour.Ja::1]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja1
[Comment_AnimBP_Tour.Ja::2]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja2
[Comment_AnimBP_Tour.Ja::3]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja3
[Comment_AnimBP_Tour.Ja::4]: ../../Lyra/ABP/Comment_AnimBP_Tour.Ja.md#commentanimbptourja4
[Comment_TourInPlace.Ja]: ../../Lyra/ABP/Comment_TourInPlace.Ja.md#commenttourinplaceja
[Comment_TourInPlace.Ja::1]: ../../Lyra/ABP/Comment_TourInPlace.Ja.md#commenttourinplaceja1
[Comment_TourInPlace.Ja::2]: ../../Lyra/ABP/Comment_TourInPlace.Ja.md#commenttourinplaceja2
[Comment_TourInPlace.Ja::3]: ../../Lyra/ABP/Comment_TourInPlace.Ja.md#commenttourinplaceja3
[Comment_TourInPlace.Ja::4]: ../../Lyra/ABP/Comment_TourInPlace.Ja.md#commenttourinplaceja4
[Comment_TourInPlace.Ja::5]: ../../Lyra/ABP/Comment_TourInPlace.Ja.md#commenttourinplaceja5
[TurnYawAnimModifier]: ../../Lyra/ABP/TurnYawAnimModifier.md#turnyawanimmodifier
[ULyraAnimInstance::GameplayTagPropertyMap]: ../../Lyra/Animation/ULyraAnimInstance.md#ulyraaniminstancegameplaytagpropertymap
[ULyraAnimInstance::GroundDistance]: ../../Lyra/Animation/ULyraAnimInstance.md#ulyraaniminstancegrounddistance
[UAnimInstance]: ../../UE/Animation/UAnimInstance.md#uaniminstance
[UAnimInstance::GetInstanceCurrentStateElapsedTime()]: ../../UE/Animation/UAnimInstance.md#uaniminstancegetinstancecurrentstateelapsedtime
[UAnimInstance::WasAnimNotifyStateActiveInSourceState()]: ../../UE/Animation/UAnimInstance.md#uaniminstancewasanimnotifystateactiveinsourcestate
[UAnimInstance::IsAnyMontagePlaying()]: ../../UE/Animation/UAnimInstance.md#uaniminstanceisanymontageplaying
[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p.156]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation#p156
[Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Editor > AnimGraph > UAnimStateTransitionNode]: https://docs.unrealengine.com/5.1/en-US/API/Editor/AnimGraph/UAnimStateTransitionNode/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > Blend ノード > Inertialization]: https://docs.unrealengine.com/5.1/ja/animation-blueprint-blend-nodes-in-unreal-engine/#inertialization
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ブループリントでのグラフ作成 > ノード関数]: https://docs.unrealengine.com/5.1/ja/graphing-in-animation-blueprints-in-unreal-engine/#%E3%83%8E%E3%83%BC%E3%83%89%E9%96%A2%E6%95%B0
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > ステートマシン > 遷移ルール]: https://docs.unrealengine.com/5.1/ja/transition-rules-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > ステートマシン > 遷移ルール >  遷移ブレンドのタイプ]: https://docs.unrealengine.com/5.1/ja/transition-rules-in-unreal-engine/#%E9%81%B7%E7%A7%BB%E3%83%96%E3%83%AC%E3%83%B3%E3%83%89%E3%81%AE%E3%82%BF%E3%82%A4%E3%83%97
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > ブループリントのスレッドセーフな更新アニメーション]: https://docs.unrealengine.com/5.0/ja/animation-in-lyra-sample-game-in-unreal-engine/#%E3%83%96%E3%83%AB%E3%83%BC%E3%83%97%E3%83%AA%E3%83%B3%E3%83%88%E3%81%AE%E3%82%B9%E3%83%AC%E3%83%83%E3%83%89%E3%82%BB%E3%83%BC%E3%83%95%E3%81%AA%E6%9B%B4%E6%96%B0%E3%82%A2%E3%83%8B%E3%83%A1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3
