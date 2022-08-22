## ULyraHeroComponent

> A component used to create a player controlled pawns (characters, vehicles, etc..).  
> 
> ----
> プレイヤーが制御するポーン（キャラクター、ビークルなど）を作成するために使用されるコンポーネントです。  

* 概要
	* 主な役割
		* 入力時のロジックの実装と Enhanced Input との関連付け。
		* [ULyraPawnExtensionComponent] のアビリティシステム関連の機能呼び出し。
		* アビリティによるカメラ情報の保持。
	* 追加しているポーン
		* C++ では追加していません。
		* `B_Hero_Default` （キャラクターの BP の基底クラス） で追加しています。
	* [ULyraPawnExtensionComponent] との関係
		* 参照方法
			* 自身を追加している Pawn にて `FindComponentByClass<ULyraPawnExtensionComponent>()` を呼び出すことで参照しています。
		* 用途
			* [ULyraPawnData] を使用するとき。
			* [ULyraAbilitySystemComponent] を使用するとき。
	* [ULyraPawnData] との関係
		* [ULyraPawnData::InputConfig] / [ULyraPawnData::DefaultCameraMode] を参照しています。
	* [ULyraAbilitySystemComponent] との関係
		* クラス内ではキャッシュを持ちません。
		* 初期化時（ [ULyraHeroComponent::OnPawnReadyToInitialize()] ）に [ALyraPlayerState] から取得し、 [ULyraPawnExtensionComponent] に設定します。
		* 以降、アクセス時は [ULyraPawnExtensionComponent] 経由で行います。
	* [ALyraCharacter] との関係
		* ほぼありません。
		* [ALyraCharacter::ToggleCrouch()] の機能を利用するときのみ参照しています。
			* ただ、上記の関数は `ACharacter` の機能しか利用していないので、最悪参照なしでも実装可能です。そのぐらいの関係性の低さです。
			* 利用は [ULyraHeroComponent::Input_Crouch()] にて行っています。
	* **InputTag** と [UInputAction] の関連付け
		* [UGameFeatureAction_AddInputBinding] から呼び出されます。


### ULyraHeroComponent::DefaultInputConfigs

> Input Configs that should be added to this player when initalizing the input.  
> NOTE: You should only add to this if you do not have a game feature plugin accessible to you.  
> If you do, then use the GameFeatureAction_AddInputConfig instead.  
> 
> ----
> 入力を初期化するときに、このプレーヤに追加されるべき入力コンフィグです。  
> 注：この設定は、 GameFeature プラグインにアクセスできない場合にのみ追加する必要があります。  
> もしアクセスできるならば、代わりに [UGameFeatureAction_AddInputConfig] を使用してください。  

* 概要
	* [FMappableConfigPair] の配列を保持しています。
		* この設定は [ULyraHeroComponent::InitializePlayerInput()] で読み込まれ、 [ULyraSettingsLocal] に反映されます。
			* [ULyraSettingsLocal] に反映された内容は [ULyraInputComponent::AddInputMappings()] で Enhanced Input にマッピングが追加されます。
			* 上記のコメントの通り、 Game Feature を使用しない場合のみこのプロパティを設定することが想定されています。
	* 利用しているクラス
		* `B_SimplePawn`

### ULyraHeroComponent::IsPawnComponentReadyToInitialize()

* 概要
	* 自身を所有している Pawn の Controller/PlayerState/Owner/InputComponent などの関連付け状態のチェックを行います。
	* このコンポーネントの準備というより、自身を追加している Pawn の準備の確認を行っています。

### ULyraHeroComponent::OnPawnReadyToInitialize()

* 概要
	* [ULyraPawnExtensionComponent] に登録するデリゲート用の関数です。
	* [ULyraPawnExtensionComponent::InitializeAbilitySystem()] を呼び出します。
		* 引数の [ULyraAbilitySystemComponent] は [ALyraPlayerState::GetLyraAbilitySystemComponent()] の戻り値を渡しています。
	* [ULyraHeroComponent::InitializePlayerInput()] を呼び出します。

### ULyraHeroComponent::InitializePlayerInput()

* 概要
	* 主に入力マッピングの追加と入力アクションのバインドを行います。
	* [ULyraHeroComponent::OnPawnReadyToInitialize()] から呼ばれます。


### ULyraHeroComponent::DetermineCameraMode()

* 概要
	* 状況に応じたカメラモード [ULyraCameraMode] を返します。


### ULyraHeroComponent::Input_Crouch()

* 概要
	* しゃがむ操作が行われたときに呼び出されます。
	* [ALyraCharacter::ToggleCrouch()] を呼び出します。
	* [ULyraHeroComponent::InitializePlayerInput()] にて [ULyraInputComponent::BindNativeAction()] を呼び出し、 **InputTag** `GameplayTags.InputTag_Crouch` にネイティブアクションとして登録されています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraCameraMode]: ../../Lyra/Etc/ULyraCameraMode.md#ulyracameramode
[ULyraSettingsLocal]: ../../Lyra/Etc/ULyraSettingsLocal.md#ulyrasettingslocal
[FMappableConfigPair]: ../../Lyra/GameFeature/FMappableConfigPair.md#fmappableconfigpair
[UGameFeatureAction_AddInputBinding]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputBinding.md#ugamefeatureaction_addinputbinding
[UGameFeatureAction_AddInputConfig]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputConfig.md#ugamefeatureaction_addinputconfig
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraHeroComponent::OnPawnReadyToInitialize()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentonpawnreadytoinitialize
[ULyraHeroComponent::InitializePlayerInput()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinitializeplayerinput
[ULyraHeroComponent::Input_Crouch()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinput_crouch
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ULyraPawnExtensionComponent::InitializeAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentinitializeabilitysystem
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ALyraCharacter::ToggleCrouch()]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharactertogglecrouch
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ALyraPlayerState::GetLyraAbilitySystemComponent()]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstategetlyraabilitysystemcomponent
[ULyraInputComponent::AddInputMappings()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentaddinputmappings
[ULyraInputComponent::BindNativeAction()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentbindnativeaction
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[ULyraPawnData::InputConfig]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatainputconfig
[ULyraPawnData::DefaultCameraMode]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatadefaultcameramode
[UInputAction]: ../../UE/Input/UInputAction.md#uinputaction
