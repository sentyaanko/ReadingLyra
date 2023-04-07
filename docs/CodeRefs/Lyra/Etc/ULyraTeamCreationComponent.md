## ULyraTeamCreationComponent

* 概要
	* `UGameStateComponent` の派生クラスです。
	* エクスペリエンスによりこのコンポーネントが有効になった際、以下を行います。
		* [ULyraTeamCreationComponent::TeamsToCreate] の設定に従いチームに関するアクターをスポーンさせます。
		* 現在存在する [ALyraPlayerState] をチームに所属させます。
		* プレイヤーログインの際のデリゲートにチームに所属する関数を登録し、新しくログインしてきたプレイヤーがチームに所属するようにします。
	* 派生ブループリントは以下のとおりです。
		* `B_TeamSetup_FourTeams`
		* `B_TeamSetup_TwoTeams`
	* `B_TeamSetup_FourTeams` について
		* `B_TopDownArenaExperience` ([ULyraExperienceDefinition]) にて [UGameFeatureAction_AddComponents] により [ALyraGameState] にサーバーのみで追加しています。
	* `B_TeamSetup_TwoTeams` について
		* 以下の [ULyraExperienceDefinition] にて [UGameFeatureAction_AddComponents] により [ALyraGameState] にサーバーのみで追加しています。
		* `B_LyraShooterGame_ControlPoints`
		* `B_ShooterGame_Elimination`
		* `B_TestInventoryExperience`

### ULyraTeamCreationComponent::TeamsToCreate

> List of teams to create (id to display asset mapping, the display asset can be left unset if desired)  
> 
> ----
> 作成するチームのリスト（id と表示アセットの対応付け、表示アセットは必要に応じて未設定のままでも可）

* 概要
	* チームの番号を示す `uint8` をキーに、チームの表示情報 `ULyraTeamDisplayAsset` (`UDataAsset`) を値とする連想配列です。
	* `B_TeamSetup_FourTeams` について
		* 4 チーム分が登録してあります。
	* `B_TeamSetup_TwoTeams` について
		* 2 チーム分が登録してあります。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraTeamCreationComponent::TeamsToCreate]: ../../Lyra/Etc/ULyraTeamCreationComponent.md#ulyrateamcreationcomponentteamstocreate
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[ALyraPlayerState]: ../../Lyra/GameplayFramework/ALyraPlayerState.md#alyraplayerstate
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureactionaddcomponents
