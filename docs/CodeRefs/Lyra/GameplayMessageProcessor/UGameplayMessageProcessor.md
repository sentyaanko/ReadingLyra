## UGameplayMessageProcessor

> Base class for any message processor which observes other gameplay messages and potentially re-emits updates  
> (e.g., when a chain or combo is detected)  
>  
> Note that these processors are spawned on the server once (not per player)  
> and should do their own internal filtering if only relevant for some players.  
> 
> ----
> 他のゲームプレイメッセージを監視し、更新を再送信する可能性のあるメッセージプロセッサの基本クラス  
> （例：チェーンやコンボが検出されたときなど）。 
>  
> これらのプロセッサはサーバー上で一度生成され（プレイヤー毎ではありません）、
> 一部のプレイヤーにのみ関連する場合は、独自の内部フィルタリングを行うべきであることに注意してください。 

* 概要
	* [UGameplayMessageSubsystem] への登録・解除のための機能を実装した、 [UGameplayMessageSubsystem] を利用したメッセージのリッスンを行うための基底クラスです。
		* あくまで [UGameplayMessageSubsystem] の機能を利用しているだけなので、このクラスを派生することは必須ではない。
		* たとえば [ULyraAccoladeHostWidget] 等の widget は自前で [UGameplayMessageSubsystem] の機能を利用してメッセージをリッスンしている。
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet]) などから `AGameStateBase` 派生クラスに追加される。
	* この派生クラスは主に [UGameFeatureAction_AddComponents] によって追加される。




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraAccoladeHostWidget]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidget
[UGameplayMessageSubsystem]: ../../Plugin/GameplayMessageSubsystem/UGameplayMessageSubsystem.md#ugameplaymessagesubsystem
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
