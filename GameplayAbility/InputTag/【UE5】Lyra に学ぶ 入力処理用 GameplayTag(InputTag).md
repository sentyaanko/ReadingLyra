<style>
	.th_v{
		writing-mode: vertical-rl;
		transform: rotate(180deg);
	}
	.th_h{
		vertical-align: bottom;
	}
	.th_f{
		text-align: center;
		writing-mode: vertical-rl;
		transform: rotate(180deg);
	}
</style>


# 【UE5】Lyra に学ぶ 入力処理用 GameplayTag(InputTag) <!-- omit in toc -->

UE5 の新しいサンプル [Lyra Starter Game] 。  
その中で、入力と Gameplay Ability をつなぐのに GameplayTag が利用されており、これを読み解いていきます。  
基本的に GameplayTag 側から見た他のアセットとの関係としてまとめています。

* 解説しないこと
	* Gameplay Ability 側から見たものは個々の Gameplay Ability 毎にまとめる必要がありそうなので、ここでは扱いません。
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

* 特に正式名称というわけではありません。  
* このドキュメントでは **GameplayTag のうち、InputTag で始まるもの** をそのように称しています。
* C++ で定義されているものと ini ファイルで定義されているものがあります。
	* `LyraGameplayTags.cpp`
		* `UGameplayTagsManager::AddNativeGameplayTag()` を呼び出すことで定義している。
		* ここで定義しているものは `Project Settings > Gameplay Tags > Gameplay Tag List` で表示されるが削除できない。
		* これを利用して定義するのに適しているのは以下のようなもの。
			* Native に InputAction にバインドするもの。（ C++ 内で GameplayTag が確定している必要がある為。）
			* 言い方を変えると、 Gameplay Ability とは関連付けないもの。
				* そのため、 `ULyraAbilitySet` で利用されない。
	* `Config/DefaultGameplayTags.ini`
		* ここには GameFeature に属さない共通設定を定義するのが適している。
	* `Plugins/GameFeatures/ShooterCore/ShooterCoreTags.ini`
		* ここには GameFeature の ShooterCore に属する設定を定義するのが適している。
* InputTag は主に以下のアセットで利用されています。
	* `ULyraInputConfig`
		* InputTag と InputAction を関連付けるのに使用。
	* `ULyraAbilitySet`
		* InputTag と Gameplay Ability を関連付けるのに使用。
	* Gameplay Ability
		* イベントグラフの `Send Gameplay Event` / `Send Gameplay Event to Actor`
			* 他の Gameplay Ability に GameplayEvent を送る際の識別子として使用。
		* イベントグラフの `Wait Gameplay Event`
			* アクティブ化済みの Gameplay Ability にて、外部から GameplayEvent を受け取る際の識別子として使用。
		* `Detail > Triggers > Ability Triggers > Trigger Tag`
			* アクティブ化前の Gameplay Ability にて、外部から GameplayEvent を受け取る際の識別子として使用。
	* キャラクタークラス
	* BehaviorTree
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

