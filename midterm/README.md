## Miterm Project: Cat And Mice Ecosystem

### Description:
For my midterm project, I have developed "cat and mice" ecosystem simulation. The canvas depicts a room and a mice home.

The cat roams freely and randomly within the room. When any mouse comes under its detection, it chases it and eats in upon catch. If it does not eat a mouse with a certain
time period, it gets aggressive and starts to move and chase mice at faster speed. While it is aggressive, it also detects mice at a greater distance.

Mice tend to stay in the house most of the time. They leave their home just to seek food. They can smell food from anywhere in the room. When a mouse is at safe distance from cat, or when mouse's distance from food is safely less than its distance from cat, it starts seeking the food at its maximum speed. The "safe" distance depends on the hunger level of a mouse. If it is more hungry, it will risk seeking food at lesser distances from cat. 

While Mice are in the house, they roam at slow speeds at fair distance from one another. Each mouse has a limited lifespan which decreases every second by some specific value in variable called life decrease rate. They grow to certain size until 30% of their life. Their maximum speeds also increases at certain rate during this time. After living 70% of their lives, their maximum speed starts to decrease until death. Each second, their hunger also increases. Hunger resets to 0 after they eat food. Once they have lived 20% of life, they become fertile and can reproduce inside their house. They start seeking mates who are also fertile, have opposite gender, and are ready to reproduce. After reproducing, they get ready to reproduce again after certain time period. They can reproduce until 50% of their life. A child gets a mix of its parents' attributes, such as size, size increase rate, maximum speed, life decrease rate, and hunger increase rate.

When mice are outside their home seeking food, they either choose to go after another piece of food nearby or back to their home. If cat is closer to mice home than a mouse, then that mouse runs away from cat while satying inside the room rather than seeking its home.

Food can be placed by the user with a mouse click anywhere inside the room. Use can also follow instructions in the code to uncomment a call to the function which automatically spawns food at a random location inside room after certain time. If no food is present in the room, mice do not leave their home.

If mice house population becomes very high (150), very young and very old mice starts dying out of suffocation.

### Process
The random movement of cat inside the room is implemented using _flow field_ which employs _perlin noise_ for smooth movement. The flowfield directions change after certain amount of time or when cat is about to hit a wall.

There are three points in the mice house which mice can seek when they are outside. _Reynold's steering code_ from _The Nature of Code_ book is used to implement seek behavior. Mice always seek the closest point in house. These points are implemented by an _arraylist_ of _PVectors_, so more points can always be added.

When in the house, the steering force from the walls is much higher than the mice separation force. So, mice stays in the house no matter how much the house population increase.
The steering force to seek the food is also much higher than separation force, so mice prefers getting to the food first more than getting away from one another.

When a mouse is running away from the cat, it separates from the cat at maximum speed in the opposite direction until its about to hit a wall. In that case, the mouse's desired velocity would be an average of separation from cat and wall which is slightly more skewed towards separating from wall (since exact average results in moving parallel to the wall). I could also have just used more steering force away from wall. But using the skewed average shows more interesting results as it seems like mouse is in absolute panic and is trying really hard to get away from cat from the sides.

### Video Link

Here is the [link](https://drive.google.com/file/d/1V88Bs1BZoxFa2pUDyfIYCe7y99-nEiUO/view?usp=sharing) to the video of ecosystem simulation.

### Screenshots
![Screenshot1](https://github.com/ehtishamoas/RobotaPsyche/blob/main/midterm/Screenshot1.jpg)
![Screenshot2](https://github.com/ehtishamoas/RobotaPsyche/blob/main/midterm/Screenshot2.jpg)

### Interesting Observations
Sometimes when some mouse has gone far away from home and is stuck at wall corner and cat is chasing it to eat it, other mice from the home diverts cat's attention to them by coming out for food when cat starts chasing them instead of the mouse stuck at the corner. On the other hand, we can also think of it as other mice are using their friend's situation to sneak behind cat's back and get food for themselves.
I found it very interesting that I did not code any of these behaviors but still I am drawing different conclusions from such observations.
