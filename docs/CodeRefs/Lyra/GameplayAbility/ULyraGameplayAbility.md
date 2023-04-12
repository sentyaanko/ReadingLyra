## ULyraGameplayAbility

> The base gameplay ability class used by this project.  
> 
> ----
> このプロジェクトで使用する基本的な GameplayAbility クラスです。 

### ULyraGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()

* 概要
	* [UGameplayAbility::MakeOutgoingGameplayEffectSpec()] のオーバーライドです。
	* 攻撃が命中した部位の物理マテリアルから `UPhysicalMaterialWithTags` を取得し、 `UPhysicalMaterialWithTags::Tags` を GameplayEffectSpec に設定します。
		* GameplayEffectSpec では設定された GameplayTag を元にヘッドショット判定を行っています。詳細は以下などを参照してください。
			* `PA_Mannequin` の `head` の `Details > Physics > Simple Collision Physical Material` 
			* `GCNL_Character_DamageTaken` の `EvaluateWeakSpot`
			* GameplayTag は `Gameplay.Zone.WeakSpot` を使用。
				* 銃撃の命中箇所による異なる処理を行うための連想配列のキーとしても利用。例えば以下：
					* レティクルの色（デフォルトが赤、ヘッドショット時は黄色）
						* `W_Reticle_Rifle`/`W_Reticle_Shotgun`/`W_Reticle_Pistol`
					* ダメージ計算時の乗算値（ Rifle/Shotgun/Pistol で 1.5/1.75/2.0 をそれぞれ指定）
						* `B_WeaponInstance_Rifle`/`B_WeaponInstance_Shotgun`/`B_WeaponInstance_Pistol`


### ULyraGameplayAbility::OnAbilityFailedToActivate()

* 概要
	* [ULyraGameplayAbility::NativeOnAbilityFailedToActivate()] / [ULyraGameplayAbility::ScriptOnAbilityFailedToActivate()] を呼び出します。
	* [ULyraAbilitySystemComponent::HandleAbilityFailed()] から呼び出されます。

### ULyraGameplayAbility::NativeOnAbilityFailedToActivate()
### ULyraGameplayAbility::ScriptOnAbilityFailedToActivate()

> Called when the ability fails to activate  
> 
> ----
> アビリティのアクティブ化に失敗したときに呼び出されます  

* 概要
	* アビリティのアクティブ化に失敗した際に概ね以下のようなことを行います。
		* [ULyraGameplayAbility::FailureTagToUserFacingMessages] に従い、エラーメッセージ用の情報を Gameplay Message `Ability.UserFacingSimpleActivateFail.Message` で送信します。
			* この Gameplay Message は `W_AbilityFailureFeedback` ([ULyraTaggedWidget]) が受信します。
		* [ULyraGameplayAbility::FailureTagToAnimMontage] に従い、モンタージュの情報を Gameplay Message `Ability.PlayMontageOnActivateFail.Message` で送信します。
			* この Gameplay Message は `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon]) が受信します。

### ULyraGameplayAbility::FailureTagToUserFacingMessages

> Map of failure tags to simple error messages  
> 
> ----
> 失敗タグと簡易エラーメッセージの対応表です  

* 概要
	* アクティブ化の失敗の原因を示す GameplayTag をキーとし、テキストを値とする連想配列です。
	* Gameplay Message `Ability.UserFacingSimpleActivateFail.Message` にて [FLyraAbilitySimpleFailureMessage] を送る際に利用する情報です。
	* 一例として、 `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon]) では以下が設定されています。
		| key                         | value      | 意味                                                                                     |
		|-----------------------------|------------|------------------------------------------------------------------------------------------|
		| `Ability.ActivateFail.Cost` | `No Ammo!` | コスト不足でアクティブ化出来ない場合はテキスト `No Ammo!` を Gameplay Message で送信する |

### ULyraGameplayAbility::FailureTagToAnimMontage

> Map of failure tags to anim montages that should be played with them  
> 
> ----
> 失敗タグと再生すべきアニメーションモンタージュの対応表です  

* 概要
	* アクティブ化の失敗の原因を示す GameplayTag をキーとし、モンタージュを値とする連想配列です。
	* Gameplay Message `Ability.PlayMontageOnActivateFail.Message` にて [FLyraAbilityMontageFailureMessage] を送る際に利用する情報です。
	* 一例として、 `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon]) では以下が設定されています。
		| key                         | value                 | 意味                                                                                                    |
		|-----------------------------|-----------------------|---------------------------------------------------------------------------------------------------------|
		| `Ability.ActivateFail.Cost` | `AM_MM_Rifle_DryFire` | コスト不足でアクティブ化出来ない場合はモンタージュ `AM_MM_Rifle_DryFire` を Gameplay Message で送信する |

### ULyraGameplayAbility::ActivateAbility()

* 概要
	* [UGameplayAbility::ActivateAbility()] のオーバーライドです。
	* 基底クラスの関数を呼び出す以外のことは行っていません。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility::NativeOnAbilityFailedToActivate()]: #ulyragameplayabilitynativeonabilityfailedtoactivate
[ULyraGameplayAbility::ScriptOnAbilityFailedToActivate()]: #ulyragameplayabilityscriptonabilityfailedtoactivate
[ULyraGameplayAbility::FailureTagToUserFacingMessages]: #ulyragameplayabilityfailuretagtouserfacingmessages
[ULyraGameplayAbility::FailureTagToAnimMontage]: #ulyragameplayabilityfailuretagtoanimmontage
[ULyraAbilitySystemComponent::HandleAbilityFailed()]: ../../Lyra/GameplayAbility/ULyraAbilitySystemComponent.md#ulyraabilitysystemcomponenthandleabilityfailed
[ULyraGameplayAbility_RangedWeapon]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayabilityrangedweapon
[FLyraAbilityMontageFailureMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraAbilityMontageFailureMessage.md#flyraabilitymontagefailuremessage
[FLyraAbilitySimpleFailureMessage]: ../../Lyra/GameplayMessageProcessorStruct/FLyraAbilitySimpleFailureMessage.md#flyraabilitysimplefailuremessage
[ULyraTaggedWidget]: ../../Lyra/Widget/ULyraTaggedWidget.md#ulyrataggedwidget
[UGameplayAbility::ActivateAbility()]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilityactivateability
[UGameplayAbility::MakeOutgoingGameplayEffectSpec()]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilitymakeoutgoinggameplayeffectspec
