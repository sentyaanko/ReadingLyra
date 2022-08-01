## ULyraGameplayAbility

> The base gameplay ability class used by this project.  
> 
> ----
> このプロジェクトで使用する基本的な GameplayAbility クラスです。 

### ULyraGameplayAbility::ApplyAbilityTagsToGameplayEffectSpec()

* 概要
	* 仮想関数です。
	* [UGameplayAbility::MakeOutgoingGameplayEffectSpec()] をオーバーライドしている。
	* 攻撃が命中した部位の物理マテリアルから `UPhysicalMaterialWithTags` を取得し、 `UPhysicalMaterialWithTags::Tags` を GameplayEffectSpec に設定する。
		* GameplayEffectSpec では設定された GameplayTag を元にヘッドショット判定を行っている。詳細は以下などを参照してください。
			* `PA_Mannequin` の `head` の `Details > Physics > Simple Collision Physical Material` 
			* `GCNL_Character_DamageTaken` の `EvaluateWeakSpot`
			* GameplayTag は `Gameplay.Zone.WeakSpot` を使用している。
				* 銃撃の命中箇所による異なる処理を行うための連想配列のキーでも利用されている。例えば以下：
					* レティクルの色（デフォルトが赤、ヘッドショット時は黄色）
						* `W_Reticle_Rifle`/`W_Reticle_Shotgun`/`W_Reticle_Pistol`
					* ダメージ計算時の乗算値（ Rifle/Shotgun/Pistol で 1.5/1.75/2.0 が指定されている）
						* `B_WeaponInstance_Rifle`/`B_WeaponInstance_Shotgun`/`B_WeaponInstance_Pistol`


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[UGameplayAbility::MakeOutgoingGameplayEffectSpec()]: ../../UE/GameplayAbility/UGameplayAbility.md#ugameplayabilitymakeoutgoinggameplayeffectspec
