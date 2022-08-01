## UGameplayAbility

[Unreal Engine 5.0 Documentation > Unreal Engine API Reference > Plugins > GameplayAbilities > Abilities > UGameplayAbility](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GameplayAbilities/Abilities/UGameplayAbility/)

> Abilities define custom gameplay logic that can be activated or triggered.
> 
> The main features provided by the AbilitySystem for GameplayAbilities are: 
> - CanUse functionality:
> 	- Cooldowns
> 	- Costs (mana, stamina, etc)
> 	- etc
> - Replication support
> 	- Client/Server communication for ability activation
> 	- Client prediction for ability activation
> - Instancing support
> 	- Abilities can be non-instanced (native only)
> 	- Instanced per owner
> 	- Instanced per execution (default)
> - Basic, extendable support for:
> 	- Input binding
> 	- 'Giving' abilities (that can be used) to actors
> 
> See GameplayAbility_Montage for an example of a non-instanced ability
> - Plays a montage and applies a GameplayEffect to its target while the montage is playing.
> - When finished, removes GameplayEffect.
> 
> Note on replication support:
> - Non instanced abilities have limited replication support. 
> 	- Cannot have state (obviously) so no replicated properties
> 	- RPCs on the ability class are not possible either.
> 
> To support state or event replication, an ability must be instanced. This can be done with the InstancingPolicy property.
> 
> ----
> アビリティは、アクティブ化またはトリガー化することができるカスタムゲームプレイロジックを定義します。
>  
> AbilitySystem が GameplayAbilities に提供する主な機能は以下の通りです。
> - CanUse 機能。
> 	- クールダウン
> 	- コスト(マナ、スタミナなど)
> 	- その他
> - レプリケーションのサポート
> 	- アビリティ発動時のクライアント/サーバ通信
> 	- アビリティ発動時のクライアント予測
> - インスタンス化対応
> 	- アビリティは非インスタンス化可能（ネイティブのみ）
> 	- 所有者ごとにインスタンス化
> 	- 実行ごとにインスタンス化(デフォルト)
> - 基本的かつ拡張可能なサポート
> 	- 入力バインディング
> 	- アクターへの（使用可能な）能力の「付与」
> 
> インスタンス化されていないアビリティの例として、 GameplayAbility_Montage を参照してください。
> - モンタージュを再生し、モンタージュの再生中にそのターゲットに GameplayEffect を適用する。
> - 終了後、 GameplayEffect を削除する。
> 
> レプリケーションのサポートに関する注意
> - インスタンス化されていないアビリティは、レプリケーションのサポートが制限されています。 
> 	- 状態を持つことができないので、プロパティは複製されません。
> 	- アビリティクラスに対する RPC も不可能です。
> 
> ステートやイベントのレプリケーションをサポートするには、アビリティをインスタンス化する必要があります。これは、 InstancingPolicy プロパティで行うことができます。

* 概要
	* アビリティを定義するためのブループリント化可能なクラスです。
* Lyra での使われ方
	* [ULyraGameplayAbility] の基底クラスです。

### UGameplayAbility::MakeOutgoingGameplayEffectSpec()

> Convenience method for abilities to get outgoing gameplay effect specs  
> (for example, to pass on to projectiles to apply to whoever they hit)  
> 
> ----
> アビリティが GameplayEffectSpec を外部に出すための便利な方法です。  
> （例えば、投射物に渡して、当たった人に適用させるなど）。  

* 概要
	* `GameplayEffectSpec` を作るための関数で、ブループリントにも公開されています。
	* [UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()] を呼び出します。


### UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()

> Add the Ability's tags to the given GameplayEffectSpec.  
> This is likely to be overridden per project.  
> 
> ----
> 与えられた GameplayEffectSpec に、 Ability のタグを追加します。  
> これは、プロジェクトごとにオーバーライドされる可能性が高いです。  

* 概要
	* 仮想関数です。
	* [UGameplayAbility::MakeOutgoingGameplayEffectSpec()] から呼ばれます。
	* 渡された [FGameplayEffectSpec::CapturedSourceTags] に [FGameplayAbilitySpec::DynamicAbilityTags] を追加します。
* Lyra での使われ方
	* [ULyraGameplayAbility] でオーバーライドしている。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[FGameplayAbilitySpec::DynamicAbilityTags]: ../../UE/GameplayAbility/FGameplayAbilitySpec.md#fgameplayabilityspecdynamicabilitytags
[FGameplayEffectSpec::CapturedSourceTags]: ../../UE/GameplayAbility/FGameplayEffectSpec.md#fgameplayeffectspeccapturedsourcetags
[UGameplayAbility::MakeOutgoingGameplayEffectSpec()]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilitymakeoutgoinggameplayeffectspec
[UGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilityapplyabilitytagstogameplayeffectspec
