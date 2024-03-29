## ALyraGameMode

> The base game mode class used by this project.  
> 
> ----
> このプロジェクトで使用される基本ゲームモードクラスです。

* 概要
	* `AModularGameModeBase` の派生クラスです。

### ALyraGameMode::InitGame()

> Initialize the game.
> The GameMode's InitGame() event is called before any other functions (including PreInitializeComponents() )
> and is used by the GameMode to initialize parameters and spawn its helper classes.
> @warning: this is called before actors' PreInitializeComponents.
> 
> ----
> ゲームを初期化します。
> GameMode の InitGame() イベントは他の関数（ PreInitializeComponents() を含む）の前に呼ばれ、 GameMode によってパラメータを初期化し、  
> そのヘルパークラスを起動するために使用されます。  
> 警告: これはアクターの PreInitializeComponents の前に呼び出されます。

* 概要
	* マップのロード時などに呼び出されます。
	* `SetTimerForNextTick()` に [ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()] を登録し、次のフレームに呼び出しています。
		* 以下のようなコメントがあるので、`SetTimerForNextTick()` を経由しているのは PIE で動作させるためのようです。
			> Eventually only do this for PIE/auto
			> 
			> ----
			> いずれは PIE / auto のみ行う。


### ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()

> Precedence order (highest wins)
>  - Matchmaking assignment (if present)
>  - URL Options override
>  - Developer Settings (PIE only)
>  - Command Line override
>  - World Settings
>  - Default experience
> 
> ----
> 優先順位
>  ※訳は省略

* 概要
	* 引用したコメントに記載された優先順位に従い、使用するエクスペリエンスを決め、ロードをします。

### ALyraGameMode::GetPawnDataForController()

* 概要
	* [ULyraPawnData] を取得します。
	* 概ね以下のような処理を行います。
		* 渡された `AController` から [ALyraPlayerState] 経由で取得できる場合はそれを返します。
		* 取得できない場合は GameState から [ULyraExperienceManagerComponent] 経由で取得できる場合はそれを返します。
		* 取得できない場合は [ULyraAssetManager::GetDefaultPawnData()] 経由で取得できる場合はそれを返します。
		* 取得できない場合は有効な値が返せない状態なので、 null を返します。

### ALyraGameMode::RequestPlayerRestartNextFrame()

> Restart (respawn) the specified player or bot next frame  
> - If bForceReset is true, the controller will be reset this frame (abandoning the currently possessed pawn, if any)  
> 
> ----
> 指定されたプレイヤーまたはボットを次のフレームで再起動（リスポーン）させます。
> - bForceReset が true の場合、コントローラはこのフレームでリセットされます（現在所持しているポーンがある場合はそれを放棄します）。

* 概要
	* `GA_AutoRespawn` ([ULyraGameplayAbility]) から呼び出されます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]: #alyragamemodehandlematchassignmentifnotexpectingone
[ULyraAssetManager::GetDefaultPawnData()]: ../../Lyra/AssetManager/ULyraAssetManager.md#ulyraassetmanagergetdefaultpawndata
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
