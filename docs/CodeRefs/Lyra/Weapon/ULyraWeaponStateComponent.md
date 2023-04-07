## ULyraWeaponStateComponent

> Tracks weapon state and recent confirmed hit markers to display on screen  
> 
> ----
> 武器の状態や最近確認されたヒットマーカーを追跡し、画面に表示します。  

* 概要
	* `UControllerComponent` の派生クラスです。
	* `ShooterCore` ([UGameFeatureData]) の設定と [UGameFeatureAction_AddComponents] によりサーバー/クライアントの `AController`  に追加されます。
	* [ULyraGameplayAbility_RangedWeapon] や `SHitMarkerConfirmationWidget` から利用されます。

### ULyraWeaponStateComponent::GetLastWeaponDamageScreenLocations()

> Gets the array of most recent locations this player instigated damage, in screen-space  
> 
> ----
> このプレーヤーがダメージを与えた最も新しい場所の配列を、スクリーンスペースで取得します。  

* 概要
	* `SHitMarkerConfirmationWidget` で利用しています。
		* レティクル上のヒットマーカーの表示に利用しています。

### ULyraWeaponStateComponent::GetTimeSinceLastHitNotification()

> Returns the elapsed time since the last (outgoing) damage hit notification occurred  
> 
> ----
> 最後の（発信）ダメージヒット通知発生からの経過時間を返します。

* 概要
	* `SHitMarkerConfirmationWidget` で利用しています。
		* レティクル上のヒットマーカーの透明度に利用しています。

### ULyraWeaponStateComponent::AddUnconfirmedServerSideHitMarkers()

* 概要
	* サーバーの確認前のヒットマーカー用の情報を保持します。
	* [ULyraGameplayAbility_RangedWeapon::StartRangedWeaponTargeting()] から呼び出されます。

### ULyraWeaponStateComponent::ClientConfirmTargetData()

* 概要
	* RPC 関数です。
	* [ULyraWeaponStateComponent::AddUnconfirmedServerSideHitMarkers()] の際に保持しておいたヒットマーカー用の配列と、サーバーから送られた命中したインデックスを元に、最後にダメージを受けた時間とヒットマーカー情報を更新します。
	* [ULyraGameplayAbility_RangedWeapon::OnTargetDataReadyCallback()] 内の `WITH_SERVER_CODE` で括られており、サーバーからのみ呼ばれます。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraGameplayAbility_RangedWeapon]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayabilityrangedweapon
[ULyraGameplayAbility_RangedWeapon::OnTargetDataReadyCallback()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayabilityrangedweaponontargetdatareadycallback
[ULyraGameplayAbility_RangedWeapon::StartRangedWeaponTargeting()]: ../../Lyra/GameplayAbility/ULyraGameplayAbility_RangedWeapon.md#ulyragameplayabilityrangedweaponstartrangedweapontargeting
[ULyraWeaponStateComponent::AddUnconfirmedServerSideHitMarkers()]: ../../Lyra/Weapon/ULyraWeaponStateComponent.md#ulyraweaponstatecomponentaddunconfirmedserversidehitmarkers
[UGameFeatureAction_AddComponents]: ../../UE/GameFeature/UGameFeatureAction_AddComponents.md#ugamefeatureactionaddcomponents
[UGameFeatureData]: ../../UE/GameFeature/UGameFeatureData.md#ugamefeaturedata