<table rules="all">
	<thead>
		<tr>
			<th class="th_h">File</th>
			<th class="th_h">InputTag</th>
			<th class="th_v">InputData_SimplePawn</th>
			<th class="th_v">InputData_Hero</th>
			<th class="th_v">InputData_ShooterGame_AddOns</th>
			<th class="th_v">InputData_Arena</th>
			<th class="th_v">InputData_InventoryTest</th>
	</thead>
	<tbody>
		<tr><th class="th_f" rowspan="0"> LyraGameplayTags.cpp
		<tr><td> InputTag.Move                                     <td> IA_Move       <td> IA_Move             <td>                   <td> IA_Move        <td>                        </tr>
		<tr><td> InputTag.Look.Mouse                               <td> IA_Look_Mouse <td> IA_Look_Mouse       <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Look.Stick                               <td> IA_Look_Stick <td> IA_Look_Stick       <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Crouch                                   <td> IA_Crouch     <td> IA_Crouch           <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.AutoRun                                  <td> IA_AutoRun    <td> IA_AutoRun          <td>                   <td>                <td>                        </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> DefaultGameplayTags.ini
		<tr><td> InputTag.Jump                                     <td> IA_Jump       <td> IA_Jump             <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Dash                             <td>               <td> IA_Ability_Dash     <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Heal                             <td>               <td> IA_Ability_Heal     <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Weapon.Fire                              <td>               <td> IA_Weapon_Fire      <td>                   <td> IA_Weapon_Fire <td>                        </tr>
		<tr><td> InputTag.Weapon.FireAuto                          <td>               <td> IA_Weapon_Fire_Auto <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Weapon.Reload                            <td>               <td> IA_Weapon_Reload    <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Melee                            <td>               <td>                     <td> IA_Melee          <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Quickslot.Drop                   <td>               <td>                     <td> IA_DropWeapon     <td>                <td>                        </tr>
		<tr><td> InputTag.Weapon.ADS                               <td>               <td>                     <td> IA_ADS            <td>                <td>                        </tr>
		<tr><td> InputTag.Weapon.Grenade                           <td>               <td>                     <td> IA_Grenade        <td>                <td>                        </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> ShooterCoreTags.ini
		<tr><td> InputTag.Ability.Emote                            <td>               <td>                     <td> IA_Emote          <td>                <td> IA_Emote               </tr>
		<tr><td> InputTag.Ability.ShowLeaderboard                  <td>               <td>                     <td> IA_ShowScoreboard <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Quickslot                        <td>               <td>                     <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Quickslot.CycleBackward          <td>               <td>                     <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Quickslot.CycleForward           <td>               <td>                     <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Quickslot.SelectSlot             <td>               <td>                     <td>                   <td>                <td>                        </tr>
		<tr><td> InputTag.Ability.Interact                         <td>               <td>                     <td>                   <td>                <td> IA_Interact            </tr>
		<tr><td> InputTag.Ability.ToggleInventory                  <td>               <td>                     <td>                   <td>                <td> IA_ToggleInventory     </tr>
		<tr><td> InputTag.Ability.ToggleMap                        <td>               <td>                     <td>                   <td>                <td> IA_ToggleMap           </tr>
		<tr><td> InputTag.Ability.ToggleMarkerInWorld              <td>               <td>                     <td>                   <td>                <td> IA_ToggleMarkerInWorld </tr>
	</tbody>
</table>

異なる `ULyraInputConfig` を使用した際も `InputTag` と `InputAction` の組み合わせは同じになるように作られています。  
まとめると以下のようになります。

<table rules="all">
	<thead>
		<tr>
			<th class="th_h">File</th>
			<th class="th_h">InputTag</th>
			<th class="th_h">InputAction</th>
			<th class="th_h">InputAction が属するGameFeature</th>
	</thead>
	<tbody>
		<tr><th class="th_f" rowspan="0"> LyraGameplayTags.cpp
		<tr><td> InputTag.Move                                     <td> IA_Move                <td>             </tr>
		<tr><td> InputTag.Look.Mouse                               <td> IA_Look_Mouse          <td>             </tr>
		<tr><td> InputTag.Look.Stick                               <td> IA_Look_Stick          <td>             </tr>
		<tr><td> InputTag.Crouch                                   <td> IA_Crouch              <td>             </tr>
		<tr><td> InputTag.AutoRun                                  <td> IA_AutoRun             <td>             </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> DefaultGameplayTags.ini
		<tr><td> InputTag.Jump                                     <td> IA_Jump                <td>             </tr>
		<tr><td> InputTag.Ability.Dash                             <td> IA_Ability_Dash        <td>             </tr>
		<tr><td> InputTag.Ability.Heal                             <td> IA_Ability_Heal        <td>             </tr>
		<tr><td> InputTag.Weapon.Fire                              <td> IA_Weapon_Fire         <td>             </tr>
		<tr><td> InputTag.Weapon.FireAuto                          <td> IA_Weapon_Fire_Auto    <td>             </tr>
		<tr><td> InputTag.Weapon.Reload                            <td> IA_Weapon_Reload       <td>             </tr>
		<tr><td> InputTag.Ability.Melee                            <td> IA_Melee               <td> ShooterCore </tr>
		<tr><td> InputTag.Ability.Quickslot.Drop                   <td> IA_DropWeapon          <td> ShooterCore </tr>
		<tr><td> InputTag.Weapon.ADS                               <td> IA_ADS                 <td> ShooterCore </tr>
		<tr><td> InputTag.Weapon.Grenade                           <td> IA_Grenade             <td> ShooterCore </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> ShooterCoreTags.ini
		<tr><td> InputTag.Ability.Emote                            <td> IA_Emote               <td> ShooterCore </tr>
		<tr><td> InputTag.Ability.ShowLeaderboard                  <td> IA_ShowScoreboard      <td> ShooterCore </tr>
		<tr><td> InputTag.Ability.Quickslot                        <td>                        <td>             </tr>
		<tr><td> InputTag.Ability.Quickslot.CycleBackward          <td>                        <td> ShooterCore </tr>
		<tr><td> InputTag.Ability.Quickslot.CycleForward           <td>                        <td> ShooterCore </tr>
		<tr><td> InputTag.Ability.Quickslot.SelectSlot             <td>                        <td> ShooterCore </tr>
		<tr><td> InputTag.Ability.Interact                         <td> IA_Interact            <td> ShooterMaps </tr>
		<tr><td> InputTag.Ability.ToggleInventory                  <td> IA_ToggleInventory     <td> ShooterMaps </tr>
		<tr><td> InputTag.Ability.ToggleMap                        <td> IA_ToggleMap           <td> ShooterMaps </tr>
		<tr><td> InputTag.Ability.ToggleMarkerInWorld              <td> IA_ToggleMarkerInWorld <td> ShooterMaps </tr>
	</tbody>
