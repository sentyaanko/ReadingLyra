## UDataRegistrySubsystem

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > DataRegistry > UDataRegistrySubsystem](https://docs.unrealengine.com/5.0/en-US/API/Plugins/DataRegistry/UDataRegistrySubsystem/)

> Singleton manager that provides synchronous and asynchronous access to data registries  
> 
> ----
> データレジストリへの同期・非同期アクセスを提供するシングルトンマネージャです。  

* 概要
	* `UEngineSubsystem` の派生クラスです。
	* データレジストリを扱うマネージャクラスです。
* 既存のドキュメント
	* [Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]
		* データレジストリの概念について学べます。
* Lyra での使われ方
	* 称賛関連で、 `AccoladeDataRegistry` ([UDataRegistry] / [FLyraAccoladeDefinitionRow]) に設定しているデータを参照する際に利用しています。

### UDataRegistrySubsystem::AcquireItem()

> Start an async load of an item, delegate will be called on success or failure of acquire.  
> Returns false if delegate could not be scheduled
> 
> ----
> アイテムの非同期ロードを開始し、デリゲートは取得の成功または失敗時に呼び出されます。  
> デリゲートのスケジュールができなかった場合は false を返します。  

* Lyra での使われ方
	* [ULyraAccoladeHostWidget::OnNotificationMessage()] にて、称賛関連のリソースロードを行う際に利用しています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLyraAccoladeDefinitionRow]: ../../Lyra/GameplayMessageAccolade/FLyraAccoladeDefinitionRow.md#flyraaccoladedefinitionrow
[ULyraAccoladeHostWidget::OnNotificationMessage()]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidgetonnotificationmessage
[UDataRegistry]: ../../UE/DataRegistry/UDataRegistry.md#udataregistry
[Unreal Engine 5.0 Documentation > インタラクティブな体験をつくりだす > データ駆動型のゲームプレイエレメント > データ レジストリ]: https://docs.unrealengine.com/5.0/ja/data-registries-in-unreal-engine/
