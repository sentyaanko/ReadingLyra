## ULyraAccoladeHostWidget

* 称賛情報を表示するための widget 。
* [UGameplayMessageSubsystem] を利用し、称賛情報を含んだメッセージ ([FLyraNotificationMessage]) の受信を待つ。
* 受信をしたら、関連付けられたデータをロードし、称賛の通知するアイコンの表示やサウンドの再生等をする。
	* データのロードは [UDataRegistrySubsystem] を利用する。
		* その際、 `RegistryType` に `Accolades` を、`ItemName` に [FLyraNotificationMessage::PayloadTag] を指定します。
			* [FLyraNotificationMessage::PayloadTag] には `Lyra.ShooterGame.*` が設定されている。
			* これは `B_AccoladeRelay` ([UGameplayMessageProcessor]) で指定されている。
		* ロードされるのは [FLyraAccoladeDefinitionRow] である。
			* `DT_BasicShooterAccolades` / `AccoladeDataRegistry` ([FLyraAccoladeDefinitionRow]) で定義している。
			* ここで定義している RowName は [FLyraNotificationMessage::PayloadTag] と同じにしている。
			* そうすることで、 [UGameplayMessageSubsystem] で受信した名前をそのまま [UDataRegistrySubsystem] で利用しています。
	* [UDataRegistrySubsystem] への登録方法
		* `ShooterCore` ([UGameFeatureData]) の設定経由で行っている。
		* [UGameFeatureData::Actions] で [UGameFeatureAction_DataRegistry] のパラメータに `AccoladeDataRegistry` を設定している。
		* そうすることで、フィーチャーの適用時に `AccoladeDataRegistry` が [UDataRegistrySubsystem] に登録される。
* データレジストリに関しては以下を参照してください。
	[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]


### ULyraAccoladeHostWidget::OnNotificationMessage()



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameplayMessageSubsystem]: ../../Lyra/GameplayMessage/UGameplayMessageSubsystem.md#ugameplaymessagesubsystem
[FLyraAccoladeDefinitionRow]: ../../Lyra/GameplayMessageAccolade/FLyraAccoladeDefinitionRow.md#flyraaccoladedefinitionrow
[UGameplayMessageProcessor]: ../../Lyra/GameplayMessageProcessor/UGameplayMessageProcessor.md#ugameplaymessageprocessor
[FLyraNotificationMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md#flyranotificationmessage
[FLyraNotificationMessage::PayloadTag]: ../../Lyra/GameplayMessageProcessorStruct/FLyraNotificationMessage.md#flyranotificationmessagepayloadtag
[UDataRegistrySubsystem]: ../../UE/DataRegistry/UDataRegistrySubsystem.md#udataregistrysubsystem
[UGameFeatureAction_DataRegistry]: ../../UE/GameFeature/UGameFeatureAction_DataRegistry.md#ugamefeatureaction_dataregistry
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
[UGameFeatureData::Actions]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedataactions
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/
