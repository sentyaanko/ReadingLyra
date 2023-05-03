# Comment_AnimBP_Tour.En

quotation source

| No. | quotation source                                        |
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

AnimBP Tour #1  (also see ABP_ItemAnimLayersBase)

This AnimBP does not run any logic in its Event Graph.
Logic in the Event Graph is processed on the Game Thread. 
Every tick, the Event Graph for each AnimBP must be run one after the other in sequence, which can be a performance bottleneck.
For this project, we've instead used the new BlueprintThreadsafeUpdateAnimation function (found in the My Blueprint tab). 
Logic in BlueprintThreadsafeUpdateAnimation can be run in parallel for multiple AnimBP's simultaneously, removing the overhead on the Game Thread.

# 2

ABP_Mannequin_Base > BlueprintThreadSafeUpdateAnimation

AnimBP Tour #2

This function is primarily responsible for gathering game data and processing it into useful information for selecting and driving animations.
A caveat with Threadsafe functions is that we can't directly access data from game objects like we can in the Event Graph. 
This is because other threads could be running at the same time and they could be changing that data. 
Instead, we use the Property Access system to access data. 
The Property Access system will copy the data automatically when it's safe.
Here's an example where we access the Pawn owner's location (search for "Property Access" from the context menu).

# 3

ABP_Mannequin_Base > AnimGraph

AnimBP Tour #3

This Anim Graph does not reference any animations directly. 
It instead provides entry points for Montages and Linked Animation Layers to play poses at certain points in the graph. 
This graph's main purpose is to blend those entry points together (e.g. blending upper and lower body poses together).
This approach allows us to only load animations when they're needed. 
For example, a weapon will hold references to the required Montages and Linked Animation Layers, so that data will only be loaded when the weapon is loaded.
E.g. B_WeaponInstance_Shotgun holds references to Montages and Linked Animation Layers. 
That data will only be loaded when B_WeaponInstance_Shotgun is loaded.
B_WeaponInstance_Base is responsible for linking animation layers for weapons.

# 4

ABP_Mannequin_Base > AnimGraph > LocomotionSM

AnimBP Tour #4

This state machine handles the transitions between high level character states.
The behavior of each state is mostly handled by the layers in ABP_ItemAnimLayersBase.

# 5

ABP_ItemAnimLayersBase > EventGraph

AnimBP Tour #5

As with AnimBP_Mannequin_Base, this animbp performs its logic in BlueprintThreadSafeUpdateAnimation.
Also, this animbp can access data from AnimBP_Mannequin_Base using Property Access and the GetMainAnimBPThreadSafe function. 
An example is below.

# 6

ABP_ItemAnimLayersBase > EventGraph

AnimBP Tour #6

This animbp was authored to handle the logic for common weapon types, like Rifles and Pistols. 
If custom logic is needed (e.g. for a weapon like a bow), a different animbp could be authored that implements the ALI_ItemAnimLayers interface.
Rather than referencing animation assets directly, this animbp has a set of variables that can be overriden by Child Animation Blueprints. 
These variables can be found in the "Anim Set - X" categories in the My Blueprint tab.
This allows us to reuse the same logic for multiple weapons without referencing (and thus loading) the animation content for each weapon in one animbp.
See ABP_RifleAnimLayers for an example of a Child Animation Blueprint that provides values for each "Anim Set" variable.

# 7

ABP_ItemAnimLayersBase > FullBody_IdleState

AnimBP Tour #7

This animbp implements a layer for each state in AnimBP_Mannequin_Base.
Layers can play a single animation, or contain complex logic like state machines.

# 8

ABP_ItemAnimLayersBase > FullBody_StartState

AnimBP Tour #8

This is an example use case of Anim Node Functions.
Anim Node Functions can be run on animation nodes. 
They will only run when the node is active, which allows us to localize logic to specific nodes or states.
In this case, an Anim Node Function selects an animation to play when the node become relevant. 
Another Anim Node Function manages the play rate of the animation.

# 9

ABP_ItemAnimLayersBase > UpdateStartAnim

AnimBP Tour #9

This is an example of using Distance Matching to ensure that the distance traveled by the Start animation matches the distance traveled by the Pawn owner. 
This prevents foot sliding by keeping the animation and the motion model in sync.
This effectively controls the play rate of the Start animation. 
We clamp the effective play rate to prevent the animation from playing too slowly or too quickly.
If the effective play rate is clamped, we will still see some sliding. 
To fix this, we use Stride Warping later to adjust the pose to correct for the remaining difference.
The Animation Locomotion Library plugin is required to have access to Distance Matching functions.

# 10

ABP_ItemAnimLayersBase > FullBody_StartState

AnimBP Tour #10

This is an example of warping the authored pose of the animation to match what the Pawn owner is actually doing.
Orientation Warping will rotate the lower body of the pose to align to the direction the Pawn owner is moving. 
We only author Forward/Back/Left/Right directions and rely on warping to fill in the gaps.
Orientation Warping will then realign the upper body so that the character continues to aim where the camera is looking.
Stride Warping will shorten or lengthen the stride of the legs when the authored speed of the animation doesn't match the actual speed of the Pawn owner.
The Animation Warping plugin is required to have access to these nodes.
