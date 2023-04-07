## FLyraInteractionDurationMessage

* 概要
	* Gameplay Message で送信する構造体です。
	* 汎用的に使われています。
	* 使用しているチャンネルと送受信を行っているクラスの組み合わせは以下のようになっています。
		| Channel                                | 送信者                                               | 受信者                                                                  |
		|----------------------------------------|------------------------------------------------------|-------------------------------------------------------------------------|
		| `Ability.Grenade.Duration.Message`     | `GA_Grenade`<br>([ULyraGameplayAbility])             | `W_GrenadeCooldown` (`UUserWidget`)                                     |
		| `Ability.Dash.Duration.Message`        | `GA_Hero_Dash`<br>(`GA_AbilityWithWidget`)           | `W_DashTouchButton` (`UUserWidget`)<br>`W_DashCooldown` (`UUserWidget`) |
		| `Ability.Interaction.Duration.Message` | `GA_Interaction_Collect`<br>([ULyraGameplayAbility]) | `W_AbilityProgress` ([ULyraTaggedWidget])                               |
		| `Ability.Respawn.Duration.Message`     | `GA_AutoRespawn`<br>([ULyraGameplayAbility])         | `W_RespawnTimer` (`UUserWidget`)                                        |
	* 上記の通り、全て GameplayAbility から送信し、 widget が受信しています。

### FLyraInteractionDurationMessage::Instigator

* 概要
	* `AActor` です。
	* 送信者によって設定内容はまちまちです。以下のようになっています。
		| 送信者                                               | 渡している値                                           | 概要                                                         |
		|------------------------------------------------------|--------------------------------------------------------|--------------------------------------------------------------|
		| `GA_Grenade`<br>([ULyraGameplayAbility])             | `Get Lyra Character from Actor Info`                   | アビリティを起動しているキャラクタークラス                   |
		| `GA_Hero_Dash`<br>(`GA_AbilityWithWidget`)           | `Get Lyra Character from Actor Info`                   | アビリティを起動しているキャラクタークラス                   |
		| `GA_Interaction_Collect`<br>([ULyraGameplayAbility]) | `ActivateAbilityFromEvent` のパラメータ内の Instigator | [ULyraGameplayAbility_Interact::TriggerInteraction()] を参照 |
		| `GA_AutoRespawn`<br>([ULyraGameplayAbility])         | `Get Owning Player State`                              | ASC を所有している PlayerState                               |

### FLyraInteractionDurationMessage::Duration

* 概要
	* 期間を示す float です。
	* 送信者によって設定内容はまちまちです。以下のようになっています。
		| 送信者                                               | 渡している値             | 概要                                       |
		|------------------------------------------------------|--------------------------|--------------------------------------------|
		| `GA_Grenade`<br>([ULyraGameplayAbility])             | グレネードのクールダウン | UI に表示させるクールダウン期間の数値      |
		| `GA_Hero_Dash`<br>(`GA_AbilityWithWidget`)           | ダッシュのクールダウン   | UI に表示させるクールダウン期間の数値      |
		| `GA_Interaction_Collect`<br>([ULyraGameplayAbility]) | インタラクション         | インタラクションが成立するまでの期間の数値 |
		| `GA_AutoRespawn`<br>([ULyraGameplayAbility])         | リスポーンまでの期間     | UI に表示させるリスポーンまでの期間の数値  |



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility]: ../../Lyra/GameplayAbility/ULyraGameplayAbility.md#ulyragameplayability
[ULyraGameplayAbility_Interact::TriggerInteraction()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_Interact.md#ulyragameplayabilityinteracttriggerinteraction
[ULyraTaggedWidget]: ../../Lyra/Widget/ULyraTaggedWidget.md#ulyrataggedwidget
