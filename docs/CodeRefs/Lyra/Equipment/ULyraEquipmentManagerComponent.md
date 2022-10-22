## ULyraEquipmentManagerComponent

> Manages equipment applied to a pawn  
> 
> ----
> ポーンに適用された装備を管理します。  

* 概要
	* `UPawnComponent` の派生クラスです。
	* `UCLASS` にて `Const` が指定されています。
	* `ShooterCore` ([UGameFeatureData]) にて [UGameFeatureAction_AddComponents] により [ALyraCharacter] にサーバー/クライアントで追加しています。

### ULyraEquipmentManagerComponent::EquipmentList

* 概要
	* 装備しているアイテムのリストです。
	* 装備中のものだけが設定されます。
		* 例えば武器を切り替えるときは元の装備を解除した後に新しい武器を登録します。
		* これらは [ULyraQuickBarComponent] で行われています。
	* レプリケート対象です。
	* [FLyraEquipmentList] です。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLyraEquipmentList]: ../../Lyra/Equipment/FLyraInventoryList.md#flyraequipmentlist
[ULyraQuickBarComponent]: ../../Lyra/Etc/ULyraQuickBarComponent.md#ulyraquickbarcomponent
[ALyraCharacter]: ../../Lyra/GameplayFramework/ALyraCharacter.md#alyracharacter
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureaction_addcomponents
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
