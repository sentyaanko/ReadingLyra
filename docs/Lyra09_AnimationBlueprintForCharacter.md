# 【UE5】Lyra に学ぶ(09) AnimationBlueprint for Character <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
キャラクター用の AniamtionBlueprint がどのように実装されているかを見ていきます。  
扱うのはキャラクター用の AnimationBlueprint で、すなわち以下のものです。  
 * [ALI_ItemAnimLayers]
 * [ABP_Mannequin_Base]
 * [ABP_ItemAnimLayersBase] （と、その派生クラス群）
 * `ABP_Mannequin_CopyPose`
 * `ABP_Manny_PostProcess` / `ABP_Quinn_PostProcess`

主にシューターゲーム用の部分について述べ、他 (TopDownArena 用等) に関しては省略します。  
実装で使用されている仕組みに関してはほぼ言及しませんので、それらの情報は下記の参考リンク等を確認してください。  

* バージョン
	* [Lyra Starter Game]
		* 2022/11/29 版(5.1 用)


# 0. 参考

* Unreal Engine の機能解説
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > レイヤー化されたアニメーションを使用する]
		* Locomotion と Aim を例にした基本的なモーションブレンドの解説
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > エイム オフセットを作成する]
		* エイムオフセットアセットの解説
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]
		* Animation Layer Interface などの解説
* Lyra の解説
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]
		* Lyra のアニメーションブループリントで使われている機能がまとめられています。
	* [Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】]


# 1. ABP 全体のお話

## 1.1. キャラクター関連の ABP 一覧

### 1.1.1. 継承関係

継承ツリーは以下のようになっています。

* `AnimLayerInterface`
	* [ALI_ItemAnimLayers]
* `AnimInstance`
	* [ULyraAnimInstance]
		* [ABP_Mannequin_Base]
	* [ABP_ItemAnimLayersBase]
		* `ABP_PistolAnimLayers`
		* `ABP_PistolAnimLayers_Feminine`
		* `ABP_RifleAnimLayers`
			* `ABP_ShotgunAnimLayers`
		* `ABP_RifleAnimLayers_Feminine`
			* `ABP_ShotgunAnimLayers_Feminine`
		* `ABP_UnarmedAnimLayers`
		* `ABP_UnarmedAnimLayers_Feminine`
	* `ABP_Mannequin_CopyPose`
	* `ABP_Manny_PostProcess`
	* `ABP_Quinn_PostProcess`

Manny (無印)と Quinn (_Feminine 付き)の継承関係は基本的に兄弟になっています。  
Shotgun は Rifle の派生クラスとなっています。これは流用が多い為です。  
[ABP_Mannequin_Base] と [ABP_ItemAnimLayersBase] に継承関係はありません。


### 1.1.2. クラス名と用途

| クラス名							| 用途																							|
|----								|----																							|
| [ALI_ItemAnimLayers]				| 武器毎に異なる AnimGrap を実装するためのアニメーションレイヤーインターフェイスクラスです。	|
| [ULyraAnimInstance]				| Lyra 用に拡張した `AnimInstance` の派生クラスです。											|
| [ABP_Mannequin_Base]				| キャラクター用の ABP で [ALI_ItemAnimLayers] の関数を呼び出しをしています。					|
| [ABP_ItemAnimLayersBase]			| 武器用の基底クラスで [ALI_ItemAnimLayers] の関数を実装しています。							|
| `ABP_PistolAnimLayers`			| Manny の Pistol 用の DataOnly の ABP です。													|
| `ABP_PistolAnimLayers_Feminine`	| Quinn の Pistol 用の DataOnly の ABP です。													|
| `ABP_RifleAnimLayers`				| Manny の Rifle 用の DataOnly の ABP です。													|
| `ABP_RifleAnimLayers_Feminine`	| Quinn の Rifle 用の DataOnly の ABP です。													|
| `ABP_ShotgunAnimLayers`			| Manny の Shotgun 用の DataOnly の ABP です。													|
| `ABP_ShotgunAnimLayers_Feminine`	| Quinn の Shotgun 用の DataOnly の ABP です。													|
| `ABP_UnarmedAnimLayers`			| Manny の 非武装用の DataOnly の ABP です。													|
| `ABP_UnarmedAnimLayers_Feminine`	| Quinn の 非武装用の DataOnly の ABP です。													|
| `ABP_Mannequin_CopyPose`			| 親のメッシュコンポーネントのポーズを複製する ABP です。										|
| `ABP_Manny_PostProcess`			| Manny の プロシージャルアニメーションのポストプロセス用の ABP です。							|
| `ABP_Quinn_PostProcess`			| Quinn の プロシージャルアニメーションのポストプロセス用の ABP です。							|

* [ALI_ItemAnimLayers]
	* [ABP_Mannequin_Base] と [ABP_ItemAnimLayersBase] の Class Setting `Interfaces > Implemented Interfaces` で [ALI_ItemAnimLayers] を追加しています。
		> **Note**  
		> [Unreal Engine Forum > Update to UE5.1 have anim layer bug]  
		> 5.1.0 だと不具合がありました。 5.1.1 では修正されているようです。
	* [ABP_Mannequin_Base] は [ALI_ItemAnimLayers] のインターフェイスを利用する側です。
	* [ABP_ItemAnimLayersBase] は [ALI_ItemAnimLayers] のインターフェイスを実装する側です。


