# Comment_TurnInPlace.Ja

引用元

| No. | 引用元                                                  |
|-----|---------------------------------------------------------|
| 1   | ABP_Mannequin_Base > AnimGraph                          |
| 2   | ABP_Mannequin_Base > UpdateRootYawOffset                |
| 3   | ABP_Mannequin_Base > SetRootYawOffset                   |
| 4   | ABP_Mannequin_Base > SetRootYawOffset                   |
| 5   | ABP_Mannequin_Base > ProcessTurnYawCurve                |
| 6   | ABP_ItemAnimLayersBase > FullBody_IdleState > IdleSM    |

# 1

ABP_Mannequin_Base > AnimGraph

ターンインプレイス #1 (ABP_ItemAnimLayersBase も参照)

ポーンのオーナーが回転すると、メッシュコンポーネントも一緒に回転するため、足が滑ってしまいます。
ここでは、キャラクターの回転に対抗して、足を固定するようにします。

# 2

ABP_Mannequin_Base > UpdateRootYawOffset

ターンインプレイス #2

この関数は、Pawn の所有者の現在の状態に応じてヨーオフセットを更新する 処理を行います。

# 3

ABP_Mannequin_Base > SetRootYawOffset

ターンインプレイス #3

オフセットが大きいと、キャラクターが後方を狙いすぎて、背骨がねじれすぎてしまうので、オフセットをクランプしています。
ターンインプレイスアニメーションは、通常オフセットに追いつきますが、ユーザーがカメラを速く回転させると、このクランプによって足が滑るようになります。
もし必要であれば、このクランプは、180度まで可能な照準アニメーションを持つか、より積極的にターンインプレイスアニメーションをトリガーすることによって置き換えることができます。

# 4

ABP_Mannequin_Base > SetRootYawOffset

ターンインプレイス #4

武器がカメラと一直線になるように、照準がヨーオフセットに対抗するようにしたいです。

# 5

ABP_Mannequin_Base > ProcessTurnYawCurve

ターンインプレイス #5

ヨーオフセットが大きくなりすぎると、キャラクターを回転させるために TurnInPlace アニメーションがトリガーされます。
例えば、カメラが右に 90 度回転した場合、カメラはキャラクタの右肩を向くようになります。
キャラクターを左に90度回転させるアニメーションを再生すると、キャラクターは再びカメラに背を向けるようになります。
「TurnYawAnimModifier」アニメーションモディファイアを使用して、各 TurnInPlace アニメーションに必要なカーブを生成します。
TurnInPlace アニメーションをトリガーする例については、 ABP_ItemAnimLayersBase を参照してください。

# 6

ABP_ItemAnimLayersBase > FullBody_IdleState > IdleSM

ターンインプレイス #6 (AnimBP_Mannequin_Base も参照)

ヨーオフセットが十分に大きくなったら、オフセットを小さくするために TurnInPlace アニメーションをトリガーします。
TurnInPlace アニメーションは、回転が終了すると、多くの場合、いくつかの落ち着く動作で終了します。
この間、 TurnInPlaceRecovery 状態に移行し、オフセットが再び大きくなると TurnInPlaceRotation 状態に移行することができます。
こうすることで、 Pawn のオーナーが回転し続ける場合、落ち着きの完了を待たずに、 TurnInPlace アニメーションの回転部分を再生し続けることができます。
