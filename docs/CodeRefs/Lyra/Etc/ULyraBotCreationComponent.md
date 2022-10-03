## ULyraBotCreationComponent

>> 詳細は未確認です。

* 概要
	* `UGameStateComponent` の派生クラスです。
	* 派生ブループリントは以下の通りです。
		* `B_ShooterBotSpawner`
		* `B_ShooterBotSpawner_ControlPoint`
	* `B_ShooterBotSpawner` について
		* `B_ShooterGame_Elimination` ([ULyraExperienceDefinition]) にて [UGameFeatureAction_AddComponents] によって [ALyraGameState] にサーバーのみ追加されます。
	* `B_ShooterBotSpawner_ControlPoint` について
		* `B_LyraShooterGame_ControlPoints` ([ULyraExperienceDefinition]) にて [UGameFeatureAction_AddComponents] によって [ALyraGameState] にサーバーのみ追加されます。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
