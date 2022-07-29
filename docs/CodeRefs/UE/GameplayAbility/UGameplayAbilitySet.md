## UGameplayAbilitySet

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > UGameplayAbilitySet](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameplayAbilities/UGameplayAbilitySet/)

> This is an example input binding enum for GameplayAbilities. 
> Your project may want to create its own.
> The MetaData default bind keys (LMB, RMB, Q, E, etc) are a convenience for designers setting up abilities sets or whatever other data you have that gives an ability with a default key binding. 
> Actual key binding is up to DefaultInput.ini
> 
> E.g., "Ability1" is the command string that is bound to AbilitySystemComponent::ActivateAbility(1). 
> The Meta data only *suggests* that you are binding "Ability1" to LMB by default in your projects DefaultInput.ini.
> 
> ----
> GameplayAbilities の入力バインディングenumの例です。
> プロジェクトによっては、独自に作成することも可能です。
> MetaData のデフォルト バインド キー (LMB, RMB, Q, E など) は、デザイナーがアビリティ セットやその他のデータを設定して、アビリティにデフォルトキーバインドを設定する際に便利なものです。
> 実際のキーバインディングは DefaultInput.ini によって決定されます。
> 
> 例："Ability1 "はAbilitySystemComponent::ActivateAbility(1)に束縛されるコマンド文字列です。
> メタデータは、プロジェクトの DefaultInput.ini で、デフォルトで LMB に "Ability1" をバインドしていることを示唆しているにすぎません*。

* 概要
	* ドキュメントでは使用しているように書いていますが、特に使っていないように思われます。
		* そもそも、 UGameplayAbilitySet 自体、サンプルのようなもので、汎用的に使える仕組みではないように思われます。
		* 代わりに、 [ULyraAbilitySet] を使用しているように思われます。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAbilitySet]: ../../Lyra/GameplayAbility/ULyraAbilitySet.md#ulyraabilityset
