## ILyraReadyInterface

* コンポーネントの準備状態を判定するための関数を定義したインターフェイス。
* Lyra での使われ方
	* [ULyraPawnComponent] のみが継承している。
	* この機能を利用する他のクラスは [ULyraPawnComponent] を継承している。

### ILyraReadyInterface::IsPawnComponentReadyToInitialize()

* このコンポーネントが動作する準備ができている場合は true を返す。
* ネットワークを介している場合、プロパティのレプリケーションや `Possess` の順が不定のため、それを吸収するために利用される。




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraPawnComponent]: ../../Lyra/GameplayAbility/ULyraPawnComponent.md#ulyrapawncomponent
