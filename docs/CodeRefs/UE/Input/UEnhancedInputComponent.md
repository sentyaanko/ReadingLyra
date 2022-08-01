## UEnhancedInputComponent

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > EnhancedInput > UEnhancedInputComponent](https://docs.unrealengine.com/5.0/en-US/API/Plugins/EnhancedInput/UEnhancedInputComponent/)

> An Enhanced Input Component is a transient component that enables an Actor to bind enhanced actions to delegate functions, or monitor those actions.
> Input components are processed from a stack managed by the PlayerController and processed by the PlayerInput.
> These bindings will not consume input events, but this behaviour can be replicated using UInputMappingContext::Priority.
> 
> ----
> Enhanced Input Component は、Actor が拡張アクションをデリゲート関数にバインドしたり、それらの アクションを監視したりできるようにするための一時的なコンポーネントです。
> 入力コンポーネントは、PlayerController が管理するスタックから、PlayerInput によって処理されます。
> これらのバインディングは入力イベントを消費しませんが、この動作は UInputMappingContext::Priority を使用して複製することができます。

* 概要
	* *Project Settings > Engine - Input > Default Classes > Default Input Component Class* でこの派生クラスを指定します。
	* Actor が所持する InputComponent クラスはここで指定されたクラスになります。
* Lyra での使われ方
	* [ULyraInputComponent] の基底クラスです。

### UEnhancedInputComponent::BindAction()

> Binds a delegate function matching any of the handler signatures to a UInputAction assigned via UInputMappingContext to the owner of this component.
> 
> ----
> UInputMappingContext を介してこのコンポーネントの所有者に割り当てられた UInputAction に、いずれかのハンドラ署名に一致するデリゲート関数をバインドします。

* 概要
	* 入力アクションが発生した際に実行するデリゲートを登録する関数です。
* Lyra での使われ方
	* 以下等から呼び出されます。
		* [ULyraInputComboComponent::BindInputCallbacks()]
		* [ULyraInputComponent::BindNativeAction()]
		* [ULyraInputComponent::BindAbilityActions()]


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraInputComboComponent::BindInputCallbacks()]: ../../Lyra/Input/ULyraInputComboComponent.md#ulyrainputcombocomponentbindinputcallbacks
[ULyraInputComponent]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponent
[ULyraInputComponent::BindNativeAction()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentbindnativeaction
[ULyraInputComponent::BindAbilityActions()]: ../../Lyra/Input/ULyraInputComponent.md#ulyrainputcomponentbindabilityactions
