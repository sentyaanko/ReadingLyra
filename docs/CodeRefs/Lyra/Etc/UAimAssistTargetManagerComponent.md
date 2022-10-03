## UAimAssistTargetManagerComponent

>> 詳細は未確認です。

> The Aim Assist Target Manager Component is used to gather all aim assist targets that are within a given player's view.  
> Targets must implement the IAimAssistTargetInterface and be on the collision channel that is set in the ShooterCoreRuntimeSettings.  
> 
> ----
> Aim Assist Target Manager Component は、指定されたプレイヤーのビュー内にあるすべての照準アシストターゲットを収集するために使用されます。
> ターゲットは、IAimAssistTargetInterface を実装し、ShooterCoreRuntimeSettings で設定されたコリジョンチャンネル上にある必要があります。  

* 概要
	* `UGameStateComponent` の派生クラスです。
	* 派生ブループリントに `B_AimAssistTargetManager` があります。
	* `B_AimAssistTargetManager` について
		* `ShooterCore` ([UGameFeatureData]) にて [UGameFeatureAction_AddComponents] によって [ALyraGameState] にクライアントのみに追加されます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
