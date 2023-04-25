## SyncMarkerAnimModifier

>> 詳細は未確認です。

* 既存のドキュメント
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]
		* Animation Modifier についての解説です。
	* [Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > 同期グループ > マーカーベースの同期]
		* 同期グループについての解説です。同期マーカーに関する情報もあります。
* 概要
	* `UAnimationModifier` の派生クラスです。
	* アニメーションカーブを自動生成するためのアニメーションモディファイアです。
	* [RootBoneName] の直前と今回のフレームのベクトルと [LeftFootNotifyTrackName] ([RightFootNotifyTrackName]) と [TrajectoryReferenceBoneName] が成すベクトルの内積が正から負へ変わったフレームに [LeftFootMarkerName] ([RightFootMarkerName]) という名の同期マーカーを設置します。

### RootBoneName
### LeftFootNotifyTrackName
### RightFootNotifyTrackName
### LeftFootBoneName
### RightFootBoneName
### TrajectoryReferenceBoneName
### LeftFootMarkerName
### RightFootMarkerName
### SampleStep
### RemovePreExistingSyncMarkers


[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > 同期グループ > マーカーベースの同期]: https://docs.unrealengine.com/5.1/ja/animation-sync-groups-in-unreal-engine/#%E3%83%9E%E3%83%BC%E3%82%AB%E3%83%BC%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AE%E5%90%8C%E6%9C%9F


<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[RootBoneName]: #rootbonename
[LeftFootNotifyTrackName]: #leftfootnotifytrackname
[RightFootNotifyTrackName]: #rightfootnotifytrackname
[TrajectoryReferenceBoneName]: #trajectoryreferencebonename
[LeftFootMarkerName]: #leftfootmarkername
[RightFootMarkerName]: #rightfootmarkername
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション アセットと機能 > Animation Modifier]: https://docs.unrealengine.com/5.1/ja/animation-modifiers-in-unreal-engine/
[Unreal Engine 5.1 Documentation > キャラクターとオブジェクトにアニメーションを設定する > スケルタルメッシュのアニメーション システム > アニメーション ブループリント > 同期グループ > マーカーベースの同期]: https://docs.unrealengine.com/5.1/ja/animation-sync-groups-in-unreal-engine/#%E3%83%9E%E3%83%BC%E3%82%AB%E3%83%BC%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AE%E5%90%8C%E6%9C%9F
