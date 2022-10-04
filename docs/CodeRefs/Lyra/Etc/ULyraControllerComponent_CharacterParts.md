## ULyraControllerComponent_CharacterParts

> A component that configure what cosmetic actors to spawn for the owning controller when it possesses a pawn  
> 
> ----
> ポーンを所持しているときに、どのコスメティックアクターを生成するかを設定するコンポーネントです。  

* 概要
	* `UControllerComponent` の派生クラスです。
	* 派生ブループリントは以下の通りです。
		* `B_PickRandomCharacter`
	* `B_PickRandomCharacter` について
		* 以下の [ULyraExperienceDefinition] 派生ブループリントにて、 [UGameFeatureAction_AddComponents] により `AController` へサーバーのみ追加されます。
			* `B_LyraShooterGame_ControlPoints`
			* `B_ShooterGame_Elimination`
			* `B_TestInventoryExperience`
			* `B_TopDownArenaExperience`



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
