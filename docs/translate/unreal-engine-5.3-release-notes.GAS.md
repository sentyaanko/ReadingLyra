
以下から GAS 関連の項目のみピックアップして翻訳したもの。

https://docs.unrealengine.com/5.3/ja/unreal-engine-5.3-release-notes/

# Release Notes

## Runtime

### Bug Fix:

* Fixed issue when linking/unlinking anim layers from UGameplayAbility::EndAbility. 

-----

+ UGameplayAbility::EndAbility からアニメーションレイヤーをリンク／アンリンクする際の問題を修正しました。

## Gameplay

### API Change:

* It is now safe to call Super::ActivateAbility in a child class. Previously, it would call CommitAbility.
* Commands are prefixed with AbilitySystem.

-----

+ 子クラスで Super::ActivateAbility を安全に呼び出せるようになりました。以前は CommitAbility を呼び出していました。
+ コマンドの前には AbilitySystem が付きます。

### New:

* OnAvatarSet is now called on the primary instance instead of the CDO for instanced per Actor Gameplay Abilities.
* Allow both Activate Ability and Activate Ability From Event in the same Gameplay Ability Graph.
* GAS: Added a GameplayTagQuery field to FGameplayTagRequirements to enable more complex requirements to be specified.
* GAS: ModMagnitudeCalc wrapper functions have been declared const.
* GAS: Extended the functonality to execute and cancel Gameplay Abilities & Gameplay Effects from a console command.
* Added the ability to perform an "Audit" on Gameplay Ability Blueprints that will show information on how they're developed and intended to be used.
* Added support for properly replicating different types of FGameplayEffectContext.
* Updated FGameplayAttribute::PostSerialize to mark the contained attribute as a searchable name.
* FGameplayEffectContextHandle will now check if data is valid before retrieving "Actors".
* Retain rotation for Gameplay Ability System Target Data LocationInfo.
* Gameplay Ability System now stops searching for PC only if a valid PC is found.
* Updated GetAbilitySystemComponent to default parameter to Self.
* Marked functions as virtual in AbilityTask_WaitTargetData.

-----

+ アクターごとにインスタンス化されたゲームプレイアビリティについて、CDO ではなくプライマリインスタンスで OnAvatarSet が呼び出されるようになりました。
+ 同じ Gameplay Ability Graph で、 Activate Ability と Activate Ability From Event の両方を許可するようになりました。
+ GAS: より複雑な要件を指定できるように、 FGameplayTagRequirements に GameplayTagQuery フィールドを追加しました。
+ GAS: ModMagnitudeCalc ラッパー関数が const 宣言されました。
+ GAS: コンソールコマンドからゲームプレイアビリティとゲームプレイエフェクトを実行およびキャンセルする機能を拡張しました。
+ ゲームプレイアビリティブループリントの `Audit(監査)` を実行する機能が追加され、開発方法と使用目的に関する情報が表示されるようになりました。
+ 異なるタイプの FGameplayEffectContext を適切に複製するためのサポートを追加しました。
+ FGameplayAttribute::PostSerialize を更新し、含まれるアトリビュートを検索可能な名前としてマークするようにしました。
+ FGameplayEffectContextHandle が `Actors` を取得する前にデータが有効かどうかをチェックするようになりました。
+ Gameplay Ability System Target Data LocationInfo の回転を保持するようになりました。
+ 有効な PC が見つかった場合にのみ、Gameplay Ability System が PC の検索を停止するようになりました。
+ GetAbilitySystemComponent のデフォルトパラメータを Self に更新しました。
+ AbilityTask_WaitTargetData に仮想関数を追加しました。

### Improvement:


### Crash Fix:

* Fixed a crash caused by GlobalAbilityTaskCount when using Live Coding.
* Fixed UAbilityTask::OnDestroy to not crash if called recursively for cases like UAbilityTask_StartAbilityState.

-----

+ Live Coding を使用しているときに GlobalAbilityTaskCount によって引き起こされるクラッシュを修正しました。
+ UAbilityTask::OnDestroy が UAbilityTask_StartAbilityState のようなケースで再帰的に呼び出されてもクラッシュしないように修正しました。

### Bug Fix:

* GameplayAbilityWorldReticle now faces towards the source Actor instead of the TargetingActor.
* Cache trigger event data if it was passed in with GiveAbilityAndActivateOnce and the ability list was locked.
* Moved ShouldAbilityRespondToEvent from client-only code path to both server and client.
* Added some data validation for Combo Step Completion and Cancellation States to make sure at least one state is set.
* Fixed FAttributeSetInitterDiscreteLevels from not working in Cooked Builds due to Curve Simplification.
* Set CurrentEventData in GameplayAbility.
* Fixed ShouldAbilityRespondToEvent from not getting called on the instanced GameplayAbility.
* PostAttributeChange and AttributeValueChangeDelegates will now have the correct OldValue.
* Ensure that the UAbilitySystemGlobals::InitGlobalData is called if the Ability System is in use. Previously if the user did not call it, the Gameplay Ability System did not function correctly.

-----

+ GameplayAbilityWorldReticle が、TargetingActor ではなくソース Actor の方を向くようになりました。
+ GiveAbilityAndActivateOnce で渡され、アビリティリストがロックされていた場合に、トリガーイベントデータをキャッシュするようにしました。
+ ShouldAbilityRespondToEvent をクライアント専用のコードパスからサーバーとクライアントの両方に移動しました。
+ 少なくとも 1 つの状態が設定されていることを確認するために、コンボステップの完了とキャンセルの状態に対するデータ検証を追加しました。
+ FAttributeSetInitterDiscreteLevels が、 Curve Simplification のために Cooked Builds で機能しないのを修正しました。
+ GameplayAbility に CurrentEventData を設定しました。
+ インスタンス化された GameplayAbility で呼び出されなかった ShouldAbilityRespondToEvent を修正しました。
+ PostAttributeChange と AttributeValueChangeDelegate が正しい OldValue を持つようになりました。
+ アビリティシステムが使用されている場合に、 UAbilitySystemGlobals::InitGlobalData が呼び出されるようにしました。以前は、ユーザがこれを呼び出さなかった場合、ゲームプレイアビリティシステムは正しく機能しませんでした。

### Deprecated:

* Removed unused function FGameplayAbilityTargetData::AddTargetDataToGameplayCueParameters.
* Removed vestigial GameplayAbility::SetMovementSyncPoint

-----

+ 未使用の関数 FGameplayAbilityTargetData::AddTargetDataToGameplayCueParameters を削除しました。
+ 過去のものとなったGameplayAbility::SetMovementSyncPointを削除しました。

### Removed:

* Removed unused replication flag from Gameplay tasks & Ability system components
* Removed ensure when no combo actions are present. Logs a warning instead. 

-----

+ ゲームプレイタスクとアビリティシステムコンポーネントから、未使用の複製フラグを削除しました。
+ コンボ・アクションが存在しない場合の ensure を削除しました。代わりに警告を記録します。


# Upgrade Notes

## Framework

### Gameplay

#### Upgrade Notes:

* [Modular Gameplay Effects - Gameplay Ability System (GAS)] Moved some gameplay effect functionality into optional components. All existing content will automatically update to use components during PostCDOCompiled, if necessary. 

-----

+ [Modular Gameplay Effects - Gameplay Ability System (GAS)] いくつかのゲームプレイエフェクトの機能をオプションのコンポーネントに移動しました。既存のすべてのコンテンツは、必要に応じて、 PostCDOCompiled 時にコンポーネントを使用するように自動的に更新されます。


----
