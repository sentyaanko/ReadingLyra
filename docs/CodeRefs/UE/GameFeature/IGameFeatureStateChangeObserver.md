## IGameFeatureStateChangeObserver

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameFeatures > IGameFeatureStateChangeObserver](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameFeatures/IGameFeatureStateChangeObserver/)

> This class is meant to be overridden in your game to handle game-specific reactions to game feature plugins being mounted or unmounted  
>  
> Generally you should prefer to use UGameFeatureAction instances on your game feature data asset instead of this,  
> especially if any data is involved  
>
> If you do use these, create them in your UGameFeaturesProjectPolicies subclass and register them via  
> AddObserver / RemoveObserver on UGameFeaturesSubsystem  
> 
> ----
> このクラスは、ゲーム内でオーバーライドして、 GameFeature プラグインのマウントやアンマウントに対するゲーム固有の反応を処理するためのものです。  
> 
> 一般的には、 GameFeature データアセットの UGameFeatureAction インスタンスを、この代わりに使用することをお勧めします。  
> 
> もし、これを使う場合は、UGameFeaturesProjectPolicies のサブクラスで作成し、UGameFeaturesSubsystem の AddObserver / RemoveObserver で登録します。  

* 概要
	* [UGameFeaturesSubsystem] の基底クラスです。
	* [UGameFeaturesSubsystem::AddObserver()] でこのインターフェイスを持つ `UObject` 派生クラスを登録します。
	* そうすることで、 GameFeature のマウント等が発生した際にオブザーバの関数が呼び出されます。
	* これを利用し、プロジェクトごとの処理を実装可能にしています。
* Lyra での使われ方
	* [ULyraGameFeature_HotfixManager] / [ULyraGameFeature_AddGameplayCuePaths] の基底クラスです。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameFeature_AddGameplayCuePaths]: ../../Lyra/GameFeature/ULyraGameFeature_AddGameplayCuePaths.md#ulyragamefeatureaddgameplaycuepaths
[ULyraGameFeature_HotfixManager]: ../../Lyra/GameFeature/ULyraGameFeature_HotfixManager.md#ulyragamefeaturehotfixmanager
[UGameFeaturesSubsystem]: ../../UE/GameFeature/UGameFeaturesSubsystem.md#ugamefeaturessubsystem
[UGameFeaturesSubsystem::AddObserver()]: ../../UE/GameFeature/UGameFeaturesSubsystem.md#ugamefeaturessubsystemaddobserver
