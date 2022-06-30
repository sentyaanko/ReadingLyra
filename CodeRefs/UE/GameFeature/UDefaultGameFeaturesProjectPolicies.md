## UDefaultGameFeaturesProjectPolicies

> This is a default implementation that immediately processes all game feature plugins the based on their BuiltInAutoRegister, 
> BuiltInAutoLoad, and BuiltInAutoActivate settings.  
>  
> It will be used if no project-specific policy is set in Project Settings .. Game Features  
> 
> ----
> これは、すべてのゲーム機能プラグインを BuiltInAutoRegister, BuiltInAutoLoad, BuiltInAutoActivate の設定に基づいて直ちに処理するデフォルトの実装です。 
> 
> Project Settings ... Game Features でプロジェクト固有のポリシーが設定されていない場合に使用されます。 


* 概要
	* GameFeature のロード時などの挙動のデフォルト実装を定義している。
* Lyra での使われ方
	* [ULyraGameFeaturePolicy] の基底クラスとして利用。
