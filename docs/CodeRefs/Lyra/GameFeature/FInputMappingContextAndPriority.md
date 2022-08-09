## FInputMappingContextAndPriority

* 概要
	* [UInputMappingContext] とプライオリティを示す構造体です。
	* [UGameFeatureAction_AddInputContextMapping::InputMappings] で利用されています。
	* 使用しているアセットは以下の通りです。
		| Asset                                                         | InputMapping<br>([UInputMappingContext]) | Priority |
		| ------------------------------------------------------------- | ---------------------------------------- | ---------|
		| `LAS_InventoryTest`<br>([ULyraExperienceActionSet])           | `IMC_InventoryTest`                      | 1        |
		| `LAS_ShooterGame_SharedInput`<br>([ULyraExperienceActionSet]) | `IMC_ShooterGame_KBM`                    | 1        |

## FInputMappingContextAndPriority::InputMapping

* 概要
	* 入力マッピングコンテキスト [UInputMappingContext] を指定します。

## FInputMappingContextAndPriority::Priority

> Higher priority input mappings will be prioritized over mappings with a lower priority.  
> 
> ----
> 優先順位の高い入力マッピングは、優先順位の低いマッピングより優先される。  

* 概要
	* 優先度を示す整数値で、大きいほど優先されます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[UGameFeatureAction_AddInputContextMapping::InputMappings]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureaction_addinputcontextmappinginputmappings
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
