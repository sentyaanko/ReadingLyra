# Comment_AnimBP_Tour.Ja

引用元

| No. | 引用元                                                  |
|-----|---------------------------------------------------------|
| 1   | ABP_Mannequin_Base > EventGraph                         |
| 2   | ABP_Mannequin_Base > BlueprintThreadSafeUpdateAnimation |
| 3   | ABP_Mannequin_Base > AnimGraph                          |
| 4   | ABP_Mannequin_Base > AnimGraph > LocomotionSM           |
| 5   | ABP_ItemAnimLayersBase > EventGraph                     |
| 6   | ABP_ItemAnimLayersBase > EventGraph                     |
| 7   | ABP_ItemAnimLayersBase > FullBody_IdleState             |
| 8   | ABP_ItemAnimLayersBase > FullBody_IdleState             |
| 9   | ABP_ItemAnimLayersBase > UpdateStartAnim                |
| 10  | ABP_ItemAnimLayersBase > FullBody_StartState            |

# 1

ABP_Mannequin_Base > EventGraph

AnimBP ツアー #1 (ABP_ItemAnimLayersBaseも参照)

この AnimBP は、イベントグラフでロジックを実行しない。
イベントグラフのロジックはゲームスレッドで処理されます。
毎ティック、各 AnimBP の Event Graph を順番に実行する必要があり、パフォーマンスのボトルネックになることがあります。
このプロジェクトでは、代わりに新しい BlueprintThreadsafeUpdateAnimation 関数 (My Blueprint タブにあります) を使用しました。
BlueprintThreadsafeUpdateAnimation のロジックは、複数の AnimBP に対して同時に並行して実行することができ、 Game Thread のオーバーヘッドを除去することができます。

# 2

ABP_Mannequin_Base > BlueprintThreadSafeUpdateAnimation

AnimBP ツアー #2

この関数は主にゲームデータを収集し、アニメーションの選択と駆動に役立つ情報に処理する役割を担っています。
スレッドセーフな関数の注意点は、イベントグラフのようにゲームオブジェクトのデータに直接アクセスできないことです。
これは、他のスレッドが同時に実行されていて、そのデータを変更している可能性があるためです。
その代わりに、プロパティアクセスシステムを使用してデータにアクセスします。
プロパティアクセスシステムは、安全なときに自動的にデータをコピーします。
ここでは、ポーンのオーナーの場所にアクセスする例を示します（コンテキストメニューから "Property Access" を検索してください）。

# 3

ABP_Mannequin_Base > AnimGraph

AnimBP ツアー #3

この Anim Graph は、アニメーションを直接参照することはありません。
代わりに、モンタージュやリンクされたアニメーションレイヤーに、グラフ内の特定のポイントでポーズを再生するためのエントリーポイントを提供します。
このグラフの主な目的は、これらのエントリーポイントをブレンドすることです（例：上半身と下半身のポーズをブレンドする）。
このアプローチにより、必要なときだけアニメーションをロードすることができます。
例えば、ウェポンは必要なモンタージュとリンクされたアニメーションレイヤーへの参照を保持し、ウェポンがロードされたときにのみそのデータがロードされるようにします。
例： B_WeaponInstance_Shotgun は、 Montages と Linked Animation Layers への参照を保持しています。
そのデータは B_WeaponInstance_Shotgun がロードされたときのみロードされます。
B_WeaponInstance_Base は武器のアニメーションレイヤーをリンクする役割を担っています。

# 4

ABP_Mannequin_Base > AnimGraph > LocomotionSM

AnimBP ツアー #4

このステートマシンは、高レベルのキャラクタの状態間の遷移を処理します。
各ステートの動作は、ほとんど ABP_ItemAnimLayersBase のレイヤーによって処理されます。

# 5

ABP_ItemAnimLayersBase > EventGraph

AnimBP ツアー #5

AnimBP_Mannequin_Base と同様に、この animbp は BlueprintThreadSafeUpdateAnimation でそのロジックを実行します。
また、この animbp は、Property Access と GetMainAnimBPThreadSafe 関数を使用して AnimBP_Mannequin_Base のデータにアクセスすることができます。
以下に例を示します。

# 6

ABP_ItemAnimLayersBase > EventGraph

AnimBP ツアー #6

この AnimBP は Rifles や Pistols のような一般的な武器タイプのロジックを処理するために作成されました。
もしカスタムロジックが必要な場合（例えば弓のような武器）、 ALI_ItemAnimLayers インターフェースを実装した別の animbp を作成することができます。
この animbp はアニメーションアセットを直接参照するのではなく、子アニメーションブループリントでオーバーライド可能な変数のセットを持っています。
これらの変数は、 "My Blueprint" タブの "Anim Set - X" カテゴリで見つけることができます。
これにより、1 つの animbp で各武器のアニメーション コンテンツを参照（つまりロード）することなく、複数の武器に同じロジックを再利用することができます。
各 "Anim Set" 変数の値を提供する子アニメーションブループリントの例については、 ABP_RifleAnimLayers を参照してください。

# 7

ABP_ItemAnimLayersBase > FullBody_IdleState

AnimBP ツアー #7

この animbp は、 AnimBP_Mannequin_Base の各状態に対応するレイヤーを実装しています。
レイヤーは 1 つのアニメーションを再生したり、ステートマシンのような複雑なロジックを含むことができます。

# 8

ABP_ItemAnimLayersBase > FullBody_StartState

AnimBP ツアー #8

Anim Node Functions の使用例です。
Anim Node Functions はアニメーションノードで実行できます。
ノードがアクティブなときだけ実行されるので、特定のノードやステートにロジックをローカライズすることができます。
この例では、 Anim Node Functions はノードが関連したときに再生するアニメーションを選択します。
また、別の Anim Node Function がアニメーションの再生レートを管理します。

# 9

ABP_ItemAnimLayersBase > UpdateStartAnim

AnimBP ツアー #9

これは距離マッチングを使用して、スタートアニメーションの移動距離とポーンの所有者の移動距離を一致させる例です。
これにより、アニメーションとモーションモデルを同期させることで、足の滑りを防止しています。
これは、「スタート」アニメーションの再生レートを効果的に制御します。
アニメーションの再生速度が遅すぎたり早すぎたりしないように、有効な再生速度を調整します。
有効再生速度が固定されている場合でも、スライドは見られます。
これを解決するには、後でストライドワーピングを使用して、残りの差を修正するためにポーズを調整します。
Distance Matching の機能を利用するには、 Animation Locomotion Library プラグインが必要です。

# 10

ABP_ItemAnimLayersBase > FullBody_StartState

AnimBP ツアー #10

ポーンの持ち主が実際に行っている動作に合わせて、アニメーションのオーサリングされたポーズをワーピングする例です。
Orientation Warping は、ポーンのオーナーが動いている方向に合わせて、ポーズの下半身を回転させます。
前方/後方/左側/右側の方向のみをオーサリングし、そのギャップを埋めるためにワーピングに頼っています。
オリエンテーション・ワーピングは、キャラクターがカメラの方向を向き続けるように、上半身を再調整します。
ストライド・ワーピングは、オーサリングされたアニメーションの速度が実際の速度と一致しない場合に、脚の歩幅を短くしたり長くしたりします。
これらのノードにアクセスするためには、 Animation Warping プラグインが必要です。
