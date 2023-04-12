## ULyraGameplayAbility_RangedWeapon

> An ability granted by and associated with a ranged weapon instance  
> 
> ----
> 射撃武器のインスタンスによって付与され、またそれに関連するアビリティです。 

* 概要
	* [ULyraGameplayAbility_FromEquipment] の派生クラスです。
	* 銃のような射撃用のアビリティの基底クラスです。
	* 派生ブループリントは以下の通りです。
		* `GA_HealPickup`
		* `GA_Weapon_Fire`
			* `GA_Weapon_Fire_Pistol`
			* `GA_Weapon_Fire_Rifle_Auto`
			* `GA_Weapon_Fire_Shotgun`
			* `GA_WeaponNetShooter`


### ULyraGameplayAbility_RangedWeapon::OnTargetDataReadyCallback()

* 概要
	* TargetData の準備ができた際に呼び出す関数です。
	* [ULyraGameplayAbility_RangedWeapon::StartRangedWeaponTargeting()] から呼び出されます。
	* `UAbilitySystemComponent::AbilityTargetDataSetDelegate()` を利用し、 TargetData 更新時のデリゲートとして登録されています。
		* これにより、クライアントから TargetData の更新があった際の処理が実装されています。
	* `UAbilitySystemComponent::CallServerSetReplicatedTargetData()` による Batching Client -> Server RPC を利用しています。
		* これにより、クライアントからサーバーへ TargetData をレプリケーションしています。
	* `WITH_SERVER_CODE` で括ったコード内で [ULyraWeaponStateComponent::ClientConfirmTargetData()] を呼び出しています。
		* これにより、 [ULyraWeaponStateComponent::AddUnconfirmedServerSideHitMarkers()] で保持していたサーバーの確認前の情報を確認済みにします。

### ULyraGameplayAbility_RangedWeapon::StartRangedWeaponTargeting()

* 概要
	* 射撃の開始時に呼び出す関数です。
	* TargetData を作成し、 [ULyraWeaponStateComponent] に表示用の情報として保存し、サーバー/クライアントの連携処理を行います。
	* `GA_Weapon_Fire` ([ULyraGameplayAbility_RangedWeapon]) などの `ActivateAbility` 内で `IsLocallyControlled` が true のときのみ呼び出しています。
	* [ULyraWeaponStateComponent::AddUnconfirmedServerSideHitMarkers()] を呼び出します。
		* これにより、 Locally Controlled の環境で サーバーの確認前のヒットマーカー用の情報を保持させています。
	* [ULyraGameplayAbility_RangedWeapon::OnTargetDataReadyCallback()] を呼び出します。


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility_RangedWeapon]: #ulyragameplayabilityrangedweapon
[ULyraGameplayAbility_RangedWeapon::OnTargetDataReadyCallback()]: #ulyragameplayabilityrangedweaponontargetdatareadycallback
[ULyraGameplayAbility_RangedWeapon::StartRangedWeaponTargeting()]: #ulyragameplayabilityrangedweaponstartrangedweapontargeting
[ULyraGameplayAbility_FromEquipment]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_FromEquipment.md#ulyragameplayabilityfromequipment
[ULyraWeaponStateComponent]: ../../Lyra/Weapon/ULyraWeaponStateComponent.md#ulyraweaponstatecomponent
[ULyraWeaponStateComponent::AddUnconfirmedServerSideHitMarkers()]: ../../Lyra/Weapon/ULyraWeaponStateComponent.md#ulyraweaponstatecomponentaddunconfirmedserversidehitmarkers
[ULyraWeaponStateComponent::ClientConfirmTargetData()]: ../../Lyra/Weapon/ULyraWeaponStateComponent.md#ulyraweaponstatecomponentclientconfirmtargetdata
