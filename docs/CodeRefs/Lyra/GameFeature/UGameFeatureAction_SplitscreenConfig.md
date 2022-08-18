## UGameFeatureAction_SplitscreenConfig

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.  
> 
> ----
> 指定されたタイプのアクターに GameplayAbility（と Attribute ）を付与する責任を持つ GameFeatureAction です。	
>> Note: UGameFeatureAction_AddAbilities のコピペなので実態に即していません。

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
