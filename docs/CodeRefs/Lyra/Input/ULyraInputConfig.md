## ULyraInputConfig

> Non-mutable data asset that contains input configuration properties.

* 適用単位ごとに用意する、入力アクションの設定を定義するクラスです。
* `NativeInputActions`/`AbilityInputActions` に [FLyraInputAction] の配列を保持しています。
	* `NativeInputActions`
		* 固定の処理が実装されているアクション。
			* Move/Look_Mouse/Look_Stick/Crouch/AutoRun
		* それぞれの専用関数に直接バインドされ、それぞれの処理を行っている。
	* `AbilityInputActions`
		* Gameplay Ability として実装されているアクション。
			* Jump 、その他のアクション。
		* アビリティ用の汎用関数にバインドされ、 **InputTag** を元に付与されている Gameplay Ability を検索してアクティブ化する。
* 適用単位毎に `InputData_` で始まるデータアセットを作成する。

| アセット名                       | 用途                                                          |
|----------------------------------|---------------------------------------------------------------|
| InputData_Arena                  | Exploader 用                                                  |
| InputData_Hero                   | ShooterGame 用（基礎部分）                                    |
| InputData_SimplePawn             | SimplePawn （デフォルトマップ等の円柱と球で作られたポーン）用 |
| InputData_InventoryTest          | インベントリ操作用の設定？解説は割愛。                        |
| InputData_ShooterGame_AddOns     | ShooterGame 用（ Game Feature 拡張部分）                      |

InputData_Arena > HeroData_Arena ([ULyraPawnData])
InputData_Hero > HeroData_ShooterGame ([ULyraPawnData])
InputData_SimplePawn > SimplePawnData ([ULyraPawnData])
InputData_InventoryTest > LAS_InventoryTest ([ULyraExperienceActionSet])
InputData_ShooterGame_AddOns > LAS_ShooterGame_SharedInput ([ULyraExperienceActionSet])


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[FLyraInputAction]: ../../Lyra/Input/FLyraInputAction.md#flyrainputaction
[ULyraPawnData]: ../../Lyra/PawnSetting/ULyraPawnData.md#ulyrapawndata
