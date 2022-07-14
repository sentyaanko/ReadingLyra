このファイルは個人的なメモです。  
主にドキュメント作成時の一時的な情報が置かれています。


```.powershell
# 以下のコマンドは CodeRefs 以下で実行すること。

# CodeRefs 以下の md ファイルから見出しを取得し、 HeadingID をファイルに出力する。
# HeadingIDsForCodeRefs.md は CodeRefs 以下のファイルで使用するためのもの。
# HeadingIDsForRoot.md は リポジトリのルート(CodeRefs フォルダが置かれているパス)で使用するためのもの。
Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';Write-Output "[$LinkName]: ../../$RelativePath#$Anchor" } | Out-File ..\tmp\HeadingIDsForCodeRefs.md -Encoding utf8
Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';Write-Output "[$LinkName]: CodeRefs/$RelativePath#$Anchor" } | Out-File ..\tmp\HeadingIDsForRoot.md -Encoding utf8

# CodeRefs 以下の .md ファイルの HeadingID の更新処理(2 steps)

# step1: md ファイルから <!--- CodeRefs ---> という文字列を探し、それより前の行までを .md.tmp ファイルに出力する
$myHeadingIDs=Get-Content ..\tmp\HeadingIDsForCodeRefs.md -Encoding UTF8;Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile=$myMdFilename + '.tmp';Set-Content $myTmpFile $myContent,$myHeadingIDs -Encoding UTF8} 

# step2: step1 で出力した .md.tmp ファイルを .md ファイルに上書きする(実際は .md ファイルを削除後にリネームしている)
Get-ChildItem -Recurse -include *.md.tmp | ForEach-Object{ $myDstFilename=$_.FullName.TrimEnd('.tmp');Remove-Item $myDstFilename;$_.MoveTo($myDstFilename) }






# /docs の md ファイルの h1 を検索して、出力する
#Get-ChildItem -include *.md -Exclude index.md | Select-String '^# ' -Encoding utf8 | ForEach-Object {$LinkName=$_.Line -replace '^# ','';$RelativePath=$_.RelativePath($PWD) -replace '\\','/';"[$LinkName]: $RelativePath"}

#Get-ChildItem *.md -Exclude index.md | Select-String '^# ' -Encoding utf8 | ForEach-Object {$LinkName=$_.Line -replace '^# ','';$RelativePath=$_.RelativePath($PWD) -replace '\\','/';"[$LinkName]: $RelativePath"}
#Get-ChildItem *.md -Exclude index.md | Get-Content -TotalCount 1 -Encoding utf8
#Get-ChildItem *.md -Exclude index.md | Get-Member
#Get-ChildItem *.md -Exclude index.md | ForEach-Object {$myHeading=Get-Content $_.FullName -TotalCount 1 -Encoding utf8;$myRelativePath=(Resolve-Path $_ -Relative) -replace '\\','/';"[$myHeading]: $myRelativePath"}

#'CONTOSO\Administrator' -replace '\w+\\(?<user>\w+)', 'FABRIKAM\${user}'
#'# 【UE5】Lyra に学ぶ Enhanced Input <!-- omit in toc -->' -replace '^# (?<header>.+) \<\!-- omit in toc --\>', '${header}'
#'# 【UE5】Lyra に学ぶ Enhanced Input <!-- omit in toc -->' -replace '^# (.+) \<\!-- omit in toc --\>', '$1'



	$myHeadingIDsFilename = "HeadingIDsForRoot.md"
	$myHeadingIDsFullName = "$PSScriptRoot\..\tmp\$myHeadingIDsFilename"
	$myHeadingIDsCodeRefs = [System.IO.File]::ReadAllText($myHeadingIDsFullName)
	$Lines=$myHeadingIDsCodeRefs -split "`n"
	foreach($Line in $Lines){
		if(($Line.Length -gt 0) -and !($Line.Contains("::"))){
			$HeadAndAnchor=$Line -split ': '
			$myHeading=$HeadAndAnchor[0]
			$myLists += "`t- $myHeading`n"
		}
	}



#$myArray = @()
#Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';$myArray += "[$LinkName]: ../../$RelativePath#$Anchor" }
#$myOut = $myArray -join "`n"
#[System.IO.File]::WriteAllLines("${PSScriptRoot}\..\tmp\HeadingIDsForCodeRefs.md", $myOut)

#Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';Write-Output "[$LinkName]: ../../$RelativePath#$Anchor`n" } | Out-File ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding utf8 -NoNewline
#Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';Write-Output "[$LinkName]: CodeRefs/$RelativePath#$Anchor`n" } | Out-File ..\..\src\tmp\HeadingIDsForRoot.md -Encoding utf8 -NoNewline

# 改行コードを LF に
#Get-ChildItem -Recurse -include *.md | ForEach-Object {$myMd=((Get-Content $_.FullName -Encoding UTF8) -join "`n")+"`n";[System.IO.File]::WriteAllText($_.FullName,$myMd)}



# step1: md ファイルから <!--- CodeRefs ---> という文字列を探し、それより前の行までを .md.tmp ファイルに出力する
# $HeadingIDs=Get-Content ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding UTF8;Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile=$myMdFilename + '.tmp';Set-Content $myTmpFile $myContent,$HeadingIDs -Encoding UTF8} 

# step2: step1 で出力した .md.tmp ファイルを .md ファイルに上書きする(実際は .md ファイルを削除後にリネームしている)
# Get-ChildItem -Recurse -include *.md.tmp | ForEach-Object{ $myDstFilename=$_.FullName.TrimEnd('.tmp');Remove-Item $myDstFilename;$_.MoveTo($myDstFilename) }

#Get-ChildItem -Recurse -include *.md | $myMd=Get-Content; Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->'
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName;$mySelect=Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->';ForEach-Object{$myEndLine=$_.LineNumber-1;$myContent=$myMd[0..$myEndLine];} -InputObject $mySelect}
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName;$mySelect=Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->';if($mySelect){Get-Member -InputObject $mySelect}}
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName;$mySelect=Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->';if($mySelect){$mySelect.Matches[-1].Index}}
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName;$mySelect=Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->';if($mySelect){Get-Member -InputObject $mySelect.Matches[-1]}}
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName -;$mySelect=Select-String -InputObject $myMd. -Pattern '<!--- CodeRefs --->';if($mySelect){$mySelect.LineNumber}}
##Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile="${PWD}\${myMdFilename}.tmp";$myAllContent= $myContent,$HeadingIDs;[System.IO.File]::WriteAllText($myTmpFile, $myAllContent);Get-Member -InputObject $myAllContent;Get-Member -InputObject $myContent;Get-Member -InputObject $HeadingIDs}
#$HeadingIDs=Get-Content ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding UTF8;Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile=$myMdFilename + '.tmp';$myAllContent= $myContent,$HeadingIDs;$PWD;$myTmpFile}

#Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile="${PWD}\${myMdFilename}.tmp";$myAllContent= $myContent,$HeadingIDs;[System.IO.File]::WriteAllText($myTmpFile, $myAllContent);Get-Member -InputObject $myAllContent;Get-Member -InputObject $myContent;Get-Member -InputObject $HeadingIDs}
#Get-ChildItem -Recurse -include *.md.tmp2 | ForEach-Object {$myMd=Get-Content $_.FullName; }
```


   TypeName: Microsoft.PowerShell.Commands.MatchInfo
Name         MemberType Definition
----         ---------- ----------
Equals       Method     bool Equals(System.Object obj)
GetHashCode  Method     int GetHashCode()
GetType      Method     type GetType()
RelativePath Method     string RelativePath(string directory)
ToString     Method     string ToString(), string ToString(string directory)
Filename     Property   string Filename {get;}
IgnoreCase   Property   bool IgnoreCase {get;set;}
Line         Property   string Line {get;set;}
LineNumber   Property   int LineNumber {get;set;}
Matches      Property   System.Text.RegularExpressions.Match[] Matches {get;set;}
Path         Property   string Path {get;set;}
Pattern      Property   string Pattern {get;set;}



* 解説しないこと
	* UE4 の頃から変わっていない部分の解説
		* GAS の基本的な部分は 4.27 の頃から変わっていない（はず）です。（2022/04/11 現在）
			* 多くのファイルに更新が入っているので全く同じというわけではないです。
		* もし GAS のことをよく知らないならば、以下を参照してください。
			* [【UE4】Gameplay Ability System を使い始めたい人向けの情報]
	* 個々のアビリティの実装詳細




#### ULyraHeroComponent からの呼び出しツリー

* InitializePlayerInput にて、アビリティ用の入力のバインドを行っている。
	* 具体的には LyraIC->BindAbilityActions の中で EnhancedInputComponent::BindAction の呼び出しを行っている。
	* [ULyraHeroComponent]```::Input_AbilityInputTagPressed``` / [ULyraHeroComponent]```::Input_AbilityInputTagReleased``` をバインドしている。
	* 関数内では ULyraAbilitySystemComponent::AbilityInputTagPressed / ULyraAbilitySystemComponent::AbilityInputTagReleased を呼び出している。
	* 関数内では ULyraAbilitySystemComponent::InputPressedSpecHandles / ULyraAbilitySystemComponent::InputReleasedSpecHandles に一旦バッファリングされる。
	* その後、 ALyraPlayerController::PostProcessInput から ULyraAbilitySystemComponent::ProcessAbilityInput が呼び出される。
	* そこで新たに Activate するアビリティがある場合は UAbilitySystemComponent::TryActivateAbility で試みる。
	* 起動済みのアビリティに対しては、 WaitInputPressed / WaitInputReleased が動作するようにように、 UAbilitySystemComponent::InvokeReplicatedEvent の呼び出しが行われている。
	* このあたりは UAbilitySystemComponent::AbilityLocalInputPressed で行っていたことを EnhancedInput 経由で行うために ULyraAbilitySystemComponent::ProcessAbilityInput で実装している形となる。
	* 入力にバインドされた関数の呼び出しタイミング
		* APlayerController::TickActor
			* APlayerController::TickPlayerInput
				* APlayerController::ProcessPlayerInput
					* [UEnhancedPlayerInput]::ProcessInputStack
						* UPlayerInput::ProcessInputStack
							* ALyraPlayerController::PreProcessInput
								* APlayerController::PreProcessInput
							* ALyraPlayerController::PostProcessInpu
								* APlayerController::PostProcessInput
						* [UEnhancedInputComponent]::GetActionEventBindings

* 各クラスの役割まとめ
	* [ULyraHeroComponent] (: ULyraPawnComponent (: UPawnComponent))
		* [ULyraHeroComponent]
			* InitializePlayerInput()
				* 入力イベントの初期化関数。
				* [ULyraInputComponent] を通じて、アビリティ用の入力関数へのバインドを行う。
			* Input_AbilityInputTagPressed()
				* アビリティ用の入力開始時の関数。
				* ULyraAbilitySystemComponent::AbilityInputTagPressed() を呼び出す。
			* AbilityInputTagReleased()
				* アビリティ用の入力終了時の関数。
				* ULyraAbilitySystemComponent::AbilityInputTagReleased() を呼び出す。
	* [ULyraInputComponent] (: [UEnhancedInputComponent] (: UInputComponent))
		* [ULyraInputComponent]
			* 仮想関数のオーバーライドなどは行っていない。
			* [FLoadedMappableConfigPair] や [ULyraInputConfig] の情報を基底クラス側に設定するためのクラス。
		* [UEnhancedInputComponent]
			* EnhancedActionEventBindings
				* バインドされたイベント配列。
	* [UEnhancedPlayerInput] (: UPlayerInput)
		* [UEnhancedPlayerInput]
			* ProcessInputStack()
				* override 元の関数を呼び出す。
				* EnhancedInputComponent::EnhancedActionEventBindings のイテレーション処理を行う。
		* UPlayerInput
			* ProcessInputStack()
				* APlayerController の具象クラス ALyraPlayerController の PreProcessInput() を呼び出す。
				* APlayerController の具象クラス ALyraPlayerController の PostProcessInput() を呼び出す。
	* ALyraPlayerController (: ACommonPlayerController (: AModularPlayerController (: APlayerController (: AController))))
		* ALyraPlayerController
			* PostProcessInput()
				* ULyraAbilitySystemComponent::ProcessAbilityInput() を呼び出す
		* APlayerController
			* TickActor()
				* Tick 関数。
				* TickPlayerInput() を呼び出す。
			* TickPlayerInput()
				* ProcessPlayerInput() を呼び出す。
			* ProcessPlayerInput()
				* UPlayerInput の具象クラス [UEnhancedPlayerInput] の ProcessInputStack() を呼び出す。
	* ULyraAbilitySystemComponent (: UAbilitySystemComponent)
		* ULyraAbilitySystemComponent
			* AbilityInputTagPressed()
				* 入力開始があった時に呼び出され、対応するイベントハンドルを InputPressedSpecHandles に一時保存する
			* AbilityInputTagReleased()
				* 入力終了があった時に呼び出され、対応するイベントハンドルを InputReleasedSpecHandles に一時保存する
			* ProcessAbilityInput
				* バッファリングされていた InputPressedSpecHandles / InputReleasedSpecHandles のイテレーション処理を行う
					* Activate する場合は UAbilitySystemComponent::TryActivateAbility() を通じて行う。
					* すでに Activate している場合は WaitInputPressed / WaitInputReleased AbilityTask か動作するように、UAbilitySystemComponent::InvokeReplicatedEvent を呼び出す。
			* InputPressedSpecHandles / InputReleasedSpecHandles
				* ハンドルの配列。
				* 入力イベントが発生した際に一度こちらにバッファリングし、後でまとめてイベント処理される。
				* コンフィグにて、複数のボタンに同じ機能を割り当てられるようにしている。
				* バッファリングは、ボタンの同時押し対策になる。





# Gameplay Ability のアクティブ化方法

* `Detail > Triggers > Ability Triggers > Trigger Tag` で `Trigger Source` に `Gameplay Event` を指定しておく。
	* Gameplay Event によるアクティブ化。
	* アビリティの付与時に際に指定された `Trigger Tag` の付与状況を監視するようになる。
	* `Trigger Tag` が付与された際に `UAbilitySystemComponent::MonitoredTagChanged()`  経由で `UAbilitySystemComponent::InternalTryActivateAbility()` が呼び出され、アクティブ化が試みられる。
	* これは BehaviorTree などからアビリティを起動する際などに利用できる。
		* 例： `BTS_Shoot` にて `GA_Weapon_Fire` をアクティブ化するために `Send Gameplay Event to Actor` で `InputTag.Weapon.Fire` を指定する。
* `ULyraAbilitySet` 経由。
	* `ULyraAbilitySystemComponent` が自前で行っているアクティブ化方法。
	* `ULyraAbilitySet` 経由で付与する場合、 InputTag が `FGameplayAbilitySpec::DynamicAbilityTags` に設定される。
	* InputAction 発生時に、バインドされた InputTag をキーを受け取り、付与されているアビリティから `FGameplayAbilitySpec::DynamicAbilityTags` に InputTag が含むものを探す。
	* 見つかったら `UAbilitySystemComponent::TryActivateAbility()` が呼び出され、アクティブ化が試みられる。
	* InputTag については Actor に付与されるわけではない。


* `GameplayEventData` の基礎
	* `GameplayEventData` を受け取る主な２つの方法
		* `ActivateAbilityFromEvent` イベントを利用し、アクティブ時に受け取る
			* `Ability Triggers` で `GameplayEvent` を指定し、かつ `GameplayEventData` を渡しつつアクティブ化したい場合はこれを使う。
			* その際、 `ActivateAbility` がイベントグフラに存在するとこちらが呼ばれてしまうので、削除する必要がある。
		* `Wait Gameplay Event` ノード経由で受け取る
			* `OnSpawn` を利用するなど、予めアクティブ化しておき、 `Wait Gameplay Event` ノードを利用してイベント発生時のデリゲートで受け取る。
* `ActivateAbility` / `ActivateAbilityFromEvent` ノードの使用状況
	* `GA_Interaction_Collect` のみ `ActivateAbilityFromEvent` を使用している
	* それ以外は `Ability Triggers` を指定しているケースでも `ActivateAbility` を使用している。




* `GA_QuickbarSlots` との関係
	* `Class Defaults > detail` を確認すると、以下のように設定されている。
		* `Lyra > Ability Activation > Activation Policy` を `On Spawn`
			* スポーン時に付与
		* `Lyra > Ability Activation > Activation Group` を `Independent`
			* 他のアビリティとは独立して動作
	* また `EndAbility` を呼び出していない。
	* つまり、スポーン時にアクティブ化し、他のアビリティの干渉を受けず、常にアクティブ状態です。
		* TODO: Lyra の Gameplay Ability 基底クラスに関して要確認。











# 擬似コード

関連部分を抽出した疑似コードです。  

* ```#Tick``` で Tick 処理の関数の呼び出し階層を追いかけられます。
* ```#InitializeInputAction``` で [UInputAction] の初期化処理の関数の呼び出し階層を追いかけられます。

```c++
// Engine Core 関連 begin{

class APlayerController
{
	TickActor()
	{
		//#Tick-1
		TickPlayerInput();
	}
	TickPlayerInput()
	{
		//#Tick-2
		ProcessPlayerInput();
	}
	ProcessPlayerInput()
	{
		//#Tick-3
		//PlayerInput は UEnhancedPlayerInput
		PlayerInput->ProcessInputStack();
	}
	PreProcessInput()
	{
		//#Tick-8
	}
	PostProcessInput()
	{
		//#Tick-10
	}
};

class UInputComponent
{
};

class UPlayerInput
{
	ProcessInputStack()
	{
		//#Tick-5
		//PlayerController は ALyraPlayerController
		PlayerController->PreProcessInput();
		PlayerController->PostProcessInput();
	}
};

// Engine Core 関連 end}

// AbilitySystemPlugin 関連 begin{
class UAbilitySystemComponent
{
	AbilitySpecInputPressed()
	{
		//#Tick-13
		//> Called on local player always. 
		//> Called on server only if bReplicateInputDirectly is set on the GameplayAbility.
		//> 常にローカル プレーヤーで呼び出されます。
		//> GameplayAbilityにbReplicateInputDirectlyが設定されている場合のみ、サーバーで呼び出される。
	}
	AbilitySpecInputReleased()
	{
		//#Tick-15
		//> Called on local player always. 
		//> Called on server only if bReplicateInputDirectly is set on the GameplayAbility.
		//> 常にローカル プレーヤーで呼び出されます。
		//> GameplayAbilityにbReplicateInputDirectlyが設定されている場合のみ、サーバーで呼び出される。
	}
};

// AbilitySystemPlugin 関連 end}

// Enhanced Input 関連 begin{
class UEnhancedInputComponent : public UInputComponent
{
	GetActionEventBindings()
	{
		return EnhancedActionEventBindings;
	}
	BindHandles()
	{
		//#InitializeInputAction-3
		EnhancedActionEventBindings.Add();
	}
	//> The collection of action bindings.
	//> アクションバインディングのコレクション。
	TArray<TUniquePtr<FEnhancedInputActionEventBinding>> EnhancedActionEventBindings;
};

class UEnhancedPlayerInput : public UPlayerInput
{
	ProcessInputStack()override
	{
		//#Tick-4
		Super::ProcessInputStack();
		for( auto it : UEnhancedInputComponent::GetActionEventBindings())
		{
			//Execute の中身は Input_AbilityInputTagPressed/Input_AbilityInputTagReleased
			it->Execute();
		}
	}
};

// Enhanced Input 関連 end}

// Lyra 関連 begin}

class ULyraInputComponent : public UEnhancedInputComponent
{
	BindAbilityActions(AbilityInputActions, PressedFunc, ReleasedFunc)
	{
		//#InitializeInputAction-2
		for(auto it : AbilityInputActions)
		{
			BindHandles(it->InputAction, Triggered, PressedFunc, it->InputTag);
			BindHandles(it->InputAction, Completed, ReleasedFunc, it->InputTag);
		}
	}
};

class ALyraPlayerController : public APlayerController
{
	PreProcessInput()override
	{
		//#Tick-7
		Super::PreProcessInput();
	}
	PostProcessInput()override
	{
		//#Tick-9
		Super::PostProcessInput();
		ULyraAbilitySystemComponent::ProcessAbilityInput();
	}
};

class ULyraAbilitySystemComponent : public UAbilitySystemComponent
{
	ProcessAbilityInput()
	{
		//#Tick-11
		for( auto it : InputHeldSpecHandles)
		{
			if(/*アクティブ化の条件をみたす場合*/)
			{
				AbilitiesToActivate.AddUnique(it);
			}
		}
		for( auto it : InputPressedSpecHandles)
		{
			if(/*すでにアクティブ化している場合、 WaitInputPress AbilityTask を動作させるための処理を行う*/)
			{
				AbilitySpecInputPressed(it);
			}
			if(/*アクティブ化の条件をみたす場合*/)
			{
				AbilitiesToActivate.AddUnique(it);
			}
		}
		for (auto it : AbilitiesToActivate)
		{
			TryActivateAbility(it);
		}
		for( auto it : InputReleasedSpecHandles)
		{
			if(/*すでにアクティブ化している場合、 WaitInputRelease AbilityTask を動作させるための処理を行う*/)
			{
				AbilitySpecInputReleased(it);
			}
		}
	}
	AbilityInputTagPressed()
	{
		InputPressedSpecHandles.AddUnique(AbilitySpec.Handle);
		InputHeldSpecHandles.AddUnique(AbilitySpec.Handle);
	}
	AbilityInputTagReleased()
	{
		InputReleasedSpecHandles.AddUnique(AbilitySpec.Handle);
		InputHeldSpecHandles.Remove(AbilitySpec.Handle);
	}
	AbilitySpecInputPressed()override
	{
		//#Tick-12
		//> We don't support UGameplayAbility::bReplicateInputDirectly.
		//> Use replicated events instead so that the WaitInputPress ability task works.
		//> UGameplayAbility::bReplicateInputDirectly をサポートしていません。
		//> WaitInputPress AbilityTask が動作するように、代わりに複製されたイベントを使用します。
		Super::AbilitySpecInputPressed();

		if(active)
		{
			//> Invoke the InputPressed event. 
			//> This is not replicated here. 
			//> If someone is listening, they may replicate the InputPressed event to the server.
			//> InputPressed イベントを呼び出します。
			//> ここではレプリケートされません。
			//> 誰かがリスニングしている場合、InputPressedイベントをサーバーにレプリケートすることがあります。
			InvokeReplicatedEvent(EAbilityGenericReplicatedEvent::InputPressed, Spec.Handle, Spec.ActivationInfo.GetActivationPredictionKey());
		}
	}
	AbilitySpecInputReleased()override
	{
		//#Tick-14
		//> We don't support UGameplayAbility::bReplicateInputDirectly.
		//> Use replicated events instead so that the WaitInputRelease ability task works.
		//> UGameplayAbility::bReplicateInputDirectly をサポートしていません。
		//> WaitInputRelease AbilityTask が動作するように、代わりに複製されたイベントを使用します。
		Super::AbilitySpecInputPressed();

		if(active)
		{
			//> Invoke the InputReleased event.
			//> This is not replicated here. 
			//> If someone is listening, they may replicate the InputReleased event to the server.
			//> InputReleased イベントを呼び出します。
			//> ここではレプリケートされません。
			//> 誰かがリスニングしている場合、InputReleasedイベントをサーバーにレプリケートすることがあります。
			InvokeReplicatedEvent(EAbilityGenericReplicatedEvent::InputPressed, Spec.Handle, Spec.ActivationInfo.GetActivationPredictionKey());
		}
	}
	//> Handles to abilities that had their input pressed this frame.
	//> このフレームで入力が押されたアビリティへのハンドル。
	TArray<FGameplayAbilitySpecHandle> InputPressedSpecHandles;

	//> Handles to abilities that had their input released this frame.
	//> このフレームで入力が放されたアビリティへのハンドル。
	TArray<FGameplayAbilitySpecHandle> InputReleasedSpecHandles;

	//> Handles to abilities that have their input held.
	//> 入力が保持されているアビリティへのハンドル。
	TArray<FGameplayAbilitySpecHandle> InputHeldSpecHandles;
};

class ULyraHeroComponent : public ULyraPawnComponent
{
	InitializePlayerInput()
	{
		//#InitializeInputAction-1
		ULyraInputComponent::BindAbilityActions(InputConfig, &Input_AbilityInputTagPressed, &Input_AbilityInputTagReleased);
	}
	Input_AbilityInputTagPressed()
	{
		//#Tick-6
		ULyraAbilitySystemComponent::AbilityInputTagPressed();
	}
	Input_AbilityInputTagReleased()
	{
		//#Tick-6
		ULyraAbilitySystemComponent::AbilityInputTagReleased();
	}
};

ここから
足りない者追加していく。

// Lyra 関連 end}

```

* InputData_Arena
	* NativeInputActions
		* IA_Move
	* AbilityInputActions
		* IA_Weapon_Fire
