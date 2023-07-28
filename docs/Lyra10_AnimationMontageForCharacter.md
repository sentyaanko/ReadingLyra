# 【UE5】Lyra に学ぶ(10) AnimationMontage for Character <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
キャラクター用のアニメーションモンタージュはどういった物があるのか、それらがどの様に使われているのかを見ていきます。  

* バージョン
	* [Lyra Starter Game]
		* 2022/11/29 版(5.1 用)


# 1. 各 Animation Montage の参照元

アニメーションモンタージュは以下のような場所から再生されます。
* GameplayAbility
* GameplayCueNotify
* キャラクターや武器のブループリント

| アニメーションモンタージュ								| 参照元														| 用途			| Note	|
|----														|----															|----			|----	|
| ```AM_MF_Emote_FingerGuns```								| ```GA_Emote```												| エモート		|		|
| ```AM_MM_Dash_[Backward\|Forward\|Left\|Right]```			| ```GA_Hero_Dash```											| ダッシュ		|		|
| ```AM_MM_Death_[Back\|Front\|Left\|Right]_01```			| ```B_Hero_Default::Death Montages```							| 死亡			|		|
| ```AM_MM_Death_Front_0[2-3]```							| ```B_Hero_Default::Death Montages```							| 死亡			|		|
| ```AM_MM_HitReact_[Back\|Front\|Left\|Right]_Med_01```	| ```GCNL_Character_DamageTaken```								| 被ダメージ	|		|
|															| ```GA_Weapon_Fire```											| 被ダメージ 	| *1	|
|															| ```GA_Melee```												| 被ダメージ 	| *2	|
| ```AM_MM_HitReact_Front_[Lgt_01\|Lgt_02\|Med_02]```		| ```GCNL_Character_DamageTaken```								| 被ダメージ	|		|
|															| ```GA_Weapon_Fire```											| 被ダメージ 	| *1	|
| ```AM_MM_HitReact_Front_Hvy_01```							| ```GA_Melee```												| 被ダメージ 	| *2	|
| ```AM_MM_HitReact_[Back\|Left\|Right]_Lgt_01```			| 参照元なし													| 				|		|
| ```AM_MM_HitReact_Front_Lgt_0[3-4]```						| 参照元なし													| 				|		|
| ```AM_MM_Generic_Unequip```								| ```GA_Hero_Heal```											| 回復			| *3	|
|															| ```B_WeaponInstance_Base::WeaponUnequipMontage```				| 装備解除		|		|
| ```AM_MM_Pistol_Equip```									| ```B_WeaponInstance_Pistol::WeaponEquipMontage```				| 装備			|		|
| ```AM_MM_Rifle_Equip```									| ```B_WeaponInstance_[Rifle\|Shotgun]::WeaponEquipMontage```	| 装備			|		|
| ```AM_MM_Pistol_DryFire```								| ```GA_Weapon_Fire_Pistol```									| 空打ち		|		|
| ```AM_MM_Rifle_DryFire```									| ```GA_Weapon_Fire```											| 空打ち		|		|
| ```AM_MM_Pistol_Fire```									| ```GA_Weapon_Fire_Pistol```									| 発砲			|		|
| ```AM_MM_Rifle_Fire```									| ```GA_Weapon_Fire_```											| 発砲			|		|
| ```AM_MM_Shotgun_Fire```									| ```GA_Weapon_Fire_Shotgun```									| 発砲			|		|
|															| ```GA_WeaponNetShooter```										| 発砲			|		|
| ```AM_MM_Pistol_Melee```									| ```B_WeaponInstance_Base::MeleeAttackMontage```				| 近接攻撃		|		|
| ```AM_MM_Rifle_Melee```									| ```B_WeaponInstance_Rifle::MeleeAttackMontage```				| 近接攻撃		|		|
|															| ```B_WeaponInstance_NetShooter::MeleeAttackMontage```			| 近接攻撃		|		|
|															| ```GA_Interaction_Collect```									| インタラクト	| *4	|
| ```AM_MM_Shotgun_Melee```									| ```B_WeaponInstance_Shotgun::MeleeAttackMontage```			| 近接攻撃		|		|
| ```AM_MM_[Pistol\|Rifle]_Reload```						| ```GA_Weapon_Reload_[Pistol\|Rifle]```						| リロード		|		|
| ```AM_MM_Shotgun_Reload```								| ```GA_Weapon_Reload_[Shotgun\|NetShooter]```					| リロード		|		|
| ```AM_MM_Pistol_Spawn```									| ```GA_SpawnEffect```											| スポーン		|		|
| ```AM_MM_Rifle_GrenadeToss```								| ```GA_Grenade```												| 投擲			|		|
| ```DropBomb_Montage```									| ```GA_DropBomb```												| 爆弾設置		|		|
| ```AM_MM_Dash_Forward_LoadingScreenStills```				| 参照元なし													| 				|		|

