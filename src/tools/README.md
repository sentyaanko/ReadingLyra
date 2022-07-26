ps1 の実行の際は事前に以下のようなコマンドで、 ps1ファイルのブロック解除と powershell の実行ポリシーを変更しておく必要があります。

```powershell
Unblock-File CreateHeadingIDs.ps1
Set-ExecutionPolicy RemoteSigned -Scope Process
```
