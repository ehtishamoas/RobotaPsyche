## February 14
I have implemented simple behaviors of a mouse for my ecosystem project. A mouse tends to stay in its house for most of the time until it gets hungry and smells food. Mouse's life decreases with time and it happens more rapidly when its hunger level reaches very high levels. I used millis() function in processing to decrease the life of mouse by 1 unit each second and to increase hunger by 5 units each second. If hunger level cross 80, mouse's life start to decrease by 5 units a second. 

When the hunger level crosses 50 and mouse can smell the food outside, it leaves its safezone, eats the food, and immediately comes back. After eating, its hunger level goes down to 0. After mouse eats food, new food is generated at a random location after some random amount of time (this random time is constrained for the simulation between 20 and 30 seconds).

#### Video:
Here is the [link](https://drive.google.com/file/d/1Ne4Jl0Os_4-xopicwibn6DvliwCR8nY0/view?usp=sharing) to the video of current behaviors of a mouse.

My next steps would be to introduce a cat which would move randomly around the canvas but won't be able to enter mouse's house. Then, mouse will leave for the food whenever the cat will be at safe distance from the food and the house. With increasing hunger levels, mouse will be more willing to risk its safety for food. And when the cat sees the mouse, it will start to chase it down.