* InputData_Hero
	* NativeInputActions
		* IA_Move
		* IA_Look_Mouse
		* IA_Look_Stick
		* IA_Crouch
		* IA_AutoRun
	* AbilityInputActions
		* IA_Jump
		* IA_Weapon_Reload
		* IA_Ability_Heal
		* IA_Ability_Death
		* IA_Weapon_Fire
		* IA_Weapon_Fire_Auto
* InputData_SimplePawn
	* NativeInputActions
		* IA_Move
		* IA_Look_Mouse
		* IA_Look_Stick
		* IA_Crouch
		* IA_AutoRun
	* AbilityInputActions
		* IA_Jump



* InputData_InventoryTest
	* LAS_InventoryTest
		* B_TestInventoryExperience
			* L_InventoryTestMap
* InputData_ShooterGame_AddOns
	* LAS_ShooterGame_SharedInput
		* B_ShooterGame_Elimination
			* L_ShooterGym
			* L_Expanse
			* L_Expanse_Blockout
			* L_FiringRange_WP
		* B_LyraShooterGame_ControlPoints
			* L_Convolution_Blockout
		* B_TestInventoryExperience
			* L_InventoryTestMap



* InputData_InventoryTest
	* NativeInputActions
	* AbilityInputActions
		* IA_Interact
		* IA_ToggleMap
		* IA_ToggleInventory
		* IA_ToggleMarkerInWorld
		* IA_Emote
* InputData_ShooterGame_AddOns
	* NativeInputActions
	* AbilityInputActions
		* IA_ShowScoreboard
		* IA_ADS
		* IA_Grenade
		* IA_Emote
		* IA_DropWeapon
		* IA_Melee


## Lyra における入力アクションにバインドされるた関数から Gameplay Ability の呼び出し

* 以下の関数内で、自身に付与されている Gameplay Ability から引数で渡された ```InputTag``` を持つアビリティを探し出してアクティブ化を行います。
	* ```ULyraHeroComponent::Input_AbilityInputTagPressed()```
	* ```ULyraHeroComponent::Input_AbilityInputTagReleased()``` 
* アビリティの付与方法についての解説はこのドキュメントでは割愛します。





* アビリティを付与する方法は３種類。
	* [ULyraPawnData] の [ULyraAbilitySet] の配列 の設定することで、 [ULyraPawnData] からポーンを構築する際に付与する。
		* [ALyraPlayerState]```::SetPawnData()``` 内で [ULyraAbilitySet]```::GiveToAbilitySystem()``` を呼び出している。
	* [ULyraEquipmentDefinition] の [ULyraAbilitySet] の配列 の設定することで、 [ULyraEquipmentDefinition] に関連付けられた武器を装備した際に付与する。
		* [FLyraEquipmentList]```::AddEntry()``` 内で [ULyraAbilitySet]```::GiveToAbilitySystem()``` を呼び出している。
	* [UGameFeatureData] の [UGameFeatureAction] の配列を設定することで、 Game Feature がアクティブになった際に付与する。
		* [UGameFeatureAction_AddAbilities]```::AddActorAbilities()``` 内で [ULyraAbilitySet]```::GiveToAbilitySystem()``` を呼び出している。

* [ULyraAbilitySet]```::GiveToAbilitySystem()``` で ```UAbilitySystemComponent::GiveAbility()``` を呼び出すことで行う。
* ```FGameplayAbilitySpec``` を構築時、 ```FGameplayAbilitySpec::DynamicAbilityTags``` に ```FLyraAbilitySet_GameplayAbility::InputTag``` を ```AddTag()``` している。
	* そうすることで、入力アクションの際には ```InputTag``` が渡されるので、自身に付与されている Gameplay Ability の配列の内で ```DynamicAbilityTags.HasTagExact(InputTag)``` が true を返す物を探すことで関連付けている。

TODO: 見直してまとめる。
TODO:2022/5/6 このへんから














# クラスの解説（ Enhanced Input Plugin ）

ドキュメントで出てきたクラスの解説。  
基本的にヘッダの説明とその訳を載せているだけです。  

## UInputAction

> Input action definition. These are instanced per player (via FInputActionInstance)
> 入力アクションの定義です。 これらはプレーヤーごとにインスタンス化されます（FInputActionInstanceを介して）

## UInputMappingContext

