## ULyraPlayerSpawningManagerComponent

>> 詳細は未確認です。

* 概要
	* `UGameStateComponent` の派生クラスです。
	* `UTDM_PlayerSpawningManagmentComponent` の基底クラスです。
	* 派生ブループリントは以下の通りです。
		* [ULyraPlayerSpawningManagerComponent]
			* `UTDM_PlayerSpawningManagmentComponent`
				* `B_TeamSpawningRules`
	* `B_TeamSpawningRules` について
		* 以下の [ULyraExperienceDefinition] にて [UGameFeatureAction_AddComponents] により [ALyraGameState] にサーバーのみに追加しています。
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
