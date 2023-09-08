# Gameplay

## API Change:

* 子クラスで Super::ActivateAbility を安全に呼び出せるようになった。以前は CommitAbility を呼び出していました。
* これにより、照準感度をチェックするためにユーザー設定オブジェクトにアクセスしたい場合など、 Local Player にアクセスしたい Enhanced Input のトリガー/モディファイアーを書くのが少し簡単になります。
* これは、ポーンの初期化時に使用する、ゲームにとって便利なステートの一部です。
* コマンドの前には AbilitySystem が付きます。
* 空の GameplayTagQueries は曖昧なので、呼び出し元がケースバイケースで処理する必要があります。
* `Paper2d.DisableSyncLoadInEditor` CVar フラグを指定することで、テクスチャの読み込みを以前の方法に戻すことができます。
* SDetailsViewBase::HighlightProperty に nullptr を渡しても何もしなくなり、代わりにすべてのプロパティのハイライトが解除されるようになりました。
* これは、入力デバイスサブシステムを使用しようとしている場合に重要な修正です。

## New:

* Targeting System の AOE Targeting Task に、ワールド空間ではなく相対空間に基づいてオフセッ トするオプションを追加しました。
* TargetingSubsystem 関数を同じメタデータ カテゴリに移動しました。
* 特定の Local Player のセーブゲームオブジェクトをセーブおよびロードするためのユーティリティ関数を提供する、 ULocalPlayerSaveGame ベースクラスをエンジンに追加しました。これは、 GameplayStatics の既存のセーブ/ロード ロジックをラップし、 PC 以外のプラットフォームでのセーブ/ロードを適切にサポートするために必要な機能を提供します。
* アクターごとにインスタンス化されたゲームプレイアビリティについて、CDO ではなくプライマリインスタンスで OnAvatarSet が呼び出されるようになりました。
* AOE タスクのトレース元を、そのタスクが返す FHitResult の TraceStart として追加しました。これにより、ユーザーはターゲット後にその情報を利用できるようになります。
* 入力スロットが列挙型をサポートしました。
* 設定の更新を延期できるように enhanced input の設定を更新しました。
* MatchAnyTags 、 MatchAllTags 、および MatchNoTags タグクエリがブループリントで公開された make ノードを持つようになりました。
* UTargetingTask を Abstract としてマークし、EditInlineNew プロパティで選択できないようにしました。
* AOE ターゲティングタスクによって使用されるコリジョン パラメータ用のデータストアを追加しました。
* AOE ターゲティングタスクのデータストアからコリジョンデータをオーバーライドするフックを追加しました。
* ターゲティング結果を取得する前にターゲティングハンドルを取得できるように、 Perform Targeting ノードの非同期タスクを公開しました。
* LocalPlayer に GetPlatformUserIndex 関数を追加し、異なるインデックスを説明するコメントを修正しました。
* AInfo のコンストラクタを拡張し、デフォルトの ObjectInitializer パラメータをサポートするようにしました。これにより、派生クラスがデフォルトのコンストラクタをオーバーライドして、 AInfo 固有の初期化を見逃す可能性がある場合に対応できるようになりました。
* 同じ Gameplay Ability Graph で、 Activate Ability と Activate Ability From Event の両方を許可するようになりました。
* AnimTask_PlayMontageAndWait に、 BlendOut イベント後に Completed と Interrupted を許可するトグルが追加されました。
* カメラシェイクとカメラアニメーションのポストプロセス設定が、ベースワールド値ではなくオーバーライドとして処理されるようになりました。
* カメラコンポーネントのアスペクト比軸制約のオーバーライドを追加しました。
* UPlayerInput クラスに GetOwningLocalPlayer 関数を追加しました。
* GAS: より複雑な要件を指定できるように、 FGameplayTagRequirements に GameplayTagQuery フィールドを追加しました。
* UPlayer に ReceivedPlayerController 関数を追加し、所有する APlayerController ポインタがそのプレイヤーで有効になったときに、所有するプレイヤーコントローラーから呼び出されるようにしました。これと並行して、 ULocalPlayer と Local Player Subsystems に `OnPlayerControllerChanged` デリゲートを追加し、簡単にフックインできるようにしました。
* SourceTagQuery を補強するために FGameplayEffectQuery::SourceAggregateTagQuery が導入されました。
* GAS: ModMagnitudeCalc ラッパー関数が const 宣言されました。
* Input Action のイベントノードで、 `Triggered` を除くすべての exec ピンを advanced view としてマークしました。
* Enhanced Input に連続入力インジェクションを追加しました。
* FPrimaryAssetId 関数のパラメータに AllowedTypes を設定できるようになりました。これを使用するには、 UPARAM(meta = (AllowedTypes = "SomeAssetType")) をパラメータに追加します。
* Enhanced Input に EKeys::AnyKey サポートを追加しました。
* GAS: コンソールコマンドからゲームプレイアビリティとゲームプレイエフェクトを実行およびキャンセルする機能を拡張しました。
* ゲームプレイアビリティブループリントの `Audit(監査)` を実行する機能が追加され、開発方法と使用目的に関する情報が表示されるようになりました。
* FGameplayTagQuery::Matches が空のクエリに対して false を返すようになりました。
* FDateTime の To/From Unix Timestamp 関数をブループリントに公開しました。
* 異なるタイプの FGameplayEffectContext を適切に複製するためのサポートを追加しました。
* FGameplayAttribute::PostSerialize を更新し、含まれるアトリビュートを検索可能な名前としてマークするようにしました。
* FGameplayEffectContextHandle が `Actors` を取得する前にデータが有効かどうかをチェックするようになりました。
* Gameplay Ability System Target Data LocationInfo の回転を保持するようになりました。
* 有効な PC が見つかった場合にのみ、Gameplay Ability System が PC の検索を停止するようになりました。
* GetAbilitySystemComponent のデフォルトパラメータを Self に更新しました。
* アセットを差分する際、変更されたプロパティを示す色付きのハイライトがアセット詳細パネルに表示されるようになりました。
* Enhanced Action Key Mapping と Input Action アセットのコメントを更新し、モディファイアが適用される順序について説明しました。個々のキーマッピングで定義されたモディファイアは、入力アクションアセットで定義されたモディファイアよりも先に適用されます。モディファイアは、Input Action アセットで定義されたものを上書きすることはなく、評価時に統合されます。
* FInstancedPropertyBag にメタデータ付きコールバック・オプションを追加しました。
	* プロパティのタイプを変更する際に、いくつかのタイプをフィルタリングするための TypeFilter コールバックを追加しました。
	* プロパティの削除をキャンセルする RemoveCheck コールバックを追加しました。
	* invoke の汎用的な方法を追加しました。
