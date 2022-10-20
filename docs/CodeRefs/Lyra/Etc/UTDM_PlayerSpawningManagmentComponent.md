## UTDM_PlayerSpawningManagmentComponent

>> 詳細は未確認です。

* 概要
	* [ULyraPlayerSpawningManagerComponent] の派生クラスです。
	* 相手チームのプレイヤーから遠いスポーン地点を探す実装をしているクラスです。
	* 派生ブループリントは以下のとおりです。
		* `B_TeamSpawningRules`
	* `B_TeamSpawningRules` について
		* 以下の [ULyraExperienceDefinition] にて [UGameFeatureAction_AddComponents] により [ALyraGameState] にサーバーのみで追加しています。
			* `B_ShooterGame_Elimination`
			* `B_LyraShooterGame_ControlPoints`
			* `B_TestInventoryExperience`


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraPlayerSpawningManagerComponent]: ../../Lyra/Etc/ULyraPlayerSpawningManagerComponent.md#ulyraplayerspawningmanagercomponent
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
