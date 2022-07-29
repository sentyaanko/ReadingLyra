# 【UE5】Lyra に学ぶ 入力処理用 GameplayTag(InputTag) <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中で、入力と Gameplay Ability をつなぐのに GameplayTag が利用されており、これを読み解いていきます。  
基本的に GameplayTag 側から見た他のアセットとの関係としてまとめています。

* 解説しないこと
	* Gameplay Ability 
		* 仕組みや Gameplay Ability から見た GameplayTag については、ここでは扱いません。
		* Lyra で実装されている Gameplay Ability について知りたい場合、以下が詳しいです。
			* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ]
* バージョン
	* [Lyra Starter Game]
		* 2022/04/05 版


# Index <!-- omit in toc -->

- [そもそも InputTag とは？](#そもそも-inputtag-とは)
- [InputTag と ULyraInputConfig の関係](#inputtag-と-ulyrainputconfig-の関係)
- [InputTag と ULyraAbilitySet の関係](#inputtag-と-ulyraabilityset-の関係)
	- [ShooterGame 関連](#shootergame-関連)
	- [Weapon 関連](#weapon-関連)
	- [その他](#その他)
- [InputTag と Gameplay Ability の関係](#inputtag-と-gameplay-ability-の関係)
- [その他のクラスとの関係](#その他のクラスとの関係)
- [終わりに](#終わりに)


# そもそも InputTag とは？

* 正式名称というわけではありません。  
* このドキュメントでは **GameplayTag のうち、InputTag で始まるもの** をそのように称しています。
	* 公式ドキュメントで **入力タグ** 、翻訳元で **Input Tag** という記述もあるので、完全な的外れな呼称というわけではありません。
		* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 入力タグ アクティベーション サポート]
* InputTag は **入力に反応して実行する処理をモジュール式に追加出来るようにするため** に使用されています。
	* Lyra では上記を実現できるように GameplayTag と Gameplay Ability を組み合わせてセットアップしている、という感じです。
* 入力から Gameplay Ability へのつながりは以下の様になります。
	1. 物理的な入力に対し `UInputMappingContext` で関連付けられた `UInputAction` の呼び出す。
	2. `UInputAction` にバインドされた関数の呼び出し。バインドされた関数は `ULyraInputConfig` で設定されている InputTag を引数で渡す。
	3. 渡された InputTag を元に `ULyraAbilitySet` で設定されている Gameplay Ability の関数の呼び出す。
* InputTag は主に以下のアセットで利用されています。
	* `ULyraInputConfig`
		* InputTag と InputAction を関連付けるのに使用。
		* これにより、 Enhanced Input にて InputAction と InputTag をバインドする。
	* `ULyraAbilitySet`
		* InputTag と Gameplay Ability を関連付けるのに使用。
		* これにより、 Lyra の実装にて InputTag を元に Gameplay Ability を制御する。
	* Gameplay Ability
		* イベントグラフの `Send Gameplay Event` / `Send Gameplay Event to Actor`
			* 他の Gameplay Ability に GameplayEvent を送る際の識別子として使用。
		* イベントグラフの `Wait Gameplay Event`
			* アクティブ化済みの Gameplay Ability にて、外部から GameplayEvent を受け取る際の識別子として使用。
		* `Detail > Triggers > Ability Triggers > Trigger Tag`
			* アクティブ化前の Gameplay Ability にて、外部から GameplayEvent を受け取る際の識別子として使用。
	* キャラクタークラス
	* BehaviorTree
* C++ で定義されているものと ini ファイルで定義されているものがあります。
	* `LyraGameplayTags.cpp`
		* `UGameplayTagsManager::AddNativeGameplayTag()` を呼び出すことで定義している。
		* ここで定義しているものは *Project Settings > Gameplay Tags > Gameplay Tag List* で表示される。が、削除できない。
		* これを利用して定義するのに適しているのは以下のようなもの。
			* Native に InputAction にバインドするもの。（ C++ 内で GameplayTag が確定している必要がある為。）
			* 言い方を変えると、 Gameplay Ability とは関連付けないもの。
				* そのため、 `ULyraAbilitySet` で利用されない。
	* `Config/DefaultGameplayTags.ini`
		* ここには GameFeature に属さない共通設定を定義するのが適している。
	* `Plugins/GameFeatures/ShooterCore/ShooterCoreTags.ini`
		* ここには GameFeature の ShooterCore に属する設定を定義するのが適している。
* 定義されている InputTag は以下の通り。
	* **LyraGameplayTags.cpp**
		* InputTag.Move
		* InputTag.Look.Mouse
		* InputTag.Look.Stick
		* InputTag.Crouch
		* InputTag.AutoRun
	* **DefaultGameplayTags.ini**
		* InputTag.Jump
		* InputTag.Ability.Dash
		* InputTag.Ability.Heal
		* InputTag.Weapon.Fire
		* InputTag.Weapon.FireAuto
		* InputTag.Weapon.Reload
		* InputTag.Ability.Melee
		* InputTag.Ability.Quickslot.Drop
		* InputTag.Weapon.ADS
		* InputTag.Weapon.Grenade
	* **ShooterCoreTags.ini**
		* InputTag.Ability.Emote
		* InputTag.Ability.ShowLeaderboard
		* InputTag.Ability.Quickslot.CycleBackward
		* InputTag.Ability.Quickslot.CycleForward
		* InputTag.Ability.Quickslot.SelectSlot
		* InputTag.Ability.Interact
		* InputTag.Ability.ToggleInventory
		* InputTag.Ability.ToggleMap
		* InputTag.Ability.ToggleMarkerInWorld


# InputTag と ULyraInputConfig の関係

表の幅を抑えるため `ULyraInputConfig` のプレフィックスの `InputData_` は省略します。

| InputTag                                 | SimplePawn    | Hero                | ShooterGame_AddOns | Arena          | InventoryTest          |
|------------------------------------------|---------------|---------------------|--------------------|----------------|------------------------|
| **LyraGameplayTags.cpp**                 |               |                     |                    |                |                        |
| InputTag.Move                            | IA_Move       | IA_Move             |                    | IA_Move        |                        |
| InputTag.Look.Mouse                      | IA_Look_Mouse | IA_Look_Mouse       |                    |                |                        |
| InputTag.Look.Stick                      | IA_Look_Stick | IA_Look_Stick       |                    |                |                        |
| InputTag.Crouch                          | IA_Crouch     | IA_Crouch           |                    |                |                        |
| InputTag.AutoRun                         | IA_AutoRun    | IA_AutoRun          |                    |                |                        |
|                                          |               |                     |                    |                |                        |
| **DefaultGameplayTags.ini**              |               |                     |                    |                |                        |
| InputTag.Jump                            | IA_Jump       | IA_Jump             |                    |                |                        |
| InputTag.Ability.Dash                    |               | IA_Ability_Dash     |                    |                |                        |
| InputTag.Ability.Heal                    |               | IA_Ability_Heal     |                    |                |                        |
| InputTag.Weapon.Fire                     |               | IA_Weapon_Fire      |                    | IA_Weapon_Fire |                        |
| InputTag.Weapon.FireAuto                 |               | IA_Weapon_Fire_Auto |                    |                |                        |
| InputTag.Weapon.Reload                   |               | IA_Weapon_Reload    |                    |                |                        |
| InputTag.Ability.Melee                   |               |                     | IA_Melee           |                |                        |
| InputTag.Ability.Quickslot.Drop          |               |                     | IA_DropWeapon      |                |                        |
| InputTag.Weapon.ADS                      |               |                     | IA_ADS             |                |                        |
| InputTag.Weapon.Grenade                  |               |                     | IA_Grenade         |                |                        |
|                                          |               |                     |                    |                |                        |
| **ShooterCoreTags.ini**                  |               |                     |                    |                |                        |
| InputTag.Ability.Emote                   |               |                     | IA_Emote           |                | IA_Emote               |
| InputTag.Ability.ShowLeaderboard         |               |                     | IA_ShowScoreboard  |                |                        |
| InputTag.Ability.Quickslot               |               |                     |                    |                |                        |
| InputTag.Ability.Quickslot.CycleBackward |               |                     |                    |                |                        |
| InputTag.Ability.Quickslot.CycleForward  |               |                     |                    |                |                        |
| InputTag.Ability.Quickslot.SelectSlot    |               |                     |                    |                |                        |
| InputTag.Ability.Interact                |               |                     |                    |                | IA_Interact            |
| InputTag.Ability.ToggleInventory         |               |                     |                    |                | IA_ToggleInventory     |
| InputTag.Ability.ToggleMap               |               |                     |                    |                | IA_ToggleMap           |
| InputTag.Ability.ToggleMarkerInWorld     |               |                     |                    |                | IA_ToggleMarkerInWorld |

異なる `ULyraInputConfig` を使用した際も `InputTag` と `InputAction` の組み合わせは同じになるように作られています。  
まとめると以下のようになります。

| InputTag                                 | InputAction            | InputAction が属するGameFeature |
|------------------------------------------|------------------------|---------------------------------|
| **LyraGameplayTags.cpp**                 |                        |                                 |
| InputTag.Move                            | IA_Move                |                                 |
| InputTag.Look.Mouse                      | IA_Look_Mouse          |                                 |
| InputTag.Look.Stick                      | IA_Look_Stick          |                                 |
| InputTag.Crouch                          | IA_Crouch              |                                 |
| InputTag.AutoRun                         | IA_AutoRun             |                                 |
|                                          |                        |                                 |
| **DefaultGameplayTags.ini**              |                        |                                 |
| InputTag.Jump                            | IA_Jump                |                                 |
| InputTag.Ability.Dash                    | IA_Ability_Dash        |                                 |
| InputTag.Ability.Heal                    | IA_Ability_Heal        |                                 |
| InputTag.Weapon.Fire                     | IA_Weapon_Fire         |                                 |
| InputTag.Weapon.FireAuto                 | IA_Weapon_Fire_Auto    |                                 |
| InputTag.Weapon.Reload                   | IA_Weapon_Reload       |                                 |
| InputTag.Ability.Melee                   | IA_Melee               | ShooterCore                     |
| InputTag.Ability.Quickslot.Drop          | IA_DropWeapon          | ShooterCore                     |
| InputTag.Weapon.ADS                      | IA_ADS                 | ShooterCore                     |
| InputTag.Weapon.Grenade                  | IA_Grenade             | ShooterCore                     |
|                                          |                        |                                 |
| **ShooterCoreTags.ini**                  |                        |                                 |
| InputTag.Ability.Emote                   | IA_Emote               | ShooterCore                     |
| InputTag.Ability.ShowLeaderboard         | IA_ShowScoreboard      | ShooterCore                     |
| InputTag.Ability.Quickslot               |                        |                                 |
| InputTag.Ability.Quickslot.CycleBackward |                        | ShooterCore                     |
| InputTag.Ability.Quickslot.CycleForward  |                        | ShooterCore                     |
| InputTag.Ability.Quickslot.SelectSlot    |                        | ShooterCore                     |
| InputTag.Ability.Interact                | IA_Interact            | ShooterMaps                     |
| InputTag.Ability.ToggleInventory         | IA_ToggleInventory     | ShooterMaps                     |
| InputTag.Ability.ToggleMap               | IA_ToggleMap           | ShooterMaps                     |
| InputTag.Ability.ToggleMarkerInWorld     | IA_ToggleMarkerInWorld | ShooterMaps                     |

* InputTag と InputAction の属する GameFeature の差について
	* 例１： `IA_Melee` は GameFeature `ShooterCore` に属しているが、 `InputTag.Ability.Melee` は `DefaultGameplayTags.ini` で定義されている。
	* 例２： `IA_Interact` は GameFeature `ShooterMaps` に属しているが、 `InputTag.Ability.Melee` は `ShooterCoreTags.ini` で定義されている。
	* 理由は不明。要確認。
* `InputTag.Ability.Quickslot.*` の補足
	* 他の InputTag と異なり、 C++ でのバインドで使用されていない。
		* つまり、 `ULyraAbilitySet` や `LyraInputConfig` から参照されていない。
	* `GA_QuickbarSlots` と `B_Hero_ShooterMannequin` で使用されている。
		* `B_Hero_ShooterMannequin` は `ControlPoints` 等で使用されるキャラクタークラス。
		* `GA_QuickbarSlots` は使用武器を変えるためのアビリティ。
	* `B_Hero_ShooterMannequin` との関係
		* 直接 Enhanced Action Events(EnhancedInputAction ノード)を利用して以下の InputAction のイベントを実装している。
			* `IA_QuickSlot_CycleBackward`
			* `IA_QuickSlot_CycleForward`
			* `IA_QuickSlot1`
			* `IA_QuickSlot2`
			* `IA_QuickSlot3`
		* 上記のイベントの中で `Send Gameplay Event to Actor` の EventTag として下記のタグを使用している。
			* `InputTag.Ability.Quickslot.CycleBackward`
			* `InputTag.Ability.Quickslot.CycleForward`
			* `InputTag.Ability.Quickslot.SelectSlot`
		* `InputTag.Ability.Quickslot.SelectSlot` を送る際の処理について。
			* `GameplayEventData` の `EventMagnitude` に使用する武器のスロットを設定している。
	* `GA_QuickbarSlots` との関係
		* `Wait Gameplay Event` ノードの EventTag として下記のタグを使用している。
			* `InputTag.Ability.Quickslot.CycleBackward`
			* `InputTag.Ability.Quickslot.CycleForward`
			* `InputTag.Ability.Quickslot.SelectSlot`
		* `InputTag.Ability.Quickslot.SelectSlot` を受け取る際の処理について。
			* `GameplayEventData` の `EventMagnitude` から使用する武器のスロットを受け取っている。
		* `AbilitySet_ShooterHero` にて下記のタグとペアで使用し、アビリティの付与の際に利用している。
			* `InputTag.Ability.Quickslot`
		* `InputTag.Ability.Quickslot` とその子階層の関係について。
			* `InputTag.Ability.Quickslot` 自体は定義されていない。が、子階層があるため利用できる。
			* 階層のルールと意図の推察
				* ルール
					* Gameplay Ability を表すタグを決め、 `ULyraAbilitySet` にペアで登録する。
						* （ここでは `GA_QuickbarSlots` と `InputTag.Ability.Quickslot` ）
					* Gameplay Ability 内で GameplayTag を使用する場合はその子階層を使用する。
						* （`InputTag.Ability.Quickslot.SelectSlot` 等。 ）
				* 意図
					* 元々、 GameplayTag の階層は、関連したアビリティを一括停止するなどするために利用できる。
						* 例：武器変更時に武器のアビリティを一括で止めるなど。
						* ただ、 InputTag に関して言えば、そういった用途では使用しないのでこれとは無関係。
					* ここでは関連した GameplayTag であることがわかりやすいようにしている？
					* `InputTag.Ability.Quickslot` 以下に使用中の武器に関する InputTag を置こうとしていた？
					* `InputTag.Ability.Quickslot.Drop` の意図は？
						* 定義も `DefaultGameplayTags.ini` と `ShooterCoreTags.ini` に分かれてしまっている。
					* なにか歪な感じがします。

# InputTag と ULyraAbilitySet の関係

表の幅を抑えるため `ULyraAbilitySet` のプレフィックス（サフィックス）の `AbilitySet_(_AbilitySet)` は省略します。

## ShooterGame 関連

| InputTag                         | ShooterHero               | ControlPoint          | Elimination            |
|----------------------------------|---------------------------|-----------------------|------------------------|
| **DefaultGameplayTags.ini**      |                           |                       |                        |
| InputTag.Jump                    | GA_Hero_Jump              |                       |                        |
| InputTag.Ability.Dash            | GA_Hero_Dash              |                       |                        |
| InputTag.Ability.Melee           | GA_Melee                  |                       |                        |
| InputTag.Ability.Quickslot.Drop  | GA_DropWeapon             |                       |                        |
| InputTag.Weapon.ADS              | GA_ADS                    |                       |                        |
| InputTag.Weapon.Grenade          | GA_Grenade                |                       |                        |
|                                  |                           |                       |                        |
| **ShooterCoreTags.ini**          |                           |                       |                        |
| InputTag.Ability.Emote           | GA_Emote                  |                       |                        |
| InputTag.Ability.ShowLeaderboard |                           | GA_ShowLeaderboard_CP | GA_ShowLeaderboard_TDM |
| InputTag.Ability.Quickslot       | GA_QuickbarSlots          |                       |                        |
|                                  |                           |                       |                        |
| **None InputTag**                |                           |                       |                        |
|                                  | GA_Hero_Death             | GA_AutoRespawn        | GA_AutoRespawn         |
|                                  | GA_SpawnEffect            |                       |                        |
|                                  | LyraGameplayAbility_Reset |                       |                        |

* 以下の様なことがわかります。
	* ルールによって異なるリーダーボードをルール毎の `ULyraAbilitySet` で指定している。
	* リスポーンはルールによらず `GA_AutoRespawn` で行っている。
	* ShooterGame での死亡処理は `GA_Hero_Death` を使用している。
* `InputTag.Ability.Quickslot` と `GA_QuickbarSlots`
	* `AbilitySet_ShooterHero` で `GA_QuickbarSlots` が設定されているが、 `ULyraInputConfig` での指定がない。
		* つまりは `ULyraInputConfig` 経由で入力マッピングされていない。
		* つまり C++ 経由で入力アクションからアクティブ化されない。
		* ただ、このアビリティは `Activation Policy` が `OnSpawn` に設定されている。
			* つまりアビリティが付与された時点でアクティブ化するので問題ない。
* InputTag が指定されていない Gameplay Ability
	* これらは、要は入力をトリガにせずにアクティブ化する Gameplay Ability です。
	* 例：
		* `GA_AutoRespawn`
			* `Activation Policy` が `OnSpawn` に設定されており、アビリティが付与された時点でアクティブ化する。
		* `GA_Hero_Death`
			* InputTag ではない、他の GameplayTag(`GameplayEvent.Death`) によりアクティブ化する。

## Weapon 関連

| InputTag                    | ShooterPistol           | ShooterRifle              | ShooterShotgun           | ShooterNetShooter           |
|-----------------------------|-------------------------|---------------------------|--------------------------|-----------------------------|
| **DefaultGameplayTags.ini** |                         |                           |                          |                             |
| InputTag.Weapon.Fire        | GA_Weapon_Fire_Pistol   |                           |                          |                             |
| InputTag.Weapon.FireAuto    |                         | GA_Weapon_Fire_Rifle_Auto | GA_Weapon_Fire_Shotgun   | GA_WeaponNetShooter         |
| InputTag.Weapon.Reload      | GA_Weapon_Reload_Pistol | GA_Weapon_Reload_Rifle    | GA_Weapon_Reload_Shotgun | GA_Weapon_Reload_NetShooter |
|                             |                         |                           |                          |                             |
| **None InputTag**           |                         |                           |                          |                             |
|                             | GA_Weapon_AutoReload    | GA_Weapon_AutoReload      | GA_Weapon_AutoReload     |                             |

* 以下の様なことがわかります。
	* Pistol は `InputTag.Weapon.Fire` でそれ以外は `InputTag.Weapon.FireAuto` を使用している。
	* NetShooter は `GA_Weapon_AutoReload` を付与していない。つまりオートリロードがない。


## その他

| InputTag                             | Arena              | HealPickup    | InventoryTest          | ShootingTarget |
|--------------------------------------|--------------------|---------------|------------------------|----------------|
| **DefaultGameplayTags.ini**          |                    |               |                        |                |
| InputTag.Weapon.Fire                 | GA_DropBomb        | GA_HealPickup |                        |                |
|                                      |                    |               |                        |                |
| **ShooterCoreTags.ini**              |                    |               |                        |                |
| InputTag.Ability.Interact            |                    |               | GA_Interact            |                |
| InputTag.Ability.ToggleInventory     |                    |               | GA_ToggleInventory     |                |
| InputTag.Ability.ToggleMap           |                    |               | GA_ToggleMap           |                |
| InputTag.Ability.ToggleMarkerInWorld |                    |               | GA_ToggleMarkerInWorld |                |
|                                      |                    |               |                        |                |
| **None InputTag**                    |                    |               |                        |                |
|                                      | GA_ArenaHero_Death |               |                        |                |

* 以下の様なことがわかります。
	* Arena での死亡処理は `GA_ArenaHero_Death` を使用している。（ ShooterGame とは異なる Gameplay Ability を使用している）


# InputTag と Gameplay Ability の関係

| InputTag                                 | Gameplay Ability                                 | 利用箇所                                |
|------------------------------------------|--------------------------------------------------|-----------------------------------------|
| **DefaultGameplayTags.ini**              |                                                  |                                         |
| InputTag.Jump                            |                                                  |                                         |
| InputTag.Ability.Dash                    | GA_Hero_Dash                                     | Ability Triggers                        |
| InputTag.Ability.Heal                    | GA_Hero_Heal                                     | Ability Triggers                        |
| InputTag.Weapon.Fire                     | GA_Weapon_Fire                                   | Ability Triggers                        |
| InputTag.Weapon.FireAuto                 |                                                  |                                         |
| InputTag.Weapon.Reload                   | GA_Weapon_ReloadMagazine<br>GA_Weapon_AutoReload | Ability Triggers<br>Send Gameplay Event |
| InputTag.Ability.Melee                   |                                                  |                                         |
| InputTag.Ability.Quickslot.Drop          |                                                  |                                         |
| InputTag.Weapon.ADS                      | GA_ADS<br>GA_Melee                               | Ability Triggers<br>Ability Triggers    |
| InputTag.Weapon.Grenade                  | GA_Grenade                                       | Ability Triggers                        |
|                                          |                                                  |                                         |
| **ShooterCoreTags.ini**                  |                                                  |                                         |
| InputTag.Ability.Quickslot.CycleBackward | GA_QuickbarSlots                                 | Wait Gameplay Event                     |
| InputTag.Ability.Quickslot.CycleForward  | GA_QuickbarSlots                                 | Wait Gameplay Event                     |
| InputTag.Ability.Quickslot.SelectSlot    | GA_QuickbarSlots                                 | Wait Gameplay Event                     |
| InputTag.Ability.Interact                | GA_Interact                                      | Ability Triggers                        |


* Ability Triggers
	* `Detail > Triggers > Ability Triggers > Trigger Tag` の事です。
	* 設定していると GameplayEvent によるアクティブ化ができるようになり、外部からアクティブ化がしやすくなります。
	* Lyra では BehaviorTree から呼び出しています。
* 個々の設定に関して
	* `InputTag.Weapon.Reload`
		* `GA_Weapon_AutoReload` で `Send Gameplay Event` に渡すことで、 GameplayEvent 経由で `GA_Weapon_ReloadMagazine` をアクティブ化しています。
	* `InputTag.Weapon.ADS`
		* `GA_Melee` の Ability Triggers で指定されていますが、おそらく間違いです。
		* `InputTag.Ability.Melee` を指定するのが正しいと思われます。
			* ただし、現状では、 AI は ADS も Melee 攻撃も使っていません（ BehaviorTree からの参照がありません ）。
			* つまりはこの GameplayEvent は現状発生しないので、影響はありません。
				* AI で ADS や Melee 攻撃をさせるように拡張する際は注意が必要です。

# その他のクラスとの関係

| InputTag                                 | キャラクタークラス      | BehaviorTree     |
|------------------------------------------|-------------------------|------------------|
| **DefaultGameplayTags.ini**              |                         |                  |
| InputTag.Weapon.Fire                     |                         | BTS_Shoot        |
| InputTag.Weapon.FireAuto                 |                         | BTS_ReloadWeapon |
|                                          |                         |                  |
| **ShooterCoreTags.ini**                  |                         |                  |
| InputTag.Ability.Quickslot.CycleBackward | B_Hero_ShooterMannequin |                  |
| InputTag.Ability.Quickslot.CycleForward  | B_Hero_ShooterMannequin |                  |
| InputTag.Ability.Quickslot.SelectSlot    | B_Hero_ShooterMannequin | BTS_Shoot        |

* 全て `Send Gameplay Event to Actor` の EventTag として利用されています。
	* つまり、 Gameplay Ability のアクティブ化や `Wait Gameplay Event` のデリゲートの呼び出しに利用されています。
* 各列を見ることで、以下の様なことがわかります。
	* キャラクタークラス
		* ３つの InputTag に紐づいた Gameplay Ability が キャラクタークラスから（ C++ の仕組みを経由せず）利用されている。
	* BehaviorTree
		* ３つの InputTag に紐づいた Gameplay Ability が AI から利用されている。

# 終わりに

ここまでで、 InputTag とアセットのつながりが見えてきたと思います。  
これを把握することで、 Lyra で実装されている Gameplay Ability の全体像が掴めるようになるのではと思い、このドキュメントを作成しました。  
大きな表が多く文字ばかり、という読みづらい内容とは思いますが、どなたかの参考になれば幸いです。

-----
おしまい。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 入力タグ アクティベーション サポート]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#%E5%85%A5%E5%8A%9B%E3%82%BF%E3%82%B0%E3%82%A2%E3%82%AF%E3%83%86%E3%82%A3%E3%83%99%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%B5%E3%83%9D%E3%83%BC%E3%83%88
