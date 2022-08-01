## ULyraExperienceManagerComponent

* 概要
	* [ULyraExperienceDefinition] のロード等を行うコンポーネント。
	* [ALyraGameState] に追加されている。
	* [UAsyncAction_ExperienceReady] はこのクラスの機能を利用し、エクスペリエンスのロード完了を監視する。
	* ロード完了時に呼び出すデリゲートを内部に持つ。それぞれの利用箇所は以下の通りです。
		* [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()]
			* [ULyraTeamCreationComponent]
			* [ULyraFrontendStateComponent]
		* [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()]
			* [UAsyncAction_ExperienceReady]
			* [ALyraGameMode]
			* [ALyraPlayerState]
		* [ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()]
			* [ULyraBotCreationComponent]


### ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()
### ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()
### ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()

* 概要
	* ロード完了時に呼び出すデリゲートを登録する関数です。
	* すでにロードが完了している場合は渡されたデリゲートを直ちに呼びだす。
	* 登録された場合、 `HighPriority` 、無印、 `LowPriority` の順番に呼び出される。




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraBotCreationComponent]: ../../Lyra/Etc/ULyraBotCreationComponent.md#ulyrabotcreationcomponent
[ULyraFrontendStateComponent]: ../../Lyra/Etc/ULyraFrontendStateComponent.md#ulyrafrontendstatecomponent
[ULyraTeamCreationComponent]: ../../Lyra/Etc/ULyraTeamCreationComponent.md#ulyrateamcreationcomponent
[UAsyncAction_ExperienceReady]: ../../Lyra/Experience/UAsyncAction_ExperienceReady.md#uasyncaction_experienceready
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_highpriority
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregister_onexperienceloaded_lowpriority
[ALyraGameMode]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
