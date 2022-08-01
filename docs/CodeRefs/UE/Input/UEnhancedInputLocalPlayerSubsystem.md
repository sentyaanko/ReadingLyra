## UEnhancedInputLocalPlayerSubsystem

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UEnhancedInputLocalPlayerSubsystem](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UEnhancedInputLocalPlayerSubsyst-/)

> Per local player input subsystem  
> 
> ----
> ローカルプレーヤー毎の入力サブシステムです。

* 概要
	* [IEnhancedInputSubsystemInterface] の派生クラスです。
	* このクラスの実装は [UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()] のみです。
	* `ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>()` によって取得可能です。
	* [UInputMappingContext] の登録の際にも利用します。

### UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()

* 概要
	* LocalPlayer から PlayerController を取得し [UEnhancedPlayerInput] にキャストして返します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[IEnhancedInputSubsystemInterface]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterface
[UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()]: ../../UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystemgetplayerinput
[UEnhancedPlayerInput]: ../../UE/Input/UEnhancedPlayerInput.md#uenhancedplayerinput
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
