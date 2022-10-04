## ALyraPlayerController

> The base player controller class used by this project.  
> 
> ----
> このプロジェクトで使用される基本プレイヤーコントローラークラスです。

* 概要
	* `ACommonPlayerController` の派生クラスです。
	* `ILyraCameraAssistInterface` のインターフェイスの実装をしています。
	* `ILyraTeamAgentInterface` のインターフェイスの実装をしています。
		* 基底クラスが保持する PlayerState が変更された際に自身が所属するチームの変更を知らせるのに使用しています。
	* `ShooterCore` ([UGameFeatureData]) を有効化する際に [UGameFeatureAction_AddComponents] を使用し [ULyraIndicatorManagerComponent] を追加しています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraIndicatorManagerComponent]: ../../Lyra/Etc/ULyraIndicatorManagerComponent.md#ulyraindicatormanagercomponent
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