### 1.1.3. 参照元

* [ABP_Mannequin_Base]
	* キャラクタークラスのメッシュコンポーネントの Anim Class で利用しています。
	* 具体的には `B_Hero_ShooterMannequin` 等の Mesh コンポーネントのプロパティ `Mesh > Anim Class` にて利用しています。
* [ABP_ItemAnimLayersBase] の派生クラス
	* キャラクタークラスの Linked Animation Blueprint で利用しています。
	* 具体的には `B_WeaponInstance_Base` のイベント `OnEquipped` / `OnUnequipped` 内でノード `LinkAnimClassLayers` を呼び出す事で、 [ABP_Mannequin_Base] の Linked Animation Blueprint として設定しています。
		> **Note**  
		> * `B_WeaponInstance_Base` はプロパティ `Animation > Equipped Anim Set` 等を持ち、この値を上記のタイミングで使用します。
		> * `B_WeaponInstance_Base` は武器毎の派生クラスを持ち、上記のプロパティに [ABP_ItemAnimLayersBase] の武器毎の派生クラスを指定することで武器に合った Linked Animation Blueprint の設定ができるようにしています。
* `ABP_Mannequin_CopyPose`
	* キャラクター表示用のアクターのメッシュコンポーネントの Anim Class で利用しています。
	* 具体的には `B_Hero_ShooterMannequin` 等の子アクター `B_Manny` / `B_Quinn` の Mesh コンポーネントのプロパティ `Mesh > Anim Class` にて利用しています。
* `ABP_Manny_PostProcess` / `ABP_Quinn_PostProcess`
	* ポストプロセスアニメーションブループリントとして利用しています。
	* 具体的には `SKM_Manny` / `SKM_Quinn` の `Skeltal Mesh  > Post Process Anim Blueprint` にて利用しています。
	* AnimGrap で使用しているノードは `Control Rig` と `Pose Driver` のみです。
		* `Control Rig` は `CR_Mannequin_Procedural` を使用しています。
		* `Pose Driver` は `Manny` / `Quinn` 毎のポーズアセット 14 種((4(腕) + 3(足)) x 2(左右) )を使用しています。

一体のキャラクターを表示するのに 4 つのアニメーションブループリントが使われていることになります。  
実行時のキャラクター



### 1.1.4. 実行時のキャラクターのアクター階層

例として、見た目が Manny で Pistol 装備中という状況で説明します。

* `B_Hero_ShooterMannequin`(`B_Hero_Default`(`Character_Default`(`ALyraCharacter`(`AModularCharacter`(`ACharacter`)))))
	* `B_Manny`(`ALyraTaggedActor`(`AActor`))
	* `B_Pistol`(`B_Weapon`(`AActor`))

※カッコの中は基底クラス名です。  

キャラクター (B_Hero_ShooterMannequin) の子にキャラクター表示用のアクター (B_Manny) と武器用アクター (B_Pistol) が作られます。  

### 1.1.5. 実行時のアクターのアニメーションブループリント

| アクター						| Animation Blueprint		| Linked Animation Blueprint			| スケルタルメッシュ	| Post Process Anim Blueprint	|
|----							|----						|----									|----					|----							|
| `B_Hero_ShooterMannequin`		| [ABP_Mannequin_Base]		| [ABP_ItemAnimLayersBase] の派生クラス	| `SKM_Manny_Invis`		|								|
| `B_Manny`						| `ABP_Mannequin_CopyPose`	|										| `SKM_Manny`			| `ABP_Manny_PostProcess`		|

* キャラクターの制御を行っているアクター `B_Hero_ShooterMannequin` に設定されたアニメーションブループリント [ABP_Mannequin_Base] によって基本的なアニメーション制御を行う。
* 武器毎の処理の差は Linked Animation Blueprint を利用して [ABP_ItemAnimLayersBase] の派生クラスで行う。
* `B_Hero_ShooterMannequin` に設定されたスケルタルメッシュ `SKM_Manny_Invis` は何も表示されない様に作られている。
* キャラクターの表示を行っているアクター `B_Manny` に設定されたアニメーションブループリント `ABP_Mannequin_CopyPose` によって親アクター `B_Hero_ShooterMannequin` のメッシュコンポーネントのポーズを複製することでベースとなるポーズの設定を行う。
* `B_Manny` に設定されたスケルタルメッシュ `SKM_Manny` のプロパティ `Skeletal Mesh > Post Process Anim Blueprint` に設定された `ABP_Manny_PostProcess` により、スケルタルメッシュ毎の調整を行う。
	* `B_Manny` / `B_Quinn` の EventGraph のコメントを引用
		> The mesh component has the ABP_Mannequin_CopyPose anim BP,  
		> which will just copy the pose across from the invisible 'driving' mesh component since the skeletons are directly compatible.  
		> If you change the mesh to something incompatble, use a Rertarget anim BP instead which targets the correct skeleton.
		>
		> ----
		> このメッシュコンポーネントには ABP_Mannequin_CopyPose アニメーション BP があり、  
		> スケルトンに直接互換性があるため、不可視の「ドライビング」メッシュコンポーネントからポーズをコピーします。  
		> メッシュを互換性のないものに変更する場合は、正しいスケルトンをターゲットにする Rertarget anim BP を代わりに使用してください。

アクターの階層 (`B_Manny` / `B_Quinn` のどちらを追加するのか) や各アセットの設定 (どの武器を装備するのか) は実行時に行われます。  
そのあたりの解説はドキュメントが膨大になるので割愛します。  


## 1.2. ABP とアニメーションアセットの関係

* Animation Seaquence
	* [ABP_Mannequin_Base] では参照しません。
	* 武器を装備したときの基底クラスである [ABP_ItemAnimLayersBase] では、変数を用意し、武器毎の派生クラスで任意のアニメーションシーケンスを設定できるようにしています。
* Aim Offset
	* Animation Seaquence と同様です。
* Blend Space 1D
	* [ABP_Mannequin_Base] にて Lean 用のアセットを直接参照しています。
		> **Note**  
		> Lean は移動中にカメラを左右に回した際、その方向に頭を向け、体を傾ける処理です。
* Pose Asset
	 * `ABP_Manny_PostProcess` / `ABP_Quinn_PostProcess` にてノード `Pose Driver` から直接参照しています。
* Control Rig
	 * `CR_Mannequin_FootPlant`
		 * [ABP_Mannequin_Base] にてノード `Control Rig` から直接参照しています。
			 > **Note**  
			 > 床の位置に足をあわせるためのコントロールリグです。  
			 > プロジェクト初期状態ではこちらは利用されていません。  
			 > 代わりに `5.1` で追加された `Foot Placement` ノードを利用するようになっています。
	 * `CR_Mannequin_Procedural`
		 * `ABP_Manny_PostProcess` / `ABP_Quinn_PostProcess` にてノード `Control Rig` から直接参照しています。

## 1.3. ABP で記載されているツアーコメントについて

* ブループリントのコメントの中で各機能に関するコメントが複数の場所に連番数字付きで書かれています。
* 具体的には以下の 2 種があります。
	* AnimBP Tour
		* [Comment_AnimBP_Tour.Ja] にコメントをまとめて引用しています。
	* TurnInPlace
		* [Comment_TurnInPlace.Ja] にコメントをまとめて引用しています。




# 2. Anim Node の Tag と Anim Node Reference ノード

* 既存のドキュメント
	* [Dev Comunity > Forums > How to get a anim layer node reference as shown in the Lyra Example project?]
	* [Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p159]

Lyra では [ABP_Mannequin_Base::Start (state)] に配置しているノード [ALI_ItemAnimLayers::FullBody_StartState] のプロパティ Tag に `StartLayerNode` を設定しています。  
この Tag を利用し、 [ABP_Mannequin_Base::UpdateLocomotionStateMachine()] ではいくつかの関数を経て現在設定されている AnimLayer のリファレンスを取得しています。  
この参照先を毎フレームチェックすることで AnimLayer が変更されたかを変数に保存しています。  
この変更されたかを示す変数は [ABP_Mannequin_Base::LocomotionSM] 内のトランジションから参照されています。  
使われ方の例として Pivot 中に武器変更すると Cycle に移行する、が挙げられます。


# 3. 所定の位置での旋回(TurnInPlace)

* 既存のドキュメント
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > 所定の位置での旋回]

## 3.1. 仕組み

Lyra ではキャラクターアクタはコントローラーのヨー方向に向いています。（ `UseControllerRotationYaw` が true ）  
ですが、キャラクターが移動していない状態でマウスを動かす等カメラの向きを操作した場合、キャラクターの下半身の向きは以下のように実装されています。 

* 移動しなくなった時点の下半身の方向を保持しておく。
* 更新毎に保存しておいた下半身の方向と現在のコントローラーのヨー方向を比較する。
* 45 度 + αの範囲内では足を動かさずに上半身の向きだけ変える。
* 45 度 + αを超えると 90 度、下半身の向きを変える。

> α は遊びの範囲で、これがあることで 45 度を行き来しただけでアニメーションが再生されないようになります。  
> 実際には [ABP_ItemAnimLayersBase::WantsTurnInPlace (rule)] にて、回転角の絶対値が 50 度を超えた際にステートが移行されるようになっています。  
> （よって、上記の説明のαは 5 度で実装しているということになります）


つまり上半身と下半身の向きが一致していないということです。  
この挙動は、主に以下の処理により実現しています。  

* 上半身の向きだけ変える処理
	* 操作した向きの回転をノード `AimOffset Player` のパラメータ `Yaw` に与える
	* 操作した向きと逆回転をルートボーンに与える（ノード `RotateRootBone` を利用）
	* これらが互いに打ち消し合うことで足が回転前の位置のまま滑らないようにしている
* 下半身の向きを変える処理
	* 事前の準備
		* 90 度向きを変えるための、ルートボーンが回転を行うアニメーションシーケンスを用意する
		* アニメーションモディファイア [TurnYawAnimModifier] を利用してフレームごとの回転をアニメーションカーブ `RemainingTurnYaw` にベイクする
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

## 3.2. TurnYawAnimModifier

* 既存のドキュメント
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]
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

* RemainingTurnYaw
	* 全フレームに自動的にキーを打っている。
		* 指定したボーン(root)の Yaw の最終フレームの値から現在のフレームの値を引いた値
* TurnYawWeight
	* 以下の３箇所に自動的にキーを打っている。
		* 0 フレーム目に値 1
		* 指定したボーン(root)の Yaw の最終フレームの値と同じになる前に値 1
		* 指定したボーン(root)の Yaw の最終フレームの値と同じになる後に値 0

これらの値を利用することで、振り向くアニメーションとエイムの向きに矛盾がなく、スムーズに繋がるように実装されています。















LeftHandPose_OverrideState
* 左手のポーズを上書きするための処理を記述するための関数です。
* [ALI_ItemAnimLayers::LeftHandPose_OverrideState] の実装では無効化されています。
	* 設定様変数で無効化されており、ブレンドのウェイト決定のためのアニメーションカーブを持つアニメーションがありません。









TODO: このへんから
書式統一の見直し。









TODO: Pivot とは？


# AnimGrap とアニメーションレイヤーの解説

`ABP_PistolAnimLayers` の場合のアセット名を例として書いておきます。

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
				> `BS_MM_RifleJog_Leans` は移動方向に顔を向けたり体を傾けたりする表現を行うためのブレンドスペースです。  
				> 以下などが参考になります。  
				> * https://www.youtube.com/watch?v=154aGaLIid0
				> * https://www.youtube.com/watch?v=UpTgdN-9yUo
				> * https://www.youtube.com/watch?v=flHL3qJB3_I
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
					> `Blend Masks` で `UpperBodyMask` を指定。
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
					> `Blend Masks` で `UpperBodyMask` を指定。
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
					> `Blend Masks` で `UpperBodyMask` を指定。
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
					> `Blend Masks` で `UpperBodyMask` を指定。
				4.  の出力が `OutputPose()` につながる。
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
					> `Blend Masks` で `UpperBodyMask` を指定。
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
					> `Blend Masks` で `UpperBodyMask` を指定。
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
					> `Blend Masks` で `UpperBodyMask` を指定。
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
					> `Blend Masks` で `UpperBodyMask` を指定。
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
					> `Blend Masks` で `UpperBodyMask` を指定。
				4. 3 の出力が `OutputPose()` につながる。
	> * ジャンプ中の処理の流れは、アニメーションが異なるだけで、主な流れは全く同じです。
2. [ALI_ItemAnimLayers::LeftHandPose_OverrideState]
	* 左手のポーズのために用意されているインターフェイスです。
	* パラメータ
		* `Input Pose`: 1 の出力
	* [ABP_ItemAnimLayersBase::FullBody_FallLandState]
		* 現状では何も起きないようにデータや変数が設定されています。
			> 本来は以下のような目的のものと思われます。
			> * 銃撃時の左手のポーズを左手の基本的なポーズとし、通常はそれをブレンドする。
			> * 上記を行いたくないアニメーションはアニメーションカーブで無効化する。
		* 処理の流れ
			1. 入力されたアニメーション
			2. 左手のアニメーション
				> 指定されていません。（ `None` となっている）
			3. 1 と 2 を `LayeredBlendPerBone()` で左手のみブレンドする。
				> `Blend Masks` で `LeftFingerMask` （ `hand_l` から先であり、左手）を指定。  
				> `Blend Weights 0` で [ABP_ItemAnimLayersBase::LeftHandPoseOverrideWeight] を指定。  
			4. 3 の出力が `OutputPose()` につながる。
			> この機能は以下の変数で設定している値により無効化されています。  
			> * アニメーションを指定する変数 [ABP_ItemAnimLayersBase::LeftHandPose_Override] が `None`
			> * `Blend Weights 0` に設定する変数 [ABP_ItemAnimLayersBase::LeftHandPoseOverrideWeight] が常に `0.0`
			> 	* 算出の際に利用する変数 [ABP_ItemAnimLayersBase::EnableLeftHandPoseOverride] が false
			> 	* 算出の際に利用するアニメーションカーブ `DisableLeftHandPoseOverride` を設定しているアニメーションが存在しない
3. 2 の出力をポーズキャッシュ `Locomotion` に保存
	* 以降の処理で複数のアニメーションモンタージュのソースポーズとして利用します。
4. `UpperBodyAdditive` スロット
	* 武器装備、解除、近接攻撃、リロード、空打ち、グレネード投擲を扱うスロットです。
	* パラメータ
		* `Source`: デフォルトの加算ポーズ `AdditiveIdentityPose()`
	> このスロットを使用しているモンタージュとアニメーションは以下のとおりです。  
	> * `AM_MM_Pistol_[DryFire|Equip|Reload|Melee]`
	> 	* `MM_Pistol_[DryFire|Equip|Reload|Melee]_Additive`
	> * `AM_MM_Generic_Unequip`
	> 	* `MM_Pistol_Equip_Additive`
	> * `AM_MM_Rifle_GrenadeToss`
	> 	* `MM_Rifle_GrenadeToss_Additive`
	> 
	> アニメーションシーケンスは `_Additive` が付いていないものを複製し、`AdditiveAnimType` を `LocalSpace` に変更したものと思われます。
