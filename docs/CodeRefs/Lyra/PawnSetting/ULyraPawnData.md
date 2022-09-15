## ULyraPawnData

> Non-mutable data asset that contains properties used to define a pawn.  
> 
> ----
> ポーンを定義するために使用されるプロパティを含む、変更不可のデータアセットです。  

* 概要
	* プレイヤー用ポーンの設定を作成するためのデータアセットです。
	* 利用するポーンクラス/[ULyraAbilityTagRelationshipMapping]/[ULyraInputConfig]/ULyraCameraMode 等を設定できます。
	* 所有者・キャッシュに関して
		* 所有者
			* [ALyraGameState] です。
			* エクスペリエンスのロード時に [ALyraGameState] に追加された [ULyraExperienceManagerComponent] のメンバ [ULyraExperienceDefinition] に設定されます。
		* キャッシュ
			* エクスペリエンスのロード後、 [ALyraPlayerState] に渡し、キャッシュをもたせます。
			* ポーンのスポーン時に [ALyraGameMode] にて [ULyraPawnExtensionComponent] に渡し、キャッシュをもたせます。
	* アセットの用途は以下の通りです。
		| アセット名                  | 用途                                                                                                                                                                  |
		|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
		| `DefaultPawnData_EmptyPawn` | DefaultGame.ini で指定されている、 [ULyraAssetManager::DefaultPawnData] の初期値。 [ULyraExperienceDefinition::DefaultPawnData] が設定されていない場合に利用される。  |
		| `HeroData_Arena`            | `B_TopDownArenaExperience` で指定されている。 Exploader で使用される。                                                                                                |
		| `HeroData_ShooterGame`      | `B_ShooterGame_Elimination` / `B_LyraShooterGame_ControlPoints` / `B_TestInventoryExperience`  で指定されている。 Elimination/Control 等で使用される。                |
		| `ShootingTarget_PawnData`   | 参照されていない。テスト用データと思われる。　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　                                      |
		| `SimplePawnData`            | `B_LyraDefaultExperience` で指定されている。 デフォルトで使用される。                                                                                                 |

処理の流れは大まかに以下のようになっている。

![ULyraPawnData_Lifetime]


### ULyraPawnData::PawnClass

> Class to instantiate for this pawn (should usually derive from ALyraPawn or ALyraCharacter).  
> 
> ----
> このポーンのためにインスタンス化するクラス (通常 ALyraPawn または ALyraCharacter から派生する必要があります)。  

* 概要
	* `APawn` を指定します。
	* アセットの設定は以下の通りです。
		| アセット名                  | PawnClass                 |
		|-----------------------------|---------------------------|
		| `DefaultPawnData_EmptyPawn` | None                      |
		| `HeroData_Arena`            | `B_HeroArena`             |
		| `HeroData_ShooterGame`      | `B_Hero_ShooterMannequin` |
		| `ShootingTarget_PawnData`   | `B_ShootingTarget`        |
		| `SimplePawnData`            | `B_SimpleHeroPawn`        |

### ULyraPawnData::InputConfig

> Input configuration used by player controlled pawns to create input mappings and bind input actions.  
> 
> ----
> プレイヤーが操作するポーンが、入力マッピングを作成し、入力アクションをバインドするために使用する入力設定です。  

* 概要
	* [ULyraInputConfig] を指定します。
	* アセットの設定は以下の通りです。
		| アセット名                  | InputConfig             |
		|-----------------------------|-------------------------|
		| `DefaultPawnData_EmptyPawn` | None                    |
		| `HeroData_Arena`            | `InputData_Arena`       |
		| `HeroData_ShooterGame`      | `InputData_Hero`        |
		| `ShootingTarget_PawnData`   | None                    |
		| `SimplePawnData`            | `InputData_SimplePawn`  |

### ULyraPawnData::TagRelationshipMapping

> What mapping of ability tags to use for actions taking by this pawn  
> 
> ----
> このポーンが行うアクションに使用するアビリティタグのマッピングを指定します。  

* 概要
	* [ULyraAbilityTagRelationshipMapping] を指定します。
	* アセットの設定は以下の通りです。
		| アセット名                  | TagRelationshipMapping         |
		|-----------------------------|--------------------------------|
		| `DefaultPawnData_EmptyPawn` | None                           |
		| `HeroData_Arena`            | None                           |
		| `HeroData_ShooterGame`      | `TagRelationships_ShooterHero` |
		| `ShootingTarget_PawnData`   | None                           |
		| `SimplePawnData`            | None                           |

### ULyraPawnData::DefaultCameraMode

> Default camera mode used by player controlled pawns.  
> 
> ----
> プレイヤーが操作するポーンが使用するデフォルトのカメラモードです。  

* 概要
	* [ULyraCameraMode] を指定します。
	* アセットの設定は以下の通りです。
		| アセット名                  | DefaultCameraMode       |
		|-----------------------------|-------------------------|
		| `DefaultPawnData_EmptyPawn` | None                    |
		| `HeroData_Arena`            | `CM_ArenaFramingCamera` |
		| `HeroData_ShooterGame`      | `CM_ThirdPerson`        |
		| `ShootingTarget_PawnData`   | None                    |
		| `SimplePawnData`            | `CM_ThirdPerson`        |

### ULyraPawnData::AbilitySets

> Ability sets to grant to this pawn's ability system.  
> 
> ----
> このポーンのアビリティシステムに付与するアビリティセット。

* 概要
	* [ULyraAbilitySet] の配列です。
	* アセットの設定は以下の通りです。
		| アセット名                  | AbilitySets                 |
		|-----------------------------|-----------------------------|
		| `DefaultPawnData_EmptyPawn` | None                        |
		| `HeroData_Arena`            | `AbilitySet_Arena`          |
		| `HeroData_ShooterGame`      | `AbilitySet_ShooterHero`    |
		| `ShootingTarget_PawnData`   | `ShootingTarget_AbilitySet` |
		| `SimplePawnData`            | None                        |



----
<!--- 自前の画像へのリンク --->
[ULyraPawnData_Lifetime]: ../../../images/ULyraPawnData_Lifetime.png


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAssetManager::DefaultPawnData]: ../../Lyra/AssetManager/ULyraAssetManager.md#ulyraassetmanagerdefaultpawndata
[ULyraCameraMode]: ../../Lyra/Etc/ULyraCameraMode.md#ulyracameramode
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceDefinition::DefaultPawnData]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitiondefaultpawndata
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraAbilityTagRelationshipMapping]: ../../Lyra/GameplayAbility/ULyraAbilityTagRelationshipMapping.md#ulyraabilitytagrelationshipmapping
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ALyraGameMode]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
