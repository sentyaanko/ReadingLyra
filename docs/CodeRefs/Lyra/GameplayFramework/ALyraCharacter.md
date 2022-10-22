## ALyraCharacter

> The base character pawn class used by this project.  
> Responsible for sending events to pawn components.  
> New behavior should be added via pawn components when possible.  
> 
> ----
> このプロジェクトで使用される基本キャラクターのポーンクラスです。  
> ポーンコンポーネントにイベントを送信する責任があります。  
> 可能であれば、ポーンコンポーネントを介して新しい動作を追加する必要があります。  

* 概要
	* `AModularCharacter` の派生クラスです。
	* 以下のインターフェイスの実装をしています。
		* `IAbilitySystemInterface`
		* `IGameplayCueInterface`
		* `IGameplayTagAssetInterface`
		* `ILyraTeamAgentInterface`
	* キャラクターの基底クラスです。
	* [ULyraPawnExtensionComponent] を追加しています。
		* アビリティシステムに関するアクセサと、コンポーネントの初期化周りの関数を呼び出しています。

### ALyraCharacter::ToggleCrouch()

* 概要
	* しゃがみ・立ちの状態を切り替えます。
	* [ULyraHeroComponent::Input_Crouch()] から呼び出されます。
	* 実装は `ACharacter` / `UCharacterMoveComponent` の機能を利用指定実装されています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraHeroComponent::Input_Crouch()]: ../../Lyra/GameplayAbility/ULyraHeroComponent.md#ulyraherocomponentinput_crouch
[ULyraPawnExtensionComponent]: ../../Lyra/GameplayAbility/ULyraPawnExtensionComponent.md#ulyrapawnextensioncomponent