5. `ApplyAdditive()`
	* 地上に居る際の全身の `UpperBodyAdditive` スロットとのブレンドです。
	* パラメータ
		* `Base`: ポーズキャッシュ `Locomotion`
		* `Additive`: 4 の出力
		* `Alpha`: [ABP_Mannequin_Base::UpperBodyDynamicAdditiveWeight]
			> [ABP_Mannequin_Base::UpperBodyDynamicAdditiveWeight] は地上でアニメーションモンタージュが再生中の場合は 1.0 となります。
6. `UpperBody` スロット
	* 武器装備、解除、近接攻撃、リロード、空打ち、グレネード投擲を扱うスロットです。
	* パラメータ
		* `Source`: ポーズキャッシュ `Locomotion`
	> このスロットを使用しているモンタージュとアニメーションは以下のとおりです。  
	> * `AM_MM_Pistol_[DryFire|Equip|Reload|Melee]`
	> 	* `MM_Pistol_[DryFire|Equip|Reload|Melee]`
	> * `AM_MM_Generic_Unequip`
	> 	* `MM_Pistol_Equip`
	> * `AM_MM_Rifle_GrenadeToss`
	> 	* `MM_Rifle_GrenadeToss`
7. `LayerdBlendPerBone()`
	* （地上に居るかに依らない）上半身のボーンのみの `UpperBody` スロットとのブレンドです。
	* パラメータ
		* `Base Pose`: 5 の出力
		* `Blend Pose 0`: 6 の出力
		* `Blend Weights 0`: 1.0 固定
		* `Blend Masks`: `UpperBodyLowerBodySplitMask` （ `spine_01` から先であり、上半身）
8. `FullBodyAdditivePreAim` スロット
	* 発砲を扱うスロットです。
	* パラメータ
		* `Source`: 7 の出力
	> このスロットを使用しているモンタージュとアニメーションは以下のとおりです。  
	> * `AM_MM_Pistol_Fire`
	> 	* `MM_Pistol_Fire`
	> 		> `AdditiveAnimType`: `MeshSpace`
	> 		> `BasePoseType`: `MM_Pistol_Fire`
	> 		> `RefFrameIndex`: 24 (`MM_Pistol_Fire` は 20 フレームしか存在しません（最終フレーム扱い？要確認）)
9. 8 の出力をポーズキャッシュ `UpperbodyLowerbodySplit` に保存
	* 以降の処理でアニメーションモンタージュのソースポーズとして利用します。（キャッシュを取っている理由は要確認）
10. [ALI_ItemAnimLayers::FullBody_Aiming]
	* エイムによるポーズのために用意されているインターフェイスです。
	* パラメータ
		* `Pre Aim Pose`: 9 の出力
		* `Aim Yaw`: [ABP_Mannequin_Base::AimYaw]
			> **Note**  
			> 詳しくは [所定の位置での旋回] を参照してください。
		* `Aim Pitch`: [ABP_Mannequin_Base::AimPitch]
			> **Note**  
			> この値は `NormalizeAxis(APawn::GetBaseAimRotation().Pitch)` です。  
	* [ABP_ItemAnimLayersBase::FullBody_Aiming]
		* 上半身を狙った向きにするアニメーションのブレンドを行っています。
			> ノード `AimOffset Player` を 2 つ使い、ブレンドしています。
			> これらは「武器を構えたもの」と、「武器を構えずに頭の向きだけ変えるもの」です。
			> 銃撃後の移動の際、両手を徐々に下げるような表現を行うためのものです。
		* 処理の流れ
			1. 入力されたポーズをポーズキャッシュ `BasePose` に保存
				> これはすぐ後で 2 つのノード `AimOffset Player` のパラメータ `Base Pose` で利用するためです。
			2. ノード `AimOffset Player` で武器を構えずに頭の向きだけ変えたポーズを出力
				> `AO_MM_Unarmed_IdleReady`
			3. ノード `AimOffset Player` で武器を構えたポーズを出力
				> `AO_MF_Pistol_Idle_ADS`
			4. 2 の出力と 3 の出力をノード `Blend` でブレンドする
			5. 4 の出力が `OutputPose()` につながる。
11. `AdditiveHitReact` スロット
	* ダメージを受けたときのリアクションを扱うスロットです。
	* パラメータ
		* `Source`: 10 の出力
	> このスロットを使用しているモンタージュとアニメーションは以下のとおりです。  
	> * `AM_MM_HitReact_[Back|Front|Left|Right]_[Lgt|Med|Hvy]_[01|02|03|04]`
	> 	* `MM_HitReact_[Back|Front|Left|Right]_[Lgt|Med|Hvy]_[01|02|03|04]`
	> 		> `AdditiveAnimType`: `LocalSpace`
	> 		> `BasePoseType`: ファイルごとにまちまちですが、自身を指定しているものがほとんどです。
	> 		> `RefFrameIndex`: 0
	>
	> 方向（前後左右）、威力（軽い普通重い）、バリエーション（最大 4 種）の組み合わせからなります。
12. [ALI_ItemAnimLayers::FullBodyAdditives]
	* 他の処理で行われていない、追加要素的なフルボディアニメーションのためのインターフェイスです。
	* [ABP_ItemAnimLayersBase::FullBodyAdditives]
		* ジャンプなどの着地後、通常状態に復帰するアニメーションに使用しています。
		* 処理の流れ
			1. [ABP_ItemAnimLayersBase::FullBodyAdditive_SM] の出力が `OutputPose()` につながる。
		* [ABP_ItemAnimLayersBase::FullBodyAdditive_SM]
			* ジャンプなどの着地に関する状態制御を行う。
			* [ABP_ItemAnimLayersBase::Identity (state)]
				* 地上に居る状態。
				* 処理の流れ
					* 何も出力しません。
			* [ABP_ItemAnimLayersBase::AirIdentity (state)]
				* 空中に居る状態。
				* 処理の流れ
					* 何も出力しません。
			* [ABP_ItemAnimLayersBase::LandRecovery (state)]
				* 地上に着いた直後の状態。
				* 処理の流れ
					1. デフォルトの加算ポーズ `AdditiveIdentityPose()`
					2. `Sequence Player()` で着地の復帰アニメーションを指定
						> * `MM_Pistol_Jump_RecoveryAdditive`
						> 	> `AdditiveAnimType`: `LocalSpace`
						> 	> `BasePoseType`: `MM_Pistol_Jump_RecoveryAdditive`
						> 	> `RefFrameIndex`: 22 (`MM_Pistol_Jump_RecoveryAdditive` は 21 フレームしか存在しません（最終フレーム扱い？要確認）)
					3. 1 の出力と 2 の出力をノード `Blend` でブレンドする
					4. 3 の出力が `OutputAnimationPose()` につながる。
13. `ApplyAdditive()`
	* 12 のポーズ（抽象的には追加要素的なフルボディアニメーション、具象的には着地アニメーション）とのブレンドです。
	* パラメータ
		* `Base`: 11 の出力
		* `Additive`: 12 の出力
		* `Alpha`: 0.65 固定
14. `FullBody` スロット
	* 全身を使うワンショット用アニメーションを扱うスロットです。
	* パラメータ
		* `Source`: 13 の出力
	> このスロットを使用しているモンタージュとアニメーションは以下のとおりです。  
	> * `AM_MF_Emote_FingerGuns`
	> 	* `MF_Emote_FingerGuns`
	> * `AM_MM_Dash_[Backward|Forward|Left|Right]`
	> 	* `MM_Dash_[Backward|Forward|Left|Right]`
	> * `AM_MM_Death_[Back|Front|Left|Right][_01|_02|_03]`
	> 	* `MM_Death_[Back|Front|Left|Right][_01|_02|_03]`
	> * `AM_MM_Pistol_Spawn`
	> 	* `MM_Pistol_Spawn_Turn180`
	>
	> エモート、ダッシュ、死亡、スポーンのフルボディアニメーションからなります。
* `Inertialization`
	* これは `Inertialization` (慣性化) を使う際に必要なノードです。
		* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > Blend ノード > Inertialization]
	> `Inertialization` は以下で使用しています。  
	> * [ABP_Mannequin_Base::LocomotionSM] 内の以下のルール
	> 	* [ABP_Mannequin_Base::Start to Cycle (rule)]
	> 	* [ABP_Mannequin_Base::Pivot to Cycle (rule)]
	> 	* [ABP_Mannequin_Base::Stop to Idle (rule)]
	> * [ABP_ItemAnimLayersBase::IdleSM] 内の以下のルール
	> 	* [ABP_ItemAnimLayersBase::TurnInPlaceRecovery to Idle (rule)]
	> 	* [ABP_ItemAnimLayersBase::WantsTurnInPlace (rule)]
	> 	* [ABP_ItemAnimLayersBase::TurnInPlaceRotation to TurnInPlaceRecovery (rule)]
	> * [ABP_ItemAnimLayersBase::IdleStance] 内の以下のルール
	> 	* [ABP_ItemAnimLayersBase::Idle to StanceTransition (rule)]
	> 	* [ABP_ItemAnimLayersBase::StanceTransition to Idle (rule)]
	> * [ABP_ItemAnimLayersBase::PivotSM] 内の以下のルール
	> 	* [ABP_ItemAnimLayersBase::WantsToRePivit (rule)]
* `Rotate Root Bone`
	* `Turn In Place` 処理の一環です。
	* 移動停止時の足の向きを維持するため、コントローラーのヨー回転を打ち消す回転をルートボーンに与えています。