</table>

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

## ShooterGame 関連

<table rules="all">
	<thead>
		<tr>
			<th class="th_h">File</th>
			<th class="th_h">InputTag</th>
			<th class="th_v">AbilitySet_ShooterHero</th>
			<th class="th_v">AbilitySet_ControlPoint</th>
			<th class="th_v">AbilitySet_Elimination</th>
	</thead>
	<tbody>
		<tr><th class="th_f" rowspan="0"> DefaultGameplayTags.ini
		<tr><td> InputTag.Jump                                     <td> GA_Hero_Jump              <td>                       <td>                        </tr>
		<tr><td> InputTag.Ability.Dash                             <td> GA_Hero_Dash              <td>                       <td>                        </tr>
		<tr><td> InputTag.Ability.Melee                            <td> GA_Melee                  <td>                       <td>                        </tr>
		<tr><td> InputTag.Ability.Quickslot.Drop                   <td> GA_DropWeapon             <td>                       <td>                        </tr>
		<tr><td> InputTag.Weapon.ADS                               <td> GA_ADS                    <td>                       <td>                        </tr>
		<tr><td> InputTag.Weapon.Grenade                           <td> GA_Grenade                <td>                       <td>                        </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> ShooterCoreTags.ini
		<tr><td> InputTag.Ability.Emote                            <td> GA_Emote                  <td>                       <td>                        </tr>
		<tr><td> InputTag.Ability.ShowLeaderboard                  <td>                           <td> GA_ShowLeaderboard_CP <td> GA_ShowLeaderboard_TDM </tr>
		<tr><td> InputTag.Ability.Quickslot                        <td> GA_QuickbarSlots          <td>                       <td>                        </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> None InputTag
		<tr><td>                                                   <td> GA_Hero_Death             <td> GA_AutoRespawn        <td> GA_AutoRespawn         </tr>
		<tr><td>                                                   <td> GA_SpawnEffect            <td>                       <td>                        </tr>
		<tr><td>                                                   <td> LyraGameplayAbility_Reset <td>                       <td>                        </tr>
	</tbody>
</table>

* 以下の様なことがわかります。
	* ルールによって異なるリーダーボードをルール毎の `ULyraAbilitySet` で指定している。
	* リスポーンはルールによらず `GA_AutoRespawn` で行っている。
	* ShooterGame での死亡処理は `GA_Hero_Death` を使用している。
* `InputTag.Ability.Quickslot` と `GA_QuickbarSlots`
	* `AbilitySet_ShooterHero` で `GA_QuickbarSlots` が設定されているが、 `ULyraInputConfig` での指定がない。
		* つまりは `ULyraInputConfig` 経由で入力マッピングされていない。
		* つまり C++ 経由で入力アクションからのアクティブ化されない。
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

