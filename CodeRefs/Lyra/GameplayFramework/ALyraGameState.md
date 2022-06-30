## ALyraGameState

* TODO: ソースを見て追記事項があれば。
* TODO: 特に以下。
	> Ability System Component をアビリティとして実装された Game Phase (ゲーム フェーズ) とともに使用します。  
	> これらの Game Phase はアクティブ/非アクティブ化され、ゲームプレイ イベントを処理する方法に影響を及ぼします。  
	> たとえば、ShooterCore は次のフェーズを実装します。  
* [ULyraAbilitySystemComponent] を追加しています。
* GameState であり、 ASC を追加しています。
* また、その ASC は

### ALyraGameState::MulticastMessageToClients()

> Send a message that all clients will (probably) get  
> (use only for client notifications like eliminations, server join messages, etc... that can handle being lost)  
> 
> ----
> すべてのクライアントが（おそらく）受け取ることになるメッセージを送る  
> (削除、サーバ参加メッセージなど、紛失しても大丈夫なクライアントからの通知にのみ使用します)  

* 以下で呼び出されている。
	* `Phase_Warmup`
* この呼び出しは `Phase_Warmup` が `GameState` に付与されるアビリティのため、サーバーのみで動作するため、


### ALyraGameState::MulticastReliableMessageToClients()

> Send a message that all clients will be guaranteed to get  
> (use only for client notifications that cannot handle being lost)  
> 
> ----
> すべてのクライアントが確実に受け取ることができるメッセージを送信する  
> (紛失に耐えられないクライアントへの通知のみに使用)  

* 以下で呼び出されている。
	* `GA_Auto_Respawn`
	* `B_EliminationFeedRelay`
* どちらの呼び出しも `HasAuthority` により、サーバーのみで呼び出す様にしている。