> **Note**  
> * *1. ```GA_Weapon_Fire::SelectHitMongate()``` 内で利用されていますが、この関数は利用されていません。
> * *2. ```GA_Melee::SelectHitMongate()``` 内で利用されていますが、この関数は利用されていません。
> * *3. 回復アイテム使用時のアニメーションとして利用しています。
> * *4. インタラクションで拾うアニメーションとして利用しています。


# 2. アニメーションスロットについて(about Animation Slot)

## 2.1. Animation Slot の用途

| Group			| Slot							| 用途																|
|----			|----							|----																|
| AdditiveGroup	| AdditiveHitReact				| 被ダメージ														|
| DefaultGroup	| FullBodyAdditivePreAim		| 発砲																|
| 				| UpperBody						| 武器装備、解除、近接攻撃、リロード、空打ち、投擲					|
| 				| UpperBodyAdditive				| 同上																|
| 				| FullBody						| 上記以外（エモート、ダッシュ、死亡、スポーン）					|
| 				| DefaultSlot					| 未使用															|
| 				| UpperBodyDynAdditive			| 未使用															|
| 				| UpperBodyDynAdditiveBase		| 未使用															|

被ダメージ時のモンタージュ再生用だけグループが AdditiveGroup であり、 DefaultGroup とは独立して再生できるようになっています。  
それ以外はすべて DefaultGroup に属しており、例えばリロード中にエモートをするとリロードのアニメーションが中断されます。

[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション スロット] より引用。
> スロット グループは整理するためだけのものではありません。  
> すでに実行されているものと同じグループのスロットを使用するモンタージュをプレイするとき、アクティブであったアニメーションを停止します。  
> この自動動作によりモンタージュを中断させることができます。  
> たとえば、武器リロード モンタージュは、能力/近接攻撃モンタージュをプレイするために中断できます。  
> 両方のモンタージュが、同じグループ内の各スロットでアニメーションをプレイしている場合、後のモンタージュが前のものを中断します。  


## 2.2. Animation Montage から見た Animation Slot の使用状況

| Animation Montage															| Slot						| Animation Sequence															| Note	|
|----																		|----						|----																			|----	|
| ```AM_MM_HitReact_[Back\|Front\|Left\|Right]_[Lgt\|Med\|Hvy]_0[1-4]```	| AdditiveHitReact			| ```MM_HitReact_[Back\|Front\|Left\|Right]_[Lgt\|Med\|Hvy]_0[1-4]```			| *1	|
| ```AM_MM_[Pistol\|Rifle\|Shotgun]_Fire```									| FullBodyAdditivePreAim	| ```MM_[Pistol\|Rifle\|Shotgun]_Fire```										|		|
| ```AM_MM_[Pistol\|Rifle\|Shotgun]_[DryFire\|Equip\|Reload\|Melee]```		| UpperBody					| ```MM_[Pistol\|Rifle\|Shotgun]_[DryFire\|Equip\|Reload\|Melee]```				| *2	|
|																			| UpperBodyAdditive			| ```MM_[Pistol\|Rifle\|Shotgun]_[DryFire\|Equip\|Reload\|Melee]_Additive```	| *3	|
| ```AM_MM_Generic_Unequip```												| UpperBody					| ```MM_Pistol_Equip```															| 		|
|																			| UpperBodyAdditive			| ```MM_Pistol_Equip_Additive```												| *3	|
| ```AM_MM_Rifle_GrenadeToss```												| UpperBody					| ```MM_Rifle_GrenadeToss```													| *4	|
|																			| UpperBodyAdditive			| ```MM_Rifle_GrenadeToss_Additive```											| *3	|
| ```DropBomb_Montage```													| UpperBody					| ```MM_Rifle_GrenadeToss```													| 		|
| ```AM_MF_Emote_FingerGuns```												| FullBody					| ```MF_Emote_FingerGuns```														|		|
| ```AM_MM_Dash_[Backward\|Forward\|Left\|Right]```							| FullBody					| ```MM_Dash_[Backward\|Forward\|Left\|Right]```								|		|
| ```AM_MM_Death_[Back\|Front\|Left\|Right]_01```							| FullBody					| ```MM_Death_[Back\|Front\|Left\|Right]_01```									|		|
| ```AM_MM_Death_Front_0[2-3]```											| FullBody					| ```MM_Death_Front_0[2-3]```													|		|
| ```AM_MM_Pistol_Spawn```													| FullBody					| ```MM_Pistol_Spawn_Turn180```													| *5	|
| ```AM_MM_Dash_Forward_LoadingScreenStills```								| FullBody					| ```MM_Dash_Forward_LoadingScreenStills```										|		|

