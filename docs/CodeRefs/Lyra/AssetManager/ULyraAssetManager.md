## ULyraAssetManager

> Game implementation of the asset manager that overrides functionality and stores game-specific types.  
> It is expected that most games will want to override AssetManager as it provides a good place for game-specific loading logic.  
> This class is used by setting 'AssetManagerClassName' in DefaultEngine.ini.  
> 
> ----
> アセットマネージャーのゲーム実装で、機能をオーバーライドし、ゲーム固有の型を保存します。 
> AssetManager はゲーム固有の読み込みロジックを格納するのに適しているため、ほとんどのゲームでオーバーライドされることが予想されます。 
> このクラスは DefaultEngine.ini で 'AssetManagerClassName' を設定することで使用されます。 

* 概要
	* `UAssetManager` の派生クラスです。
	* *Project Settings > Engine - General Settings > Default Classes > Asset Manager Class* でこのクラスを指定しています。


### ULyraAssetManager::DefaultPawnData

> Pawn data used when spawning player pawns if there isn't one set on the player state.  
> 
> ----
> 

* 概要
	* [ULyraPawnData] の既定値です。
	* `DefaultGame.ini` にて `DefaultPawnData_EmptyPawn` ([ULyraPawnData]) が指定されています。
	* 現在のエクスペリエンスに有効な [ULyraPawnData] が設定されていない場合に利用される値です。
		* すなわち GameState が所持する [ULyraExperienceManagerComponent] が所持する [ULyraExperienceDefinition::DefaultPawnData] が有効ではない場合。

### ULyraAssetManager::GetDefaultPawnData()

* 概要
	* [ULyraPawnData] を返します。
	* 値は [ULyraAssetManager::DefaultPawnData] です。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAssetManager::DefaultPawnData]: ../../Lyra/AssetManager/ULyraAssetManager.md#ulyraassetmanagerdefaultpawndata
[ULyraExperienceDefinition::DefaultPawnData]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitiondefaultpawndata
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
