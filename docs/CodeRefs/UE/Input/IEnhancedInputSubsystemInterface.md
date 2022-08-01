## IEnhancedInputSubsystemInterface

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > IEnhancedInputSubsystemInterface](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/IEnhancedInputSubsystemInterface/)

> Includes native functionality shared between all subsystems  
> 
> ----
> 全サブシステムで共有されるネイティブ機能が含まれます。

* 概要
	* EnhancedInput を利用するためのサブシステムのための実装クラスです。
	* [UEnhancedInputLocalPlayerSubsystem] の基底クラスです。

### IEnhancedInputSubsystemInterface::GetPlayerInput()

* 概要
	* [UEnhancedPlayerInput] を取得するための純粋仮想関数です。

### IEnhancedInputSubsystemInterface::InjectInputForAction()
### IEnhancedInputSubsystemInterface::InjectInputVectorForAction()

> Input simulation via injection.  
> Runs modifiers and triggers delegates as if the input had come through the underlying input system as FKeys.  
> Applies action modifiers and triggers on top.  
> 
> @param Action			The Input Action to set inject input for  
> @param RawValue		The value to set the action to  
> @param Modifiers		The modifiers to apply to the injected input.  
> @param Triggers		The triggers to apply to the injected input.  
> 
> ----
> インジェクションによる入力シミュレーションです。  
> あたかも入力が FKey として基礎となる入力システムを通ってきたかのように、モディファイアとトリガーのデリゲートを実行します。  
> アクションモディファイアとトリガーを上位に適用します。  
> 
> @param Action			インジェクション入力に設定する入力アクション。  
> @param RawValue		アクションを設定する値。  
> @param Modifiers		インジェクションされた入力に適用されるモディファイア。  
> @param Triggers		インジェクションされた入力に適用するトリガー。  

* 概要
	* キー入力があったかのように入力アクションを発生させる関数です。
* Lyra での使われ方
	* `W_QuickBarSlot` ([ULyraTaggedWidget]) で、ボタンをクリックされた際などに利用しています。


### IEnhancedInputSubsystemInterface::RebuildControlMappings()

> Reapply all control mappings to players pending a rebuild
> 
> ----
> リビルド待ちのプレーヤーにすべてのコントロールマッピングを再適用します。

* 概要
	* コントロールマッピングが変更された際等に内部で呼び出される関数です。
	* 例えば、以下の [UInputMappingContext] の追加/削除の関数から呼び出されます。
		* [IEnhancedInputSubsystemInterface::AddMappingContext()]
		* [IEnhancedInputSubsystemInterface::RemoveMappingContext()]

### IEnhancedInputSubsystemInterface::AddMappingContext()

> Add a control mapping context.
> 
> ----
> コントロールマッピングコンテキストを追加します。

* Lyra での使われ方
	* [UGameFeatureAction_AddInputContextMapping] にて  [UInputMappingContext] の追加の際に呼び出しています。

### IEnhancedInputSubsystemInterface::RemoveMappingContext()

> Remove a specific control context. 
> 
> ----
> 特定のコントロールコンテキストを削除する。

* Lyra での使われ方
	* [UGameFeatureAction_AddInputContextMapping] にて  [UInputMappingContext] の削除の際に呼び出しています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameFeatureAction_AddInputContextMapping]: ../../Lyra/GameFeature/UGameFeatureAction_AddInputContextMapping.md#ugamefeatureaction_addinputcontextmapping
[ULyraTaggedWidget]: ../../Lyra/Widget/ULyraTaggedWidget.md#ulyrataggedwidget
[IEnhancedInputSubsystemInterface::AddMappingContext()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceaddmappingcontext
[IEnhancedInputSubsystemInterface::RemoveMappingContext()]: ../../UE/Input/IEnhancedInputSubsystemInterface.md#ienhancedinputsubsysteminterfaceremovemappingcontext
[UEnhancedInputLocalPlayerSubsystem]: ../../UE/Input/UEnhancedInputLocalPlayerSubsystem.md#uenhancedinputlocalplayersubsystem
[UEnhancedPlayerInput]: ../../UE/Input/UEnhancedPlayerInput.md#uenhancedplayerinput
[UInputMappingContext]: ../../UE/Input/UInputMappingContext.md#uinputmappingcontext
