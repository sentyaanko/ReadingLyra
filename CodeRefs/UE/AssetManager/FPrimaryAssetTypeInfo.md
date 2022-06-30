## FPrimaryAssetTypeInfo

> Structure with publicly exposed information about an asset type. These can be loaded out of a config file.  
> 
> ----
> アセットタイプに関する一般に公開された情報を持つ構造体。これらは設定ファイルから読み込むことができます。  

* 概要
	* AssetManager が使用する設定情報。
* Lyra での使われ方
	* `Project Settings > Game - Asset Manager`
		* プロジェクト設定が可能。以下が設定されている。
			| Primary Asset Type                 | Asset Base Class                      | 備考                                                            |
			|------------------------------------|---------------------------------------|-----------------------------------------------------------------|
			| Map                                | `UWorld`                              |                                                                 |
			| LyraGameData                       | [ULyraGameData]                       | `DefaultGameData` のみが該当する。                              |
			| PrimaryAssetLabel                  | `UPrimaryAssetLabel`                  |                                                                 |
			| GameFeatureData                    | [UGameFeatureData]                    |                                                                 |
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |                                                                 |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] | `L_DefaultEditorOverview` のポータルとしても利用。              |
			| LyraLobbyBackground                | [ULyraLobbyBackground]                | `ShooterGameLobbyBG` 飲みが該当する。ロビーの背景用レベル情報。 |
			| LyraExperienceActionSet            | [ULyraExperienceActionSet]            |                                                                 |
	* [UGameFeatureData::PrimaryAssetTypesToScan]
		* GameFeature の設定も可能。
		* `ShooterCore` ([UGameFeatureData]) では以下が設定されている。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
			| LyraExperienceActionSet            | [ULyraExperienceActionSet]            |
			| Map                                | `UWorld`                              |
			| PlayerMappableInputConfig          | [UPlayerMappableInputConfig]          |
		* `ShooterMaps` ([UGameFeatureData]) では以下が設定されている。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| Map                                | `UWorld`                              |
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| LyraLobbyBackground                | [ULyraLobbyBackground]                |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
		* `TopDownArena` ([UGameFeatureData]) では以下が設定されている。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| Map                                | `UWorld`                              |
			| PlayerMappableInputConfig          | [UPlayerMappableInputConfig]          |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
		* それぞれの GameFeature のパスを設定している。