* [ALI_ItemAnimLayers::FullBody_SkeletalControls]
	* IK 等のためのインターフェイスです。
	* [ABP_ItemAnimLayersBase::FullBody_SkeletalControls]
		* 概ね以下のことを行っています。
			* Manne と Quin の比率差による武器の位置調整
			* 武器の位置に手をあわせる
			* 床の位置に足を合わせ、腰も連動させる
			* 武器をしまう際など、武器用ボーンのスケールを小さくする
		* 処理の流れ
			1. `Hand IK Retargeting`
				* 比率の異なるキャラクター Manne と Quin の、比率の差による不自然な動きの低減をしています。
				* 右手を優先し、武器用のボーンを動かすことで左手の位置の調整を行います。
			2. `Copy Bone`
				* ボーン `VB_IK_Hand_L_weaponSpace` のトランスフォームをボーン `ik_hand_l` にコピーします。
				* この後の　`Two Bone IK` のための処理です。
			3. `Transform (modify) Bone`
				* ControlRig を使用する場合は Z 軸に -2.0 の平行移動を行います。
					* （プロジェクトの初期状態では ControlRig を使用しないようになっています。）
			4. `Two Bone IK`
				* 一つ目が右手用、二つ目が左手用の IK です。
				* 詳細
					* パラメータ `IKBone`
						* ボーン `hand_r` / `hand_l` （手首）を指定しています。
					* パラメータ `Effector Target`
						* ボーン `ik_hand_r` / `ik_hand_l` を指定しています。
					* パラメータ `Joint Target`
						* ボーン `lowerarm_r` / `lowerarm_l` （肘）を指定しています。
					* パラメータ `Joint Target Location`
						* (0.0, 50.0, 0.0) / (0.0, -50.0, 0.0) （肘から手首に向かう逆方向 50）を指定しています。
					* パラメータ `Take Rotation from Effector Space`
						* 左手用だけ true に変更しています。
			5. `Foot Placement`
				* レイを使った地面の検出、腰の FK ボーンと足の IK ボーンの制御を行うノードです。
				* ここでは足腰が地面にマッチするように使用しています。
				* ジャンプ中は無効になるようパラメータ `Enabled` が設定されています。
				* 詳細
					* パラメータ `Enabled`
						* [ABP_ItemAnimLayersBase::ShouldEnableFootPlacement()] を指定しています。
					* パラメータ `Settings > Plant Settings > Lock Type`
						* `Unlocked` （Lock しない）を指定しています。
			6. `Leg IK`
				* 足用の IK です。
				* 詳細
					* パラメータ `Alpha`
						* 1 - (アニメーションカーブ `DisableLegIK`) を指定しています。
						* アニメーションカーブ `DisableLegIK` について
							* 以下で設定されています。
								* AM_MM_Dash_Forward
								* MM_Pistol_Jump_Apex
								* MM_Pistol_Jump_Fall_Land
								* MM_Pistol_Jump_Fall_Loop
								* MM_Pistol_Jump_Start
								* MM_Pistol_Jump_Start_Loop
							* `[0.0, 1.0]` の値が設定されています。
								* 足を地面から離したい間は 1.0 、着けたい間は 0.0 に設定されています。
							* このアニメーションカーブを設定するアニメーションモディファイアはありません。つまり手付けのようです。
						* つまり地面から足を離したアニメーション中は無効ということです。
			7. `Transform (modify) Bone`
				* ノードコメント
					> Scaling down the weapon during the equips  
					> 
					> ----
					> 装備中に武器をスケールダウンさせる。
				* 武器を装備するモーション中などで武器のスケールを変更するためのノードです。
				* 詳細
					* パラメータ `Bone to Modifiy`
						* ボーン `weapon_r` （武器接続専用ボーン）を指定しています。




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



TODO: やってることの整理、とりあえずクラスごとに分けましょう。連番リストだと内容が重すぎて終わってるので段落なんかを使うように文章整理しましょう。

[Unreal Engine Forum > Update to UE5.1 have anim layer bug]: https://forums.unrealengine.com/t/update-to-ue5-1-have-anim-layer-bug/693524

[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]: https://docs.unrealengine.com/5.1/ja/animation-modifiers-in-unreal-engine/

[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > 所定の位置での旋回]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/#%E6%89%80%E5%AE%9A%E3%81%AE%E4%BD%8D%E7%BD%AE%E3%81%A7%E3%81%AE%E6%97%8B%E5%9B%9E

[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]: https://docs.unrealengine.com/5.1/ja/using-animation-blueprint-linking-in-unreal-engine/

[技術ブログ > Lyra アニメーションを UE5 ゲームに適応する方法について]: https://www.unrealengine.com/ja/tech-blog/adapting-lyra-animation-to-your-ue5-game


