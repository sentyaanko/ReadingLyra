# 【UE5】Lyra に学ぶ(09) AnimationAssets <!-- omit in toc -->

UE5 の新しい？サンプル [Lyra Starter Game] 。  
キャラクター用のアニメーション関連のアセットはどのようなものがあるのかを見ていきます。  

* バージョン
	* [Lyra Starter Game]
		* 2022/11/29 版(5.1 用)


# 0. 基本的なルール

## 0.1. 命名規則

* 男性用 / 女性用でそれぞれ MM / MF と付きます。
* 武器種ごとに別のアセットがある場合、 Pistol / Rifle/ Shotgun / Unarmed と付きます。
* 武器種によらないものは武器名が省略されています。
	* 例：ダッシュなど。
* すべてアセットがあるわけではなく、用意されていないものは別の性別、武器種のものが設定されています。
	* 例：Shotgun はその殆どが Rifle を流用しています。 Crouch は MM のアセットしかありません。
* 命名規則から外れるケースがあります。詳細は Note 列の番号を元に表の下の Note を参照してください。

## 0.2. 表の見方
* 命名規則の表
	* 命名規則の列はアセット名を正規表現にしたものです。
* アセットの有無の表
	* Pistol / Rifle/ Shotgun / Unarmed の列が武器種ごとのアセットの存在状況です。
		* 一文字目が男性用の情報、二文字目が女性用の情報です。
		* M: 男性用がある
		* F: 女性用がある
		* -: アセットがない
		* *: Note に特記事項がある
	* 例: `[MF|MM]_[Pistol|Rifle|Shotgun|Unarmed]_Idle_ADS`
		* Rifle 列が `-F` 、 Shotgun 列が `M-` となっており、これは以下の2ファイルが存在することを意味しています。
			* `MF_Rifle_Idle_ADS`
			* `MM_Shotgun_Idle_ADS`


# 1. ABP_ItemAnimLayersBase の派生クラスのプロパティに設定されているアセット

遠隔武器の基底クラスである [ABP_ItemAnimLayersBase] には Animation Sequence や Aim Offset を設定するプロパティがあります。  
これらは派生クラスで適切なアセットを指定できるようにするためのものす。  
派生クラスは(男女 2) x (武器種 3 + 非武装 1) で合計 8 つあります。  


## 1.1. プロパティ名と設定されているアセットの命名規則

| gruup						| variable name						| 命名規則																					| Note	|
|----						|----								|----																						|----	|
| Anim Set - Idle			| Idle ADS							| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_ADS`										| *1	|
|							|									| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Ready`									| *1	|
|							| Idle Hipfire						| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Hipfire`									| *2	|
|							|									| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Ready`									| *2	|
|							| Idle Breaks						| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_IdleBreak_Fidget`								| 		|
|							|									| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_IdleBreak_Scan`								|		|
|							|									| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Break`									|		|
|							| Crouch Idle						| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Idle`									|		|
|							| Crouch Entry						| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Entry`									|		|
|							| Crouch Exit						| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Exit`									|		|
|							| Left Hand Pose Override			| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Hipfire`									| *3	|
| Anim Set - Starts			| Jog Start Cardinals				| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_[Bwd\|Fwd\|Left\|Right]_Start`			| 		|
|							| ADS Start Cardinals				| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Walk_[Bwd\|Fwd\|Left\|Right]_Start`			| 		|
|							| Crouch Start Cardinals			| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Walk_[Bwd\|Fwd\|Left\|Right]_Start`	| 		|
| Anim Set - Stops			| Jog Stop Cardinals				| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_[Bwd\|Fwd\|Left\|Right]_Stop`				| 		|
|							| ADS Stop Cardinals				| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Walk_[Bwd\|Fwd\|Left\|Right]_Stop`			| 		|
|							| Crouch Stop Cardinals				| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Walk_[Bwd\|Fwd\|Left\|Right]_Stop`		| 		|
| Anim Set - Pivots			| Jog Pivot Cardinals				| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_[Bwd\|Fwd\|Left\|Right]_Pivot`			| 		|
|							| 									| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_Pivot_[Bwd\|Fwd\|Left\|Right]`			| 		|
|							| ADS Pivot Cardinals				| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Walk_[Bwd\|Fwd\|Left\|Right]_Pivot`			| 		|
|							| Crouch Pivot Cardinals			| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Walk_[Bwd\|Fwd\|Left\|Right]_Pivot`	| 		|
| Anim Set - Turn in Place	| Turn in Place Left/Right			| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Turn[Left\|Right]_90`							| 		|
|							| Crouch Turn in Place Left/Right	| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Turn[Left\|Right]_90`					| 		|
| Anim Set - Jog			| Jog Cardinals						| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_[Bwd\|Fwd\|Left\|Right]`					| 		|
| Anim Set - Jump			| Jump Start						| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Start`									| 		|
|							| Jump Apex							| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Apex`									| 		|
|							| Jump Fall Land					| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Fall_Land`								| 		|
|							| Jump Recovery Additive			| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_RecoveryAdditive`						| 		|
|							| Jump Start Loop					| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Start_Loop`								| 		|
|							| Jump Fall Loop					| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Fall_Loop`								| 		|
| Anim Set - Walk			| Walk Cardinals					| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Walk_[Bwd\|Fwd\|Left\|Right]`					| 		|
|							| Crouch Walk Cardinals				| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Walk_[Bwd\|Fwd\|Left\|Right]`			| 		|
| Anim Set - Aiming			| Aim Hip Fire Pose					| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Hipfire_OverridePose`							| 		|
|							| 									| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Hipfire`									| 		|
|							| Aim Hip Fire Pose Crouch			| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_OverridePose`							| 		|
|							| Idle Aim Offset					| `AO_[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Ready`								| 		|
|							| 									| `AO_[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Hipfire`								| 		|
|							| 									| `AO_[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_ADS`									| 		|
|							| Relaxed Aim Offset				| `AO_[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Ready`								| 		|

> **Note**  
> * *1,2.	武器を持っている場合は上の、持っていない場合は下の命名規則のアセットを使用します。
> * *3.	このプロパティが設定されているのは Shotgun 用の `ABP_ShotgunAnimLayers(_Feminine)?` のみです。

## 1.2. 命名規則ごとのアセットの有無

| 命名規則																					| Pistol	| Rifle	| Shotgun	| Unarmed	| Note	|
|----																						|----		|----	|----		|----		|----	|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Ready`									| --		| --	| --		| MF		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Hipfire`									| MF		| -F	| MF		| --		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_ADS`										| --		| -F	| M-		| --		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_IdleBreak_Fidget`								| --		| MF	| --		| M-		| *1	|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_IdleBreak_Scan`								| MF		| M-	| --		| M-		|		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Break`									| --		| --	| --		| -F		|		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Idle`									| M-		| M-	| --		| M-		|		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Entry`									| M-		| M-	| --		| M-		|		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Exit`									| M-		| M-	| --		| M-		|		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_[Bwd\|Fwd\|Left\|Right]_Start`			| MF		| MF	| --		| MF		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_[Bwd\|Fwd\|Left\|Right]_Stop`				| MF		| MF	| --		| MF		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_[Bwd\|Fwd\|Left\|Right]_Pivot`			| -F		| MF	| --		| *F		| *2	|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_Pivot_[Bwd\|Fwd\|Left\|Right]`			| M-		| --	| --		| *-		| *2	|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_[Bwd\|Fwd\|Left\|Right]`					| MF		| MF	| --		| MF		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Walk_[Bwd\|Fwd\|Left\|Right]_Start`			| M*		| MF	| --		| MF		| *3	|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Walk_[Bwd\|Fwd\|Left\|Right]_Stop`			| MF		| MF	| --		| MF		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Walk_[Bwd\|Fwd\|Left\|Right]_Pivot`			| M-		| MF	| --		| MF		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Walk_[Bwd\|Fwd\|Left\|Right]`					| MF		| MF	| --		| MF		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Walk_[Bwd\|Fwd\|Left\|Right]_Start`	| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Walk_[Bwd\|Fwd\|Left\|Right]_Stop`		| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Walk_[Bwd\|Fwd\|Left\|Right]_Pivot`	| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Walk_[Bwd\|Fwd\|Left\|Right]`			| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Turn[Left\|Right]_90`							| MF		| MF	| --		| MF		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Turn[Left\|Right]_90`					| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Start`									| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Apex`									| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Fall_Land`								| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_RecoveryAdditive`						| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Start_Loop`								| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jump_Fall_Loop`								| M-		| M-	| --		| M-		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Hipfire_OverridePose`							| -F		| M-	| --		| --		| 		|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_OverridePose`							| M-		| M-	| --		| --		| 		|
| `AO_[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Ready`								| --		| --	| --		| M-		| 		|
| `AO_[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Hipfire`								| --		| M-	| --		| --		| 		|
| `AO_[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_ADS`									| MF		| M-	| --		| --		| *4	|

> **Note**  
> * *1.	`Mf_Rifle_IdleBreak_Fidget` だけ命名規則に沿わずに `Mf` となっています。（おそらく命名ミス）
> * *2.	`MM_Unarmed_Jog_Right_Pivot` だけアセットがなく、代わりに `MM_Unarmed_Jog_Pivot_Right` があります。（おそらく命名ミス）
> * *3.	`MF_Pistol_Walk_Left_Start` だけアセットがありません。（おそらく作成漏れ）
> * *4. `AO_MM_Rifle_Idle_ADS` だけ参照元がありません。	


# 2. Blend Space 1D から利用されているアセット

## 2.1. 各 Blend Space 1D の用途と参照元

各 Blend Space 1D の用途と参照元は以下のとおりです。

| Blend Space 1D			| 用途										| 参照元				|
|----						|----										|----					|
| `BS_MM_Rifle_Jog_Leans`	| カメラの回転に合わせた顔の向きと体の傾き	| [ABP_Mannequin_Base]	|
| `BS_MM_Rifle_Crouch_Walk`	| 移動方向に合わせたしゃがみ歩き			| 参照元なし			|
| `BS_MM_Unarmed_Jog_Walk`	| 非武装時の速度に合わせた歩きから走り		| 参照元なし			|

つまり `BS_MM_Rifle_Jog_Leans` 以外は使われていません。  
また、 `BS_MM_Rifle_Jog_Leans` は [ABP_Mannequin_Base] で指定されており、武器種などのバリエーションもありません。

## 2.2. 各 Blend Space 1D で使用しているアセットの命名規則

| Blend Space 1D			| 命名規則											| Note	|
|----						|----												|----	|
| `BS_MM_Rifle_Jog_Leans`	| `MM_Rifle_Jog_Lean(s)?_[Center\|Left\|Right]`		| *1	|
| `BS_MM_Rifle_Crouch_Walk`	| `MM_Rifle_Crouch_Walk_[Fwd\|Bwd\|Left\|Right]`	|		|
| `BS_MM_Unarmed_Jog_Walk`	| `MM_Unarmed_[Walk\|Jog]_Fwd`						|		|

> **Note**  
> * *1.	`MM_Rifle_Jog_Leans_Left` のみ `Leans` と `s` が付きます。（おそらく命名ミス）


# 3. Aim Offset から利用されているアセット

## 3.1. 各 Aim Offset の参照元

| Aim Offset					| 参照元							| variable name											| Note	|
|----							|----								|----													|----	|
| `AO_MM_Pistol_Idle_ADS`		| `ABP_PistolAnimLayers`			| Idle Aim Offset										| 		|
| `AO_MF_Pistol_Idle_ADS`		| `ABP_PistolAnimLayers_Feminine`	| Idle Aim Offset										| 		|
| `AO_MM_Rifle_Crouch_Idle`		| 参照元なし						| 														| 		|
| `AO_MM_Rifle_Idle_ADS`		| 参照元なし						| 														| 		|
| `AO_MM_Rifle_Idle_Hipfire`	| `ABP_RifleAnimLayers`				| Idle Aim Offset										| 		|
|								| `ABP_RifleAnimLayers_Feminine`	| Idle Aim Offset										| 		|
|								| `ABP_ShotgunAnimLayers`			| Idle Aim Offset										| 		|
|								| `ABP_ShotgunAnimLayers_Feminine`	| Idle Aim Offset										| 		|
| `AO_MM_Unarmed_Idle_Ready`	| `ABP_ItemAnimLayersBase`			| Idle Aim Offset / Relaxed Aim Offset のデフォルト値	| *1	|
|								| `ABP_PistolAnimLayers`			| Relaxed Aim Offse										| 		|
|								| `ABP_PistolAnimLayers_Feminine`	| Relaxed Aim Offse										| 		|
|								| `ABP_RifleAnimLayers`				| Relaxed Aim Offse										| 		|
|								| `ABP_RifleAnimLayers_Feminine`	| Relaxed Aim Offse										| 		|
|								| `ABP_UnarmedAnimLayers`			| Relaxed Aim Offse										| 		|
|								| `ABP_UnarmedAnimLayers_Feminine`	| Relaxed Aim Offse										| 		|

> **Note**  
> * *1.	[ABP_ItemAnimLayersBase] `> FullBody_Aiming` 内の `AimOffset Player` のパラメータ `Blend Space` のデフォルト値です。  
> 	変数にバインドされており、派生クラスで変更できるようになっています。
> 	`Yaw` と `Pitch` を受け取れるようにするために参照を残しているようです。

参照元から見ると以下のようになります。

| 参照元							| Idle Aim Offset				| Relaxed Aim Offset			|
|----								|----							|----							|
| `ABP_PistolAnimLayers`			| `AO_MM_Pistol_Idle_ADS`		| `AO_MM_Unarmed_Idle_Ready`	|
| `ABP_PistolAnimLayers_Feminine`	| `AO_MF_Pistol_Idle_ADS`		| `AO_MM_Unarmed_Idle_Ready`	|
| `ABP_RifleAnimLayers`				| `AO_MM_Rifle_Idle_Hipfire`	| `AO_MM_Unarmed_Idle_Ready`	|
| `ABP_RifleAnimLayers_Feminine`	| `AO_MM_Rifle_Idle_Hipfire`	| `AO_MM_Unarmed_Idle_Ready`	|
| `ABP_ShotgunAnimLayers`			| `AO_MM_Rifle_Idle_Hipfire`	| `AO_MM_Unarmed_Idle_Ready`	|
| `ABP_ShotgunAnimLayers_Feminine`	| `AO_MM_Rifle_Idle_Hipfire`	| `AO_MM_Unarmed_Idle_Ready`	|
| `ABP_UnarmedAnimLayers`			| `AO_MM_Unarmed_Idle_Ready`	| `AO_MM_Unarmed_Idle_Ready`	|
| `ABP_UnarmedAnimLayers_Feminine`	| `AO_MM_Unarmed_Idle_Ready`	| `AO_MM_Unarmed_Idle_Ready`	|

つまり、 `AO_MM_Rifle_Crouch_Idle` と `AO_MM_Rifle_Idle_ADS` は使われていません。  
また、他のアセットは [ABP_ItemAnimLayersBase] のプロパティ Idle Aim Offset / Relaxed Aim Offset で指定されています。  
各プロパティの用途は以下のようになっています。

| gruup						| variable name						| 用途									|
|----						|----								|----									|
| Anim Set - Aiming			| Idle Aim Offset					| カメラの向いている方向に銃を向ける	|
|							| Relaxed Aim Offset				| 移動中など、銃を下げる				|

状況に応じてこれら二つの Aim Offset をブレンドするように実装しています。

## 3.2. 各 Aim Offset で使用しているアセットの命名規則

| Aim Offset					| 命名規則												| Note	|
|----							|----													|----	|
| `AO_MM_Pistol_Idle_ADS`		| `MM_Pistol_Idle_ADS_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`	| 		|
|								| `MM_Pistol_Idle_ADS`									| *1	|
| `AO_MF_Pistol_Idle_ADS`		| `MF_Pistol_Idle_ADS_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`	| 		|
|								| `MF_Pistol_Idle_ADS`									| *1	|
| `AO_MM_Rifle_Crouch_Idle`		| `MM_Rifle_Crouch_Idle_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`	| 		|
|								| `MM_Rifle_Crouch_Idle`								| *1	|
| `AO_MM_Rifle_Idle_ADS`		| `MM_Rifle_Idle_ADS_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`		| 		|
|								| `MM_Rifle_Idle_ADS`									| *1	|
| `AO_MM_Rifle_Idle_Hipfire`	| `MM_Rifle_Idle_Hipfire_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`	| 		|
|								| `MM_Rifle_Idle_ADS`									| *1,2	|
| `AO_MM_Unarmed_Idle_Ready`	| `MM_Unarmed_Idle_Ready_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`	| 		|
|								| `MM_Unarmed_Idle_Ready`								| *1	|

> **Note**  
> * *1.	`Additive Setting > Preview Base Pose` で指定しています。
> * *2.	命名規則から `MM_Rifle_Idle_Hipfire` を使うべきだと思いますが、 そうしていない理由は不明です。  
> 	Editor Only の Preview 用のプロパティなのであまり気にする必要はないと思います。  
> 	アセット名に ADS や Hipfire と付いていますが、現在の実装ではそれらとは特に関係していません。    
> 	ADS 中と腰撃ち中に別のエイムオフセットを使うような実装はされていないので、実行時は状況によりプレビュー時とは異なる見た目になりえます。

命名規則の `[LB|L|C|R|RB][U|C|D]` は `[左後|左|正面|右|右後][上|正面|下]` のバリエーションです。

## 3.3. 命名規則ごとのアセットの有無

| 命名規則																					| Pistol	| Rifle	| Shotgun	| Unarmed	| Note	|
|----																						|----		|----	|----		|----		|----	|
| `[MM\|MF]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_ADS`										| MF		| M-	| --		| --		| 		|
| `[MM\|MF]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_ADS_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`		| MF		| M-	| --		| --		| *1	|
| `[MM\|MF]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Hipfire_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`	| --		| M-	| --		| --		| 		|
| `[MM\|MF]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Ready`									| --		| --	| --		| MF		| *2	|
| `[MM\|MF]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Idle_Ready_AO_[LB\|L\|C\|R\|RB][U\|C\|D]`		| --		| --	| --		| M-		| 		|

> **Note**  
> * *1.	`MM_Rifle_Idle_ADS_AO_[LB|L|C|R|RB][U|C|D]` は（参照されていない  `AO_MM_Rifle_Idle_ADS` からしか利用されていないため）利用されていません。
> * *2.	`MF_Unarmed_Idle_Ready` は Aim Offset からは利用されていません。
> 	> 非武装時のプロパティ Idle ADS などで利用されています。


# 4. Animation Montage から利用されているアセット

## 4.1. 各 Animation Montage の参照元

アニメーションモンタージュは以下のような場所から再生されます。
* GameplayAbility
* GameplayCueNotify
* キャラクターや武器のブループリント


| 用途							| アニメーションモンタージュ									| アニメーションシーケンス									| Note	|
|----							|----															|----														|----	|
| エモート用					| `AM_MF_Emote_FingerGuns`										| `MF_Emote_FingerGuns`										|		|
| ダッシュ用					| `AM_MM_Dash_[Backward\|Forward\|Left\|Right]`					| `MM_Dash_[Backward\|Forward\|Left\|Right]`				|		|
| 死亡時のリアクション用		| `AM_MM_Death_[Back\|Front\|Left\|Right]_01`					| `MM_Death_[Back\|Front\|Left\|Right]_01`					|		|
| 								| `AM_MM_Death_Front_0[2-3]`									| `MM_Death_Front_0[2-3]`									|		|
| 被ダメージのリアクション用	| `AM_MM_HitReact_[Back\|Front\|Left\|Right]_[Lgt\|Med]_01`		| `MM_HitReact_[Back\|Front\|Left\|Right]_[Lgt\|Med]_01`	| *1	|
| 								| `AM_MM_HitReact_Front_Lgt_0[2-4]`								| `MM_HitReact_Front_Lgt_0[2-4]`							| *1	|
| 								| `AM_MM_HitReact_Front_Med_02`									| `MM_HitReact_Front_Med_02`								|		|
| 								| `AM_MM_HitReact_Front_Hvy_01`									| `MM_HitReact_Front_Hvy_01`								|		|
| 装備解除用					| `AM_MM_Generic_Unequip`										| `MM_Pistol_Equip(_Additive)?`								| *2	|
| 装備用						| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Equip`				| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Equip(_Additive)?`	| *2	|
| 空打ち用						| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_DryFire`				| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_DryFire(_Additive)?`| *2	|
| 発砲用						| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Fire`				| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Fire`				|		|
| 近接攻撃用					| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Melee`				| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Melee(_Additive)?`	| *2	|
| リロード用					| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Reload`				| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Reload(_Additive)?`	| *2	|
| スポーン用					| `AM_MM_Pistol_Spawn`											| `MM_Pistol_Spawn_Turn180`									| *3	|
| グレネード用					| `AM_MM_Rifle_GrenadeToss`										| `MF_Rifle_GrenadeToss(_Additive)?`						| *2,4	|
| TopDownArena の爆弾設置用		| `DropBomb_Montage`											| `MF_Rifle_GrenadeToss`									|		|
| 参照元なし					| `AM_MM_Dash_Forward_LoadingScreenStills`						| `MM_Dash_Forward_LoadingScreenStills`						|		|

> **Note**  
> * *1. 以下のアセットのバリエーションは参照元がなく、使用されていません。
> 	* AM_MM_HitReact_Back_Lgt_01
> 	* AM_MM_HitReact_Front_Lgt_03
> 	* AM_MM_HitReact_Front_Lgt_04
> 	* AM_MM_HitReact_Left_Lgt_01
> 	* AM_MM_HitReact_Right_Lgt_01
> * *2. `_Additive` のバリエーションを持つアニメーションがいくつかあります。  
>	* `_Additive` が付いていない方は、（地上に居るかに依らない）上半身のボーンのみをブレンドするためのものです。  
>		> これを使わないと、空中にいるときにアニメーションがブレンドされません。
>	* `_Additive` が付いている方は、地上に居る際の（下半身を含む）全身のブレンドをするためのものです。  
>		> これを使わないと、下半身のアニメーションがブレンドされません。
> * *3.	初期武器が Pistol の為、他の武器用のバリエーションは使用していません。
> * *4.	Rifle と付いていますが、武器に依らず同じアセットを使用しています。

## 4.2. 命名規則ごとのアセットの有無

| 命名規則																					| Pistol	| Rifle	| Shotgun	| Unarmed	| Note	|
|----																						|----		|----	|----		|----		|----	|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Equip(_Additive)?`									| M-		| M-	| --		| --		| 		|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_DryFire(_Additive)?`								| M-		| M-	| --		| --		| 		|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Fire`												| M-		| M-	| M-		| --		| 		|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Melee(_Additive)?`									| M-		| M-	| M-		| --		| 		|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Reload(_Additive)?`									| M-		| M-	| M-		| --		| 		|
| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Equip`											| M-		| M-	| --		| --		| 		|
| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_DryFire`											| M-		| M-	| --		| --		| 		|
| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Fire`											| M-		| M-	| M-		| --		| 		|
| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Melee`											| M-		| M-	| M-		| --		| 		|
| `AM_MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Reload`											| M-		| M-	| M-		| --		| 		|


# 5. Animation Sequence と Pose Asset のペア

## 5.1. 各 Animation Sequence と Pose Asset の参照元

| type						| 命名規則																				|
|----						|----																					|
| Animation Sequence		| `[Manny\|Quinn]_[calf\|clavicle\|foot\|hand\|lowerarm\|thigh\|upperarm]_[l\|r]_anim`	|
| Pose Asset				| `[Manny\|Quinn]_[calf\|clavicle\|foot\|hand\|lowerarm\|thigh\|upperarm]_[l\|r]_pose`	|

命名規則の `[Manny|Quinn]_[calf|clavicle|foot|hand|lowerarm|thigh|upperarm]_[l|r]` は `[男女]_[関節名]_[左右]` のバリエーションです。  

Animation Sequence は Pose Asset から参照されます。　　
Pose Asset は `ABP_[Manny|Quinn]_PostProcess` から利用されています。　　
`ABP_[Manny|Quinn]_PostProcess` は、 `SKM_[Manny|Quinn]` のプロパティ `Post Process Anim Blueprint` で指定されています。　　
用途は未確認です。

## 5.2. 命名規則ごとのアセットの有無

Animation Sequence と Pose Asset 、どちらも (男女 2) x (関節 7) x (左右 2) の 28 のバリエーションを持っています。


# 用途不明なアセット

参照元がなく、用途不明なアセットです。

| 命名規則																					| Pistol	| Rifle	| Shotgun	| Unarmed	| Note	|
|----																						|----		|----	|----		|----		|----	|
| `MM_Dash_Forward_LoadingScreen_Still_[A-E]`												| **		| **	| **		| **		| *1	|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Crouch_Turn[Left\|Right]_180`						| M-		| M-	| --		| M-		| *2	|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_Stop`											| M-		| --	| --		| --		| 		|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Jog_Fwd_RAW`										| --		| M-	| --		| --		| 		|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Spawn`												| M-		| M-	| --		| --		| *3	|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Spawn_Slow`											| M-		| --	| --		| --		| *3	|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Spawn_Fast`											| --		| M-	| --		| --		| *3	|
| `MM_[Pistol\|Rifle\|Shotgun\|Unarmed]_Spawn_Turn180`										| M-		| M-	| --		| --		| *4	|
| `[MF\|MM]_[Pistol\|Rifle\|Shotgun\|Unarmed]_Turn[Left\|Right]_180`						| MF		| MF	| --		| MF		| 		|
| `SplashPose_([1-9]\|1[0-6])`																| **		| **	| **		| **		| 		|
| `SplashPose_Quinn_([1-9]\|1[0-8])`														| **		| **	| **		| **		| 		|
| `SplashPose_SmearPoses`																	| **		| **	| **		| **		| 		|
| `QuinnIntro_BlockOut_Pose[1-7]_[Manny\|Quinn]`											| **		| **	| **		| **		| 		|

> **Note**  
> * *1.	素材撮影用のもののようで、使用されていません。
> * *2.	しゃがみ状態の転換用のものらしいですが、使用されていません。
> * *3.	スポーン用のアニメーションらしいですが、使用されていません。
> 	> スポーン用のアニメーションは `MM_Pistol_Spawn_Turn180` が使用されています。
> * *4.	`MM_Pistol_Spawn_Turn180` は例外でスポーン時のアニメーションとして利用しています。


# 終わりに
数が多く、命名ミスと思われるものがいくつかありますが、概ね一定のルールに沿って作られているのがわかると思います。  
オリジナルの武器を追加する際等の参考になれば幸いです。

-----
おしまい。


<!-- links -->

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ABP_ItemAnimLayersBase]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbase
[ABP_Mannequin_Base]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
