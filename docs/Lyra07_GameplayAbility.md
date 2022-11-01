# 【UE5】Lyra に学ぶ(07) GameplayAbility <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中では、`Gameplay Ability System` (以降 GAS と略します) が利用されています。  
このドキュメントは GameplayAbility で実装されている機能についての解説です。  

* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版

# Index <!-- omit in toc -->

- [参考](#参考)
- [1. ULyraGameplayAbility](#1-ulyragameplayability)
	- [1.1. ULyraGameplayAbility_Death](#11-ulyragameplayability_death)
		- [1.1.1. GA_ArenaHero_Death](#111-ga_arenahero_death)
		- [1.1.2. GA_Hero_Death](#112-ga_hero_death)
	- [1.2. ULyraGameplayAbility_FromEquipment](#12-ulyragameplayability_fromequipment)
		- [1.2.1. GA_Weapon_AutoReload](#121-ga_weapon_autoreload)
		- [1.2.2. GA_Weapon_ReloadMagazine](#122-ga_weapon_reloadmagazine)
			- [1.2.2.1. GA_Weapon_Reload_Pistol](#1221-ga_weapon_reload_pistol)
			- [1.2.2.2. GA_Weapon_Reload_Rifle](#1222-ga_weapon_reload_rifle)
			- [1.2.2.3. GA_Weapon_Reload_Shotgun](#1223-ga_weapon_reload_shotgun)
			- [1.2.2.4. GA_Weapon_Reload_NetShooter](#1224-ga_weapon_reload_netshooter)
		- [1.2.3. ULyraGameplayAbility_RangedWeapon](#123-ulyragameplayability_rangedweapon)
			- [1.2.3.1. GA_HealPickup](#1231-ga_healpickup)
			- [1.2.3.2. GA_Weapon_Fire](#1232-ga_weapon_fire)
				- [1.2.3.2.1. GA_Weapon_Fire_Pistol](#12321-ga_weapon_fire_pistol)
				- [1.2.3.2.2. GA_Weapon_Fire_Rifle](#12322-ga_weapon_fire_rifle)
				- [1.2.3.2.3. GA_Weapon_Fire_Shotgun](#12323-ga_weapon_fire_shotgun)
				- [1.2.3.2.4. GA_WeaponNetShooter](#12324-ga_weaponnetshooter)
	- [1.3. ULyraGameplayAbility_Interact](#13-ulyragameplayability_interact)
		- [1.3.1. GA_Interact](#131-ga_interact)
	- [1.4. ULyraGameplayAbility_Jump](#14-ulyragameplayability_jump)
		- [1.4.1. GA_Hero_Jump](#141-ga_hero_jump)
	- [1.5. ULyraGameplayAbility_Reset](#15-ulyragameplayability_reset)
	- [1.6. ULyraGamePhaseAbility](#16-ulyragamephaseability)
		- [1.6.1. Phase_Warmup](#161-phase_warmup)
		- [1.6.2. Phase_Playing](#162-phase_playing)
		- [1.6.3. Phase_PostGame](#163-phase_postgame)
	- [1.7. GA_AbilityWithWidget](#17-ga_abilitywithwidget)
		- [1.7.1. GA_ADS](#171-ga_ads)
		- [1.7.2. GA_Emoto](#172-ga_emoto)
		- [1.7.3. GA_Hero_Dash](#173-ga_hero_dash)
		- [1.7.4. GA_Melee](#174-ga_melee)
	- [1.8. GAB_ShowWidget_WhenInputPressed](#18-gab_showwidget_wheninputpressed)
		- [1.8.1. GA_ToggleInventory](#181-ga_toggleinventory)
		- [1.8.2. GA_ToggleMap](#182-ga_togglemap)
	- [1.9. GAB_ShowWidget_WhileInputHeld](#19-gab_showwidget_whileinputheld)
		- [1.9.1. GA_ShowLeaderboard_CP](#191-ga_showleaderboard_cp)
		- [1.9.2. GA_ShowLeaderboard_TDM](#192-ga_showleaderboard_tdm)
	- [1.10. GA_AutoRespawn](#110-ga_autorespawn)
	- [1.11. GA_DropBomb](#111-ga_dropbomb)
	- [1.12. GA_Grenade](#112-ga_grenade)
	- [1.13. GA_Hero_Heal](#113-ga_hero_heal)
	- [1.14. GA_Interaction_Collect](#114-ga_interaction_collect)
	- [1.15. GA_QuickbarSlots](#115-ga_quickbarslots)
	- [1.16. GA_SpawnEffect](#116-ga_spawneffect)
	- [1.17. GA_ToggleMarkerInWorld](#117-ga_togglemarkerinworld)
- [終わりに](#終わりに)

# 参考

* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ネイティブ アビリティ サブクラス]
		* C++ で実装されたアビリティに関する解説があります。
		* 引用はここから行っています。
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ブループリント アビリティ サブクラス]
		* ブループリント で実装されたアビリティに関する解説があります。
		* 引用はここから行っています。

# 1. ULyraGameplayAbility

* このプロジェクトで使用する、 GameplayAbility の基底クラスです。
* 詳しくは [ULyraGameplayAbility] を参照してください。

## 1.1. ULyraGameplayAbility_Death

> Death Gameplay Event が発生すると、自動的にトリガーするように設定されます。
> 他のすべてのアビリティをキャンセルし、ポーンの Health Component に Death プロセス開始のシグナルを出します (これが他のゲーム通知と状態変更のトリガーとなる)。  
> ビジュアル エフェクトはこのクラス (GA_Hero_Death) の BP アビリティ拡張 (GA_Hero_Death) で実行されます。

* 死亡に関する処理を行う基底クラスです。
* 詳しくは [ULyraGameplayAbility_Death] を参照してください。

### 1.1.1. GA_ArenaHero_Death

* TopDownArena 用の死亡処理です。

### 1.1.2. GA_Hero_Death

* ShooterCore 用の死亡処理です。

## 1.2. ULyraGameplayAbility_FromEquipment

> Lyra の Equipment システムとインタラクトする機能と、アビリティに関連するアイテムを取得する機能を提供します。

* 銃などを装備した際に付与される、それらに関連付けられたアビリティの基底クラスです。
* 詳しくは [ULyraGameplayAbility_FromEquipment] を参照してください。

### 1.2.1. GA_Weapon_AutoReload

* リロードアビリティを呼び出す汎用アビリティです。

### 1.2.2. GA_Weapon_ReloadMagazine

> この Gameplay Ability は、 Ability.Type.Action.Reload タグのアセットで、InputTag.Weapon.Reload によってアクティブ化されます。  
> これは Event.Movement.Reload タグを付与します。  
> アクティブである間、移動オプションを制限します。  
> リロード ロジックは、武器に関連付けられた 3 種類のゲームプレイタグのスタックを中心に展開します。  
> Lyra.ShooterGame.Weapon.MagazineSize は、その時点の武器のマガジン当たりに許容される弾薬の最大量です。
> Lyra.ShooterGame.Weapon.MagazineAmmo は、その時点のマガジンに残っている弾薬の量です。
> 量がゼロに到達したとき、発射を続けるために武器をリロードする必要があります。
> Lyra.ShooterGame.Weapon.SpareAmmo はその時点のマガジンにない、残りの弾薬量です。
> `K2_CanActivateAbility` 関数をオーバーライドします。
> これは以下の起動アクティベーション チェックロジックをブループリントで実装したものです。
> 
> * MagazineAmmo が MagazineSize より少ないかどうかをチェックします。false の場合、マガジンが一杯であり、リロードを続けられません。
> * SpareAmmo がゼロより大きいかどうかをチェックします。false の場合、プレイヤーのこの武器で弾薬が切れています。
> 
> アビリティのアクティベーション時：  
> * 関連アイテムの MagazineAmmo スタック カウントをチェックします。その時点のマガジンに弾薬が残っていない場合、武器発射アビリティのアクティベーションを抑えるためにタグが適用されます。
> * 武器リロード アニメーション モンタージュをプレイし、GameplayEvent.ReloadDone イベントをリッスンします。マネキンのモンタージュでアニメーション通知を通じて、このイベントが送信されます。
> * このイベントが受信されたとき、権限 (サーバー) をチェックし、リロード ロジックを実行します。これはキャラクターのインベントリで関連武器の Lyra.ShooterGame.Weapon.MagazineAmmo および Lyra.ShooterGame.Weapon.SpareAmmo に対する値を変更するだけです。このアビリティを終了します。
> * 何らかの理由でイベントが処理されなかった場合、モンタージュが停止または中断された時点で、アビリティはローカルに終了します。On End Ability は、アクティベーション時に設定される発射抑制タグが事前に設定されていた場合、それを削除するために呼び出されます。

* リロード処理を行うアビリティの基底クラスです。

#### 1.2.2.1. GA_Weapon_Reload_Pistol

* Pistol 用のリロードアビリティです。

#### 1.2.2.2. GA_Weapon_Reload_Rifle

* Rifle 用のリロードアビリティです。

#### 1.2.2.3. GA_Weapon_Reload_Shotgun

* Shotgun 用のリロードアビリティです。

#### 1.2.2.4. GA_Weapon_Reload_NetShooter

* NetShooter 用のリロードアビリティです。

### 1.2.3. ULyraGameplayAbility_RangedWeapon

> 武器発射のネイティブ実装。
> 弾薬数、命中精度などを決定するために関連する武器とやり取りします。
> 発射コーン内で弾丸の軌道を計算し、命中目標を見つけ、検証するためのレイキャスト機能が用意されています。

* 射撃武器用のアビリティの基底クラスです。
* 詳しくは [ULyraGameplayAbility_RangedWeapon] を参照してください。

#### 1.2.3.1. GA_HealPickup

* Health の回復を行う消費アイテムのアビリティです。

#### 1.2.3.2. GA_Weapon_Fire

> Fire および Reload アビリティは、関連する武器が拾い上げられたとき、Lyra Equipment Definition (ULyraEquipmentDefinition) クラスの Ability Set を通じて、付与されます。  
> アクティベーション要件は、ULyraGameplayAbility_RangedWeapon クラスで処理されます。  
> ターゲット ロジックは同じクラスによって C++ で実行されます。  
> Weapon Fire Gameplay Ability は、タグ InputTag.Weapon.FireAuto (入力バインディング) と Input.Weapon.Fire タグ (ゲームプレイ イベント) でアクティブ化されます。  
> マガジンが空の場合、リロード アビリティで設定された Ability.Weapon.NoFiring タグで抑制されます。  
> Ability.Type.Action.WeaponFire のアセット タグは Event.Movement.WeaponFire タグを付与します。  
> タグがアクティブである間、On Ability Added イベントは、Ability.PlayMontageOnActivateFail.Message タグのリスナーをセットアップします。  
> 弾薬が残っていない間、プレイヤーが武器の発射を試みると、このイベントがトリガーされます。  
> メッセージを受け取ったとき、発射を失敗したモンタージュがプレイされます (空砲)。  
> このモンタージュはプレイヤーがまだ生存している場合にのみプレイされ、アニメーションのスパムを回避するために指定時間が経過した場合にのみ再トリガーされます。  
> On Activation が呼び出されるとき、キャラクターがローカルでコントロールされる場合、ネイティブのトレース ターゲットを実行し、次の順でターゲット データを作成します。
> 
> 1. アビリティ コスト (弾薬消費) はネイティブにコミットされます。
> 1. ターゲット設定データはネットワーク予測され、サーバーに送信され、 ULyraWeaponStateComponent によって検証され確認されます。
> 1. ターゲット設定データがサーバーで確認された場合、BP イベント OnRangedWeaponTargetDataReady が呼び出され、見つかったすべてのターゲットが渡されます。これにより、アビリティでダメージの適用、ヒット エフェクトのプレイが可能になります。
> 1. 発射アニメーション モンタージュをプレイします。
> 1. タイマーに Fire Delay を設定します。ショットの間の効果的な遅延です。
> 1. Fire Delay つまりタイマーが終了したとき、アビリティを終了します。さらに発射しようとすると、アクティベーション ロジックで処理されます。
> 
> On Ranged Weapon Target Data Ready は、武器が命中したすべてのターゲットが確認されたとき、C++ から呼び出されます。
> これは Firing ゲームプレイ キューを武器のオーナーでトリガーし、最初のヒットをパラメータとして渡します。
> キューがすべてのターゲット ヒットで繰り返され、各ターゲット位置で衝突のゲームプレイ キューがプレイされます。
> アビリティに権限 (サーバーで実行) がある場合、各ターゲット ヒットでダメージ Gameplay Effect を適用します。

* 射撃処理を行うアビリティの基底クラスです。

##### 1.2.3.2.1. GA_Weapon_Fire_Pistol

* Pistol 用の射撃アビリティです。

##### 1.2.3.2.2. GA_Weapon_Fire_Rifle

* Rifle 用の射撃アビリティです。

##### 1.2.3.2.3. GA_Weapon_Fire_Shotgun

* Shotgun 用の射撃アビリティです。

##### 1.2.3.2.4. GA_WeaponNetShooter

* NetShooter 用の射撃アビリティです。

## 1.3. ULyraGameplayAbility_Interact

* プレイヤーがオブジェクトとインタラクトを行うアビリティの基底クラスです。
* 詳しくは [ULyraGameplayAbility_Interact] を参照してください。

### 1.3.1. GA_Interact

* `L_InventoryTestMap` にてプレイヤーに付与されている、インタラクトアビリティです。

## 1.4. ULyraGameplayAbility_Jump

* ジャンプアビリティの基底クラスです。
* 詳しくは [ULyraGameplayAbility_Jump] を参照してください。

### 1.4.1. GA_Hero_Jump

> ポーンの Character Movement Component で Jump と StopJumping の入力をトリガーする機能を提供し、その際、アビリティのオーナーがローカルにコントロールされた有効なポーンであるのかをチェックします。

* ShooterCore 等でプレイヤーに付与されている、ジャンプアビリティです。

## 1.5. ULyraGameplayAbility_Reset

> アクティブ化されたとき、このアビリティは、直ちに所有するプレイヤーの新しいポーンをスポーンされた初期状態にリセットし、他のすべてのアビリティをキャンセルします。

* 詳しくは [ULyraGameplayAbility_Reset] を参照してください。

## 1.6. ULyraGamePhaseAbility

* ゲームルールの進行状態を表すアビリティの基底クラスです。
* 詳しくは [ULyraGamePhaseAbility] を参照してください。
* Lyra では 準備中/プレイ中/ゲーム終了後 の 3 種があり、さらに ShooterCore/TopDownArena で別のアセットが同名で用意されています。

### 1.6.1. Phase_Warmup
### 1.6.2. Phase_Playing
### 1.6.3. Phase_PostGame

## 1.7. GA_AbilityWithWidget

> 追加の UI 機能を提供するあらゆるアビリティの基本クラスです。  
> これはアビリティのウィジェットの状態を管理し、ステータス、クールダウン、その他のアビリティ情報を表示できるようにします。  
> 一例として、 Lyra の Melee アビリティがあり、モバイル プラットフォーム向けのカスタム タッチ入力ウィジェットを備えています。  
> OnAbilityAdded イベントは、ウィジェット拡張を UI Extension Subsystem に登録し、これにより拡張ハンドルが保存されます。  
> OnAbilityRemoved イベントは、拡張機能の登録を解除し、拡張機能ハンドルをクリアします。

* 派生クラスでもロジックの実装を行っている。
* `GAB_ShowWidget_WhenInputPressed` / `GAB_ShowWidget_WhileInputHeld` とのプレフィックスの差はそのあたりが理由なのかもしれない。

### 1.7.1. GA_ADS

> HUD 表示ボタンを処理するため GA_AbilityWithWidget から継承します。  
> このアビリティは、Ability.Type.Action.ADS タグのアセットで、InputTag.Weapon.ADS によってアクティブ化され、Event.Movement.ADS タグを付与します。  
> アクティブな間、ローカル予測 (Local predicted) されます。  
> つまり、クライアントですぐに実行され、サーバーは追いつくために同期します。  
> 
> アクティベーション時：
> 1. 視野角 (FOV) を狭めるためにカスタムのカメラ モードを適用します。
> 1. キャラクターの歩行速度をキャッシュし、オーバーライドします。アビリティはローカルで予測されるので、これは所有するクライアントとサーバーで実行し、ローカルではないクライアントにレプリケートされます。
> 1. 一時入力マッピング コンテキストを適用します。低い乗数で動きの入力をオーバーライドします。入力の大きさを減らすことにより、さらなる動きの入力が低い加速度を生み出し、低い加速度値でサーバーにレプリケートされます。これによりキャラクターは狙いを定めながら歩行します。
> 1. ローカル プレイヤーでは、UI が更新され、「狙いを開始」のサウンドがプレイされます。
> 1. 入力ボタンが放されるまで待機し、放されるとアビリティを終了します。
> 
> アビリティ終了時：
> 1. カスタムのカメラ モードをクリアします。
> 1. ローカルにコントロールされている場合、UI が更新され、「狙いを終了」のサウンドがプレイされます。
> 1. 制御対象キャラクターの歩行速度を元に戻し、通常の移動速度を戻すための入力マッピング コンテキストを削除します。

### 1.7.2. GA_Emoto
### 1.7.3. GA_Hero_Dash

> GA_AbilityWithWidget から継承します。
> このアビリティは、InputTag.Ability.Dash タグのアセットで、Ability.Type.Action.Dash によってアクティブ化されます `Event.Movement.Dash` を付与します。  
> アクティブにすると、クールダウン エフェクト **GE_HeroDash_Cooldown** を使用します。
> 
> クールダウンのアクティベーション時：
> 1. アビリティ コストをチェックします。コストを支払える場合はコミットし、支払えない場合はアビリティを終了します。
> 1. ローカル コントロールをチェックし、サーバーでアビリティを終了します。
> 1. ローカル クライアントで、ダッシュ方向が入力と見ている方向に基づいて選択されます。動きの入力がない場合、クライアントでアビリティが終了します (ダッシュ方向入力がある場合にのみ、ダッシュが発生)。
> 1. 動きの方向とキャラクターの向きに基づいて、プレイするアニメーション モンタージュを選択します。
> 1. キャラクターがしゃがんでいる場合、立ち上がらせます。
> 1. アビリティに権限がない (ローカル クライアント) の場合、サーバー RPC を通じて、ダッシュ方向と選択モンタージュをレプリケートします。
> 1. 所有クライアントとサーバーの両方で、選択モンタージュをプレイし、ダッシュ方向にルート モーションの力を加えます。
> 1. メッセージング サブシステムを通じてメッセージを送信します。クライアント側の UI はクールダウン時間を同期できます。
> 1. サーバーで、ダッシュ エフェクト ゲームプレイ キューをトリガーし、その結果すべてのクライアントでレプリケートされます。
> 1. ルート モーションの力が完了したとき、一定時間遅延し、アビリティを終了します。これにより一定時間、付与されたアビリティ タグが維持され、射撃やジャンプなど他のアクションが抑えられます。


### 1.7.4. GA_Melee

> Ability.Type.Action.Melee のアセットタグを含み、アクティブである間は Event.Movement.Melee タグを付与します。  
> このアビリティはタグ InputTag.Weapon.Ads でトリガーされます。  
> このタグがアクティブ化されたときに、On Activation イベントは、次の順でアビリティ コストをコミットします。
> 
> 1. その時点で装備している武器を見つけ、関連するアニメーション モンタージュをプレイします。
> 1. 権限 (サーバーをのみ) をチェックし、プレイヤーの正面でカプセル トレースを実行します。
> 1. トレースがポーンにヒットする場合、さらにチェックが実行されます。たとえば、フレンドリ ファイア (味方からの誤射) を避けるためのチーム比較、レベル ジオメトリでターゲットが隠れていないことを確認する 2 番目のチェックがあります。
> 1. 有効なヒットが登録されている場合、RootMotion の力を通じて、キャラクターがターゲットに向かって移動します。
> 1. 次に近接攻撃のダメージのゲームプレイ エフェクトがターゲットに適用され、近接攻撃ヒットのゲームプレイ キューがオーナーでトリガーされます。
> 1. 最後に、Melee Impact サウンドはマルチキャスト RPC を通じてすべてのクライアントでプレイされます。

## 1.8. GAB_ShowWidget_WhenInputPressed

* 派生クラスはデータ専用ブループリントになっている。
* `GA_AbilityWithWidget` とのプレフィックスの差はそのあたりが理由なのかもしれない。

### 1.8.1. GA_ToggleInventory
### 1.8.2. GA_ToggleMap
## 1.9. GAB_ShowWidget_WhileInputHeld

* 派生クラスはデータ専用ブループリントになっている。
* `GA_AbilityWithWidget` とのプレフィックスの差はそのあたりが理由なのかもしれない。

### 1.9.1. GA_ShowLeaderboard_CP
### 1.9.2. GA_ShowLeaderboard_TDM
## 1.10. GA_AutoRespawn
## 1.11. GA_DropBomb
## 1.12. GA_Grenade

> このアビリティは、Ability.Type.Action.Grenade タグのアセットで、InputTag.Weapon.Grenade によってアクティブ化されます。  
> これは GE_Grenade_Cooldown をクールダウン エフェクトとして使用します。  
> On Pawn Avatar Set は、ローカルクライアントの UI Extension Subsystem でウィジェットを登録し、アビリティインスタンスごとにウィジェットが 1 つだけ追加されるようにします。  
> On Activation はアビリティ コストとクールダウンをチェックし、コミットします。  
> いずれかのチェックが失敗するとアビリティが終了します。
> 次のプロセスで実行されます。
> 
> 1. アビリティ コストとクールダウンをコミットします。
> 1. 手りゅう弾のスポーンの位置と回転を計算します。
> 1. 権限をチェックします。権限がサーバーにある場合、算出された値で、手りゅう弾のアクタがスポーンされ、所有する Lyra キャラクターを発生元として設定します。
> 1. スポーンされた B_Grenade アクタが、爆発チェックを実行すること、関連 Gameplay Effects を適用することを担当します。
> 1. B_Grenade は敵のポーンとのコリジョンがあるときに、自動的に爆発します。フレンドリ ファイアを発生元 (手りゅう弾を投げた) キャラクターに適用しますが、チームメンバーには適用しません。
> 1. 手りゅう弾投てきモンタージュをプレイします。Gameplay Message Subsystem を通じて、クールダウンの残り時間をブロードキャストします。その結果、関連するウィジェットがクールダウン表示と同期できます。
> 1. モンタージュの完了を待つことなくアビリティをすぐに終了します。
> 
> On Ability Removed は UI Extension を登録解除し、クリアします。

## 1.13. GA_Hero_Heal
## 1.14. GA_Interaction_Collect
## 1.15. GA_QuickbarSlots
## 1.16. GA_SpawnEffect
## 1.17. GA_ToggleMarkerInWorld




# 終わりに

todo

どなたかの参考になれば幸いです。


-----
おしまい。

<!--- ページ内のリンク --->
[1. ULyraGameplayAbility]: #1-ulyragameplayability
[1.1. ULyraGameplayAbility_Death]: #11-ulyragameplayability_death
[1.1.1. GA_ArenaHero_Death]: #111-ga_arenahero_death
[1.1.2. GA_Hero_Death]: #112-ga_hero_death
[1.2. ULyraGameplayAbility_FromEquipment]: #12-ulyragameplayability_fromequipment
[1.2.1. GA_Weapon_AutoReload]: #121-ga_weapon_autoreload
[1.2.2. GA_Weapon_ReloadMagazine]: #122-ga_weapon_reloadmagazine
[1.2.2.1. GA_Weapon_Reload_Pistol]: #1221-ga_weapon_reload_pistol
[1.2.2.2. GA_Weapon_Reload_Rifle]: #1222-ga_weapon_reload_rifle
[1.2.2.3. GA_Weapon_Reload_Shotgun]: #1223-ga_weapon_reload_shotgun
[1.2.2.4. GA_Weapon_Reload_NetShooter]: #1224-ga_weapon_reload_netshooter
[1.2.3. ULyraGameplayAbility_RangedWeapon]: #123-ulyragameplayability_rangedweapon
[1.2.3.1. GA_HealPickup]: #1231-ga_healpickup
[1.2.3.2. GA_Weapon_Fire]: #1232-ga_weapon_fire
[1.2.3.2.1. GA_Weapon_Fire_Pistol]: #12321-ga_weapon_fire_pistol
[1.2.3.2.2. GA_Weapon_Fire_Rifle]: #12322-ga_weapon_fire_rifle
[1.2.3.2.3. GA_Weapon_Fire_Shotgun]: #12323-ga_weapon_fire_shotgun
[1.2.3.2.4. GA_WeaponNetShooter]: #12324-ga_weaponnetshooter
[1.3. ULyraGameplayAbility_Interact]: #13-ulyragameplayability_interact
[1.3.1. GA_Interact]: #131-ga_interact
[1.4. ULyraGameplayAbility_Jump]: #14-ulyragameplayability_jump
[1.4.1. GA_Hero_Jump]: #141-ga_hero_jump
[1.5. ULyraGameplayAbility_Reset]: #15-ulyragameplayability_reset
[1.6. ULyraGamePhaseAbility]: #16-ulyragamephaseability
[1.6.1. Phase_Warmup]: #161-phase_warmup
[1.6.2. Phase_Playing]: #162-phase_playing
[1.6.3. Phase_PostGame]: #163-phase_postgame
[1.7. GA_AbilityWithWidget]: #17-ga_abilitywithwidget
[1.7.1. GA_ADS]: #171-ga_ads
[1.7.2. GA_Emoto]: #172-ga_emoto
[1.7.3. GA_Hero_Dash]: #173-ga_hero_dash
[1.7.4. GA_Melee]: #174-ga_melee
[1.8. GAB_ShowWidget_WhenInputPressed]: #18-gab_showwidget_wheninputpressed
[1.8.1. GA_ToggleInventory]: #181-ga_toggleinventory
[1.8.2. GA_ToggleMap]: #182-ga_togglemap
[1.9. GAB_ShowWidget_WhileInputHeld]: #19-gab_showwidget_whileinputheld
[1.9.1. GA_ShowLeaderboard_CP]: #191-ga_showleaderboard_cp
[1.9.2. GA_ShowLeaderboard_TDM]: #192-ga_showleaderboard_tdm
[1.10. GA_AutoRespawn]: #110-ga_autorespawn
[1.11. GA_DropBomb]: #111-ga_dropbomb
[1.12. GA_Grenade]: #112-ga_grenade
[1.13. GA_Hero_Heal]: #113-ga_hero_heal
[1.14. GA_Interaction_Collect]: #114-ga_interaction_collect
[1.15. GA_QuickbarSlots]: #115-ga_quickbarslots
[1.16. GA_SpawnEffect]: #116-ga_spawneffect
[1.17. GA_ToggleMarkerInWorld]: #117-ga_togglemarkerinworld
[終わりに]: #終わりに

[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ネイティブ アビリティ サブクラス]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%82%A2%E3%83%93%E3%83%AA%E3%83%86%E3%82%A3%E3%82%B5%E3%83%96%E3%82%AF%E3%83%A9%E3%82%B9
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ブループリント アビリティ サブクラス]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E3%83%96%E3%83%AB%E3%83%BC%E3%83%97%E3%83%AA%E3%83%B3%E3%83%88%E3%82%A2%E3%83%93%E3%83%AA%E3%83%86%E3%82%A3%E3%82%B5%E3%83%96%E3%82%AF%E3%83%A9%E3%82%B9

<!--- 自前の画像へのリンク --->
[Lyra_CharacterAndComponents]: images/Lyra_CharacterAndComponents.png

<!--- generated --->
[ULyraGamePhaseAbility]: CodeRefs/Lyra/GameplayAbility/ULyraGamePhaseAbility.md#ulyragamephaseability
[ULyraGameplayAbility]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraGameplayAbility_Death]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Death.md#ulyragameplayability_death
[ULyraGameplayAbility_FromEquipment]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_FromEquipment.md#ulyragameplayability_fromequipment
[ULyraGameplayAbility_Interact]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Interact.md#ulyragameplayability_interact
[ULyraGameplayAbility_Jump]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Jump.md#ulyragameplayability_jump
[ULyraGameplayAbility_RangedWeapon]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayability_rangedweapon
[ULyraGameplayAbility_Reset]: CodeRefs/Lyra/GameplayAbility/ULyraGameplayAbility_Reset.md#ulyragameplayability_reset
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ネイティブ アビリティ サブクラス]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%82%A2%E3%83%93%E3%83%AA%E3%83%86%E3%82%A3%E3%82%B5%E3%83%96%E3%82%AF%E3%83%A9%E3%82%B9
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ブループリント アビリティ サブクラス]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E3%83%96%E3%83%AB%E3%83%BC%E3%83%97%E3%83%AA%E3%83%B3%E3%83%88%E3%82%A2%E3%83%93%E3%83%AA%E3%83%86%E3%82%A3%E3%82%B5%E3%83%96%E3%82%AF%E3%83%A9%E3%82%B9
