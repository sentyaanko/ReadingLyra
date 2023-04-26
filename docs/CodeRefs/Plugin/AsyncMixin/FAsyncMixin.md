## FAsyncMixin

>> 詳細は未確認です。

> The FAsyncMixin allows easier management of async loading requests, to ensure linear request handling, to make writing code much easier.  
> The usage pattern is as follows,  
> 
> - First - inherit from FAsyncMixin, even if you're a UObject, you can also inherit from FAsyncMixin.
> - Then - you can make your async loads as follows.
> 	``` c++
> 	CancelAsyncLoading();			// Some objects get reused like in lists, so it's important to cancel anything you had pending doesn't complete.
> 	AsyncLoad(ItemOne, CallbackOne);
> 	AsyncLoad(ItemTwo, CallbackTwo);
> 	StartAsyncLoading();
> 	```
> 
> You can also include the 'this' scope safely, one of the benefits of the mix-in, is that none of the callbacks are ever out of scope of the host AsyncMixin derived object.  
> - e.g.
> 	```c++
> 	AsyncLoad(SomeSoftObjectPtr, [this, ...]() {
> 
> 	});
> 	``` 
> 
> What will happen is first we cancel any existing one(s), e.g. perhaps we are a widget that just got told to represent some new thing.  
> What will happen is we'll Load ItemOne and ItemTwo, *THEN* we'll call the callbacks in the order you requested the async loads - even if ItemOne or ItemTwo was already loaded when you request it.  
> 
> When all the async loading requests complete, OnFinishedLoading will be called.  
>  
> If you forget to call StartAsyncLoading(), we'll call it next frame, but you should remember to call it when you're done with your setup, as maybe everything is already loaded, and it will avoid a single frame of a loading indicator flash, which is annoying.  
>  
> * NOTE:
> 	* The FAsyncMixin also makes it safe to pass &#91;```this```&#93; as a captured input into your lambda, because it handles unhooking everything if either your owner class is destroyed, or you cancel everything.
> * NOTE: 
> 	* FAsyncMixin doesn't add any additional memory to your class.
> 	* Several classes currently handling async loading internally allocate TSharedPtr<FStreamableHandle> members and tend to hold onto SoftObjectPaths temporary state.
> 	* The FAsyncMixin does all of this internally with a static TMap so that all of the async request memory is stored temporarily and sparsely.
> * NOTE:
> 	* For debugging and understanding what's going on, you should add -LogCmds="LogAsyncMixin Verbose" to the command line.
> 
> ----
> 
> FAsyncMixin は、非同期ロード要求を簡単に管理し、線形な要求処理を保証し、コードをより簡単に書くことができるようにします。   
> 使用パターンは以下の通りです。  
> 
> - まず FAsyncMixin を継承します。UObject であっても FAsyncMixin を継承することができます。
> - そうすれば、以下のように非同期ロードを作ることができます。
> 	``` c++
> 	CancelAsyncLoading();			// リストのように再利用されるオブジェクトもあるので、保留にしていたものが完了しない場合はキャンセルすることが重要です。
> 	AsyncLoad(ItemOne, CallbackOne);
> 	AsyncLoad(ItemTwo, CallbackTwo);
> 	StartAsyncLoading();
> 	```
> また、 'this' スコープを安全に含めることができます。ミックスインの利点の1つは、どのコールバックもホスト AsyncMixin 派生オブジェクトのスコープ外にならないことです。  
> - e.g.
> 	```c++
> 	AsyncLoad(SomeSoftObjectPtr, [this, ...]() {
> 
> 	});
> 	``` 
> 
> 何が起こるかというと、まず、既存のものをキャンセルします。例えば、私たちは、新しいものを表現するように言われたウィジェットかもしれません。  
> 何が起こるかというと、 ItemOne と ItemTwo をロードし、 *その後* 、あなたが非同期ロードを要求した順番にコールバックを呼び出すのです - たとえ ItemOne や ItemTwo が要求したときにすでにロードされていたとしても。  
> 
> すべての非同期ロード要求が完了すると、 OnFinishedLoading が呼び出されます。  
>  
> StartAsyncLoading() を呼び忘れた場合、次のフレームで呼び出しますが、セットアップが完了したときに呼び出すことを覚えておくべきです。おそらくすべてがすでにロードされており、ロードインジケータのフラッシュが 1 フレームだけ発生するのを避けることができます。  
>  
> * 注意:
> 	* FAsyncMixin はまた、オーナークラスが破壊されたり、すべてをキャンセルした場合に、すべてのフックを解除する処理を行うため、ラムダへのキャプチャ入力として &#91;```this```&#93; を渡すことが安全になるようにします。
> * 注意:
> 	* FAsyncMixin はクラスにメモリを追加することはありません。
> 	* 現在非同期ロードを扱ういくつかのクラスは内部で TSharedPtr<FStreamableHandle> メンバーを割り当て、 SoftObjectPaths の一時状態を保持する傾向があります。
> 	* FAsyncMixin は内部で静的な TMap を使って、非同期リクエストのメモリを一時的にまばらに保存するようにします。
> * 注意:
> 	* デバッグや状況把握のためには、コマンドラインに -LogCmds="LogAsyncMixin Verbose" を追加することをお勧めします。

> TODO 
> I think we need to introduce a retention policy, preloads automatically stay in memory until canceled but what if you want to preload individual items just using the AsyncLoad functions?  
> I don't want to introduce individual policies per call, or introduce a whole set of preload vs asyncloads, so would would rather have a retention policy.  
> Should it be a member and actually create real memory when you inherit from AsyncMixin, or should it be a template argument?
> 
> ----
> TODO
> 保持ポリシーを導入する必要があると思います。プリロードはキャンセルされるまで自動的にメモリに残りますが、 AsyncLoad 関数を使うだけで個々のアイテムをプリロードしたい場合はどうすればいいでしょうか？
> 呼び出しごとに個別のポリシーを導入したり、プリロード対非同期ロードのセットを導入したりしたくないので、むしろ保持ポリシーを持つことをお勧めします。 
> AsyncMixin を継承する際にメンバーとして実際に実メモリを作成するべきか、それともテンプレートの引数として作成するべきか？


* 概要
	* 非同期ロードのコントロールを行うクラスです。
	* ミックスインし、各種関数を呼び出すことで機能を利用することを想定しています。
* Lyra での使われ方
	* [ULyraAccoladeHostWidget] の基底クラスです。

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->
[ULyraAccoladeHostWidget]: ../../Lyra/GameplayMessageAccolade/ULyraAccoladeHostWidget.md#ulyraaccoladehostwidget
