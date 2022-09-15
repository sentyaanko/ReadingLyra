## ULyraEquipmentManagerComponent

> Manages equipment applied to a pawn  
> 
> ----
> ポーンに適用された装備を管理します。  

* 概要
	* `UPawnComponent` の派生クラスです。
	* [UGameFeatureAction_AddComponents] を通じてコンポーネントを追加しています。
		* 設定箇所： `ShooterCore` ([UGameFeatureData])
		* 対象： [ALyraCharacter]
		* クライアント： ✔
		* サーバー： ✔

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
