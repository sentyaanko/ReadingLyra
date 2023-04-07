## ULyraFrontendStateComponent

>> 詳細は未確認です。

* 概要
	* `UGameStateComponent` の派生クラスです。
	* `ILoadingProcessInterface` のインターフェイスの実装をしています。
	* Frontend シーンにてエクスペリエンスのデータロード状況や `UCommonUserSubsystem` の初期化状況に応じて画面を遷移させる役割を担っています。
	* 派生ブループリントは以下の通りです。
		* `B_LyraFrontendStateComponent`
	* `B_LyraFrontendStateComponent` について
		* `B_LyraFrontEnd_Experience` ([ULyraExperienceDefinition]) にて [UGameFeatureAction_AddComponents] により [ALyraGameState] にクライアントのみで追加しています。

### ULyraFrontendStateComponent::PressStartScreenClass

* 概要
	* [UCommonActivatableWidget] 型です。
	* `B_LyraFrontendStateComponent` にて `W_LyraStartup` が設定されています。

### ULyraFrontendStateComponent::MainScreenClass

* 概要
	* [UCommonActivatableWidget] 型です。
	* `B_LyraFrontendStateComponent` にて `W_LyraFrontEnd` が設定されています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[ALyraGameState]: ../../Lyra/GameplayFramework/ALyraGameState.md#alyragamestate
[UCommonActivatableWidget]: ../../Plugin/CommonUI/UCommonActivatableWidget.md#ucommonactivatablewidget
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureactionaddcomponents
