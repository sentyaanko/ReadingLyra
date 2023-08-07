# 【UE5】Lyra に学ぶ(11) AnimationBlueprint for Character <!-- omit in toc -->

UE5 の新しい？サンプル [Lyra Starter Game] 。  
このプロジェクトでキャラクター用の Animation Blueprint はどのようなものがあるのかを見ていきます。  
話題に上げるのは概ね以下のものです。  
 * [ABP_Mannequin_Base]
 * [ABP_ItemAnimLayersBase] （と、その派生クラス群）
 * `ABP_Mannequin_CopyPose`
 * `ABP_Manny_PostProcess` / `ABP_Quinn_PostProcess`
 * [ALI_ItemAnimLayers] (Animation Layer Interface ですが、関連があるのでこちらについても触れます)

主にシューターゲーム用の部分について述べ、他 (TopDownArena 用等) に関しては省略します。  
実装で使用されている仕組みに関してはほぼ言及しませんので、それらの情報は下記の参考リンク等を確認してください。  
また、各 Animation Blueprint の実装内容に関しても(ドキュメントが肥大化するので)深掘りはしません。

* バージョン
	* [Lyra Starter Game]
		* 2022/11/29 版(5.1 用)



# 0. 参考

* Unreal Engine の機能解説
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]
		* Animation Layer Interface などの解説
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > 別のスケルタル メッシュからポーズをコピーする]
		* ポーズのコピーを行うノード `Copy Pose From Mesh` の解説
	* [Docswell > 猫でも分かる UE4のAnimation Blueprintの運用について【Unreal Engine Meetup Nagoya #6 in 名古屋城】 > p.62]
		* ポーズのコピーを行うノード `Copy Pose From Mesh` の解説
	* [Docswell > 猫でも分かる UE4のAnimation Blueprintの運用について【Unreal Engine Meetup Nagoya #6 in 名古屋城】 > p.101]
		* Post Process Animation Blueprint の解説
	* [Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】]
		* アニメーションの機能の解説
* Lyra の解説
	* [Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]
		* Lyra の Animation Blueprint の解説


# 1. 継承関係

継承ツリーは以下のようになっています。

* [IAnimLayerInterface]
	* [ALI_ItemAnimLayers]
* [UAnimInstance]
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

Manny (サフィックスなし) と Quinn (サフィックス `_Feminine`) は継承関係はありません。  
Shotgun は Rifle の派生クラスとなっています。これは流用が多い為です。  
[ABP_Mannequin_Base] と [ABP_ItemAnimLayersBase] に継承関係はありません。


# 2. クラス名と用途

| クラス名							| 用途																							|
|----								|----																							|
| [ALI_ItemAnimLayers]				| 武器毎に異なる AnimGrap を実装するための Animation Layer Interface です。						|
| [ULyraAnimInstance]				| Lyra 用に拡張した `AnimInstance` の派生クラスです。											|
| [ABP_Mannequin_Base]				| キャラクター用の Animation Blueprint で [ALI_ItemAnimLayers] の関数を呼び出しをしています。	|
| [ABP_ItemAnimLayersBase]			| 武器用の基底クラスで [ALI_ItemAnimLayers] の関数を実装しています。							|
| `ABP_Mannequin_CopyPose`			| 親のメッシュコンポーネントのポーズを複製する Animation Blueprint です。						|
| `ABP_Manny_PostProcess`			| Manny の Post Process Animation Blueprint です。												|
| `ABP_Quinn_PostProcess`			| Quinn の Post Process Animation Blueprint です。												|

[ALI_ItemAnimLayers] の派生クラスはすべて DataOnly で Manny / Quinn と武器の組み合わせです。

| クラス名							| Manny / Quinn	| 武器				|
|----								|----			|----				|
| `ABP_PistolAnimLayers`			| Manny			| Pistol			|
| `ABP_PistolAnimLayers_Feminine`	| Quinn			| Pistol			|
| `ABP_RifleAnimLayers`				| Manny			| Rifle				|
| `ABP_RifleAnimLayers_Feminine`	| Quinn			| Rifle				|
| `ABP_ShotgunAnimLayers`			| Manny			| Shotgun			|
| `ABP_ShotgunAnimLayers_Feminine`	| Quinn			| Shotgun			|
| `ABP_UnarmedAnimLayers`			| Manny			| Unarmed (非武装)	|
| `ABP_UnarmedAnimLayers_Feminine`	| Quinn			| Unarmed (非武装)	|

* [ALI_ItemAnimLayers]
	* [ABP_Mannequin_Base] と [ABP_ItemAnimLayersBase] の Class Setting `Interfaces > Implemented Interfaces` で [ALI_ItemAnimLayers] を追加しています。
		> **Note**  
		> [Unreal Engine Forum > Update to UE5.1 have anim layer bug]  
		> 5.1.0 だと不具合がありました。 5.1.1 では修正されているようです。
	* [ABP_Mannequin_Base] は [ALI_ItemAnimLayers] のインターフェイスを利用する側です。
	* [ABP_ItemAnimLayersBase] は [ALI_ItemAnimLayers] のインターフェイスを実装する側です。


# 3. 参照元

* [ABP_Mannequin_Base]
	* キャラクタークラスのメッシュコンポーネントの Anim Class で利用しています。
	* 具体的には `B_Hero_ShooterMannequin` 等の Mesh コンポーネントのプロパティ `Mesh > Anim Class` にて利用しています。
* [ABP_ItemAnimLayersBase] の派生クラス
	* キャラクタークラスの Linked Animation Blueprint として利用しています。
	* 具体的には `B_WeaponInstance_Base` のイベント `OnEquipped` / `OnUnequipped` 内でノード `LinkAnimClassLayers` を呼び出す事で、 [ABP_Mannequin_Base] の Linked Animation Blueprint として設定しています。
		> **Note**  
		> * `B_WeaponInstance_Base` はプロパティ `Animation > Equipped Anim Set` 等を持ち、この値を上記のタイミングで使用します。
		> * `B_WeaponInstance_Base` は武器毎の派生クラスを持ち、上記のプロパティに [ABP_ItemAnimLayersBase] の武器毎の派生クラスを指定することで武器に合った Linked Animation Blueprint の設定ができるようにしています。
* `ABP_Mannequin_CopyPose`
	* キャラクター表示用のアクターのメッシュコンポーネントの Anim Class で利用しています。
	* 具体的には `B_Hero_ShooterMannequin` 等の子アクター `B_Manny` / `B_Quinn` の Mesh コンポーネントのプロパティ `Mesh > Anim Class` にて利用しています。
* `ABP_Manny_PostProcess` / `ABP_Quinn_PostProcess`
	* Post Process Animation Blueprint として利用しています。
	* 具体的には `SKM_Manny` / `SKM_Quinn` の `Skeltal Mesh  > Post Process Anim Blueprint` にて利用しています。
	* AnimGrap で使用しているノードは `Control Rig` と `Pose Driver` のみです。
		* `Control Rig` は `CR_Mannequin_Procedural` を使用しています。
		* `Pose Driver` は `Manny` / `Quinn` 毎のポーズアセット 14 種((4(腕) + 3(足)) x 2(左右) )を使用しています。

一体のキャラクターを表示するのに 4 つの Animation Blueprint が使われていることになります。  


# 4. 実行時のキャラクターのアクター階層

例として、 Manny が Pistol 装備中という状況で説明します。

* `B_Hero_ShooterMannequin`
	* `B_Manny`
	* `B_Pistol`

キャラクター `B_Hero_ShooterMannequin` の子にキャラクター表示用のアクター `B_Manny` と武器用アクター `B_Pistol` が作られます。  


# 5. 実行時のアクターの Animation Blueprint

| アクター						| Animation Blueprint		| Linked Animation Blueprint			| スケルタルメッシュ	| Post Process Anim Blueprint	|
|----							|----						|----									|----					|----							|
| `B_Hero_ShooterMannequin`		| [ABP_Mannequin_Base]		| [ABP_ItemAnimLayersBase] の派生クラス	| `SKM_Manny_Invis`		|								|
| `B_Manny`						| `ABP_Mannequin_CopyPose`	|										| `SKM_Manny`			| `ABP_Manny_PostProcess`		|

* キャラクターの制御を行っているアクター `B_Hero_ShooterMannequin` に設定された Animation Blueprint [ABP_Mannequin_Base] によって基本的なアニメーション制御を行う。
* 武器毎の処理の差は Linked Animation Blueprint を利用して [ABP_ItemAnimLayersBase] の派生クラスで行う。
* `B_Hero_ShooterMannequin` に設定されたスケルタルメッシュ `SKM_Manny_Invis` は何も表示されない様に作られている。
* キャラクターの表示を行っているアクター `B_Manny` に設定された Animation Blueprint `ABP_Mannequin_CopyPose` によって親アクター `B_Hero_ShooterMannequin` のメッシュコンポーネントのポーズを複製することでベースとなるポーズの設定を行う。
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


# 6. ABP とアニメーションアセットの関係

* Animation Seaquence
	* [ABP_Mannequin_Base] では参照しません。
	* [ABP_ItemAnimLayersBase] では変数を用意し、武器毎の派生クラスで任意の Animation Seaquence を設定できるようにしています。
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


# 終わりに

Lyra のキャラクター用の Animation Blueprint はどのようなものがあり、どこから利用させているか、アニメーションアセットとの関係等についてまとめました。  
なにかの参考になれば幸いです。

-----
おしまい。


<!-- links -->

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ABP_ItemAnimLayersBase]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbase
[ABP_Mannequin_Base]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[ALI_ItemAnimLayers]: CodeRefs/Lyra/ABP/ALI_ItemAnimLayers.md#aliitemanimlayers
[ULyraAnimInstance]: CodeRefs/Lyra/Animation/ULyraAnimInstance.md#ulyraaniminstance
[IAnimLayerInterface]: CodeRefs/UE/Animation/IAnimLayerInterface.md#ianimlayerinterface
[UAnimInstance]: CodeRefs/UE/Animation/UAnimInstance.md#uaniminstance
[Docswell > 猫でも分かる UE4のAnimation Blueprintの運用について【Unreal Engine Meetup Nagoya #6 in 名古屋城】 > p.101]: https://www.docswell.com/s/EpicGamesJapan/5GL3MK-ManagementAnimationBP_Cat#p101
[Docswell > 猫でも分かる UE4のAnimation Blueprintの運用について【Unreal Engine Meetup Nagoya #6 in 名古屋城】 > p.62]: https://www.docswell.com/s/EpicGamesJapan/5GL3MK-ManagementAnimationBP_Cat#p62
[Docswell > 猫でも分かる UE5.0, 5.1 におけるアニメーションの新機能について【CEDEC+KYUSHU 2022】]: https://www.docswell.com/s/EpicGamesJapan/ZY3PDK-UE_CEDECKYUSHU2022_UE5Animation
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > Animation Blueprint Linking を使用する]: https://docs.unrealengine.com/5.1/ja/using-animation-blueprint-linking-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーションのワークフロー ガイドと例 > 別のスケルタル メッシュからポーズをコピーする]: https://docs.unrealengine.com/5.1/ja/copy-a-pose-in-unreal-engine/
[Unreal Engine 5.1 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアニメーション]: https://docs.unrealengine.com/5.1/ja/animation-in-lyra-sample-game-in-unreal-engine/
[Unreal Engine Forum > Update to UE5.1 have anim layer bug]: https://forums.unrealengine.com/t/update-to-ue5-1-have-anim-layer-bug/693524
