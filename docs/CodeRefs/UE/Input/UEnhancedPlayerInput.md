## UEnhancedPlayerInput

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UEnhancedPlayerInput](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UEnhancedPlayerInput/)

> UPlayerInput extensions for enhanced player input system
> 
> ----
> 拡張プレイヤー入力システムのための UPlayerInput の拡張です。

* 概要
	* `UPlayerInput` の派生クラスです。
	* EnhancedInput を使う際に使用します。
		* その場合、 *Project Settings > Engine - Input > Default Classes > Default Player Input Class* にこの派生クラスを指定します。
	* [IEnhancedInputSubsystemInterface] をフレンドクラスにしており、そちらから private メンバ等も直接変更してきます。

### UEnhancedPlayerInput::AddMapping()

> Add a player specific action mapping.  
> Returns index into EnhancedActionMappings array.
> 
> ----
> プレイヤー固有のアクションマッピングを追加します。  
> EnhancedActionMappings の配列へのインデックスを返します。  

* 概要
	* [FEnhancedActionKeyMapping] を受け取ります。
	* [UEnhancedPlayerInput::EnhancedActionMappings] に要素を追加します。
	* private 関数ですが、 [IEnhancedInputSubsystemInterface::RebuildControlMappings()] から呼び出されいます。

### UEnhancedPlayerInput::ClearAllMappings()

* 概要
	* [UEnhancedPlayerInput::EnhancedActionMappings] の全要素を削除します。
	* private 関数ですが、 [IEnhancedInputSubsystemInterface::RebuildControlMappings()] から呼び出されいます。

### UEnhancedPlayerInput::AppliedInputContexts

> Currently applied key mappings 
> Note: Source reference only. Use EnhancedActionMappings for the actual mappings (with properly instanced triggers/modifiers)
> 
> ----
> 現在適用されているキーマッピング
> 注：ソース参照のみ。実際のマッピングには EnhancedActionMappings を使用してください（適切にインスタンス化されたトリガー/モディファイア付き）。

* 概要
	* [UInputMappingContext] とプライオリティの連想配列です。
	* [IEnhancedInputSubsystemInterface::AddMappingContext()] で追加されます。
	* [IEnhancedInputSubsystemInterface::RemoveMappingContext()] で削除されます。
	* [IEnhancedInputSubsystemInterface::RebuildControlMappings()] でプライオリティが高い（数値が大きい）順に [UEnhancedPlayerInput::EnhancedActionMappings] に設定されます。

### UEnhancedPlayerInput::EnhancedActionMappings

> This player's version of the Action Mappings  
> 
> ----
> このプレイヤー版のアクションマッピング  

* 概要
	* [FEnhancedActionKeyMapping] の配列です。
	* [IEnhancedInputSubsystemInterface::RebuildControlMappings()] で [UEnhancedPlayerInput::AddMapping()] 経由で追加されます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UEnhancedPlayerInput::AddMapping()]: #uenhancedplayerinputaddmapping
[UEnhancedPlayerInput::EnhancedActionMappings]: #uenhancedplayerinputenhancedactionmappings
[FEnhancedActionKeyMapping]: ../../UE/Input/FEnhancedActionKeyMapping.md#fenhancedactionkeymapping
[IEnhancedInputSubsystemInterface]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterface
[IEnhancedInputSubsystemInterface::RebuildControlMappings()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfacerebuildcontrolmappings
[IEnhancedInputSubsystemInterface::AddMappingContext()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceaddmappingcontext
[IEnhancedInputSubsystemInterface::RemoveMappingContext()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceremovemappingcontext
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
