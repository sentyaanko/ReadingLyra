## ULyraHeroComponent

> A component used to create a player controlled pawns (characters, vehicles, etc..).  
> 
> ----
> プレイヤーが制御するポーン（キャラクター、ビークルなど）を作成するために使用されるコンポーネント。  

* 主な役割
	* 入力時のロジックの実装と Enhanced Input との関連付け。
	* [ULyraPawnExtensionComponent] のアビリティシステム関連の機能呼び出し。
	* アビリティによるカメラ情報の保持。
* 追加しているポーン
	* C++ では追加していない。
	* `B_Hero_Default` （キャラクターの BP の基底クラス） で追加している。
* [ULyraPawnExtensionComponent] との関係
	* 参照方法
		* 自身を追加している Pawn に `FindComponentByClass<ULyraPawnExtensionComponent>()` を呼び出すことで参照している。
	* 用途
		* [ULyraPawnData] を使用するとき。
		* [ULyraAbilitySystemComponent] を使用するとき。
* [ULyraPawnData] との関係
	* `InputConfig` / `DefaultCameraMode` を参照している。
* [ULyraAbilitySystemComponent] との関係
	* クラス内でキャッシュを持たない。
	* 初期化時（ [ULyraHeroComponent::OnPawnReadyToInitialize()] ）に [ALyraPlayerState] から取得し、 [ULyraPawnExtensionComponent] に設定する。
	* 以降、アクセス時は [ULyraPawnExtensionComponent] 経由で行う。
* [ALyraCharacter] との関係
	* ほぼ無い。
	* [ALyraCharacter::ToggleCrouch()] の機能を利用するときのみ参照している。
		* ただ、上記の関数は `ACharacter` の機能しか利用していないので、最悪参照なしでも実装可能です。そのぐらいの関係性の低さ。

### ULyraHeroComponent::DefaultInputConfigs

> Input Configs that should be added to this player when initalizing the input.  
> NOTE: You should only add to this if you do not have a game feature plugin accessible to you.  
> If you do, then use the GameFeatureAction_AddInputConfig instead.  
> 
> ----
> 入力を初期化するときに、このプレーヤに追加されるべき入力コンフィグ。  
> 注：この設定は、 GameFeature プラグインにアクセスできない場合にのみ追加する必要があります。  
> もしあるならば、代わりに GameFeatureAction_AddInputConfig を使用してください。  

* [FMappableConfigPair] の配列を保持している。
	* この設定は [ULyraHeroComponent::InitializePlayerInput()] で読み込まれ、 [ULyraSettingsLocal] に反映される。
		* [ULyraSettingsLocal] に反映された内容は [ULyraInputComponent::AddInputMappings()] で Enhanced Input にマッピングの追加をされる。
		* 上記のコメントの通り、 Game Feature を使用しない場合にこのプロパティを設定することを想定されている。
* 利用しているクラス
	* `B_SimplePawn`

### ULyraHeroComponent::IsPawnComponentReadyToInitialize()

* 自身を所有している Pawn の Controller/PlayerState/Owner/InputComponent などの関連付け状態のチェックを行う。
* 個のコンポーネントの準備というより、自身を追加している Pawn の準備の確認を行っている。

### ULyraHeroComponent::OnPawnReadyToInitialize()

* [ULyraPawnExtensionComponent] に登録するデリゲート用の関数です。
* [ULyraPawnExtensionComponent::InitializeAbilitySystem()] を呼び出す。
	* 引数の [ULyraAbilitySystemComponent] は [ALyraPlayerState] から受け取ったものを渡す。
* [ULyraHeroComponent::InitializePlayerInput()] を呼び出す。

### ULyraHeroComponent::InitializePlayerInput()

* 主に入力マッピングの追加と入力アクションのバインドを行う。
* [ULyraHeroComponent::OnPawnReadyToInitialize()] から呼ばれる。


### ULyraHeroComponent::DetermineCameraMode()

* 状況に応じたカメラモード [ULyraCameraMode] を返す。




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraCameraMode]: ../../Lyra/Etc/ULyraCameraMode.md#ulyracameramode
[ULyraSettingsLocal]: ../../Lyra/Etc/ULyraSettingsLocal.md#ulyrasettingslocal
[FMappableConfigPair]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpair
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraHeroComponent::OnPawnReadyToInitialize()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentonpawnreadytoinitialize
[ULyraHeroComponent::InitializePlayerInput()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinitializeplayerinput
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ULyraPawnExtensionComponent::InitializeAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentinitializeabilitysystem
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ALyraCharacter::ToggleCrouch()]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharactertogglecrouch
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ULyraInputComponent::AddInputMappings()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentaddinputmappings
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
