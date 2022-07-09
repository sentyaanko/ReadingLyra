## ULyraPawnComponent

> An actor component that can be used for adding custom behavior to pawns.  
> 
> ----
> ポーンにカスタム動作を追加するために使用することができるアクターコンポーネントです。  


* [ILyraReadyInterface] のインターフェイスを持つ以外は何も実装されていない。
* Pawn に所有させるコンポーネントの基底クラス。
	* Lyra の全てのポーン用コンポーネント基底クラスと使用しているわけではない。
	* 例えば以下は `UPawnComponent` から派生している。
		* [ULyraPawnComponent_CharacterParts]
		* [ULyraEquipmentManagerComponent]


