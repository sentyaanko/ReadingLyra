## AnimEnum_RootYawOffsetMode

* 既存のドキュメント
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション] > 所定の位置での旋回
		* オフセットモードに関する解説があります。
			> 	| オフセット モード			| 説明																															|
			>	|----						|----																															|
			>	| Accumulate (蓄積)			| アイドル時に、 `Accumulate` では、アクタの回転を完全に無効にします。															|
			>	| Hold (保持)				| 開始時に、 `Hold` では、このアニメーションが開始した元のオフセットを保持します。												|
			>	| Blend Out (ブレンド アウト) | ジョグ サイクルに入るときに、 `Blend Out` ではスムーズにブレンドし、デフォルトの「コントローラーに向ける」動作に従います。	|
		* 訳のニュアンスが微妙なので、各項目で原文の引用と翻訳を記載します。
* 概要
	* [ABP_Mannequin_Base] で利用する enum 型です。


### BlendOut

> When going into a jog cycle, Blend Out will smoothly blend it, and follow the default "orient to controller" behavior.
> 
> ----
> ジョグサイクル移行時には、 [BlendOut] はスムーズにブレンドし、デフォルトの「コントローラーに向ける」動作に従います。
>> Note: この値は各ステートで指定されない場合の既定値です。

### Hold

> During starts, Hold will preserve whichever original offset this animation started with
> 
> ----
> 開始時には、 [Hold] はこのアニメーションの開始時の元のオフセットを維持します。
>> Note: この値は Start ステート中に指定されます。


### Accumulate

> During idles, Accumulate will completely counter the Actor's rotation.
> 
> ----
> アイドル時には、 [Accumulate] はアクターの回転を完全に打ち消します。
>> Note: この値は Idle ステート中に指定されます。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[BlendOut]: #blendout
[Hold]: #hold
[Accumulate]: #accumulate
[ABP_Mannequin_Base]: ../../Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
