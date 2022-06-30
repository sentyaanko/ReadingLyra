## UCommonActivatableWidget

> The base for widgets that are capable of being "activated" and "deactivated" during their lifetime without being otherwise modified or destroyed. 
>
> This is generally desired for one or more of the following purposes:
>	- This widget can turn on/off without being removed from the hierarchy (or otherwise reconstructing the underlying SWidgets), so Construct/Destruct are insufficient
>	- You'd like to be able to "go back" from this widget, whether that means back a breadcrumb, closing a modal, or something else. This is built-in here.
>	- This widget's place in the hierarchy is such that it defines a meaningful node-point in the tree of activatable widgets through which input is routed to all widgets.
>
> By default, an activatable widget:
>	- Is not automatically activated upon construction
>	- Does not register to receive back actions (or any other actions, for that matter)
>	- If classified as a back handler, is automatically deactivated (but not destroyed) when it receives a back action
> 
> Note that removing an activatable widget from the UI (i.e. triggering Destruct()) will always deactivate it, even if the UWidget is not destroyed.
> Re-constructing the underlying SWidget will only result in re-activation if auto-activate is enabled.
>
> TODO: ADD MORE INFO ON INPUTS

