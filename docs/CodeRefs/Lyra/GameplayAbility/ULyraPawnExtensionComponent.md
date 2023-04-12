## ULyraPawnExtensionComponent

> Component used to add functionality to all Pawn classes.  
> 
> ----
> すべての Pawn クラスに機能を追加するために使用されるコンポーネントです。  

* 概要
	* [ULyraPawnComponent] の派生クラスです。
	* 概ね以下のような機能を担当しています。
		* Pawn に追加された全てのコンポーネントの準備ができているかのチェック。
			* [ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]
		* Pawn 用の [ULyraAbilitySystemComponent] の Initialize / Uninitialize の処理。
			* [ULyraPawnExtensionComponent::InitializeAbilitySystem()] / [ULyraPawnExtensionComponent::UninitializeAbilitySystem()]
		* なお、この 2 つの機能はこのクラスだけでは連動していない。
			* 準備のチェックから直接アビリティシステムの初期化は呼び出されない。（デリゲート経由で外部から呼ばれる。）
			* 要は、機能を明確にするのを目的にコンポーネントを分けようと思えば分けられる。
	* その他の役割
		* [ULyraPawnData] のキャッシュの保持。
			* [ULyraPawnExtensionComponent::PawnData]
		* [ULyraAbilitySystemComponent] のキャッシュの保持。
			* [ULyraPawnExtensionComponent::AbilitySystemComponent]
	* 利用しているクラス
		* [ALyraCharacter] に追加されている。

### ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()

> Call this anytime the pawn needs to check if it's ready to be initialized (pawn data assigned, possessed, etc..).  
> 
> ----
> ポーンが初期化（ポーンデータの割り当て、所持など）の準備ができたかどうかを確認する必要があるときはいつでもこれを呼び出します。  

* 概要
	* このコンポーネントが追加された Pawn の初期化のチェックを行います。
		1. Pawn に追加されたコンポーネントを走査して、 [ILyraReadyInterface] を持つものを探します。
		1. 見つかった対象に対し、初期化が済んでいるかのチェックを行う。
			* [ILyraReadyInterface::IsPawnComponentReadyToInitialize()] を利用する。
			* [ILyraReadyInterface::IsPawnComponentReadyToInitialize()] はここでのみ呼び出される。
		1. 全て初期化が済んでいたら、登録されたデリゲートを呼び出す。
	* 処理の流れは大まかに以下のような形となります。
		![ULyraPawnExtensionComponent_InitializeAbilitySystem]


### ULyraPawnExtensionComponent::PawnData
### ULyraPawnExtensionComponent::GetPawnData()
### ULyraPawnExtensionComponent::SetPawnData()

> Pawn data used to create the pawn.  Specified from a spawn function or on a placed instance.  
> 
> ----
> ポーンの作成に使用するポーンデータです。 スポーン関数や配置されたインスタンスから指定されます。  

* 概要
	* 主に [ULyraHeroComponent] が [ULyraPawnData] を使用したい際に利用しています。
	* データの設定方法は以下の 2 通りで行っています。
		* プレイヤーポーンがスポーンする際に指定する。
			* [ULyraPawnExtensionComponent::SetPawnData()] が呼び出され、初期化される。
		* 配置されたインスタンスで直接指定する。
	* 外部からの利用の際は [ULyraPawnExtensionComponent::GetPawnData()] を経由します。
		* これはテンプレート関数で、テンプレート引数は戻り値の型となっています。
		* このクラスで所持するオブジェクトは [ULyraPawnData] 派生型を想定しています。
		* つまり、[ULyraPawnData] 派生型を用意して、独自のキャラクターの初期化情報を追加することを想定しています。
	* 自クラスからの利用箇所について
		* [ULyraPawnExtensionComponent::InitializeAbilitySystem()]
			* [ULyraPawnData::TagRelationshipMapping] をタグリレーションシップマッピング情報として [ULyraAbilitySystemComponent::SetTagRelationshipMapping()] に渡しています。
	* 他クラスからの利用箇所について
		* [ULyraHeroComponent::InitializePlayerInput()]
			* [ULyraPawnData::InputConfig] を入力マッピングの追加と入力アクションのバインドに使用しています。
		* [ULyraHeroComponent::DetermineCameraMode()]
			* [ULyraPawnData::DefaultCameraMode] をデフォルトのカメラモードとして使用しています。

