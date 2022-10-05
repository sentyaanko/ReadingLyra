## ULyraNumberPopComponent

* 概要
	* `UControllerComponent` の派生クラスです。
	* [ULyraNumberPopComponent_NiagaraText] の基底クラスです。
	* [ULyraNumberPopComponent_MeshText] の基底クラスです。
	* ダメージ値をポップアップ表示する際に利用する仮想関数を定義したクラスです。

### ULyraNumberPopComponent::AddNumberPop()

> Adds a damage number to the damage number list for visualization  
> 
> ----
> 可視化のためのダメージ値リストにダメージ値を追加する  

* 概要
	* 派生クラスでオーバーライドすることを想定しており、このクラスの実装は空です。
	* `GCNL_Character_DamageTaken` ([AGameplayCueNotify_BurstLatent]) の `OnExecute` ノードから呼び出されています。



<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraNumberPopComponent_MeshText]: ../../Lyra/Etc/ULyraNumberPopComponent_MeshText.md#ulyranumberpopcomponent_meshtext
[ULyraNumberPopComponent_NiagaraText]: ../../Lyra/Etc/ULyraNumberPopComponent_NiagaraText.md#ulyranumberpopcomponent_niagaratext
[AGameplayCueNotify_BurstLatent]: ../../Lyra/GameplayCue/AGameplayCueNotify_BurstLatent.md#agameplaycuenotify_burstlatent
