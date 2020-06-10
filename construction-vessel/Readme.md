# 

The FMUS: 
* Winch Controller
* Winch Model
* Reference Model
* Vessel Model
* Power Plant
* Wind Model
* Wave Model
* Thrust Allocation
* 

## Winch Controller
| Input         | Type          | Description |
| ------------- |-------------  |------------ | 
| crane_setpoint| Real | $1600 |
| load_depth    | Real |   $12 |

| Output        | Type           | Cool  |
| ------------- |:-------------:| -----:|
| torque_command| Real | $1600 |

## Winch Model
| Input         | Type          | Description |
| ------------- |-------------  |------------ | 
| input_torque          | Real | Torque command from winch controller |
| vessel_position.north | Real | Vessel's north position in NED frame |
| vessel_position.east  | Real | Vessel's east position in NED frame |
| vessel_position.down  | Real | Vessel's down position in NED frame |
| vessel_position.roll  | Real | Vessel's roll orientation in NED frame |
| vessel_position.pitch | Real | Vessel's pitch orientation in NED frame |
| vessel_position.yaw   | Real | Vessel's yaw orientation in NED frame |

| Output        | Type           | Description  |
| ------------- |:-------------:| -----:|
| load_depth | Real | $1600 |
| motor_speed | Real | $1600 |
| power_consumption | Real | $1600 |


## Reference Model
| Input         | Type          | Description |
| ------------- |-------------  |------------ | 
| setpoint.north| Real | Torque command from winch controller |
| setpoint.east | Real | Vessel's north position in NED frame |
| setpoint.yaw  | Real | Vessel's east position in NED frame |

