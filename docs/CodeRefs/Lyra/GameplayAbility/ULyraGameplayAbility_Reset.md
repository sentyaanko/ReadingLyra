## ULyraGameplayAbility_Reset

> Gameplay ability used for handling quickly resetting the player back to initial spawn state.  
> Ability is activated automatically via the "GameplayEvent.RequestReset" ability trigger tag (server only).  
> 
> ----
> プレイヤーを初期スポーン状態に素早くリセットする処理に使用されるゲームプレイアビリティです。  
> アビリティは、 "GameplayEvent.RequestReset" アビリティトリガー タグによって自動的に起動されます (サーバーのみ)。  

* 概要
	* Gameplay Event `GameplayEvent.RequestReset`  が発生したときにアクティブ化するアビリティです。
		* この Gameplay Event は `B_ShooterGameScoring_Base` (`UGameStateComponent`) の関数 `ResetAllActivePlayers` で発生します。
		* ソースコメントの「サーバーのみ」の処理はイベント `BeginPlay` にて `SwitchHasAuthority` で分岐することで行っています。
	* `AbilitySet_ShooterHero` ([ULyraAbilitySet]) にて設定されています。
		* 上記は `HeroData_ShooterGame` ([ULyraPawnData]) にて設定されています。
		* つまりは `ControlPoint` / `Elimination` でプレイヤーが操作する Pawn に付与されます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
