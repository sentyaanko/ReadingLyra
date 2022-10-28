## ULyraCharacterMovementComponent

> The base character movement component class used by this project.
> 
> ----
> このプロジェクトで使用される基本の movement component クラスです。  

* 概要
	* `UCharacterMovementComponent` の派生クラスです。

### ULyraCharacterMovementComponent::GetDeltaRotation()

> Returns how far to rotate character during the time interval DeltaTime.  
> 
> ----
> 時間間隔 DeltaTime の間、キャラクタをどれだけ回転させるかを返します。 

* 概要
	* `UCharacterMovementComponent::GetDeltaRotation()` のオーバーライドです。
	* GameplayTag `Gameplay.MovementStopped` が付与されている場合は 0 を返すように拡張しています。

### ULyraCharacterMovementComponent::GetMaxSpeed()

> Returns maximum speed of component in current movement mode.  
> 
> ----
> 現在の動作モードにおけるコンポーネントの最高速度を返します。  

* 概要
	* `UMovementComponent::UPawnMovementComponent()` のオーバーライドです。
	* GameplayTag `Gameplay.MovementStopped` が付与されている場合は 0 を返すように拡張しています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->

