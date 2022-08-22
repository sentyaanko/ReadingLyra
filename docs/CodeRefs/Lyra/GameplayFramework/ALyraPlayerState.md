## ALyraPlayerState

> Base player state class used by this project.  
> 
> ----
> このプロジェクトで使用されるベースプレイヤーステートクラスです。  

* 概要
	* [ULyraPawnData] との関係
		* レプリケーション対象のプロパティとしてキャッシュを保持する。
		* [ULyraPawnData::AbilitySets] を元にアビリティの付与を行う。
	* [ULyraPawnExtensionComponent] との関係
		* [ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()] を呼び出す。
* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ フレームワークのクイック リファレンス] より
		> PlayerState は、人プレイヤーやプレイヤーをシミュレートしているボットなどの、ゲームの参加者のステートです。  
		> ゲームの一部として存在する非プレイヤーの AI は PlayerState を持ちません。  
		* ShooterGame での敵は上記における「プレイヤーをシミュレートしているボット」扱いです。
		* 要は [ALyraPlayerState] があります。

### ALyraPlayerState::StatTags

* 概要
	* ASC ではなく、このクラスが保持する GameplayTag です。
	* プレイヤーに紐づく任意の情報を保持します。
	* スコア関連で利用しています。例えば以下があります。
		* `ShooterGame.Score.Eliminations`
		* `ShooterGame.Score.Assists`
		* `ShooterGame.Score.Deaths`
		* `ShooterGame.Score.ControlPointCapture`
	* サーバー側で更新し、クライアントにレプリケーションされます。
	* 現状ではイベントドリブンでの実装になっておらず、タイマーで表示に反映させています。
		* 詳しくは **W_SB_PlayerState** の実装を参照してください。

### ALyraPlayerState::OnExperienceLoaded()

* 概要
	* [ULyraExperienceManagerComponent] に登録しているデリゲート用の関数です。
	* エクスペリエンスのロードが完了した際に呼び出されます。
	* [ALyraGameMode::GetPawnDataForController()] で [ULyraPawnData] を取得し、 [ALyraPlayerState::SetPawnData()] に渡しています。

### ALyraPlayerState::SetPawnData()

* 概要
	* 渡された [ULyraPawnData] をキャッシュとして保持します。
	* [ULyraPawnData::AbilitySets] を元に [ULyraAbilitySet::GiveToAbilitySystem()] を呼び出し、アビリティの付与を行います。


### ALyraPlayerState::ClientBroadcastMessage()

> Send a message to just this player  
> (use only for client notifications like accolades, quest toasts, etc... that can handle being occasionally lost)  
> 
> ----
> このプレイヤーにだけメッセージを送ります。  
> (賞賛、クエストトーストなど、時々失われても大丈夫なクライアント通知のみに使用します)  

* 概要
	* 以下で呼び出されています。
		* `B_AccoladeRelay` ([UGameplayMessageProcessor])
	* この呼び出しは `HasAuthority` により、サーバーのみで呼び出す様にしています。


### ALyraPlayerState::GetLyraAbilitySystemComponent()

* 概要
	* この Pawn に追加している [ULyraAbilitySystemComponent] を返します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraAbilitySet::GiveToAbilitySystem()]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilitysetgivetoabilitysystem
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
[ULyraPawnExtensionComponent::CheckPawnReadyToInitialize()]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponentcheckpawnreadytoinitialize
[ALyraGameMode::GetPawnDataForController()]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemodegetpawndataforcontroller
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[ALyraPlayerState::SetPawnData()]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstatesetpawndata
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
[ULyraPawnData::AbilitySets]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndataabilitysets
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > ゲームプレイ フレームワークのクイック リファレンス]: https://docs.unrealengine.com/5.0/ja/unreal-engine-gameplay-framework-quick-reference/
