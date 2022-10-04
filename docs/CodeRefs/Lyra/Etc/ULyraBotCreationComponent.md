## ULyraBotCreationComponent

>> 詳細は未確認です。

* 概要
	* `UGameStateComponent` の派生クラスです。
	* bot のスポーン処理を行うコンポーネントです。
	* 派生ブループリントは以下の通りです。
		* `B_ShooterBotSpawner`
		* `B_ShooterBotSpawner_ControlPoint`
	* `B_ShooterBotSpawner` について
		* `B_ShooterGame_Elimination` ([ULyraExperienceDefinition]) にて [UGameFeatureAction_AddComponents] によって [ALyraGameState] にサーバーのみ追加されます。
	* `B_ShooterBotSpawner_ControlPoint` について
		* `B_LyraShooterGame_ControlPoints` ([ULyraExperienceDefinition]) にて [UGameFeatureAction_AddComponents] によって [ALyraGameState] にサーバーのみ追加されます。

### ULyraBotCreationComponent::BotControllerClass

* 概要
	* スポーンした bot を制御する `AAIController` を指定します。
	* ブループリントで設定されている値は以下の通りです。
		| [ULyraBotCreationComponent]          | [ULyraBotCreationComponent::BotControllerClass]                          |
		| ------------------------------------ | ------------------------------------------------------------------------ |
		| `B_ShooterBotSpawner`                | `B_AI_Controller_LyraShooter` ([ALyraPlayerBotController])               |
		| `B_ShooterBotSpawner_ControlPoint`   | `B_AI_Controller_LyraShooter_ControlPoint` ([ALyraPlayerBotController])  |


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ALyraPlayerBotController]: ../../Lyra/Etc/ALyraPlayerBotController.md#alyraplayerbotcontroller
[ULyraBotCreationComponent]: ../../Lyra/Etc/ULyraBotCreationComponent.md#ulyrabotcreationcomponent
[ULyraBotCreationComponent::BotControllerClass]: ../../Lyra/Etc/ULyraBotCreationComponent.md#ulyrabotcreationcomponentbotcontrollerclass
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