* リビジョン管理で競合しているデータアセットを、コンテンツブラウザで右クリックして `リビジョン管理/マージ` を選択することで、マージできるようになりました。
* PropertyBag の詳細ビューでデフォルトタイプを変更するためのサポートを実装し、 また、 StructUtils で利用可能なすべてのメタデータ値を参照するために、メタデータ名を別のヘッダーに移動しました。
* プレイヤーコントローラーの入力モードに、デバッグ表示名文字列を追加しました。これは、入力が UI によって消費されている可能性があるため、入力がプレイヤーに届かない理由を素早くデバッグするのに便利です。
* TouchInterface の方向を明確にしました。
* AbilityTask_WaitTargetData に仮想関数を追加しました。
* 入力アクションに入力累積動作の詳細設定を追加しました。この設定により、入力アクションを、常に最も高いキー値を持つマッピングを受け入れるのではなく、異なるアクションキーマッピングからの入力を累積的に組み合わせるように変更できるようになります。実用的な例としては、 WASD 移動のように、 W キーと S キーが互いにキャンセルされるような場合に使用できます。
* StructUtils の Properties で使用できるコンテナのフィルタリングを追加しました。
* SSourceControlReview::OpenChangelist メソッドを追加し、外部コードから変更点レビューダイアログを開けるようにしました。
* 差分ツールのオーバーホールにより、非同期差分が可能になり、詳細パネルの差分精度が向上しました。
* ハードウェア・デバイス識別子に EHardwareDeviceSupportedFeatures と EHardwareDevicePrimaryType 列挙型を追加しました。これらにより、ハードウェアデバイス識別子がフラグを自分自身に設定し、それらが持ついくつかの共通の特徴を識別し、どのようなサポートがあるかをチェックできるようになりました。これらはコンフィグフラグで、与えられた入力デバイスのサポート内容を変更したり、必要に応じてカスタムハードウェアタイプを追加したりする方法をゲームに提供します。
* DataTable と DataRegistry でインスタンス化された構造体オブジェクト参照のサポートを追加しました。
* プレイヤーキーマッピング名と UInputAction ポインタに基づく入力インジェクションを許可します。これは、各プレイヤーマッピングに関連付けられた UInputAction* を追跡することで実現できます。各プレイヤーマッピング可能なキープロファイルの所有 Platform User ID を追跡して、プロファイルの外側を取得しなくても Local Player にアクセスできるようにし、これはカスタムプロファイルサブクラスで役立ちます。

## Improvement:

* カメラシェイクの時間管理をリファクタリングしました。
* ビューターゲット間のポストプロセス設定のブレンドを改善しました。
* ProjectileMovementComponent にオプションを追加し、オブジェクトがあまり関連していない場合に、いくつかのフレームで補間トランスフォームの更新を回避するようにしました。デフォルトのバージョンは最近レンダリングされたものではありませんが、拡張可能です。
* ProjectileMovementComponent の補間コンポーネントの移動に FScopedMovementUpdate を追加しました。これにより、ティック中に再びシミュレートする場合に、子コンポーネントを複数回移動させることがなくなります。

## Crash Fix:

* シームレス移動後にゲームプレイキューを適用しようとするとクラッシュする問題を修正しました。
* Live Coding を使用しているときに GlobalAbilityTaskCount によって引き起こされるクラッシュを修正しました。
* UAbilityTask::OnDestroy が UAbilityTask_StartAbilityState のようなケースで再帰的に呼び出されてもクラッシュしないように修正しました。
* AsyncTargetingRequests が処理されている間にエントリが追加されることによって引き起こされるクラッシュを修正しました（非同期ターゲティングリクエストノードが別のものとチェーンされている場合）。現在はそれらをキューに入れ、tickの最後に処理します。
* レベルを変更すると AddTimedDisplay がクラッシュする問題を修正しました。
* Subobject Data Subsystem で無効なサブオブジェクトクラスタイプを追加しようとしたときのクラッシュを防止しました。
* AGeometryCollectionISMPoolActor がガベージポインタを保持することによるクラッシュを修正しました。
* アニメーション ブループリントを差分する際のクラッシュを修正しました。
* レビューツールでアセットの追加と削除を差分する際のクラッシュを修正しました。

## Bug Fix:

