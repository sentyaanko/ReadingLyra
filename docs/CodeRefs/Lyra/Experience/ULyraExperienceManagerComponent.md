## ULyraExperienceManagerComponent

* 概要
	* `UGameStateComponent` の派生クラスです。
	* `ILoadingProcessInterface` のインターフェイスの実装をしています。
	* [ULyraExperienceDefinition] のロード等を行うコンポーネントです。
	* [ALyraGameState] のコンストラクタにて `CreateDefaultSubobject()` を利用して追加されます。
	* [UAsyncAction_ExperienceReady] はこのクラスの機能を利用し、エクスペリエンスのロード完了を監視しています。
	* ロード完了時に呼び出すデリゲートを内部に持ちます。それぞれの利用箇所は以下の通りです。
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
	* すでにロードが完了している状態でこの関数を呼出した場合は渡されたデリゲートを直ちに呼び出します。
	* ロード完了時にデリゲートを呼び出す場合、 `HighPriority` 、無印、 `LowPriority` の順番に呼び出しを行います。

### ULyraExperienceManagerComponent::GetCurrentExperienceChecked()

> This returns the current experience if it is fully loaded, asserting otherwise (i.e., if you called it too soon)  
> 
> ----
> これは、完全にロードされている場合は現在のエクスペリエンスを返し、そうでない場合(つまり、あまりにも早く呼び出した場合)はアサートします。

* 概要
	* 現在の [ULyraExperienceDefinition] を返します。

### ULyraExperienceManagerComponent::IsExperienceLoaded()

> Returns true if the experience is fully loaded  
> 
> ----
> エクスペリエンスが完全にロードされている場合、 true を返します。  

* 概要
	* クラスの内部状態を確認し、現在のエクスペリエンスが設定されており、ロードも完了している場合 true を返します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraBotCreationComponent]: ../../Lyra/Etc/ULyraBotCreationComponent.md#ulyrabotcreationcomponent
[ULyraFrontendStateComponent]: ../../Lyra/Etc/ULyraFrontendStateComponent.md#ulyrafrontendstatecomponent
[ULyraTeamCreationComponent]: ../../Lyra/Etc/ULyraTeamCreationComponent.md#ulyrateamcreationcomponent
[UAsyncAction_ExperienceReady]: ../../Lyra/Experience/UAsyncAction_ExperienceReady.md#uasyncactionexperienceready
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_HighPriority()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregisteronexperienceloadedhighpriority
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregisteronexperienceloaded
[ULyraExperienceManagerComponent::CallOrRegister_OnExperienceLoaded_LowPriority()]: ../../Lyra/Experience/ULyraExperienceManagerComponent.md#ulyraexperiencemanagercomponentcallorregisteronexperienceloadedlowpriority
[ALyraGameMode]: ../../Lyra/GameplayFramework/ALyraGameMode.md#alyragamemode
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
