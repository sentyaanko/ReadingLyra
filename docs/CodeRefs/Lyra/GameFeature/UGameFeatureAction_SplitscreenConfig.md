## UGameFeatureAction_SplitscreenConfig

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----
> 指定されたタイプのアクターにアビリティ（とアトリビュート）を付与する GameFeatureAction を担当する。 

> note: 上記はおそらく、 [UGameFeatureAction_AddAbilities] からのコピペで、適切なコメントではない。

* Split Screen を抑制します。
* Lyra での使い方
	| Asset                                                         | bDisableSplitscreen |
	| ------------------------------------------------------------- | ------------------- |
	| `B_LyraFrontEnd_Experience`<br>([ULyraExperienceDefinition])  | ✔                  |
	| `B_TopDownArenaExperience`<br>([ULyraExperienceDefinition])   | ✔                  |

>  note:  
> `UGameViewportClient::SetForceDisableSplitscreen() ` を呼び出します。  
>> Allows game code to disable splitscreen (useful when in menus)  
>> 
>> ----
>> ゲームコードで splitscreen を無効化を可能にします（メニューの時に便利）



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceDefinition]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinition
[UGameFeatureAction_AddAbilities]: ../../Lyra/GameFeature/UGameFeatureAction_AddAbilities.md#ugamefeatureaction_addabilities