<table rules="all">
	<thead>
		<tr>
			<th class="th_h">File</th>
			<th class="th_h">InputTag</th>
			<th class="th_v">AbilitySet_ShooterPistol</th>
			<th class="th_v">AbilitySet_ShooterRifle</th>
			<th class="th_v">AbilitySet_ShooterShotgun</th>
			<th class="th_v">AbilitySet_ShooterNetShooter</th>
	</thead>
	<tbody>
		<tr><th class="th_f" rowspan="0"> DefaultGameplayTags.ini
		<tr><td> InputTag.Weapon.Fire                              <td> GA_Weapon_Fire_Pistol   <td>                           <td>                          <td>                             </tr>
		<tr><td> InputTag.Weapon.FireAuto                          <td>                         <td> GA_Weapon_Fire_Rifle_Auto <td> GA_Weapon_Fire_Shotgun   <td> GA_WeaponNetShooter         </tr>
		<tr><td> InputTag.Weapon.Reload                            <td> GA_Weapon_Reload_Pistol <td> GA_Weapon_Reload_Rifle    <td> GA_Weapon_Reload_Shotgun <td> GA_Weapon_Reload_NetShooter </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> None InputTag
		<tr><td>                                                   <td> GA_Weapon_AutoReload    <td> GA_Weapon_AutoReload      <td> GA_Weapon_AutoReload     <td>                             </tr>
	</tbody>
</table>

* 以下の様なことがわかります。
	* Pistol は `InputTag.Weapon.Fire` でそれ以外は `InputTag.Weapon.FireAuto` を使用している。
	* NetShooter は `GA_Weapon_AutoReload` を付与していない。つまりオートリロードがない。


## その他

<table rules="all">
	<thead>
		<tr>
			<th class="th_h">File</th>
			<th class="th_h">InputTag</th>
			<th class="th_v">AbilitySet_Arena</th>
			<th class="th_v">AbilitySet_HealPickup</th>
			<th class="th_v">AbilitySet_InventoryTest</th>
			<th class="th_v">ShootingTarget_AbilitySet</th>
	</thead>
	<tbody>
		<tr><th class="th_f" rowspan="0"> DefaultGameplayTags.ini
		<tr><td> InputTag.Weapon.Fire                              <td> GA_DropBomb        <td> GA_HealPickup <td>                        <td>    </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> ShooterCoreTags.ini
		<tr><td> InputTag.Ability.Interact                         <td>                    <td>               <td> GA_Interact            <td>    </tr>
		<tr><td> InputTag.Ability.ToggleInventory                  <td>                    <td>               <td> GA_ToggleInventory     <td>    </tr>
		<tr><td> InputTag.Ability.ToggleMap                        <td>                    <td>               <td> GA_ToggleMap           <td>    </tr>
		<tr><td> InputTag.Ability.ToggleMarkerInWorld              <td>                    <td>               <td> GA_ToggleMarkerInWorld <td>    </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> None InputTag
		<tr><td>                                                   <td> GA_ArenaHero_Death <td>               <td>                        <td>    </tr>
	</tbody>
</table>

* 以下の様なことがわかります。
	* Arena での死亡処理は `GA_ArenaHero_Death` を使用している。（ ShooterGame とは異なる Gameplay Ability を使用している）


# InputTag と Gameplay Ability の関係

