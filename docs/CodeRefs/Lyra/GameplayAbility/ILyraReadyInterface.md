## ILyraReadyInterface

* 概要
	* コンポーネントの準備状態を判定するための関数を定義した基底クラスです。
	* [ULyraPawnComponent] にてこのインターフェイスの実装をしています。
		* この機能を利用する他のクラスは [ULyraPawnComponent] を継承しています。

### ILyraReadyInterface::IsPawnComponentReadyToInitialize()

* 概要
	* このコンポーネントが動作する準備ができている場合は true を返します。
	* ネットワークを介している場合、プロパティのレプリケーションや `Possess` の順が不定のため、それを吸収するために利用されます。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraPawnComponent]: ../../Lyra/GameplayAbility/ULyraPawnComponent.md#ulyrapawncomponent
