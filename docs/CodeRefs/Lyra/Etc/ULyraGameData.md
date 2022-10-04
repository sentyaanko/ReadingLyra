## ULyraGameData

> Non-mutable data asset that contains global game data.
> 
> ----
> グローバルなゲームデータを格納する Non-mutable データアセットです。

* 概要
	* `UPrimaryDataAsset` の派生クラスです。
	* プロジェクトに存在するアセットは以下の通りです。
		* `DefaultGameData`
	* *Project Settings > Game - Asset Manager > Asset Manager > Primary Asset Types of Scan > Index[1]* にて指定されています。
		* `DefaultGameData` が `Specific Assets` に指定されています。

### ULyraGameData::DamageGameplayEffect_SetByCaller

> Gameplay effect used to apply damage.  Uses SetByCaller for the damage magnitude.  
> 
> ----
> ダメージの適用に使用されるゲームプレイエフェクトです。 ダメージの大きさには SetByCaller を使用します。  

* 概要
	* `UGameplayEffect` を指定します。
	* [ULyraHealthComponent] にてヘルスの変更を行う GameplayEffectSpec を構築する際に使用しています。
	* `DefaultGameData` について
		* `GE_Damage_Basic_SetByCaller` が指定されています。

### ULyraGameData::HealGameplayEffect_SetByCaller

> Gameplay effect used to apply healing.  Uses SetByCaller for the healing magnitude.  
> 
> ----
> ヒーリングの適用に使用されるゲームプレイエフェクトです。 ヒーリングの大きさには SetByCaller を使用します。  

* 概要
	* `UGameplayEffect` を指定します。
	* 現状では [ULyraCheatManager] 経由でしか使用されていません。
	* `DefaultGameData` について
		* `GE_Heal_SetByCaller` が指定されています。

### ULyraGameData::DynamicTagGameplayEffect

> Gameplay effect used to add and remove dynamic tags.
> 
> ----
> ダイナミックタグの追加と削除に使用されるゲームプレイエフェクトです。

* 概要
	* `UGameplayEffect` を指定します。
	* [ULyraAbilitySystemComponent] にて GameplayTag の付与を行う GameplayEffectSpec を構築する際に使用しています。
		* 実行時に GameplayEffectSpec の `DynamicGrantedTags` を変更することで、 GameplayTag の付与を行っています。
			* これにより GameplayTag 毎に GameplayEffect を作らないで済むようになります。
	* `DefaultGameData` について
		* `GE_DynamicTag` が指定されています。
			* `Duration Policy` を `Infinite` にしている以外は何もしない GameplayEffect であり、他の影響を与え無いようにしています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraCheatManager]: ../../Lyra/Etc/ULyraCheatManager.md#ulyracheatmanager
[ULyraAbilitySystemComponent]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponent
[ULyraHealthComponent]: ../../Lyra/GameplayAbility/ULyraHealthComponent.md#ulyrahealthcomponent
