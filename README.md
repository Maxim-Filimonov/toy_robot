## Install dependencies
```
bundle install
```

## Tests
```
rspec
```

## Interactive console
```
ruby run.rb
```
Alternatively
```
chmod +x ./run.rb
./run.rb
```

## Assumptions

- **Only one robot can be placed on the table**. As it is impossible to control more than one robot only one robot
can be placed the table. Thinking ahead it might be required to either be able to switch between robots or to reset the state and remove the current robot
- **Ignorance is bliss**. Robot just ignores command it can't perform.
Would be more user friendly to reply something meaningful like "Cannot perform the move due to hazardous conditions" but that's where I would speak to the real user and figure out the actual usage.
Trying to avoid Windows "Are you sure???"


## Design

### Separation of contexts
I have found two separate contexts within the system. First is interacting with a user and responding to commands.
Second is moving the Robot around the table.

To minimise coupling between them a context only interact with a single element(root) from another context.

For example, ControlPanel only interacts with Robot not with any subsystems or sensors of the Robot.

### Robot systems isolation
The Robot understand various set of commands that's a contants and the Robot class needs to be changed to understand more commands.
However, I wanted to make sure that the Robot class changes will be minimised whenever we need to change the way existing command work.

Because of that Robot doesn't not actually perform any commands itself and delegates this task to subsystems.

Robot uses the movement subsystem to determine location where it wants to go and then uses sensors to determine is it possible to go that location.
Same happens with rotation but as there are currently no constraints against rotation all of them allowed.

### Brain
To make it easier to communicate between subsystems and sensors they are using robot brain for communication.
When a subsystem or a sensor attach to robot they initialise themselves and write to brain any required information.

For example, that is how `PLACE` commands works. 
On initialisation NavSensor uses initial data array to set current location of the robot and remembers the frame(as set as constant in the exercise).
CompassSensor determines current direction the same wa.y

### Sensor data
Each sensor maintains it's data in the robot brain. That is the way sensor and subsystem communicate with each other.

This data can be extracted from sensor by calling `sensor.data`.
Whenever, user runs a `REPORT` command the Robot just asks all sensors for its data and returns it.



## Code problem details
-----------

Toy Robot Simulator

Description:

. The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.

. There are no other obstructions on the table surface.

. The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement 

that would result in the robot falling from the table must be prevented, however further valid movement commands must still 

be allowed.

. Create an application that can read in commands of the following form -

PLACE X,Y,F

MOVE

LEFT

RIGHT

REPORT

. PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST. 
. The origin (0,0) can be considered to be the SOUTH WEST most corner.

. The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.

. MOVE will move the toy robot one unit forward in the direction it is currently facing.

. LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.

. REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.

. A robot that is not on the table can choose the ignore the MOVE, LEFT, RIGHT and REPORT commands.

. Input can be from a file, or from standard input, as the developer chooses.

. Provide test data to exercise the application.

Constraints:

The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot. 

Any move that would cause the robot to fall must be ignored.

Example Input and Output:

a)

PLACE 0,0,NORTH

MOVE

REPORT

Output: 0,1,NORTH

b)

PLACE 0,0,NORTH

LEFT

REPORT

Output: 0,0,WEST

c)

PLACE 1,2,EAST

MOVE

MOVE

LEFT

MOVE

REPORT

Output: 3,3,NORTH

-------
