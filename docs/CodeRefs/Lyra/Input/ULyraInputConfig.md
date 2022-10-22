## ULyraInputConfig

> Non-mutable data asset that contains input configuration properties.
> 
> ----
> 入力設定プロパティを含む、非ミュータブルなデータアセットです。

* 概要
	* `UDataAsset` の派生クラスです。
	* 適用単位ごとに用意する、入力アクションと **InputTag** をバインドするためのデータアセット作成用のクラスです。
	* 主に以下で利用されます。
		* [ULyraInputComponent::BindAbilityActions()] 
			* 入力アクションと **InputTag** をバインドする際に利用されます。
		* [ULyraInputComponent::BindNativeAction()] 
			* 入力アクションとネイティブ関数をバインドする際に利用されます。
		* [ULyraInputComponent::AddInputMappings()] 
			* 引数として受け取っていますが利用していません。
		* [ULyraInputComponent::RemoveInputMappings()]
			* 引数として受け取っていますが利用していません。
	* `InputData_` のプレフィックスを持ちます。
	* アセットの設定は以下の通りです。
		| アセット名                       | 用途                                                          | 参照元                                                      |
		|----------------------------------|---------------------------------------------------------------|-------------------------------------------------------------|
		| InputData_Arena                  | Exploader 用                                                  | HeroData_Arena<br>([ULyraPawnData])                         |
		| InputData_Hero                   | ShooterGame 用（基礎部分）                                    | HeroData_ShooterGame<br>([ULyraPawnData])                   |
		| InputData_SimplePawn             | SimplePawn （デフォルトマップ等の円柱と球で作られたポーン）用 | SimplePawnData<br>([ULyraPawnData])                         |
		| InputData_InventoryTest          | インベントリ操作用の設定？解説は割愛。                        | LAS_InventoryTest<br>([ULyraExperienceActionSet])           |
		| InputData_ShooterGame_AddOns     | ShooterGame 用（ Game Feature 拡張部分）                      | LAS_ShooterGame_SharedInput<br>([ULyraExperienceActionSet]) |
	* 例: `InputData_Arena` / `InputData_Hero` ([ULyraInputConfig]) での設定は以下の通りです。
		| ULyraInputConfig    |                     | [FLyraInputAction::InputTag] | [FLyraInputAction::InputAction] |
		|---------------------|---------------------|------------------------------|---------------------------------|
		| InputData_Arena     | NativeInputActions  | `InputTag.Move`              | `IA_Move`                       |
		|                     | AbilityInputActions | `InputTag.Weapon.Fire`       | `IA_Weapon_Fire`                |
		|                     |                     |                              |                                 |
		| InputData_Hero      | NativeInputActions  | `InputTag.Move`              | `IA_Move`                       |
		|                     |                     | `InputTag.Look.Mouse`        | `IA_Look_Mouse`                 |
		|                     |                     | `InputTag.Look.Stick`        | `IA_Look_Stick`                 |
		|                     |                     | `InputTag.Crouch`            | `IA_Crouch`                     |
		|                     |                     | `InputTag.AutoRun`           | `IA_AutoRun`                    |
		|                     | AbilityInputActions | `InputTag.Jump`              | `IA_Jump`                       |
		|                     |                     | `InputTag.Ability.Dash`      | `IA_Ability_Dash`               |
		|                     |                     | `InputTag.Ability.Heal`      | `IA_Ability_Heal`               |
		|                     |                     | `InputTag.Weapon.Fire`       | `IA_Weapon_Fire`                |
		|                     |                     | `InputTag.Weapon.FireAuto`   | `IA_Weapon_Fire_Auto`           |
		|                     |                     | `InputTag.Weapon.Reload`     | `IA_Weapon_Reload`              |


### ULyraInputConfig::NativeInputActions

> List of input actions used by the owner.  
> These input actions are mapped to a gameplay tag and must be manually bound.  
> 
> ----
> オーナーが使用する入力アクションのリストです。  
> これらの入力アクションはゲームプレイタグにマッピングされ、手動でバインドする必要があります。  

* 概要
	* [FLyraInputAction] の配列です。
	* 固定の処理が実装されているアクションです。
		* Move/Look_Mouse/Look_Stick/Crouch/AutoRun
	* それぞれの専用関数に直接バインドされ、それぞれの処理を行っています。

### ULyraInputConfig::AbilityInputActions

> List of input actions used by the owner.  
> These input actions are mapped to a gameplay tag and are automatically bound to abilities with matching input tags.  
> 
> ----
> オーナーが使用する入力アクションのリストです。  
> これらの入力アクションはゲームプレイタグにマッピングされ、一致する入力タグを持つアビリティに自動的にバインドされます。  

* 概要
	* [FLyraInputAction] の配列です。
	* Gameplay Ability として実装されているアクションです。
		* Jump 、その他のアクション。
	* アビリティ用の汎用関数にバインドされ、 **InputTag** を元に付与されている Gameplay Ability を検索してアクティブ化します。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[FLyraInputAction]: ../../Lyra/Input/FLyraInputAction.md#flyrainputaction
[FLyraInputAction::InputAction]: ../../Lyra/Input/FLyraInputAction.md#flyrainputactioninputaction
[FLyraInputAction::InputTag]: ../../Lyra/Input/FLyraInputAction.md#flyrainputactioninputtag
[ULyraInputComponent::AddInputMappings()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentaddinputmappings
[ULyraInputComponent::RemoveInputMappings()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentremoveinputmappings
[ULyraInputComponent::BindNativeAction()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentbindnativeaction
[ULyraInputComponent::BindAbilityActions()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentbindabilityactions
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
