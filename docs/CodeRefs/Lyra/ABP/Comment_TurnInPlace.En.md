# Comment_TurnInPlace.En

quotation source

| No. | quotation source                                        |
|-----|---------------------------------------------------------|
| 1   | ABP_Mannequin_Base > AnimGraph                          |
| 2   | ABP_Mannequin_Base > UpdateRootYawOffset                |
| 3   | ABP_Mannequin_Base > SetRootYawOffset                   |
| 4   | ABP_Mannequin_Base > SetRootYawOffset                   |
| 5   | ABP_Mannequin_Base > ProcessTurnYawCurve                |
| 6   | ABP_ItemAnimLayersBase > FullBody_IdleState > IdleSM    |

# 1

ABP_Mannequin_Base > AnimGraph

TurnInPlace #1 (also see ABP_ItemAnimLayersBase)

When the Pawn owner rotates, the mesh component rotates with it, which causes the feet to slide.
Here we counter the character's rotation to keep the feet planted.

# 2

ABP_Mannequin_Base > UpdateRootYawOffset

TurnInPlace #2

This function handles updating the yaw offset depending on the current state of the Pawn owner.

# 3

ABP_Mannequin_Base > SetRootYawOffset

TurnInPlace #3

We clamp the offset because at large offsets the character has to aim too far backwards, which over twists the spine. 
The turn in place animations will usually keep up with the offset, but this clamp will cause the feet to slide if the user rotates the camera too quickly.
If desired, this clamp could be replaced by having aim animations that can go up to 180 degrees or by triggering turn in place animations more aggressively.

# 4

ABP_Mannequin_Base > SetRootYawOffset

TurnInPlace #4

We want aiming to counter the yaw offset to keep the weapon aiming in line with the camera.

# 5

ABP_Mannequin_Base > ProcessTurnYawCurve

TurnInPlace #5

When the yaw offset gets too big, we trigger TurnInPlace animations to rotate the character back. 
E.g. if the camera is rotated 90 degrees to the right, it will be facing the character's right shoulder. 
If we play an animation that rotates the character 90 degrees to the left, the character will once again be facing away from the camera.
We use the "TurnYawAnimModifier" animation modifier to generate the necessary curves on each TurnInPlace animation.
See ABP_ItemAnimLayersBase for examples of triggering TurnInPlace animations.

# 6

ABP_ItemAnimLayersBase > FullBody_IdleState > IdleSM

TurnInPlace #6 (also see AnimBP_Mannequin_Base)

When the yaw offset gets big enough, we trigger a TurnInPlace animation to reduce the offset.
TurnInPlace animations often end with some settling motion when the rotation is finished. 
During this time, we move to the TurnInPlaceRecovery state, which can transition back to the TurnInPlaceRotation state if the offset gets big again.
This way we can keep playing the rotation part of the TurnInPlace animations if the Pawn owner keeps rotating, without waiting for the settle to finish.