<!-- links -->

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[所定の位置での旋回]: #section
[ABP_ItemAnimLayersBase]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbase
[ABP_ItemAnimLayersBase::FullBodyAdditives]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyadditives
[ABP_ItemAnimLayersBase::FullBodyAdditive_SM]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyadditivesm
[ABP_ItemAnimLayersBase::Identity (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidentity-state
[ABP_ItemAnimLayersBase::AirIdentity (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseairidentity-state
[ABP_ItemAnimLayersBase::LandRecovery (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaselandrecovery-state
[ABP_ItemAnimLayersBase::FullBody_IdleState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyidlestate
[ABP_ItemAnimLayersBase::IdleSM]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidlesm
[ABP_ItemAnimLayersBase::Idle (state){in IdleSM}]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidle-statein-idlesm
[ABP_ItemAnimLayersBase::IdleBreak (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidlebreak-state
[ABP_ItemAnimLayersBase::TurnInPlaceRotation (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseturninplacerotation-state
[ABP_ItemAnimLayersBase::TurnInPlaceRecovery (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseturninplacerecovery-state
[ABP_ItemAnimLayersBase::WantsTurnInPlace (rule)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasewantsturninplace-rule
[ABP_ItemAnimLayersBase::TurnInPlaceRotation to TurnInPlaceRecovery (rule)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseturninplacerotation-to-turninplacerecovery-rule
[ABP_ItemAnimLayersBase::TurnInPlaceRecovery to Idle (rule)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseturninplacerecovery-to-idle-rule
[ABP_ItemAnimLayersBase::IdleStance]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidlestance
[ABP_ItemAnimLayersBase::Idle (state){in IdleStance}]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidle-statein-idlestance
[ABP_ItemAnimLayersBase::StanceTransition (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasestancetransition-state
[ABP_ItemAnimLayersBase::Idle to StanceTransition (rule)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseidle-to-stancetransition-rule
[ABP_ItemAnimLayersBase::StanceTransition to Idle (rule)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasestancetransition-to-idle-rule
[ABP_ItemAnimLayersBase::FullBody_StartState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodystartstate
[ABP_ItemAnimLayersBase::FullBody_CycleState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodycyclestate
[ABP_ItemAnimLayersBase::FullBody_StopState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodystopstate
[ABP_ItemAnimLayersBase::FullBody_PivotState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodypivotstate
[ABP_ItemAnimLayersBase::PivotSM]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasepivotsm
[ABP_ItemAnimLayersBase::PivotA (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasepivota-state
[ABP_ItemAnimLayersBase::PivotB (state)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasepivotb-state
[ABP_ItemAnimLayersBase::WantsToRePivit (rule)]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasewantstorepivit-rule
[ABP_ItemAnimLayersBase::FullBody_Aiming]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyaiming
[ABP_ItemAnimLayersBase::FullBody_JumpStartState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyjumpstartstate
[ABP_ItemAnimLayersBase::FullBody_JumpApexState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyjumpapexstate
[ABP_ItemAnimLayersBase::FullBody_FallLandState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyfalllandstate
[ABP_ItemAnimLayersBase::FullBody_FallLoopState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyfallloopstate
[ABP_ItemAnimLayersBase::FullBody_JumpStartLoopState]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyjumpstartloopstate
[ABP_ItemAnimLayersBase::FullBody_SkeletalControls]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyskeletalcontrols
[ABP_ItemAnimLayersBase::ShouldEnableFootPlacement()]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseshouldenablefootplacement
[ABP_ItemAnimLayersBase::LeftHandPose_Override]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaselefthandposeoverride
[ABP_ItemAnimLayersBase::EnableLeftHandPoseOverride]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaseenablelefthandposeoverride
[ABP_ItemAnimLayersBase::LeftHandPoseOverrideWeight]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbaselefthandposeoverrideweight
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
[ABP_Mannequin_Base::Start to Cycle (rule)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasestart-to-cycle-rule
[ABP_Mannequin_Base::Stop to Idle (rule)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasestop-to-idle-rule
[ABP_Mannequin_Base::Pivot to Cycle (rule)]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbasepivot-to-cycle-rule
[ABP_Mannequin_Base::ShouldEnableControlRig()]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaseshouldenablecontrolrig
[ABP_Mannequin_Base::AdditiveLeanAngle]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaseadditiveleanangle
[ABP_Mannequin_Base::UpperbodyDynamicAdditiveWeight]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaseupperbodydynamicadditiveweight
[ABP_Mannequin_Base::AimPitch]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaseaimpitch
[ABP_Mannequin_Base::AimYaw]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbaseaimyaw
[ALI_ItemAnimLayers]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayers
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
[Dev Comunity > Forums > How to get a anim layer node reference as shown in the Lyra Example project?]: https://forums.unrealengine.com/t/how-to-get-a-anim-layer-node-reference-as-shown-in-the-lyra-example-project/663840
[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation
[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】 > p159]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation#p159
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション ノードのリファレンス > Blend ノード > Inertialization]: https://docs.unrealengine.com/5.1/ja/animation-blueprint-blend-nodes-in-unreal-engine/#inertialization
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]: https://docs.unrealengine.com/5.1/ja/using-animation-blueprint-linking-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > エイム オフセットを作成する]: https://docs.unrealengine.com/5.1/ja/creating-an-aim-offset-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > レイヤー化されたアニメーションを使用する]: https://docs.unrealengine.com/5.1/ja/using-layered-animations-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション > 所定の位置での旋回]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/#%E6%89%80%E5%AE%9A%E3%81%AE%E4%BD%8D%E7%BD%AE%E3%81%A7%E3%81%AE%E6%97%8B%E5%9B%9E
