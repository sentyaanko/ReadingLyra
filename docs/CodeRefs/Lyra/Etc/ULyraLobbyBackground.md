## ULyraLobbyBackground

* 概要
	* `UPrimaryDataAsset` の派生クラスです。
	* プロジェクトに存在するアセットは以下の通りです。
		* `ShooterGameLobbyBG`
	* *Project Settings > Game - Asset Manager > Asset Manager > Primary Asset Types of Scan > Index[6]* にて指定されています。
	* `B_LoadRandomLobbyBackground` (`AActor`) にて、以下のように利用されています。
		* 存在する [ULyraLobbyBackground] アセットをランダムに選んでロードする
			* 現状では `ShooterGameLobbyBG` のみです。
		* [ULyraLobbyBackground::BackgroundLevel] で指定されているレベルをロードする
			* `ShooterGameLobbyBG` では `L_ShooterFrontendBackground` が設定されています。
		* 背景として利用する。

## ULyraLobbyBackground::BackgroundLevel

* 概要
	* `UWorld` を指定します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraLobbyBackground]: #ulyralobbybackground
[ULyraLobbyBackground::BackgroundLevel]: #ulyralobbybackgroundbackgroundlevel