> A collection of key to action mappings for a specific input context
> Could be used to:
> Store predefined controller mappings (allow switching between controller config variants). 
> TODO: Build a system allowing redirects of UInputMappingContexts to handle this.
> Define per-vehicle control mappings
> Define context specific mappings (e.g. I switch from a gun (shoot action) to a grappling hook (reel in, reel out, disconnect actions).
> Define overlay mappings to be applied on top of existing control mappings (e.g. Hero specific action mappings in a MOBA)
> 特定の入力コンテキストのキーからアクションへのマッピングのコレクション
> 次の目的で使用できます：
> 事前定義されたコントローラーマッピングを保存します（コントローラーコンフィグバリアント間の切り替えを許可します）。
> TODO： UInputMappingContexts のリダイレクトがこれを処理できるようにするシステムを構築します。
> 車両ごとの制御マッピングを定義する
> コンテキスト固有のマッピングを定義します（たとえば、銃（シュートアクション）からグラップリングフック（リールイン、リールアウト、切断アクション）に切り替えます）。
> 既存のコントロールマッピングの上に適用されるオーバーレイマッピングを定義します（例： MOBA のヒーロー固有のアクションマッピング）

* 適用単位毎に用意している。
* 命名規則は ```IMC_``` で始まる。

| アセット名              | 用途                                                                                   |
|-------------------------|----------------------------------------------------------------------------------------|
| IMC_Default_Gamepad     | デフォルトのキーボードマウス設定                                                       |
| IMC_Default_KBM         | デフォルトのキーボードマウス設定                                                       |
| IMC_ShooterGame_Gamepad | シューターゲームのゲームパッド設定                                                     |
| IMC_ShooterGame_KBM     | シューターゲームのキーボードマウス設定                                                 |
| IMC_ADS_Speed           | ADS の際のマウスとゲームパッドの入力設定を上書きするための設定。設定内容の解説は割愛。 |
| IMC_InventoryTest       | インベントリ操作用の設定？解説は割愛。                                                 |


## UInputTrigger

エンジン側で用意されている [UInputTrigger] 派生クラスは以下の通り。

| 表示名           | クラス名                    | 概要                                                                                                                       |
|------------------|-----------------------------|----------------------------------------------------------------------------------------------------------------------------|
| Down             | UInputTriggerDown           | 入力が作動閾値を超えるとトリガーがかかります。                                                                             |
| Pressed          | UInputTriggerPressed        | 入力が作動閾値を超えたときに1回だけトリガがかかります。 <br> 入力を維持すると、それ以上トリガはかかりません。              |
| Released         | UInputTriggerReleased       | 入力が作動閾値を超える間、トリガは継続的に復帰します。 <br> 入力が作動閾値を下回ると1度だけトリガがかかります。            |
| Hold             | UInputTriggerHold           | 入力が HoldTimeThreshold 秒間し続けると、トリガがかかります。 <br> トリガは1回だけ、または繰り返し起動させることができる。 |
| Hold And Release | UInputTriggerHoldAndRelease | 入力が少なくとも HoldTimeThreshold 秒以上し続けた後、  <br>  入力が解放されたときにトリガがかかります。                    |
| Tap              | UInputTriggerTap            | 入力が作動した後、 TapReleaseTimeThreshold 秒以内に解放されないとトリガーしません。                                        |
| Pulse            | UInputTriggerPulse          | 入力が作動している間、秒単位のインターバルで発火するトリガー。                                                             |
| Chorded Action   | UInputTriggerChordAction    | このトリガーのアクションがトリガーされるために必要なコードアクションを適用します。                                         |

Lyra 側で用意されている [UInputTrigger] 派生クラスは以下の通り。

| 表示名           | クラス名                    | 概要                                                                                                                       |
|------------------|-----------------------------|----------------------------------------------------------------------------------------------------------------------------|
| Combo Action     | UInputTriggerComboAction    | すべての従属アクションが順番にトリガーされたときにトリガーされます。                                                       |


## UInputModifier

エンジン側で用意されている [UInputModifier] 派生クラスは以下の通り。

| 表示名                         | クラス名                                   | 概要                                                                                                                                     |
|--------------------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| Dead Zone                      | UInputModifierDeadZone                     | LowerThreshold -> UpperThreshold の範囲内の入力値は、 <br> 0 -> 1にリマップされます。この範囲外の値はクランプされます。                  |
| Scalar                         | UInputModifierScalar                       | 軸毎に設定された倍率で入力を拡大縮小します。                                                                                             |
| Negate                         | UInputModifierNegate                       | 軸毎に入力を反転させます。                                                                                                               |
| Smooth                         | UInputModifierSmooth                       | 複数のフレームに渡って入力を滑らかにします。                                                                                             |
| Response Curve - Exponential   | UInputModifierResponseCurveExponential     | 入力値に対して、軸毎に単純な指数応答カーブを適用します。                                                                                 |
| Response Curve - User Defined  | UInputModifierResponseCurveUser            | 入力値に対して、軸毎にカスタム応答カーブを適用します。                                                                                   |
| FOV Scaling                    | UInputModifierFOVScaling                   | 入力値に対して、軸毎にFOV依存のスケーリングを適用します。                                                                                |
| To World Space                 | UInputModifierToWorldSpace                 | 入力されたアクションバリュー内の軸をワールド空間に自動変換し、 <br> ワールド空間の値を取る関数に結果を直接プラグインできるようにします。 |
| Swizzle Input Axis Values      | UInputModifierSwizzleAxis                  | 入力値の軸成分をスウィズルする。 <br> 1次元の入力を2次元のアクションのY軸にマッピングするのに便利です。                                  |
| Modifier Collection            | UInputModifierCollection                   | 複数のアクションやマッピングに簡単に適用でき、 <br> 重複作業を省くことができるユーザー定義可能なモディファイアのグループです。           |

Lyra 側で用意されている [UInputModifier] 派生クラスは以下の通り。

| 表示名                         | クラス名                                   | 概要                                                                                                                                     |
|--------------------------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| Aim Assist Input Modifier      | UAimAssistInputModifier                    | ゲームパッドプレイヤーがより良いターゲティングができるようにするための <br> 入力モディファイアです。                                     |
| Setting Based Scalar           | ULyraSettingBasedScalar                    | SharedUserSettings の double プロパティに基づき、 <br> 入力をスケーリングします。                                                        |
| Lyra Settings Driven Dead Zone | ULyraInputModifierDeadZone                 | これはデッドゾーン入力修正で、 <br> Lyra Shared game settings にあるものが閾値となります。                                               |
| Lyra Gamepad Sensitivity       | ULyraInputModifierGamepadSensitivity       | Lyra Shared game settings の現在のゲームパッド設定に基づく <br> スカラーモディファイアを適用します。                                     |
| Lyra Aim Inversion Setting     | ULyraInputModifierAimInversion             | Lyra Shared game settings の設定に基づく、 <br> 軸値の反転を適用します。                                                                 |


## UEnhancedInputComponent

> An Enhanced Input Component is a transient component that enables an Actor to bind enhanced actions to delegate functions, or monitor those actions.
> Input components are processed from a stack managed by the PlayerController and processed by the PlayerInput.
> These bindings will not consume input events, but this behaviour can be replicated using UInputMappingContext::Priority.
> Enhanced Input Component は、Actor が拡張アクションをデリゲート関数にバインドしたり、それらの アクションを監視したりできるようにするための一時的なコンポーネントです。
> 入力コンポーネントは、PlayerController が管理するスタックから、PlayerInput によって処理されます。
> これらのバインディングは入力イベントを消費しませんが、この動作は UInputMappingContext::Priority を使用して複製することができます。

## UEnhancedPlayerInput

> UPlayerInput extensions for enhanced player input system
> 拡張プレイヤー入力システムのための UPlayerInput エクステンションです。

## UEnhancedInputLocalPlayerSubsystem

> Per local player input subsystem
> ローカルプレーヤー毎の入力サブシステム

* ```ULocalPlayer::GetSubsystem<UEnhancedInputLocalPlayerSubsystem>()``` によって取得可能。
* [UInputMappingContext] の登録の際にも利用する。



## UPlayerMappableInputConfig

> This represents one set of Player Mappable controller/keymappings. 
> You can use this input config to create the default mappings for your player to start with in your game. 
> It provides an easy way to get only the player mappable key actions, and it can be used to add multiple UInputMappingContext's at once to the player.
> Populate this data asset with Input Mapping Contexts that have player bindable actions in them. 
> これは、プレイヤーにマップ可能な コントローラ/キーマッピングの1セットを表します。
> この入力設定を使用して、ゲーム内でプレーヤーを開始するためのデフォルトのマッピングを作成することができます。
> また、複数の UInputMappingContext をプレーヤに一度に追加することもできます。
> このデータ アセットに、プレーヤのバインド可能なアクションを持つ Input Mapping Contexts を入力します。

* [UInputMappingContext] を保持するデータアセット。
* 操作方法単位で用意している。
* 命名規則は ```PMI_``` で始まる。

| アセット名                       | 用途                                               |
|----------------------------------|----------------------------------------------------|
| PMI_Default_Gamepad              | デフォルトのゲームパッド設定                       |
| PMI_Default_KBM                  | デフォルトのキーボードマウス設定                   |
| PMI_ShooterDefaultConfig_Gamepad | シューターゲームのデフォルトのゲームパッド設定     |
| PMI_ShooterDefaultConfig_KBM     | シューターゲームのデフォルトのキーボードマウス設定 |

## UGameFeatureData

> Data related to a game feature, a collection of code and content that adds a separable discrete feature to the game
> Game Feature に関連するデータで、ゲームに分離可能な個別の機能を追加するコードとコンテンツのコレクションです。

* データアセット。
* ```Actions``` に [UGameFeatureAction] の配列を保持する。

| アセット名                       | 用途                                               |
|----------------------------------|----------------------------------------------------|
| ShooterCore                      |  |
| ShooterMaps                      |  |
| TopDownArena                     |  |

* ShooterMaps について
	* BakedGeneratedMeshActor の変数 ```Plugin Name``` にて ```ShooterMaps``` が使用されている。
	* 加工可能なメッシュの保存先として利用されている？
		* 取り急ぎ EnhancedInput とは無関係のようなので置いておく。



## UGameFeatureAction

> Represents an action to be taken when a game feature is activated
> Game Feature がアクティブになったときに実行されるアクションを表します。

* Game Feature がアクティブになった際に何かを実行するための基底クラス。
* [UGameFeatureData] にこの派生クラスを指定します。


# クラスの解説（ Lyra ）

<!--- 主要クラス --->


## ULyraInputComponent

> Component used to manage input mappings and bindings using an input config data asset.  
> 入力設定データアセットを使用して、入力マッピングおよびバインディングを管理するために使用されるコンポーネントです。

* [UEnhancedInputComponent] の派生クラス。
* 仮想関数のオーバーライドなどは行っておらず、 [FLoadedMappableConfigPair] や [ULyraInputConfig] の情報を基底クラス側に設定するためのクラス。

> note:
> ULyraInputComponent::RemoveInputConfig での AddPlayerMappableConfig の呼び出しは RemovePlayerMappableConfig の間違いのように見える。


<!--- ポーン設定関連 --->

## ULyraPawnData

> Non-mutable data asset that contains properties used to define a pawn.
> ポーンを定義するために使用されるプロパティを含む、変更不可のデータアセットです。

* プレイヤー用ポーンの設定を定義するデータアセット。
* ```AbilitySets``` に [ULyraAbilitySet] の配列を保持する。
	* ポーンにデフォルトのアビリティを付与したい場合はここの設定を利用する。
* ```InputConfig``` に [ULyraInputConfig] を保持する。
	* ポーンにデフォルトの [UInputAction] と ```InputTag``` の設定を追加したい場合はここの設定を利用する。
* プレイヤー用ポーンの設定が記述されているデータアセットです。
* 利用するポーンクラス/[ULyraAbilityTagRelationshipMapping]/[ULyraInputConfig]/ULyraCameraMode 等を設定できます。

| アセット名                         | 用途                                                          |
|------------------------------------|---------------------------------------------------------------|
| DefaultPawnData_EmptyPawn          | DefaultGame.ini で指定されている、 ULyraAssetManager::DefaultPawnData の初期値。 [ULyraExperienceDefinition]```::DefaultPawnData``` が設定されていない場合に利用される。 |
| HeroData_Arena                     | B_TopDownArenaExperience で指定されている。 Exploader で使用される。 |
| HeroData_ShooterGame               | B_ShooterGame_Elimination/B_LyraShooterGame_ControlPoints/B_TestInventoryExperience  で指定されている。 Elimination/Control 等で使用される。 |
| ShootingTarget_PawnData            | 参照されていない。テスト用データと思われる。　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 |
| SimplePawnData                     | B_LyraDefaultExperience で指定されている。 デフォルトで使用される。 |


<!--- 入力設定関連 --->

## ULyraInputConfig

* 適用単位ごとに用意する、入力アクションの設定を定義するクラス。
* ```NativeInputActions```/```AbilityInputActions``` に [FLyraInputAction] の配列を保持しています。
	* ```NativeInputActions```
		* 固定の処理が実装されているアクション。
			* Move/Look_Mouse/Look_Stick/Crouch/AutoRun
		* それぞれの専用関数に直接バインドされ、それぞれの処理を行っている。
	* ```AbilityInputActions```
		* Gameplay Ability として実装されているアクション。
			* Jump 、その他のアクション。
		* アビリティ用の汎用関数にバインドされ、 ```InputTag``` を元に付与されている Gameplay Ability を検索してアクティブ化する。
* 適用単位毎に ```InputData_``` で始まるデータアセットを作成する。

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

## FLyraInputAction

* [UInputAction] と ```InputTag``` (```FGameplayTag```) のペアを持ちます。
* [ULyraInputConfig] のメンバ用の構造体であり、実体は [ULyraInputConfig] のデータアセットで定義する。


## FMappableConfigPair

> A container to organize potentially unloaded player mappable configs to their CommonUI input type
> ロードされていない可能性のあるプレーヤーにマップ可能な設定を、CommonUI入力タイプに整理するためのコンテナです。

* 入力マッピング情報を保持します。
* ```Config``` に [UPlayerMappableInputConfig] を保持しています。


<!--- Game Feature 関連 --->

## UGameFeatureAction_AddAbilities

> GameFeatureAction responsible for granting abilities (and attributes) to actors of a specified type.
> 指定されたタイプのアクターに GameplayAbility（と Attribute ）を付与する責任を持つ GameFeatureAction 。

* Game Feature がアクティブになった際に付与するアビリティ情報を保持する。
* [UGameFeatureAction] の派生クラス。
* FGameFeatureAbilitiesEntry の配列を保持する。
* Game Feature がアクティブになった際に付与するアビリティはここの設定を利用する。

## FGameFeatureAbilitiesEntry

* Gameplay Ability を付与するために [UGameFeatureAction_AddAbilities] が使用するデータです。
* [ULyraAbilitySet] の配列を保持する。


## UGameFeatureAction_AddInputConfig

> Registers a Player Mappable Input config to the Game User Settings
> Expects that local players are set up to use the EnhancedInput system.
> ゲームユーザー設定にプレーヤーにマップ可能な入力設定を登録する
> ローカルプレイヤーが EnhancedInput システムを使用するように設定されていることを想定しています。

* Game Feature がアクティブになった際に付与する入力マッピング情報を保持する。
* ```InputConfigs``` に [FMappableConfigPair] の配列を保持しています。


## UGameFeatureAction_AddInputBinding

> Adds InputMappingContext to local players' EnhancedInput system. 
> Expects that local players are set up to use the EnhancedInput system.
> ローカル プレイヤーの EnhancedInput システムに InputMappingContext を追加します。
> ローカル プレーヤーが EnhancedInput システムを使用するように設定されていることが期待されます。


## ULyraAbilitySet

> Non-mutable data asset used to grant gameplay abilities and gameplay effects.
> GameplayAbility および GameplayEffect を付与するために使用される非ミュータブルなデータアセットです。

* Game Feature がアクティブになった際に付与する入力マッピング情報を保持する。
* ```GrantedGameplayAbilities``` に [FLyraAbilitySet_GameplayAbility] の配列を保持する。

## FLyraAbilitySet_GameplayAbility

> Data used by the ability set to grant gameplay abilities.
> GameplayAbility を付与するために AbilitySet が使用するデータです。

* Gameplay Ability と ```InputTag``` を保持しており、関連付けの定義は全てこの構造体を経由する。
* [ULyraAbilitySet] のメンバ用の構造体であり、実体は [ULyraAbilitySet] のデータアセットで定義する。


<!--- エクスペリエンス関連 --->


## ULyraExperienceActionSet

> Definition of a set of actions to perform as part of entering an experience
> エクスペリエンスに入るために行う一連のアクションの定義

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


## ULyraExperienceDefinition

> Definition of an experience
> エクスペリエンスの定義

* エクスペリエンスを定義するデータアセット。
* ```GameFeaturesToEnable``` にて使用する [UGameFeatureData] を ```Plugins/GameFeatures``` 内のプラグイン名で指定。
* ```WolrdSettings > Game Mode > Default Gameplay Experience``` で指定される。
* [ALyraGameMode]```::HandleMatchAssignmentIfNotExpectingOne()``` でアセットがロードされ、設定された内容はその後に利用される。

各エクスペリエンスで指定している [UGameFeatureData]

| アセット名                      | GameFeaturesToEnable | 
|---------------------------------|----------------------|
| B_LyraShooterGame_ControlPoints | ShooterCore          |
| B_ShooterGame_Elimination       | ShooterCore          |
| B_TopDownArenaExperience        | TopDownArena         |
| B_TestInventoryExperience       | ShooterCore          |
| B_LyraFrontEnd_Experience       | (null)               |
| B_LyraDefaultExperience         | (null)               |

各レベル（の WorldSettings ）で指定しているエクスペリエンス

| レベル名                    | WolrdSettings > Game Mode > Default Gameplay Experience |
|-----------------------------|---------------------------------------------------------|
| L_Convolution_Blockout      | B_LyraShooterGame_ControlPoints                         |
| L_Expanse                   | B_ShooterGame_Elimination                               |
| L_Expanse_Blockout          | B_ShooterGame_Elimination                               |
| L_FiringRange_WP            | B_ShooterGame_Elimination                               |
| L_ShooterGym                | B_ShooterGame_Elimination                               |
| L_TopDownArenaGym           | B_TopDownArenaExperience                                |
| L_InventoryTestMap          | B_TestInventoryExperience                               |
| L_LyraFrontEnd              | B_LyraFrontEnd_Experience                               |
| L_DefaultEditorOverview     | None (B_LyraDefaultExperience)                          |
| L_ShooterFrontendBackground | None (B_LyraDefaultExperience)                          |

B_LyraDefaultExperience はレベル（の WorldSettings ）で指定していない場合に使用されるデフォルト値。  
C++ の [ALyraGameMode] で直接指定されている。



<!--- 装備品関連 --->

## FLyraEquipmentList

> List of applied equipment
> 適用された装備一覧

* 装備一覧を保持している。
* 詳細は割愛。

## ULyraEquipmentDefinition

> Definition of a piece of equipment that can be applied to a pawn
> ポーンに適用可能な装備の定義。

* [ULyraAbilitySet] の配列を保持する。
* 武器に付随するアビリティはここの設定を利用する。

## ULyraInventoryItemFragment

> Represents a fragment of an item definition
> アイテム定義の部品を表す。

## UInventoryFragment_EquippableItem

* 装備可能な武器の部品
* [ULyraInventoryItemFragment] の派生クラス。
* [ULyraEquipmentDefinition] を保持する。

## ULyraInventoryItemDefinition

* [ULyraInventoryItemFragment] の配列を保持する。
* 武器に付随するアビリティはここの設定を利用する。
* 武器毎に ```ID_``` で始まるブループリントクラスを作成する。


<!--- 以降、関連性が低いクラス --->

## ALyraGameMode

> The base game mode class used by this project.
> このプロジェクトで使用される基本ゲームモードクラス。

* ```AModularGameModeBase``` の派生クラス。

## ULyraSettingsLocal

* UGameUserSettings 派生クラス。
* キーコンフィグの内容等を保持する。
* ```RegisteredInputConfigs``` に [FLoadedMappableConfigPair] の配列を保持しています。


## FLoadedMappableConfigPair

> A container to organize loaded player mappable configs to their CommonUI input type
> 読み込まれたプレーヤーにマップ可能な設定を、CommonUI入力タイプに整理するためのコンテナです。

* ロード済みの入力マッピング情報を保持します。
* ```Config``` に [UPlayerMappableInputConfig] を保持しています。


## ULyraAbilityTagRelationshipMapping

> Mapping of how ability tags block or cancel other abilities
> アビリティタグが他のアビリティをブロックまたはキャンセルする方法のマッピング

* 拡張されたタグ関係システム。
* 詳しくは [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra のアビリティ > 拡張されたタグ関係システム] 参照。


































## ULyraGamePhaseAbility

* ゲームのフェーズごとに有効化／無効化をコントロールするための機能を実装したアビリティクラス。
* Lyra におけるフェーズとは？
	* ゲームルール上の進行状態を示すもの。
	* 例えば ShooterCore では、Warmup / Playing / PostGame からなる（ドキュメントに記載されているとおり）。

LyraGamePhaseAbility.h のコメント
> 原文
>> Defines the game phase this game phase ability is part of.  
>> For example, if your game phase is GamePhase.RoundStart, then it will cancel all sibling phases.
>> 
>> So, if you had a phase such as GamePhase.WaitingToStart that was active, starting the ability part of RoundStart would end WaitingToStart. 
>> However, to get nested behaviors you can also nest the phases. 
>> For example, GamePhase.Playing.NormalPlay, is a sub-phase of the parent GamePhase.Playing, 
>> so changing the sub-phase to GamePhase.Playing.SuddenDeath, would stop any ability tied to GamePhase.Playing.*, but wouldn't end any ability tied to the GamePhase.Playing phase.
> 
> 和訳
>> このゲーム フェーズ能力が属するゲーム フェーズを定義します。 
>> たとえば、ゲーム フェーズが GamePhase.RoundStart の場合、その兄弟フェーズをすべてキャンセルします。
>> 
>> つまり、GamePhase.WaitingToStartなどのフェーズがアクティブだった場合、
>> RoundStartのアビリティ部分を開始すると、WaitingToStartが終了します。
>> ただし、ネストされたビヘイビアを得るには、フェーズをネストすることもできます。
>> 例えば、GamePhase.Playing.NormalPlayは親フェーズであるGamePhase.Playingのサブフェーズなので、
>> サブフェーズをGamePhase.Playing.SuddenDeathに変更すれば、GamePhase.Playing.*に結びついた能力は停止しますが、GamePhase.Playingフェーズに結びついた能力を停止するわけではありません。

### ULyraGamePhaseSubsytem

* このクラス自体はフェーズを管理するサブシステムであり、現在有効なフェーズを管理する。


## 入力タグ アクティベーション サポート


### UGameplayAbilitySet

* ドキュメントでは使用しているように書いていますが、特に使っていないように思われます。
	* そもそも、 UGameplayAbilitySet 自体、サンプルのようなもので、汎用的に使える仕組みではないように思われます。
	* 代わりに、 ULyraAbilitySet を使用しているように思われます。

`Engine\Plugins\Runtime\GameplayAbilities\Source\GameplayAbilities\Public\GameplayAbilitySet.h` のコメント
> 原文
>> This is an example input binding enum for GameplayAbilities. 
>> Your project may want to create its own.
>> The MetaData default bind keys (LMB, RMB, Q, E, etc) are a convenience for designers setting up abilities sets or whatever other data you have that gives an ability with a default key binding. 
>> Actual key binding is up to DefaultInput.ini
>> 
>> E.g., "Ability1" is the command string that is bound to AbilitySystemComponent::ActivateAbility(1). 
>> The Meta data only *suggests* that you are binding "Ability1" to LMB by default in your projects DefaultInput.ini.
>> 
> 和訳
>> GameplayAbilities の入力バインディングenumの例です。
>> プロジェクトによっては、独自に作成することも可能です。
>> MetaData のデフォルト バインド キー (LMB, RMB, Q, E など) は、デザイナーがアビリティ セットやその他のデータを設定して、アビリティにデフォルトキーバインドを設定する際に便利なものです。
>> 実際のキーバインディングは DefaultInput.ini によって決定されます。
>> 
>> 例："Ability1 "はAbilitySystemComponent::ActivateAbility(1)に束縛されるコマンド文字列です。
>> メタデータは、プロジェクトの DefaultInput.ini で、デフォルトで LMB に "Ability1" をバインドしていることを示唆しているにすぎません*。

### UInputModifier

### UInputTrigger


## Lyra ゲーム設定

* [Unreal Engine 5.0 Documentation > サンプルとチュートリアル > サンプル ゲーム プロジェクト > Lyra サンプル ゲーム > Lyra ゲーム設定]
* 入力の設定保存で多少絡む。

### UGameUserSettings

> Stores user settings for a game (for example graphics and sound settings), with the ability to save and load to and from a file.  
> ゲームのユーザー設定（グラフィックやサウンドの設定など）を保存し、ファイルへの保存と読み込みが可能です。

### ULyraSettingsLocal

* UGameUserSettings の派生クラス
* Project Setting > Default Classes にて
	* Game User Setting Class では LyraSettingsLocal を指定しています。
* そのため、  ```GEngine->GetGameUserSettings()``` でインスタンスを取得できます。
* 設定された値はこれを経由してあちこちからアクセスされています。





# ULyraAbilityTagRelationshipMapping

* `FLyraAbilityTagRelationship` の配列を保持する。
* `ULyraPawnData` から参照されている。
* `ULyraPawnData` を元にポーンを構築する際に ULyraAbilitySystemComponent に渡し、そこで保持される。
* `UGameplayAbility` のタグにアクセスする際に値がミックスされる。組み合わせは以下の通り。
	| FLyraAbilityTagRelationship | UGameplayAbility       |
	|-----------------------------|------------------------|
	| AbilityTagsToBlock          | BlockAbilitiesWithTag  |
	| AbilityTagsToCancel         | CancelAbilitiesWithTag |
	| ActivationRequiredTags      | ActivationRequiredTags |
	| ActivationBlockedTags       | ActivationBlockedTags  |
* `UGameplayAbility` でのタグの扱いがカプセル化されておらずどこで使われているか追いきれていない。要確認。
	* 構築時に統合、というような単純な方法ではなく、参照されるたびに値をミックスしている模様。
	* NonInstanced な Gameplay Ability の場合 CDO を使用するため、話はそう単純ではないのだと思われる。




















内容は主にクラスの継承関係やオーバービュー的なものなので、プロジェクトを読めば分かる内容ではあります。  
ですが、プロジェクトを読むにも結構な時間が必要になるので、ざっくり内容がわかるようにまとめておきます。  





## アビリティクラス一覧

+ LyraGameplayAbility
	+ GA_AbilityWithWidget
		+ GA_ADS
		+ GA_Emote
		+ GA_Hero_Dash
		+ GA_Melee
	+ GA_AutoRespawn
	+ GA_DropBomb
	+ GA_DropWeapon
	+ GA_Grenade
	+ GA_Hero_Heal
	+ GA_Interaction_Collect
	+ GA_QuickbarSlots
	+ GA_SpawnEffect
	+ GA_ToggleMarkerInWorld
	+ GAB_Showwidget_WhenInputPressed
		+ GA_ToggleInventory
		+ GA_ToggleMap
	+ GAB_ShowWidget_WhileInputHeld
		+ GA_ShowLeaderboard_CP
		+ GA_ShowLeaderboard_TDM
	+ LyraGamePhaseAbility
		+ Phase_Playing
		+ Phase_Playing
		+ Phase_PostGame
		+ Phase_PostGame
		+ Phase_Warmup
		+ Phase_Warmup
	+ LyraGameplayAbility_Death
		+ GA_ArenaHero_Death
		+ GA_Hero_Death
	+ LyraGameplayAbility_FromEquipment
		+ GA_Weapon_AutoReload
		+ GA_Weapon_ReloadMagazine
			+ GA_Weapon_Reload_NetShooter
			+ GA_Weapon_Reload_Pistol
			+ GA_Weapon_Reload_Rifle
			+ GA_Weapon_Reload_Shotgun
		+ LyraGameplayAbility_RangedWeapon
			+ GA_HealPickup(Unused)
			+ GA_Weapon_Fire
				+ GA_Weapon_Fire_Pistol
				+ GA_Weapon_Fire_Rifle_Auto
				+ GA_Weapon_Fire_Shotgun
				+ GA_WeaponNetShooter(PROTO)
	+ LyraGameplayAbility_Interact
		+ GA_Interact(PROTO)
	+ LyraGameplayAbility_Jump
		+ GA_Hero_Jump
	+ LyraGameplayAbility_Reset

***Lyra*** で始まるものは C++ で実装されているものです。  
***GAB_*** で始まるものはベースクラスで、インスタンス化されないものです。  
***GA_*** で始まるものはブループリントで実装されているものです。  
***GA_HealPickup(Unused)*** / ***GA_WeaponNetShooter(PROTO)*** / ***GA_Interact(PROTO)*** については使われていないようです。（要確認）  


## ULyraGlobalAbilitySystem

UWorldSubsystem のサブクラス。





			1. 付与時にアビリティに関連づく InputTag を FGameplayAbilitySpec::DynamicAbilityTags に設定します。
			2. 入力があった際は、 Enhanced Input 経由で InputTag が渡されます。
			3. ASC に付与されているアビリティのを走査して、 FGameplayAbilitySpec::DynamicAbilityTags が InputTag のものを探します。
			4. 見つかったアビリティのアクティブ化等を行います。




# その他

* [Youtube > Unreal Engine > Developing a C++ Gameplay Framework with Tom Looman ｜ Inside Unreal]
	* GAS のようなフレームワークを作成した際の解説です。
	* ライトな GAS ライクなシステムを自作したい場合に参考になるかもしれません。




[Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022]: https://youtu.be/Fj1zCsYydD8
[Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 23:47]: https://youtu.be/Fj1zCsYydD8?t=1427
[Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 24:22]: https://youtu.be/Fj1zCsYydD8?t=1462
[Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 32:47]: https://youtu.be/Fj1zCsYydD8?t=1967
[Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 34:01]: https://youtu.be/Fj1zCsYydD8?t=2041
[Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 36:18]: https://youtu.be/Fj1zCsYydD8?t=2178
[Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 44:11]: https://youtu.be/Fj1zCsYydD8?t=2651
[Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 57:01]: https://youtu.be/Fj1zCsYydD8?t=3421

* [Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022]
* [Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 23:47]
	* Input
	* 入力関連についての解説
* [Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 24:22]
	* Input asset web
	* 入力関連のアセットの依存関係についての解説
* [Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 32:47]
	* アビリティと Input Tag の連携についての解説
* [Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 34:01]
	* Gameplay experience - input mapping and binds
	* 図で `Dash` の例が解説されている。
		* `GA_HeroDash` は `InputTag.Ability.Dash` にバインドされている
		* InputMapping により `LShhif` は `IA_Dash` にマッピングされている
		* InputConfig により `InputTag.Ability.Dash` は `IA_Dash` によってトリガーされる
		* その結果、`LShhif` は (`InputTag.Ability.Dash` をトリガーし、それにバインドされた) `GA_HeroDash` をアクティブ化する
* [Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 36:18]
	* 拳銃をピックアップした際のアビリティ付与に関するフローの解説
* [Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 44:11]
	* 武器を実際に追加することで各アセットがどのように関係しているかの解説
* [Lyra Starter Game Overview ｜ Tech Talk ｜ State of Unreal 2022 > 57:01]
	* 新しいアビリティの追加手順の解説
	* 既存の GameplayAbility 派生クラスを派生しているだけなので、 GAS 知っているのであれば難しいことはしていない。

[historia > ［UE5］［C++］EnhancedInputで独自のInputTriggerを作る～UIカーソル高速移動編～]




RPC 経由での処理の流れは

* 例：`Phase_Warmup` での [ALyraGameState::MulticastMessageToClients()]
	* これは GameplayAbility で、 GameState に付与されます。
	* `Net Execution Policy` が `Server Initiated` なので、サーバーで起動され、クライアント側でも起動されます。
	* ですが、クライアントでは付与されません。
		* このアビリティは `B_TeamDeathmatchScoring` / `B_ControlPointScoring` の `BeginPlay` にて `HasAuthority` の時のみ付与されます。
	* また、 GameplayAbility のレプリケーションも行われません。
		*  `B_TeamDeathmatchScoring` / `B_ControlPointScoring` は `UGameStateComponent` 派生クラスなので、 `Phase_Warmup` の付与先は `GameState` です。
		* `GameState` はクライアントでは `Simulated Proxy` です。
		* GameplayAbility は `Simulated Proxy` にはレプリケーションされません。
	* [UGameplayMessageSubsystem] 関連で以下の処理が実行されます。
		1. サーバーで [ALyraGameState::MulticastMessageToClients()] が呼び出されます。
			* 関数内にて `GetNetMode() == NM_Client` の時のみ [UGameplayMessageSubsystem::BroadcastMessage()] で `ShooterGame.GamePhase.MatchBeginCountdown` が呼び出されます。
			* サーバー／クライアントごとの [UGameplayMessageSubsystem::BroadcastMessage()] の呼び出し状況
				* 専用サーバー：送信しません。
				* リッスンサーバー：送信しません。
				* クライアント： `Phase_Warmup` での処理は行われませんが、 [ALyraGameState::MulticastMessageToClients()] がサーバーから RPC 経由で呼び出されるので**送信します**。
		1. コスメティックイベントが実行可能な場合のみ [UGameplayMessageSubsystem::BroadcastMessage()] で `ShooterGame.GamePhase.MatchBeginCountdown` が呼び出されます。
			* サーバー／クライアントごとの [UGameplayMessageSubsystem::BroadcastMessage()] の呼び出し状況
				* 専用サーバー：送信しません。
				* リッスンサーバー：**送信します**。
				* クライアントの場合： `Phase_Warmup` での処理は行われません。
	* メッセージ `ShooterGame.GamePhase.MatchBeginCountdown` は `W_WaitingForPlayers_Message` で受信します。
* 例：`GA_AutoRespawn` での [ALyraGameState::MulticastReliableMessageToClients()]
	* これは GameplayAbility で、 PlayerState に付与されます。
	* `Net Execution Policy` が `Local Predicted` なので、クライアントで起動され、サーバー側でも起動されます。
	* [UGameplayMessageSubsystem] 関連で以下の処理が実行されます。
		1. `HasAuthority` の時のみ [ALyraGameState::MulticastReliableMessageToClients()] が呼び出されます。
			* 関数内にて `GetNetMode() == NM_Client` の時のみ [UGameplayMessageSubsystem::BroadcastMessage()] で `Ability.Respawn.Completed.Message` が呼び出されます。
			* サーバー／クライアントごとの [UGameplayMessageSubsystem::BroadcastMessage()] の呼び出し状況
				* 専用サーバー：送信しません。
				* リッスンサーバー：送信しません。
				* クライアント： `GA_AutRespawn` での処理は行われませんが、 [ALyraGameState::MulticastReliableMessageToClients()] がサーバーから RPC 経由で呼び出されるので、**送信します**。
		1. `HasAuthority` でコスメティックイベントが実行可能な場合のみ [UGameplayMessageSubsystem::BroadcastMessage()] で `Ability.Respawn.Completed.Message` が呼び出されます。
			* サーバー／クライアントごとの [UGameplayMessageSubsystem::BroadcastMessage()] の呼び出し状況
				* 専用サーバー：送信しません。
				* リッスンサーバー：**送信します**。
				* クライアントの場合： `GA_AutRespawn` での処理は行われません。
	* メッセージ `Ability.Respawn.Completed.Message` は `W_RespawnTimer` で受信します。
* 例：`B_AccoladeRelay` での [ALyraPlayerState::ClientBroadcastMessage()]
	* これは `ActorComponent` で、 `GameState` にサーバーとクライアントで付与されます。
	* [UGameplayMessageSubsystem] 関連で以下の処理が実行されます。
		1. `HasAuthority` の時のみ [ALyraPlayerState::ClientBroadcastMessage()] が呼び出されます。
			* 関数内にて `GetNetMode() == NM_Client` の時のみ [UGameplayMessageSubsystem::BroadcastMessage()] で `Lyra.ShooterGame.Accolade.*` が呼び出されます。
			* サーバー／クライアントごとの [UGameplayMessageSubsystem::BroadcastMessage()] の呼び出し状況
				* 専用サーバー：送信しません。
				* リッスンサーバー：送信しません。
				* クライアント： `B_AccoladeRelay` での処理は行われませんが、 [ALyraGameState::ClientBroadcastMessage()] がサーバーから RPC 経由で呼び出されるので、**送信します**。
		1. コスメティックイベントが実行可能な場合のみ [UGameplayMessageSubsystem::BroadcastMessage()] で `Lyra.AddNotification.Message` が呼び出されます。
			* サーバー／クライアントごとの [UGameplayMessageSubsystem::BroadcastMessage()] の呼び出し状況
				* 専用サーバー：送信しません。
				* リッスンサーバー：**送信します**。
				* クライアントの場合：**送信します**。
	* メッセージ `Lyra.ShooterGame.Accolade.*` は `B_AccoladeRelay` で受信します。
	* メッセージ `Lyra.AddNotification.Message` は `ULyraAccoladeHostWidget` で受信します。