## ALyraGameState

> The base game state class used by this project.
> 
> ----
> このプロジェクトで使用される基本ゲームステートクラスです。

* 概要
	* `AModularGameStateBase` の派生クラスです。
	* `IAbilitySystemInterface` のインターフェイスの実装をしています。
	* [ULyraAbilitySystemComponent] を追加しています。
	* [ULyraExperienceManagerComponent] を追加しています。
* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ALyraGameState]
		* このクラスが持つ Game Phase アビリティに関する記述があります。  
		> 高レベルのゲーム フェーズ ロジックが「C:\Lyra\Source\LyraGame\LyraGameState.h」ファイルにある Lyra Game State (ALyraGameState) によりサーバー側で管理されます。  
		> Game State はクライアントとサーバーの両方に存在し、Ability System Component を使用して、アビリティとして実装された Game Phase (ゲーム フェーズ) を持ちます。  
		> これらの Game Phase をアクティブ/非アクティブ化にすることで、ゲームプレイ イベントの処理に影響を及ぼします。  
		> たとえば、ShooterCore には 3 つのフェーズが実装されています。  

### ALyraGameState::MulticastMessageToClients()

> Send a message that all clients will (probably) get  
> (use only for client notifications like eliminations, server join messages, etc... that can handle being lost)  
> 
> ----
> すべてのクライアントが（おそらく）受け取ることになるメッセージを送ります。  
> (削除、サーバ参加メッセージなど、紛失しても大丈夫なクライアントからの通知にのみ使用します)  

* 概要
	* 以下で呼び出されています。
		* `Phase_Warmup`
			* `Net Execution Policy` が `Server Initiated` 、 `Replication Policy` が `Do Not Replicate` の、 `GameState` に付与されるアビリティです。
			* サーバーのみで動作し、ゲーム開始時のカウントダウンをクライアント側に通知するためにこの関数を使用しています。
	* [ALyraGameState::MulticastMessageToClients_Implementation()] を呼び出します。


### ALyraGameState::MulticastReliableMessageToClients()

> Send a message that all clients will be guaranteed to get  
> (use only for client notifications that cannot handle being lost)  
> 
> ----
> すべてのクライアントが確実に受け取ることができるメッセージを送信します。  
> (紛失に耐えられないクライアントへの通知のみに使用)  

* 概要
	* 以下で呼び出されています。
		* `GA_Auto_Respawn`
		* `B_EliminationFeedRelay`
		* どちらも事前に `HasAuthority` ノードを利用し、サーバーのみで呼び出す様に実装しています。
	* [ALyraGameState::MulticastMessageToClients_Implementation()] を呼び出します。

### ALyraGameState::MulticastMessageToClients_Implementation()

* 概要
	* `GetNetMode() == NM_Client` の環境で [UGameplayMessageSubsystem::BroadcastMessage()] を呼び出します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ALyraGameState::MulticastMessageToClients_Implementation()]: #alyragamestatemulticastmessagetoclientsimplementation
[ULyraExperienceManagerComponent]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponent
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[UGameplayMessageSubsystem::BroadcastMessage()]: ../../Plugin/GameplayMessageSubsystem/UGameplayMessageSubsystem.md#ugameplaymessagesubsystembroadcastmessage
[Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > ALyraGameState]: https://docs.unrealengine.com/5.0/ja/abilities-in-lyra-in-unreal-engine/#alyragamestate