<table rules="all">
	<thead>
		<tr>
			<th class="th_h">File</th>
			<th class="th_h">InputTag</th>
			<th class="th_h">Gameplay Ability</th>
			<th class="th_h">利用箇所</th>
	</thead>
	<tbody>
		<tr><th class="th_f" rowspan="0"> DefaultGameplayTags.ini
		<tr><td> InputTag.Jump                                     <td>                                                    <td>                                         </tr>
		<tr><td> InputTag.Ability.Dash                             <td> GA_Hero_Dash                                       <td> Ability Triggers                        </tr>
		<tr><td> InputTag.Ability.Heal                             <td> GA_Hero_Heal                                       <td> Ability Triggers                        </tr>
		<tr><td> InputTag.Weapon.Fire                              <td> GA_Weapon_Fire                                     <td> Ability Triggers                        </tr>
		<tr><td> InputTag.Weapon.FireAuto                          <td>                                                    <td>                                         </tr>
		<tr><td> InputTag.Weapon.Reload                            <td> GA_Weapon_ReloadMagazine<br>GA_Weapon_AutoReload   <td> Ability Triggers<br>Send Gameplay Event </tr>
		<tr><td> InputTag.Ability.Melee                            <td>                                                    <td>                                         </tr>
		<tr><td> InputTag.Ability.Quickslot.Drop                   <td>                                                    <td>                                         </tr>
		<tr><td> InputTag.Weapon.ADS                               <td> GA_ADS<br>GA_Melee                                 <td> Ability Triggers<br>Ability Triggers    </tr>
		<tr><td> InputTag.Weapon.Grenade                           <td> GA_Grenade                                         <td> Ability Triggers                        </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> ShooterCoreTags.ini
		<tr><td> InputTag.Ability.Quickslot.CycleBackward          <td> GA_QuickbarSlots                                  <td> Wait Gameplay Event                      </tr>
		<tr><td> InputTag.Ability.Quickslot.CycleForward           <td> GA_QuickbarSlots                                  <td> Wait Gameplay Event                      </tr>
		<tr><td> InputTag.Ability.Quickslot.SelectSlot             <td> GA_QuickbarSlots                                  <td> Wait Gameplay Event                      </tr>
		<tr><td> InputTag.Ability.Interact                         <td> GA_Interact                                       <td> Ability Triggers                         </tr>
	</tbody>
</table>

* Ability Triggers
	* `Detail > Triggers > Ability Triggers > Trigger Tag` の事です。
	* 設定していると GameplayEvent によるアクティブ化ができるようになり、外部からアクティブ化しやすくなります。
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

<table rules="all">
	<thead>
		<tr>
			<th class="th_h">File</th>
			<th class="th_h">InputTag</th>
			<th class="th_h">キャラクタークラスからの利用</th>
			<th class="th_h">BehaviorTree からの利用</th>
	</thead>
	<tbody>
		<tr><th class="th_f" rowspan="0"> DefaultGameplayTags.ini
		<tr><td> InputTag.Weapon.Fire                              <td>                         <td> BTS_Shoot        </tr>
		<tr><td> InputTag.Weapon.FireAuto                          <td>                         <td> BTS_ReloadWeapon </tr>
	</tbody>
	<tbody>
		<tr><th class="th_f" rowspan="0"> ShooterCoreTags.ini
		<tr><td> InputTag.Ability.Quickslot.CycleBackward          <td> B_Hero_ShooterMannequin <td>                  </tr>
		<tr><td> InputTag.Ability.Quickslot.CycleForward           <td> B_Hero_ShooterMannequin <td>                  </tr>
		<tr><td> InputTag.Ability.Quickslot.SelectSlot             <td> B_Hero_ShooterMannequin <td> BTS_Shoot        </tr>
	</tbody>
</table>

* 全て `Send Gameplay Event to Actor` の EventTag として利用されています。
	* つまり、 Gameplay Ability のアクティブ化や `Wait Gameplay Event` のデリゲートの呼び出しに利用されています。
* 各列を見ることで、以下の様なことがわかります。
	* キャラクタークラスからの利用
		* ３つの InputTag に紐づいた Gameplay Ability が キャラクタークラスから（ C++ の仕組みを経由せず）直接利用されている。
	* BehaviorTree からの利用
		* ３つの InputTag に紐づいた Gameplay Ability が AI から利用されている。


# 終わりに

ここまでで、 InputTag とアセットのつながりが見えてきたと思います。  
InputTag の関係を把握することで、 Lyra で実装されている Gameplay Ability の全体像が掴めるようになるのではと思い、このドキュメントを作成しました。  
大きな表が多く文字ばかり、という読みづらい内容とは思いますが、どなたかの参考になれば幸いです。

-----
おしまい。

<!--- 公式：マーケットプレイス --->
[Lyra Starter Game]: https://www.unrealengine.com/marketplace/ja/product/lyra
