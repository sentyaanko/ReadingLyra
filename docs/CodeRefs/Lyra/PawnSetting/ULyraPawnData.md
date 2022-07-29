## ULyraPawnData

> Non-mutable data asset that contains properties used to define a pawn.  
> 
> ----
> ポーンを定義するために使用されるプロパティを含む、変更不可のデータアセットです。  

* 所有者 は [ALyraGameState]
	* エクスペリエンスのロード時に [ALyraGameState] に追加された [ULyraExperienceManagerComponent] のメンバ [ULyraExperienceDefinition] に設定される。
* キャッシュ
	* エクスペリエンスのロード後、 [ALyraPlayerState] に渡し、キャッシュをもたせる。
	* ポーンのスポーン時に [ALyraGameMode] にて [ULyraPawnExtensionComponent] に渡し、キャッシュをもたせる。
* プレイヤー用ポーンの設定を定義するデータアセット。
* `AbilitySets` に [ULyraAbilitySet] の配列を保持する。
	* ポーンにデフォルトのアビリティを付与したい場合はここの設定を利用する。
* `InputConfig` に [ULyraInputConfig] を保持する。
	* ポーンにデフォルトの [UInputAction] と `InputTag` の設定を追加したい場合はここの設定を利用する。
* プレイヤー用ポーンの設定が記述されているデータアセットです。
* 利用するポーンクラス/[ULyraAbilityTagRelationshipMapping]/[ULyraInputConfig]/ULyraCameraMode 等を設定できます。

| アセット名                         | 用途                                                          |
|------------------------------------|---------------------------------------------------------------|
| DefaultPawnData_EmptyPawn          | DefaultGame.ini で指定されている、 ULyraAssetManager::DefaultPawnData の初期値。 [ULyraExperienceDefinition]`::DefaultPawnData` が設定されていない場合に利用される。 |
| HeroData_Arena                     | B_TopDownArenaExperience で指定されている。 Exploader で使用される。 |
| HeroData_ShooterGame               | B_ShooterGame_Elimination/B_LyraShooterGame_ControlPoints/B_TestInventoryExperience  で指定されている。 Elimination/Control 等で使用される。 |
| ShootingTarget_PawnData            | 参照されていない。テスト用データと思われる。　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 |
| SimplePawnData                     | B_LyraDefaultExperience で指定されている。 デフォルトで使用される。 |


処理の流れは大まかに以下のようになっている。

![ULyraPawnData_Lifetime]


### ULyraPawnData::PawnClass

> Class to instantiate for this pawn (should usually derive from ALyraPawn or ALyraCharacter).
> 
> ----


### ULyraPawnData::InputConfig

> Input configuration used by player controlled pawns to create input mappings and bind input actions.
> 
> ----


### ULyraPawnData::TagRelationshipMapping

> What mapping of ability tags to use for actions taking by this pawn
> 
> ----


### ULyraPawnData::DefaultCameraMode

> Default camera mode used by player controlled pawns.
> 
> ----


### ULyraPawnData::AbilitySets

> Ability sets to grant to this pawn's ability system.
> 
> ----

----
<!--- 自前の画像へのリンク --->
[ULyraPawnData_Lifetime]: ../../../images/ULyraPawnData_Lifetime.png


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraAbilityTagRelationshipMapping]: ../../Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ALyraGameMode]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[UInputAction]: ../../UE/Input/UInputAction.md#uinputaction