> **Note**  
> * *1.	```[Lgt|Med|Hvy]``` や ```[1-4]``` はバリエーションを表しますが、方向によっては存在しません。
>	> ```Front``` だけ以下のようにバリエーションが多くなっています。
>	> * ```Hvy``` のバリエーションが `1` のみあり、ほかはありません。
>	> * ```Lgt``` のバリエーションが ```[1-4]``` あり、ほかは `1` のみです。
>	> * ```Med``` のバリエーションが ```[1-2]``` あり、ほかは `1` のみです。
> * *2.	`AM_MM_Shotgun_DryFire` は例外的に存在しません。
> * *3. ```_Additive``` のバリエーションがあるアニメーションシーケンスがいくつかあります。  
>	* ```_Additive``` が付いていない方は、（地上に居るかに依らない）上半身のボーンのみをブレンドするためのものです。  
>		> これを使わないと、空中にいるときにアニメーションがブレンドされません。
>	* ```_Additive``` が付いている方は、地上に居る際の（下半身を含む）全身のブレンドをするためのものです。  
>		> これを使わないと、下半身のアニメーションがブレンドされません。
> * *4.	Rifle と付いていますが、武器に依らず同じアセットを使用しています。
> * *5.	初期武器が Pistol 固定の為、他の武器用のバリエーションはありません。


## 2.3. Animation Slot の適用順番

[ABP_Mannequin_Base] の `AnimGraph` で、 Animation Slot がどのように利用されているかをざっくりまとめると以下のようになります。

1. `Additive Identity Pose` に対して **UpperBodyAdditive** を `PlayAnimation` します。
2. ポーズキャッシュ `Locomotion` と 1 を `Apply Additive` を使用してブレンドします。
	> * `Alpha` は変数がバインドされています。これは地上で Animation Montage を再生すると `1.0` の値を取ります。
	> これで地上に居る際の「武器装備、解除、近接攻撃、リロード、空打ち、グレネード投擲」のアニメーションがブレンドされます。
3. ポーズキャッシュ `Locomotion` に対して **UpperBody** を `PlayAnimation` します。
4. 2,3 の出力を `Layered blend per bone` を使用してブレンドします。
	> * `Blend Weights 0` は　`1.0` 固定です。
	> * `Blend Mode` は `Blend Mask` 
	> * `Blend Mask` は `UpperBodyLowerBodySplitMask`
	>	> `UpperBodyLowerBodySplitMask` は `spine_01` から先に weight が設定されています。つまりは上半身です。
	> これで地上に居るかに依らない「武器装備、解除、近接攻撃、リロード、空打ち、グレネード投擲」のアニメーションが上半身のボーンのみブレンドされます。
5. 4 の出力に対して **FullbodyAdditivePreAim** を `PlayAnimation` します。
	> これで「発砲」のアニメーションがブレンドされます。
6. ここまでの結果をポーズキャッシュ  `UpperbodyLowerbodySplit` に保存します。
7. ポーズキャッシュ  `UpperbodyLowerbodySplit` に対して `AimOffset Player` します。
	> [ABP_ItemAnimLayersBase::FullBody_Aiming] 内で行われます。  
	> 二種類の Aim Offset を使用しその結果をブレンドしています。
8. 7 の出力に対して **AdditiveHitReact** を `PlayAnimation` します。
	> これで「被ダメージ」のアニメーションがブレンドされます。
9. 8 の出力と [ABP_ItemAnimLayersBase::FullbodyAdditives] の出力を `Apply Additive` を使用してブレンドします。
	> * `Alpha` は `0.65` 固定です。
	> これで着地時に、着地から通常状態に復帰するアニメーションがブレンドされます。
10. 9 の出力に対して **FullBody** を `PlayAnimation` します。
	> これで「エモート、ダッシュ、死亡、スポーン」のアニメーションがブレンドされます。
11. 以下省略


## 2.4. Animation Sequence の Additive Anim Type

Additive Anim Type の説明を [Unreal Engine 4.27 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション シーケンス]  より引用します。
> **Note**  
> 5.1 のドキュメントから削除されているので 4.27 から引用しています。

> Additive Anim Type  
> 
> The type of additive animation type to use:  
> No Additive, Local Space or Mesh Space.   
> Local space is additive and delta is calculated by local space.   
> Mesh Space is additive and delta will be applied in component space.  
> 
> ----
> 使用する加算アニメーション タイプです。  
> No Additive、 Local Space、 または Mesh Space があります。  
> ローカル空間は加算で、デルタはローカル空間で計算されます。  
> メッシュ空間は加算で、デルタはコンポーネント空間に適用されます。  


タイプに関して `AnimType.h` より引用します。

