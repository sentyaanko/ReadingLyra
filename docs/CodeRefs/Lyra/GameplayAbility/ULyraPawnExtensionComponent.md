## ULyraPawnExtensionComponent

> Component used to add functionality to all Pawn classes.  
> 
> ----
> すべての Pawn クラスに機能を追加するために使用されるコンポーネントです。  

* 主な役割
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

処理の流れは大まかに以下のような形。

![ULyraPawnExtensionComponent_InitializeAbilitySystem]

* このコンポーネントが追加された Pawn の初期化のチェックを行う
* Pawn に追加されたコンポーネントを走査して、 [ILyraReadyInterface] を持つものを探す。
* 見つかった対象に対し、初期化が済んでいるかのチェックを行う。
	* [ILyraReadyInterface::IsPawnComponentReadyToInitialize()] を利用する。
	* [ILyraReadyInterface::IsPawnComponentReadyToInitialize()] はここでのみ呼び出される。
* 全て初期化が済んでいたら、登録されたデリゲートを呼び出す。

* [ILyraReadyInterface::IsPawnComponentReadyToInitialize()] を利用し実装されている。
* チェックが通ったら、登録されたデリゲートを呼び出す。


### ULyraPawnExtensionComponent::PawnData
### ULyraPawnExtensionComponent::GetPawnData()
### ULyraPawnExtensionComponent::SetPawnData()

> Pawn data used to create the pawn.  Specified from a spawn function or on a placed instance.  
> 
> ----
> ポーンの作成に使用するポーンデータです。 スポーン関数や配置されたインスタンスから指定されます。  

* 主に [ULyraHeroComponent] が使用したい際に利用される。
* 指定方法
	* プレイヤーポーンがスポーンする際に指定する
		* [ULyraPawnExtensionComponent::SetPawnData()] が呼び出され、初期化される。
	* 配置されたインスタンスで直接指定する
* 外部からの利用の際は [ULyraPawnExtensionComponent::GetPawnData()] を経由する。
	* これはテンプレート関数で、テンプレート引数は戻り値の型となっている。
	* このクラスで所持するオブジェクトは [ULyraPawnData] 派生型を想定している。
	* つまり、[ULyraPawnData] 派生型を用意して、独自のキャラクターの初期化情報を追加することを想定している。
* 自クラスからの参照
	* [ULyraPawnExtensionComponent::InitializeAbilitySystem()]
		* [ULyraPawnData::TagRelationshipMapping] をタグリレーションシップマッピング情報として [ULyraAbilitySystemComponent::SetTagRelationshipMapping()] に渡す。
* 他クラスからの参照
	* [ULyraHeroComponent::InitializePlayerInput()]
		* [ULyraPawnData::InputConfig] を入力マッピングの追加と入力アクションのバインドに使用。
	* [ULyraHeroComponent::DetermineCameraMode()]
		* [ULyraPawnData::DefaultCameraMode] をデフォルトのカメラモードとして使用。

### ULyraPawnExtensionComponent::AbilitySystemComponent
### ULyraPawnExtensionComponent::GetLyraAbilitySystemComponent()

> Pointer to the ability system component that is cached for convenience.  
> 
> ----
> 利便性のためにキャッシュされたアビリティシステムコンポーネントへのポインター。  

* [ULyraAbilitySystemComponent] の初期化/終了処理を行うためにキャッシュを所持している。
* 他クラスからの参照
	* [ALyraCharacter]
	* [ULyraHeroComponent]
		* [ULyraPawnExtensionComponent::InitializeAbilitySystem()] を呼び出されることで初期化される。
		* 初期化後は、 [ULyraAbilitySystemComponent] へのアクセスはこのキャッシュを利用する。

### ULyraPawnExtensionComponent::InitializeAbilitySystem()

> Should be called by the owning pawn to become the avatar of the ability system.  
> 
> ----
> アビリティシステムのアバターになるために、所有するポーンから呼び出される必要があります。  

* [ULyraAbilitySystemComponent] の基本的な初期化に加え、 [ULyraAbilitySystemComponent::SetTagRelationshipMapping()] の呼び出しを行っている。
	* [ULyraAbilityTagRelationshipMapping] 関連はキャラクターに依らないため、このクラス経由で扱っている。

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
[ILyraReadyInterface]: ../../Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterface
[ILyraReadyInterface::IsPawnComponentReadyToInitialize()]: ../../Lyra/GameplayAbility/ILyraReadyInterface.md#ilyrareadyinterfaceispawncomponentreadytoinitialize
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraAbilitySystemComponent::SetTagRelationshipMapping()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponentsettagrelationshipmapping
[ULyraAbilityTagRelationshipMapping]: ../../Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraHeroComponent]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponent
[ULyraHeroComponent::InitializePlayerInput()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinitializeplayerinput
[ULyraHeroComponent::DetermineCameraMode()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentdeterminecameramode
[ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentcheckpawnreadytoinitialize
[ULyraPawnExtensionComponent::PawnData]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentpawndata
[ULyraPawnExtensionComponent::GetPawnData()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentgetpawndata
[ULyraPawnExtensionComponent::SetPawnData()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentsetpawndata
[ULyraPawnExtensionComponent::AbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentabilitysystemcomponent
[ULyraPawnExtensionComponent::InitializeAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentinitializeabilitysystem
[ULyraPawnExtensionComponent::UninitializeAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentuninitializeabilitysystem
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[ULyraPawnData::InputConfig]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatainputconfig
[ULyraPawnData::TagRelationshipMapping]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatatagrelationshipmapping
[ULyraPawnData::DefaultCameraMode]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndatadefaultcameramode
