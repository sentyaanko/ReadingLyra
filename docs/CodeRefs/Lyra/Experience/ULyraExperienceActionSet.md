## ULyraExperienceActionSet

> Definition of a set of actions to perform as part of entering an experience  
> 
> ----
> エクスペリエンスに入るために行う一連の動作の定義  

* [ULyraExperienceDefinition::ActionSets] で利用される。
* 以下の 5 種類
	* `EAS_BasicShooterAcolades` ([ULyraExperienceActionSet])
	* `LAS_InventoryTest` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedInput` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedComponents` ([ULyraExperienceActionSet])
	* `LAS_ShooterGame_SharedHUD` ([ULyraExperienceActionSet])

* エクスペリエンスを実現するために実行する GameFeatureAction を定義するデータアセットです。
* [UGameFeatureAction] の配列を保持する。

| アセット名                         | 用途                                                          |
|------------------------------------|---------------------------------------------------------------|
| LAS_ShooterGame_SharedInput        |  |
| LAS_ShooterGame_StandardComponents |  |
| LAS_ShooterGame_StandardHUD        |  |
| LAS_InventoryTest                  | インベントリ操作用の設定？解説は割愛。                        |
| EAS_BasicShooterAcolades           |  |

> EAS_BasicShooterAcolades
> * プレフィックスが ``EAS_`` な理由は不明。おそらく間違いだと思われる。
> * Acolades も Accolades の typo だと思われる。



### ULyraExperienceActionSet::Actions

> List of actions to perform as this experience is loaded/activated/deactivated/unloaded  
> 
> ----

* [UGameFeatureAction] の配列です。




<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraExperienceActionSet]: ../../Lyra/Experience/ULyraExperienceActionSet.md#ulyraexperienceactionset
[ULyraExperienceDefinition::ActionSets]: ../../Lyra/Experience/ULyraExperienceDefinition.md#ulyraexperiencedefinitionactionsets
[UGameFeatureAction]: ../../UE/GameFeature/UGameFeatureAction.md#ugamefeatureaction