* RemoveGameplayCue_Internal のデフォルトパラメータオブジェクトの代わりに、既存の GameplayCueParameters を使用します。
* パッケージゲームやマップ転送での動作に合わせるため、 Play in Editor の初期化を変更し、ワールドサブシステムの作成と初期化の前にゲームインスタンスサブシステムを作成するようにしたしました。
* GetInputAnalogStickState の double-to-float ラッパーが間違った関数を呼び出していたのを修正しました。
* GameplayAbilityWorldReticle が、TargetingActor ではなくソース Actor の方を向くようになりました。
* GiveAbilityAndActivateOnce で渡され、アビリティリストがロックされていた場合に、トリガーイベントデータをキャッシュするようにしました。
* Targeting System Tasks で RawScores が正しく入力されない問題を修正しました。
* ブループリントのデバッグ `StepOver` コマンドが不正なブループリントで停止する問題を修正しました。
* TargetingSelectionTask_AOE が軸合わせではなく、ソースアクタの回転を尊重するようになりました。
* NULL の TargetingTaskSet 要素の処理をスキップするようにしました。
* ビルドイベント後に SCS_Node Actor のシーンコンポーネントが正しく再登録されない問題を修正しました。
* いくつかの無限カメラシェイクをブレンドアウトする際の問題を修正しました。
* シーケンサーに表示される合成カメラシェイクパターンの時間情報を修正しました。
* FInheritedGameplayTags が、保存まで待つのではなく、即座に CombinedTags を更新するようにサポートが追加されました。
* 再ペアレント中にネイティブのルートコンポーネントがクラスを変更した場合に、エディタでのアクターのロードがトランスフォームを正しく設定するように修正しました。
* サーバーが強制的にポーンの位置を更新するタイミングに影響する問題を修正しました。
* プレイヤー・マッピング可能な名前の長さを FName の最大長に制限し、最大長を適切にチェックするようにしました。これにより、長すぎる名前を使用した場合に発生する可能性のある問題が修正されました。
* USceneComponent がガベージコレクションされたときに、`AttachChildren count increased while detaching` エラーが発生するリグレッションを修正しました。
* AActor::RerunConstructionScripts が、トランスフォームが変更されていないときに ExecuteConstruction 内で冗長な SetWorldTransform を呼び出すのを防止しました。これにより、アタッチ親を持つコンポーネントの相対トランスフォームとワールドトランスフォームにエラーが累積していました。
* 時間が拡張された場合に、クライアントの移動が意図した速度で送信されないことがあったキャラクターの移動に関する問題を修正しました。
* キャラクターが垂直（重力と一直線）にいるつもりでも、そこに到達するためにピッチやロールを変更できない問題を修正しました。
* ShouldAbilityRespondToEvent をクライアント専用のコードパスからサーバーとクライアントの両方に移動しました。
* コンテナプロパティ (TArray, TSet, TMap) に格納されているサブオブジェクトが、実行時に動的に作成された場合、詳細パネルに表示されない問題を修正しました。
* 新しく作成されたブループリント子クラスはトランザクションとしてマークされるようになったため、最初の保存後ではなく、作成時にすぐに元に戻せるようになりました。
* 特定のタイプのデータアセットおよびデータテーブルを操作する際のパスの警告を修正しました。
* プロジェクトに名前がある場合のみ、 Enhanced Input への自動アップグレードを試みます。これにより、プロジェクトランチャーからEIに関するトーストが表示される問題が解決されました。
* シェイクを開始/停止する前に、ワールドポインタを NULL チェックするようになりました。
* 少なくとも 1 つの状態が設定されていることを確認するために、コンボステップの完了とキャンセルの状態に対するデータ検証を追加しました。
* すでに ASYNC ローディングスレッドに入っている場合、 Paper2D スプライトのソーステクスチャを同期的にロードしようとしないでください。これは、クックドコンテンツが有効になっている場合、スプライトアセットのポストロード時にエディタで発生する可能性があります。
* FAttributeSetInitterDiscreteLevels が、 Curve Simplification のために Cooked Builds で機能しないのを修正しました。
* GameplayAbility に CurrentEventData を設定しました。
* MinimalReplicationTags が、潜在的にコールバックを実行する前に正しく設定されるようにしました。
* カメラアニメーションサブシステムのブループリント関数が NULL ポインタを優雅に処理するようにしました。
* UPawnMovementComponent::AddInputVector のコメントを修正しました。
* インスタンス化された GameplayAbility で呼び出されなかった ShouldAbilityRespondToEvent を修正しました。
* gc.PendingKill が無効な場合に、子アクター上で実行されるゲームプレイキュー通知アクターがメモリをリークしなくなりました。
* AActor::SetActorTickEnabled を仮想にしました。
* GameplayCueManager で、ハッシュの衝突によって GameplayCueNotify_Actors が「失われる」ことがある問題を修正しました。
* WaitGameplayTagQuery は、アクターにゲームプレイタグがない場合でも、そのクエリを尊重するようになりました。
* PostAttributeChange と AttributeValueChangeDelegate が正しい OldValue を持つようになりました。
* パラメータがビューターゲットから次のビューターゲットへ「リーク」しないように、最小ビュー情報が正しくリセットされるようになりました。
* 現在のスケールとイージング値をポストプロセスの設定ウェイトに適用しました。
* 構造体がネイティブ コードで作成された場合に、FGameplayTagQuery が適切なクエリの説明を表示しない問題を修正しました。
* bIgnoreAllPressedKeysUntilRelease が true の場合、以前のキーマッピングにあったキーのみではなく、すべてのキーのキー押下を無視するようにしました。
* 入力マッピングコンテキストでマッピングリストをコピー＆ペーストできない問題を修正しました。
* プロジェクトに名前がある場合のみ設定ファイルを変更するようにし、プロジェクトランチャーからデフォルトエンジンのiniファイルを変更しないようにしました。
* 非アセットファイルを含むチェンジリストをレビューツールで読み込む際のパッケージ読み込み警告を修正しました。
* アクションが現在のマッピングに存在しない場合に、アクションの値バインディングの値をリセットするようにしました。
* PIE 終了時に設定される "Force Reset" フラグをデバイスプロパティに追加しました。これにより、 PIE セッション間でライトの色やトリガー効果が持続する小さなバグが修正されました。
* オブジェクトのテキストエクスポート（コピー/ペーストに使用）を更新し、特殊文字を含むプロパティ名をサニタイズしました。
* FKey::KeyName を EditAnywhere としてマークし、サブオブジェクトで変更された場合にその値が正しく伝搬されるようにしました。これがないと、サブオブジェクトでプロパティが変更されたかどうかを判断するときに KeyName プロパティがフィルタリングされ、使用できない UPROPERTY になります。 FKey にはカスタムの詳細行があるため、エディタでは視覚的に影響はありません。
* SpawnActorFromClass ノードの Scale メソッドピンに関して、クックタイム中の非決定的な動作を修正しました。
* SDetailsViewBase::HighlightProperty が nullptr をサポートしておらず、プロパティのハイライトを解除する方法がなくなっていたリグレッションを修正しました。
* `showdebug EnhancedInput` コマンドで、一部のキーマッピングが誤って overriden として表示される問題を修正しました。これは、モディファイアとトリガーのインスタンス化された配列を比較していたため、配列への AddUnique 呼び出しが常に新しいマッピングを追加していたために起こっていました。
* ループ内の無効な "break" を削除し、コード化されたアクションがブロックされる順番に依存するチェックを作成しました。
* 入力デバイスサブシステムが、パッケージ化されたウィンドウズプロジェクトで有効なゲームワールドを見つけられないのを修正しました。サブシステムは、クックされたゲームワールドではなく、 PIE のみのプレイワールドを検索していました。
* RebuildControlMappings で拡張されたアクションマッピングを比較する際、モディファイアとトリガーの配列がディープコピーされていたため、新しいインスタンスと古いインスタンスを比較すると、何があっても false を返してしまう問題を修正しました。
* OneFilePerActor アクタが、以前のバージョンに対してではなく、それ自身に対して常にローカルアセットを差分する原因となっていたバグを修正しました。
* アビリティシステムが使用されている場合に、 UAbilitySystemGlobals::InitGlobalData が呼び出されるようにしました。以前は、ユーザがこれを呼び出さなかった場合、ゲームプレイアビリティシステムは正しく機能しませんでした。
* ゲームパッドをセカンドウィンドウにルーティングするように修正しました。この設定を有効にすると、ゲームパッドがエディタに接続されている場合、すべてのゲームパッド入力が次のPIEウィンドウにルーティングされます。
* 差分からエクスポートパスを除外することで、テキストベースのアセット差分における誤検出を減らしました。
* SKismetInspector の RefreshPropertyObjects がガベージコレクションされない原因となっていたバグを修正しました。

## Deprecated:

* 未使用の関数 FGameplayAbilityTargetData::AddTargetDataToGameplayCueParameters を削除しました。
* 過去のものとなったGameplayAbility::SetMovementSyncPointを削除しました。
* UPlayerMappableInputConfig を非推奨とし、 5.3 で新しい UEnhancedInputUserSettings を採用しました。
* FPlayerMappableKeySlot とそれに関連するすべての関数を 5.3 で非推奨とし、すべての古いプレイヤーマップキー関数を UEnhancedInputUserSettings に変更しました。

## Removed:

* ゲームプレイタスクとアビリティシステムコンポーネントから、未使用の複製フラグを削除しました。
* コンボ・アクションが存在しない場合の ensure を削除しました。代わりに警告を記録します。

----
