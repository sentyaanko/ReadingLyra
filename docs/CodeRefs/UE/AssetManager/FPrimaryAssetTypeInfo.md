## FPrimaryAssetTypeInfo

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Runtime > Engine > Engine > FPrimaryAssetTypeInfo](https://docs.unrealengine.com/5.0/en-US/API/Runtime/Engine/Engine/FPrimaryAssetTypeInfo/)

> Structure with publicly exposed information about an asset type.  
> These can be loaded out of a config file.  
> 
> ----
> アセットタイプに関する一般に公開された情報を持つ構造体。  
> これらは設定ファイルから読み込むことができます。  

* 概要
	* AssetManager が使用する設定情報です。
* Lyra での使われ方
	* *Project Settings > Game - Asset Manager*
		* プロジェクト設定は以下の通りです。
			| Primary Asset Type                 | Asset Base Class                      | 備考                                                            |
			|------------------------------------|---------------------------------------|-----------------------------------------------------------------|
			| Map                                | `UWorld`                              |                                                                 |
			| LyraGameData                       | [ULyraGameData]                       | `DefaultGameData` のみが該当。                                  |
			| PrimaryAssetLabel                  | `UPrimaryAssetLabel`                  |                                                                 |
			| GameFeatureData                    | [UGameFeatureData]                    |                                                                 |
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |                                                                 |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] | `L_DefaultEditorOverview` のポータルとしても利用。              |
			| LyraLobbyBackground                | [ULyraLobbyBackground]                | `ShooterGameLobbyBG` 飲みが該当する。ロビーの背景用レベル情報。 |
			| LyraExperienceActionSet            | [ULyraExperienceActionSet]            |                                                                 |
	* [UGameFeatureData::PrimaryAssetTypesToScan]
		* GameFeature での設定も可能です。
		* `ShooterCore` ([UGameFeatureData]) では設定は以下の通りです。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
			| LyraExperienceActionSet            | [ULyraExperienceActionSet]            |
			| Map                                | `UWorld`                              |
			| PlayerMappableInputConfig          | [UPlayerMappableInputConfig]          |
		* `ShooterMaps` ([UGameFeatureData]) では設定は以下の通りです。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| Map                                | `UWorld`                              |
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| LyraLobbyBackground                | [ULyraLobbyBackground]                |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
		* `TopDownArena` ([UGameFeatureData]) では設定は以下の通りです。
			| Primary Asset Type                 | Asset Base Class                      |
			|------------------------------------|---------------------------------------|
			| LyraExperienceDefinition           | [ULyraExperienceDefinition]           |
			| Map                                | `UWorld`                              |
			| PlayerMappableInputConfig          | [UPlayerMappableInputConfig]          |
			| LyraUserFacingExperienceDefinition | [ULyraUserFacingExperienceDefinition] |
		* それぞれの GameFeature のパスを設定しています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameData]: ../../Lyra/Etc/ULyraGameData.md#ulyragamedata
[ULyraLobbyBackground]: ../../Lyra/Etc/ULyraLobbyBackground.md#ulyralobbybackground
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraUserFacingExperienceDefinition]: ../../Lyra/Experience/ULyraUserFacingExperienceDefinition.md#ulyrauserfacingexperiencedefinition
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UGameFeatureData::PrimaryAssetTypesToScan]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedataprimaryassettypestoscan
[UPlayerMappableInputConfig]: ../../UE/Input/UPlayerMappableInputConfig.md#uplayermappableinputconfig
