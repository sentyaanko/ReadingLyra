## EMouseCaptureMode

* 概要
	* エンジン側で定義されているマウスのキャプチャーモードです。

### EMouseCaptureMode::NoCapture

> Do not capture the mouse at all  
>
> ----
> マウスをキャプチャしない。  

### EMouseCaptureMode::CapturePermanently

> Capture the mouse permanently when the viewport is clicked, and consume the initial mouse down that caused the capture so it isn't processed by player input  
>
> ----
> ビューポートがクリックされたときにマウスを恒久的にキャプチャし、キャプチャの原因となった最初のマウスダウンを消費するため、プレイヤー入力で処理されない。  

### EMouseCaptureMode::CapturePermanently_IncludingInitialMouseDown

> Capture the mouse permanently when the viewport is clicked, and allow player input to process the mouse down that caused the capture  
>
> ----
> ビューポートがクリックされたときにマウスを恒久的にキャプチャし、キャプチャの原因となったマウスダウンをプレーヤ入力で処理できるようにする。  

### EMouseCaptureMode::CaptureDuringMouseDown

> Capture the mouse during a mouse down, releases on mouse up  
>
> ----
> マウスダウン時にキャプチャし、マウスアップ時に解除する。  

### EMouseCaptureMode::CaptureDuringRightMouseDown

> Capture only when the right mouse button is down, not any of the other mouse buttons
>
> ----
> マウスの右ボタンが押されているときのみキャプチャし、他のマウスボタンはキャプチャしない。  

<!--- ページ内のリンク --->

<!--- 自前の画像へのリンク --->

<!--- generated --->