### ULyraPawnExtensionComponent::AbilitySystemComponent
### ULyraPawnExtensionComponent::GetLyraAbilitySystemComponent()

> Pointer to the ability system component that is cached for convenience.  
> 
> ----
> 利便性のためにキャッシュされたアビリティシステムコンポーネントへのポインター。  

* 概要
	* [ULyraAbilitySystemComponent] の初期化/終了処理を行うために [ULyraAbilitySystemComponent] のキャッシュを所持しています。
	* 他クラスからの利用
		* [ALyraCharacter]
		* [ULyraHeroComponent]
			* [ULyraPawnExtensionComponent::InitializeAbilitySystem()] を呼び出されることで初期化されます。
			* 初期化後は、 [ULyraAbilitySystemComponent] へのアクセスはこのキャッシュを利用しています。

### ULyraPawnExtensionComponent::InitializeAbilitySystem()

> Should be called by the owning pawn to become the avatar of the ability system.  
> 
> ----
> アビリティシステムのアバターになるために、所有するポーンから呼び出される必要があります。  

* 概要
	* [ULyraAbilitySystemComponent] の基本的な初期化に加え、 [ULyraAbilitySystemComponent::SetTagRelationshipMapping()] の呼び出しを行っています。
		* [ULyraAbilityTagRelationshipMapping] 関連はキャラクターに依らないため、このクラス経由で扱っています。

### ULyraPawnExtensionComponent::UninitializeAbilitySystem()

> Should be called by the owning pawn when the pawn's controller changes.  
> 
> ----
> ポーンのコントローラーが変わった時に、所有するポーンから呼び出される必要があります。  


----
<!--- 自前の画像へのリンク --->
[ULyraPawnExtensionComponent_InitializeAbilitySystem]: ../../../images/ULyraPawnExtensionComponent_InitializeAbilitySystem.png


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]: #ulyrapawnextensioncomponentcheckpawnreadytoinitialize
[ULyraPawnExtensionComponent::PawnData]: #ulyrapawnextensioncomponentpawndata
[ULyraPawnExtensionComponent::GetPawnData()]: #ulyrapawnextensioncomponentgetpawndata
[ULyraPawnExtensionComponent::SetPawnData()]: #ulyrapawnextensioncomponentsetpawndata
[ULyraPawnExtensionComponent::AbilitySystemComponent]: #ulyrapawnextensioncomponentabilitysystemcomponent
[ULyraPawnExtensionComponent::InitializeAbilitySystem()]: #ulyrapawnextensioncomponentinitializeabilitysystem
[ULyraPawnExtensionComponent::UninitializeAbilitySystem()]: #ulyrapawnextensioncomponentuninitializeabilitysystem
[ILyraReadyInterface]: ../../Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterface
[ILyraReadyInterface::IsPawnComponentReadyToInitialize()]: ../../Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterfaceispawncomponentreadytoinitialize
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraAbilitySystemComponent::SetTagRelationshipMapping()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentsettagrelationshipmapping
[ULyraAbilityTagRelationshipMapping]: ../../Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraHeroComponent]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponent
[ULyraHeroComponent::InitializePlayerInput()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinitializeplayerinput
[ULyraHeroComponent::DetermineCameraMode()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentdeterminecameramode
[ULyraPawnComponent]: ../../Lyra/GameplayAbility/ULyraPawnComponent.md#ulyrapawncomponent
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[ULyraPawnData::InputConfig]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatainputconfig
[ULyraPawnData::TagRelationshipMapping]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatatagrelationshipmapping
[ULyraPawnData::DefaultCameraMode]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatadefaultcameramode
