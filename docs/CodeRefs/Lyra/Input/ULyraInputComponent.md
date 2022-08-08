## ULyraInputComponent

> Component used to manage input mappings and bindings using an input config data asset.  
> 
> ----
> 入力設定データアセットを使用して、入力マッピングおよびバインディングを管理するために使用されるコンポーネントです。  

* 概要
	* [UEnhancedInputComponent] の派生クラスです。
	* 仮想関数のオーバーライドなどは行っていません。
	* [FLoadedMappableConfigPair] や [ULyraInputConfig] の情報を元に基底クラス側の関数を呼び出す関数が実装されています。
	* 主に [ULyraHeroComponent] から各種関数が呼び出されます。
	* [ULyraInputComboComponent] からの呼び出しもありますが、現在 [ULyraInputComboComponent] は使われていないようです。

> note:
> ULyraInputComponent::RemoveInputConfig() での AddPlayerMappableConfig の呼び出しは RemovePlayerMappableConfig の間違いのように見受けられます。

### ULyraInputComponent::AddInputMappings()

* 概要
	* 入力マッピングコンテキストを追加します。
	* [IEnhancedInputSubsystemInterface::AddPlayerMappableConfig()] を呼び出します。

### ULyraInputComponent::RemoveInputMappings()

* 概要
	* 入力マッピングコンテキストを削除します。
	* [IEnhancedInputSubsystemInterface::RemovePlayerMappableConfig()] を呼び出します。

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
[ULyraHeroComponent]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponent
[FLoadedMappableConfigPair]: ../../Lyra/Input/FLoadedMappableConfigPair.md#floadedmappableconfigpair
[ULyraInputComboComponent]: ../../Lyra/Input/ULyraInputComboComponent.md#ulyrainputcombocomponent
[ULyraInputConfig]: ../../Lyra/Input/ULyraInputConfig.md#ulyrainputconfig
[IEnhancedInputSubsystemInterface::AddPlayerMappableConfig()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceaddplayermappableconfig
[IEnhancedInputSubsystemInterface::RemovePlayerMappableConfig()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceremoveplayermappableconfig
[UEnhancedInputComponent]: ../../UE/Input/UEnhancedInputComponent.md#uenhancedinputcomponent
