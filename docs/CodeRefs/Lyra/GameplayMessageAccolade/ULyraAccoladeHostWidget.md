## ULyraAccoladeHostWidget

* 概要
	* 称賛情報を表示するための widget です。
	* 処理の流れは概ね以下のようになります。
		* [UGameplayMessageSubsystem] を利用し、称賛情報を含んだ Gameplay Message ([FLyraNotificationMessage]) の受信を待ちます。
		* 受信したら、関連付けられたデータをロードし、称賛の通知するアイコンの表示やサウンドの再生等を行います。
	* データのロードは [UDataRegistrySubsystem::AcquireItem()] を利用しています。
		* `RegistryType` に `Accolades` を、`ItemName` に [FLyraNotificationMessage::PayloadTag] を設定します。
			* [FLyraNotificationMessage::PayloadTag] には `Lyra.ShooterGame.*` が設定されています。
			* このタグは `B_AccoladeRelay` ([UGameplayMessageProcessor]) で `Listen for Gameplay Messages` ノードに設定されています。
		* ロードされるのは [FLyraAccoladeDefinitionRow] です。
			* `DT_BasicShooterAccolades` / `AccoladeDataRegistry` ([UDataRegistry] / [FLyraAccoladeDefinitionRow]) で設定しています。
			* RowName は [FLyraNotificationMessage::PayloadTag] と同じタグを設定しています。
			* そうすることで、 [UGameplayMessageSubsystem] で受信した名前をそのまま [UDataRegistrySubsystem] で利用しています。
	* [UDataRegistrySubsystem] への登録方法
		* `ShooterCore` ([UGameFeatureData]) 経由で行っています。
		* [UGameFeatureData::Actions] で [UGameFeatureAction_DataRegistry] のパラメータに `AccoladeDataRegistry` ([UDataRegistry] / [FLyraAccoladeDefinitionRow]) を設定しています。
		* これにより、フィーチャーの適用時に `AccoladeDataRegistry` ([UDataRegistry] / [FLyraAccoladeDefinitionRow]) が [UDataRegistrySubsystem] に登録されます。
* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]

### ULyraAccoladeHostWidget::OnNotificationMessage()

* 概要
	* Gameplay Message `Lyra.AddNotification.Message` のリスナー用の関数です。
	* [UGameplayMessageSubsystem::RegisterListener()] に登録しています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLyraAccoladeDefinitionRow]: ../../Lyra/GameplayMessageAccolade/FLyraAccoladeDefinitionRow.md#flyraaccoladedefinitionrow
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
[FLyraNotificationMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md#flyranotificationmessage
[FLyraNotificationMessage::PayloadTag]: ../../Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md#flyranotificationmessagepayloadtag
[UGameplayMessageSubsystem]: ../../Plugin/GameplayMessageSubsystem/UGameplayMessageSubsystem.md#ugameplaymessagesubsystem
[UGameplayMessageSubsystem::RegisterListener()]: ../../Plugin/GameplayMessageSubsystem/UGameplayMessageSubsystem.md#ugameplaymessagesubsystemregisterlistener
[UDataRegistry]: ../../UE/DataRegistry/UDataRegistry.md#udataregistry
[UDataRegistrySubsystem]: ../../UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystem
[UDataRegistrySubsystem::AcquireItem()]: ../../UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystemacquireitem
[UGameFeatureAction_DataRegistry]: ../../UE/GameFeature/UGameFeatureAction_DataRegistry.md#ugamefeatureaction_dataregistry
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UGameFeatureData::Actions]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedataactions
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/
