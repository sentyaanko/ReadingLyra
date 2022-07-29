## UDataRegistrySubsystem

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > DataRegistry > UDataRegistrySubsystem](https://docs.unrealengine.com/5.0/en-US/API/Plugins/DataRegistry/UDataRegistrySubsystem/)

> Singleton manager that provides synchronous and asynchronous access to data registries  
> 
> ----
> データレジストリへの同期・非同期アクセスを提供するシングルトンマネージャ  

* 概要
	* データレジストリを扱うマネージャクラス。
* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]
		* データレジストリの概念について学べます。
* Lyra での使われ方
	* 称賛関連で、 `AccoladeDataRegistry` ([FLyraAccoladeDefinitionRow]) のデータ参照で利用。

### UDataRegistrySubsystem::AcquireItem()

> Start an async load of an item, delegate will be called on success or failure of acquire. Returns false if delegate could not be scheduled
> 
> ----
> アイテムの非同期ロードを開始し、デリゲートは取得の成功または失敗時に呼び出されます。デリゲートのスケジュールができなかった場合は false を返します。

* Lyra での使われ方
	* [ULyraAccoladeHostWidget::OnNotificationMessage()] にて、称賛関連のリソースロードを行う際に利用。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLyraAccoladeDefinitionRow]: ../../Lyra/GameplayMessageAccolade/FLyraAccoladeDefinitionRow.md#flyraaccoladedefinitionrow
[ULyraAccoladeHostWidget::OnNotificationMessage()]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidgetonnotificationmessage
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/