```c++
/** 
 * Indicates whether an animation is additive, and what kind.
 * アニメーションがadditiveであるかどうか、またその種類を示す。
 */
UENUM()
enum EAdditiveAnimationType
{
	/** No additive. */
	/** additive 無し。 */
	AAT_None  UMETA(DisplayName="No additive"),
	/* Create Additive from LocalSpace Base. */
	/* LocalSpace Base から Additive を作成する。 */
	AAT_LocalSpaceBase UMETA(DisplayName="Local Space"),
	/* Create Additive from MeshSpace Rotation Only, Translation still will be LocalSpace. */
	/* MeshSpace Rotation のみから Additive を作成する。 Translation は LocalSpace のまま。 */
	AAT_RotationOffsetMeshSpace UMETA(DisplayName="Mesh Space"),
	AAT_MAX,
};
```

各アセットの設定内容は以下の通り。

| Animation Sequence															| Additive Anim Type	| Note	|
|----																			|----					|----	|
| ```MM_[Pistol\|Rifle\|Shotgun]_Fire```										| Mesh Space			| *1	|
| ```MM_HitReact_[Back\|Front\|Left\|Right]_[Lgt\|Med\|Hvy]_0[1-4]```			| Local Space			| *2	|
| ```MM_[Pistol\|Rifle\|Shotgun]_[DryFire\|Equip\|Reload\|Melee]```				| None					| 		|
| ```MM_[Pistol\|Rifle\|Shotgun]_[DryFire\|Equip\|Reload\|Melee]_Additive```	| Local Space			| *3	|
| ```MM_Pistol_Equip```															| None					| 		|
| ```MM_Pistol_Equip_Additive```												| Local Space			| *3	|
| ```MM_Rifle_GrenadeToss```													| None					| 		|
| ```MM_Rifle_GrenadeToss_Additive```											| Local Space			| *3	|
| ```MM_Rifle_GrenadeToss```													| None					| 		|
| ```MF_Emote_FingerGuns```														| None					| 		|
| ```MM_Dash_[Backward\|Forward\|Left\|Right]```								| None					| 		|
| ```MM_Death_[Back\|Front\|Left\|Right]_01```									| None					| 		|
| ```MM_Death_Front_0[2-3]```													| None					| 		|
| ```MM_Pistol_Spawn_Turn180```													| None					| 		|
| ```MM_Dash_Forward_LoadingScreenStills```										| None					| 		|

> **Note**  
> * *1. ```MM_[Pistol|Rifle|Shotgun]_Fire``` は Aim に関わるので Mesh Space が指定されています。
>  	> 詳しくは [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > ブレンド スペース > エイム オフセット > メッシュ空間加算] あたりを参照。
> * *2. 被ダメージ用はすべて Local Space が指定されています。
> * *3. ```.+_Additive``` はすべて Local Space が指定されています。
> * それら以外は None が指定されています。


# 終わりに

主にアニメーションモンタージュが他のアセット等とどの様に関わっているかのについてまとめました。  
なにかの参考になれば幸いです。


-----
おしまい。


<!-- links -->
[Unreal Engine 4.27 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション シーケンス]: https://docs.unrealengine.com/4.27/ja/AnimatingObjects/SkeletalMeshAnimation/Sequences/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > ブレンド スペース > エイム オフセット > メッシュ空間加算]: https://docs.unrealengine.com/5.1/ja/aim-offset-in-unreal-engine/#%E3%83%A1%E3%83%83%E3%82%B7%E3%83%A5%E7%A9%BA%E9%96%93%E5%8A%A0%E7%AE%97
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション スロット]: https://docs.unrealengine.com/5.1/ja/animation-slots-in-unreal-engine/

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ABP_ItemAnimLayersBase::FullBodyAdditives]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyadditives
[ABP_ItemAnimLayersBase::FullBody_Aiming]: CodeRefs/Lyra/ABP/ABP_ItemAnimLayersBase.md#abpitemanimlayersbasefullbodyaiming
[ABP_Mannequin_Base]: CodeRefs/Lyra/ABP/ABP_Mannequin_Base.md#abpmannequinbase
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 4.27 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション シーケンス]: https://docs.unrealengine.com/4.27/ja/AnimatingObjects/SkeletalMeshAnimation/Sequences/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > ブレンド スペース > エイム オフセット > メッシュ空間加算]: https://docs.unrealengine.com/5.1/ja/aim-offset-in-unreal-engine/#%E3%83%A1%E3%83%83%E3%82%B7%E3%83%A5%E7%A9%BA%E9%96%93%E5%8A%A0%E7%AE%97
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > アニメーション スロット]: https://docs.unrealengine.com/5.1/ja/animation-slots-in-unreal-engine/