## UGameFeatureAction_SplitscreenConfig

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----
> 指定されたタイプのアクターに GameplayAbility（と Attribute ）を付与する責任を持つ GameFeatureAction です。	
>> Note: UGameFeatureAction_AddAbilities のコピペなので実態に即していません。

* 概要
	* [UGameFeatureAction_WorldActionBase] の派生クラスです。
	* Split Screen を抑制します。
	* `UGameViewportClient::SetForceDisableSplitscreen() ` を呼び出します。以下の引用は関数のコメントです。  
		>> Allows game code to disable splitscreen (useful when in menus)  
		>> 
		>> ----
		>> ゲームコードで splitscreen を無効化を可能にします（メニューの時に便利）
	* アセットの設定は以下の通りです。
		| Asset                                                         | bDisableSplitscreen |
		| ------------------------------------------------------------- | ------------------- |
		| `B_LyraFrontEnd_Experience` ([ULyraExperienceDefinition])  | ✔                  |
		| `B_TopDownArenaExperience` ([ULyraExperienceDefinition])   | ✔                  |
	* つまり、フロントエンド(ゲーム開始時のメニュー)と TopDownArena ではローカルマルチプレイ時の画面分割を無効化しています。

## UGameFeatureAction_SplitscreenConfig::bDisableSplitscreen

* 概要
	* splitscreen を無効化する場合は true を指定します。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[UGameFeatureAction_WorldActionBase]: ../../Lyra/GameFeature/UGameFeatureAction_WorldActionBase.md#ugamefeatureactionworldactionbase
