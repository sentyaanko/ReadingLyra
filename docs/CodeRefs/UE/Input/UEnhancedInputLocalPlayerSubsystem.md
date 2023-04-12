## UEnhancedInputLocalPlayerSubsystem

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UEnhancedInputLocalPlayerSubsystem](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UEnhancedInputLocalPlayerSubsyst-/)

> Per local player input subsystem  
> 
> ----
> ローカルプレーヤー毎の入力サブシステムです。

* 概要
	* `ULocalPlayerSubsystem` の派生クラスです。
	* [IEnhancedInputSubsystemInterface] のインターフェイスの実装をしています。
	* このクラスの実装は [UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()] のみです。
	* `ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>()` によって取得可能です。
	* [UInputMappingContext] の登録の際にも利用します。

### UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()

* 概要
	* LocalPlayer から PlayerController を取得し [UEnhancedPlayerInput] にキャストして返します。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UEnhancedInputLocalPlayerSubsystem::GetPlayerInput()]: #uenhancedinputlocalplayersubsystemgetplayerinput
[IEnhancedInputSubsystemInterface]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterface
[UEnhancedPlayerInput]: ../../UE/Input/UEnhancedPlayerInput.md#uenhancedplayerinput
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
