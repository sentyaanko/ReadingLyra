## AGameplayCueNotify_BurstLatent

>> 詳細は未確認です。

> This is an instanced gameplay cue notify for effects that are one-offs.  
> Since it is instanced, it can do latent things like time lines or delays.  
> 
> ----
> 一回限りのエフェクトを通知する、インスタンス型のゲームプレイキューです。 
> インスタンス化されているため、時間軸やディレイなどの latent な処理を行うことができます。 

* 概要
	* `AGameplayCueNotify_Actor` の派生クラスです。
	* 派生ブループリントは以下の通りです。
		* `GCN_Character_Heal`
		* `GCN_Test_BurstLatent`
		* `GCN_Character_DamageTaken`
		* `GCN_Dash`
		* `GCN_Death`
		* `GCN_Launcher_Activate`
		* `GCN_Teleporter_Activate`
	* `GCNL_Character_DamageTaken` について
		* [UGameplayMessageSubsystem::BroadcastMessage()] を利用して `B_MusicManagerComponent_Base` (`UActorComponent`) に `Lyra.Damage.Taken.Message` を送る処理を実装しています。
		* [ULyraNumberPopComponent::AddNumberPop()] を呼び出し、ダメージ値の表示を行っています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraNumberPopComponent::AddNumberPop()]: ../../Lyra/Etc/ULyraNumberPopComponent.md#ulyranumberpopcomponentaddnumberpop
[UGameplayMessageSubsystem::BroadcastMessage()]: ../../Plugin/GameplayMessageSubsystem/UGameplayMessageSubsystem.md#ugameplaymessagesubsystembroadcastmessage
