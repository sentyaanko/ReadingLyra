## ALyraPlayerState

> Base player state class used by this project.  
> 
> ----
> このプロジェクトで使用されるベースプレイヤーステートクラスです。  

[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ フレームワークのクイック リファレンス] より

> PlayerState は、人プレイヤーやプレイヤーをシミュレートしているボットなどの、ゲームの参加者のステートです。  
> ゲームの一部として存在する非プレイヤーの AI は PlayerState を持ちません。  

ShooterGame での敵は上記における「プレイヤーをシミュレートしているボット」扱いです。  
要は [ALyraPlayerState] があります。


----
このへん

----


* [ULyraPawnData] との関係
	* レプリケーション対象のプロパティとしてキャッシュを保持する。
	* [ULyraPawnData::AbilitySets] を元にアビリティの付与を行う。
* [ULyraPawnExtensionComponent] との関係
	* [ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()] を呼び出す。

### ALyraPlayerState::StatTags

* ASC ではなく、このクラスが保持する GameplayTag 。
* プレイヤーに紐づく任意の情報を保持する。
* スコア関連で利用しています。例えば以下。
	* `ShooterGame.Score.Eliminations`
	* `ShooterGame.Score.Assists`
	* `ShooterGame.Score.Deaths`
	* `ShooterGame.Score.ControlPointCapture`
* サーバー側で更新し、クライアントにレプリケーションされる。
* 現状ではイベントドリブンでの実装になっておらず、タイマーで表示に反映させている。
	* 詳しくは **W_SB_PlayerState** の実装を参照してください。

### ALyraPlayerState::OnExperienceLoaded()

* [ULyraExperienceManagerComponent] に登録しているデリゲート用の関数です。
* エクスペリエンスのロードが完了した際に呼び出される。
* [ALyraGameMode::GetPawnDataForController()] で [ULyraPawnData] を取得し、 [ALyraPlayerState::SetPawnData()] に渡す。

### ALyraPlayerState::SetPawnData()

* 渡された [ULyraPawnData] をキャッシュとして保持する。
* [ULyraPawnData::AbilitySets] を元に [ULyraAbilitySet::GiveToAbilitySystem()] を呼び出し、アビリティの付与を行う。


### ALyraPlayerState::ClientBroadcastMessage()

> Send a message to just this player  
> (use only for client notifications like accolades, quest toasts, etc... that can handle being occasionally lost)  
> 
> ----
> このプレイヤーにだけメッセージを送る  
> (賞賛、クエストトーストなど、時々失われても大丈夫なクライアント通知のみに使用する)  

* 以下で呼び出されている。
	* `B_AccoladeRelay` ([UGameplayMessageProcessor])
* この呼び出しは `HasAuthority` により、サーバーのみで呼び出す様にしている。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraAbilitySet::GiveToAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilitysetgivetoabilitysystem
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentcheckpawnreadytoinitialize
[ALyraGameMode::GetPawnDataForController()]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodegetpawndataforcontroller
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ALyraPlayerState::SetPawnData()]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstatesetpawndata
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[ULyraPawnData::AbilitySets]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndataabilitysets
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ フレームワークのクイック リファレンス]: https://docs.unrealengine.com/5.0/ja/unreal-engine-gameplay-framework-quick-reference/
