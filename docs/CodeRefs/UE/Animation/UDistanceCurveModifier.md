## UDistanceCurveModifier

>> 詳細は未確認です。

[Unreal Engine 5.1 Documentation > Unreal Engine API Reference > Plugins > AnimationLocomotionLibraryEditor > UDistanceCurveModifier](https://docs.unrealengine.com/5.1/en-US/API/Plugins/AnimationLocomotionLibraryEditor/UDistanceCurveModifier/)

> Extracts traveling distance information from root motion and bakes it to a curve.
> A negative value indicates distance remaining to a stop or pivot point.
> A positive value indicates distance traveled from a start point or from the beginning of the clip.
> 
> ----
> ルートモーションから走行距離情報を抽出し、カーブにベイクします。
> 負の値は、停止点またはピボットポイントまでの残り距離を表します。
> 正の値は、スタート地点やクリップの先頭からの移動距離を表します。

* 既存のドキュメント
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > 移動 > 距離マッチング]
* 概要
	* `UAnimationModifier` の派生クラスです。
	* アニメーションカーブを自動生成するためのアニメーションモディファイアです。
	* モンタージュに設定することでルートモーションアニメーションカーブをベイクします。
* Lyra での使われ方
	* 

### SampleRate

> Rate used to sample the animation.  
> 
> ----
> アニメーションのサンプリングに使用するレートです。  
* アニメーションカーブのキーを一秒間に打つ数です。

### CurveName

> Name for the generated curve.  
> 
> ----
> 生成されるカーブの名前です。  

### StopSpeedThreshold

> Root motion speed must be below this threshold to be considered stopped.  
> 
> ----
> ルートモーションの速度がこの閾値以下でなければ、停止しているとみなされません。  

### Axis

> Axes to calculate the distance value from.  
> 
> ----
> 距離の値を計算するための軸です。  

### bStopAtEnd

> Root motion is considered to be stopped at the clip's end.  
> 
> ----
> ルートモーションは、クリップの終了時に停止したとみなされます。  




[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > 移動 > 距離マッチング]: https://docs.unrealengine.com/5.0/ja/distance-matching-in-unreal-engine/#%E3%82%AB%E3%83%BC%E3%83%96%E3%81%AE%E7%94%9F%E6%88%90

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > 移動 > 距離マッチング]: https://docs.unrealengine.com/5.0/ja/distance-matching-in-unreal-engine/#%E3%82%AB%E3%83%BC%E3%83%96%E3%81%AE%E7%94%9F%E6%88%90
