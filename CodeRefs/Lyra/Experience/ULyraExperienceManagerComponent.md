## ULyraExperienceManagerComponent

* 概要
	* [ULyraExperienceDefinition] のロード等を行うコンポーネント。
	* [ALyraGameState] に追加されている。
	* [UAsyncAction_ExperienceReady] はこのクラスの機能を利用し、エクスペリエンスのロード完了を監視する。
	* ロード完了時に呼び出すデリゲートを内部に持つ。それぞれの利用箇所は以下の通り。
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
	* ロード完了時に呼び出すデリゲートを登録する関数。
	* すでにロードが完了している場合は渡されたデリゲートを直ちに呼びだす。
	* 登録された場合、 `HighPriority` 、無印、 `LowPriority` の順番に呼び出される。


