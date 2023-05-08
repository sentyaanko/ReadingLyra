## UAnimDistanceMatchingLibrary

>> 詳細は未確認です。

[Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Plugins > AnimationLocomotionLibraryRuntime > UAnimDistanceMatchingLibrary](https://docs.unrealengine.com/5.1/en-US/API/Plugins/AnimationLocomotionLibraryRuntim-/UAnimDistanceMatchingLibrary/)

> Library of techniques for driving animations by distance metrics rather than by time.
> These techniques can be effective at compensating for differences between character movement and authored motion in the animations.
> Distance Matching effectively changes the play rate of the animation to keep the feet from sliding. 
> It's common to clamp the resulting play rate to avoid animations playing too slow or too fast and to use techniques such as Stride Warping to make up the difference.
> 
> ----
> アニメーションを時間ではなく距離の指標で駆動するためのテクニックのライブラリです。  
> これらのテクニックは、アニメーションにおけるキャラクターの動きとオーサリングされた動きの違いを補うのに効果的です。  
> 距離マッチングは、足が滑らないようにアニメーションの再生速度を効果的に変化させます。  
> アニメーションの再生速度が遅すぎたり速すぎたりしないように、結果の再生速度を調整し、ストライドワーピングなどのテクニックを使ってその差を補うのが一般的です。

### AdvanceTimeByDistanceMatching()

> Advance the sequence evaluator forward by distance traveled rather than time.  
> A distance curve is required on the animation that describes the distance traveled by the root bone in the animation.  
> See UDistanceCurveModifier.  
> @param UpdateContext - The update context provided in the anim node function.  
> @param SequenceEvaluator - The sequence evaluator node to operate on.  
> @param DistanceTraveled - The distance traveled by the character since the last animation update.  
> @param DistanceCurveName - Name of the curve we want to match   
> @param PlayRateClamp - A clamp on the effective play rate of the animation after distance matching. Set to (0,0) for no clamping.  
> 
> ----
> 時間ではなく、移動した距離によって sequence evaluator を前進させます。  
> アニメーションのルートボーンが移動した距離を記述する距離曲線がアニメーションに必要です。  
> UDistanceCurveModifier を参照してください。  
> @param UpdateContext - anim node 関数で提供される更新コンテキスト。  
> @param SequenceEvaluator - 操作する sequence evaluator ノードです。
> @param DistanceTraveled - 最後のアニメーション更新からキャラクタが移動した距離です。
> @param DistanceCurveName - マッチングさせたいカーブの名前です。
> @param PlayRateClamp - 距離マッチング後のアニメーションの有効再生速度に対するクランプです。クランプしない場合は(0,0)に設定します。

### DistanceMatchToTarget()

> Set the time of the sequence evaluator to the point in the animation where the distance curve matches the DistanceToTarget input.  
> A common use case is to achieve stops without foot sliding by, each frame, selecting the point in the animation that matches the distance the character has remaining until it stops.  
> Note that because this technique sets the time of the animation by distance remaining, it doesn't respect phase of any previous animation (e.g. from a jog cycle).  
> @param SequenceEvaluator - The sequence evaluator node to operate on.  
> @param DistanceToTarget - The distance remaining to a target (e.g. a stop or pivot point).  
> @param DistanceCurveName - Name of the curve we want to match  
>
> ----
> sequence evaluator の時間を、距離曲線が DistanceToTarget 入力に一致するアニメーションのポイントに設定します。  
> 一般的な使用例としては、足を滑らせることなく停止させるために、各フレームで、キャラクターが停止するまでの残り距離と一致するアニメーションのポイントを選択することです。  
> このテクニックは、残り距離によってアニメーションの時間を設定するため、以前のアニメーション（ジョグ サイクルなど）の位相を尊重しないことに注意してください。  
> @param SequenceEvaluator - 操作対象となる sequence evaluator ノードです。  
> @param DistanceToTarget - ターゲット（停止位置やピボットポイントなど）までの残り距離です。  
> @param DistanceCurveName - 一致させたい曲線の名前です。  


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->

