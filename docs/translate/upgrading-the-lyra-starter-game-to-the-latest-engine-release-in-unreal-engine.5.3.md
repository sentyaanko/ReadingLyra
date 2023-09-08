以下から 5.3 関連の項目のみピックアップして翻訳したもの。

https://docs.unrealengine.com/5.3/en-US/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine/

いずれ以下が更新されるはずなので、それまで待てない人向け。

https://docs.unrealengine.com/5.3/ja/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine/


## Unreal Engine 5.3

In Unreal Engine 5.3, the Lyra Sample Game continued to receive support. 
It now takes advantage of the newest features and fixes added to the engine.

----

アンリアル エンジン 5.3 では、 Lyra サンプル ゲームが引き続きサポートされています。
現在では、エンジンに追加された最新の機能と修正を活用しています。

### Upgrade Notes for 5.3:

* Some object pointer variables were changed to use `TObjectPtr`.
* Several C++ lambdas were updated to fix warnings about unsafe usage.
* Some header includes were updated to remove unnecessary paths.

----
* いくつかのオブジェクトポインタ変数が `TObjectPtr` を使用するように変更されました。
* いくつかの C++ ラムダが更新され、安全でない使い方に関する警告が修正されました。
* いくつかのヘッダインクルードが更新され、不要なパスが削除されました。

### Improvements in 5.3:

* Lyra now includes experimental Client Replay Support. 
  On the platforms that support them, Saving replays can be enabled in the settings menu and then played back from the main menu. 
  Saved replays are currently missing some visual and sound effects. 
  Some platforms may not support Client Replay Support.
* The shared gameplay settings now inherit from the new engine `LocalPlayerSaveGame` class and will not be loaded until platform login has completed successfully.
* The ShooterExplorer game feature plugin includes some in-progress experimental content that tests open world and AI systems.
* The Lyra-specific input settings were updated to handle improvements to enhanced input.

----

* Lyra は現在、実験的なクライアントリプレイサポートを含んでいます。
  リプレイをサポートしているプラットフォームでは、保存リプレイを設定メニューで有効にし、メインメニューから再生することができます。
  保存されたリプレイには現在、いくつかの視覚効果と音響効果が欠けています。
  プラットフォームによっては、クライアントリプレイサポートをサポートしていない場合があります。
* 共有ゲームプレイ設定は新しいエンジン `LocalPlayerSaveGame` クラスを継承し、プラットフォームへのログインが正常に完了するまでロードされません。
* ShooterExplorer ゲーム機能プラグインは、オープンワールドと AI システムをテストする、いくつかの進行中の実験的なコンテンツを含みます。
* Lyra 固有の入力設定は、 enhanced input を扱うために更新されました。


### Bug Fixes in 5.3:

* Fixed issues with Gameplay Abilities and customized character parts for NPC characters that are placed directly in a map.
* The SyncMarker, FootFX and FootstepEffectTag anim modifiers have been updated.
* Fixed bug where touch-based joysticks affected input while hidden.
* Fixed several networking bugs that were discovered during replay testing.
* The health change callbacks on the LyraHealthComponent now include the instigator when it is available.

----

* マップに直接配置された NPC キャラクターのゲームプレイアビリティとカスタマイズされたキャラクターパーツの問題を修正しました。
* SyncMarker 、 FootFX 、 FootstepEffectTag アニメーションモディファイアを更新しました。
* 隠れている間、タッチベースのジョイスティックが入力に影響するバグを修正しました。
* リプレイテスト中に発見されたいくつかのネットワークのバグを修正しました。
* LyraHealthComponent のヘルスチェンジコールバックは、それが利用可能な場合、インスティゲータを含むようになりました。

----
