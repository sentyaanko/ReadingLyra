## UEnhancedInputLocalPlayerSubsystem

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UEnhancedInputLocalPlayerSubsystem](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UEnhancedInputLocalPlayerSubsyst-/)

> Per local player input subsystem  
> 
> ----
> ローカルプレーヤー毎の入力サブシステム

* 概要
	* [IEnhancedInputSubsystemInterface] のインターフェイスを持つ。
	* このクラスの実装は [UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()] のみ。
	* ```ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>()``` によって取得可能。
	* [UInputMappingContext] の登録の際にも利用する。

## UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()


* 概要
	* LocalPlayer から PlayerController を取得し UEnhancedPlayerInput にキャストして返す。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[IEnhancedInputSubsystemInterface]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterface
[UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()]: ../../UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystemgetplayerinput
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
