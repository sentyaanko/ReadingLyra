## ALyraGameMode

> The base game mode class used by this project.  
> 
> ----
> このプロジェクトで使用される基本ゲームモードクラスです。

* `AModularGameModeBase` の派生クラスです。

### ALyraGameMode::InitGame()

> Initialize the game.
> The GameMode's InitGame() event is called before any other functions (including PreInitializeComponents() )
> and is used by the GameMode to initialize parameters and spawn its helper classes.
> @warning: this is called before actors' PreInitializeComponents.
> 
> ----
> ゲームを初期化する。
> GameMode の InitGame() イベントは他の関数（ PreInitializeComponents() を含む）の前に呼ばれ、 GameMode によってパラメータを初期化し、
> そのヘルパークラスを起動するために使用される。
> 警告: これはアクターのPreInitializeComponentsの前に呼び出される。

* 概要
	* マップのロード時などに呼び出される。
	* `SetTimerForNextTick()` に [ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()] を登録し、次のフレームに呼び出しています。
		* 以下のようなコメントがあるので、`SetTimerForNextTick()` を経由しているのは PIE で動作させるためらしい。
			> Eventually only do this for PIE/auto
			> 
			> ----
			> いずれはPIE/autoのみ行う。


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
>  ※以下、原文のままなので略

* 概要
	* 引用したコメントに記載された優先順位に従い、使用するエクスペリエンスを決め、ロードする。

### ALyraGameMode::GetPawnDataForController()




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ALyraGameMode::HandleMatchAssignmentIfNotExpectingOne()]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodehandlematchassignmentifnotexpectingone
