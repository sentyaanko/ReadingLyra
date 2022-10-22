## UAbilitySystemGlobals

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > UAbilitySystemGlobals](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameplayAbilities/UAbilitySystemGlobals/)

> Holds global data for the ability system. Can be configured per project via config file  
> 
> ----
> アビリティシステムのグローバルデータを保持します。設定ファイルにより、プロジェクトごとに設定可能です。  

* 概要
	* `UObject` の派生クラスです。
	* シングルトンクラスです。
* Lyra での使われ方
	* [ULyraAbilitySystemGlobals] の基底クラスです。
	* 主に GameplayCue のパス関連の機能を利用しています。

### UAbilitySystemGlobals::GameplayCueNotifyPaths

> Look in these paths for GameplayCueNotifies. These are your "always loaded" set.  
> 
> ----
> これらのパスの中から GameplayCueNotifies を探します。これらは、「常にロードされる」セットです。 

* 概要
	* `FString` の配列です。

### UAbilitySystemGlobals::AllocGameplayEffectContext()

> Should allocate a project specific GameplayEffectContext struct. Caller is responsible for deallocation  
> 
> ----
> プロジェクト固有の GameplayEffectContext 構造体を割り当てるのが望ましいです。呼び出し元が割り当て解除の責任を負います。  

* 概要
	* `FGameplayEffectContext` 派生クラスをアロケートして返す関数です。
	* Gameplay Ability 内で `FGameplayEffectContext` をアロケーションする際に呼び出されます。
* Lyra での使われ方
	* [ULyraAbilitySystemGlobals::AllocGameplayEffectContext()] でオーバーライドしています。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAbilitySystemGlobals]: ../../Lyra/GameplayAbility/ULyraAbilitySystemGlobals.md#ulyraabilitysystemglobals
[ULyraAbilitySystemGlobals::AllocGameplayEffectContext()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemGlobals.md#ulyraabilitysystemglobalsallocgameplayeffectcontext
