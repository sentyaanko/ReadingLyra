## ULyraInputComponent

> Component used to manage input mappings and bindings using an input config data asset.  
> 入力設定データアセットを使用して、入力マッピングおよびバインディングを管理するために使用されるコンポーネントです。

* [UEnhancedInputComponent] の派生クラスです。
* 仮想関数のオーバーライドなどは行っておらず、 [FLoadedMappableConfigPair] や [ULyraInputConfig] の情報を基底クラス側に設定するためのクラスです。

> note:
> ULyraInputComponent::RemoveInputConfig での AddPlayerMappableConfig の呼び出しは RemovePlayerMappableConfig の間違いのように見える。

### ULyraInputComponent::AddInputMappings()


### ULyraInputComponent::BindNativeAction()

* 概要
	* アビリティで実装されない入力のバインドを行います。
	* 具体的には移動や視点操作等がそれにあたります。

### ULyraInputComponent::BindAbilityActions()

* 概要
	* アビリティで実装されている入力のバインドを行います。
	* 具体的にはジャンプや射撃等がそれにあたります。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[FLoadedMappableConfigPair]: ../../Lyra/Input/FLoadedMappableConfigPair.md#floadedmappableconfigpair
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[UEnhancedInputComponent]: ../../UE/Input/UEnhancedInputComponent.md#uenhancedinputcomponent
