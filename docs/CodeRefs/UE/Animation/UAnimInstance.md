## UAnimInstance

>> 詳細は未確認です。

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Runtime > Engine > Animation > UAnimInstance](https://docs.unrealengine.com/5.1/en-US/API/Runtime/Engine/Animation/UAnimInstance/)

* 概要
	* AnimationBlueprint の基底クラスです。
* Lyra での使われ方
	* [ULyraAnimInstance] の基底クラスです。
	* 派生クラスは以下の通りです。
		* [UAnimInstance]
			* [ULyraAnimInstance]
				* [ABP_Mannequin_Base]
					* `ABP_Mannequin_TopDown`
			* [ABP_ItemAnimLayersBase]
				* `ABP_PistolAnimLayers`
				* `ABP_PistolAnimLayers`
					* `ABP_ShotgunAnimLayers`
				* `ABP_RifleAnimLayers_Feminine`
					* `ABP_ShotgunAnimLayers_Feminine`
				* `ABP_UnarmedAnimLayers`
				* `ABP_UnarmedAnimLayers_Feminine`
	* _Feminine 付きは quine 用。


### UAnimInstance::GetInstanceCurrentStateElapsedTime()

> Get the current elapsed time of a state within the specified state machine  
> 
> ----
> 指定されたステートマシン内のステートの現在の経過時間を取得します。  


### UAnimInstance::WasAnimNotifyStateActiveInSourceState()

> Get whether a particular notify state is active in a specific state last tick.  
> 
> ----
> 特定のステートの最後のティックで、指定された notify state がアクティブであるかどうかを取得します。  


### UAnimInstance::NativeInitializeAnimation()

> Native initialization override point  
> 
> ----
> ネイティブ初期化オーバーライドポイントです。  


### UAnimInstance::NativeUpdateAnimation()

> Native update override point.   
> It is usually a good idea to simply gather data in this step and for the bulk of the work to be done in NativeThreadSafeUpdateAnimation.  
>
> ----
> ネイティブ更新のオーバーライドポイントです。  
> 通常、このステップでは単にデータを収集するだけで、作業の大部分は NativeThreadSafeUpdateAnimation で終了するのがよい方法です。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UAnimInstance]: #uaniminstance
[ABP_ItemAnimLayersBase]: ../../Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbase
[ABP_Mannequin_Base]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[ULyraAnimInstance]: ../../Lyra/Animation/ULyraAnimInstance.md#ulyraaniminstance
