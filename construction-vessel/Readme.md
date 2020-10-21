# Construction-Vessel

This demo simulates a marine vessel doing crane operations while dynamically positioned. System plants and controllers are modularized according to responsibility and to preserve numerical stability.

FMUs are listed in Table 1.

**Table 1:** *List of FMUs in the Construction Vessel demo.*

| FMU name                | Description                                                                                                                             |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| *Vessel Model*              | Simulates the motions of a marine vessel exposed to environmental forces |
| *Power Plant*           | Simulates the vessel’s power plant |
| *Thrust Allocation*    | Maps thrust orders from DP to thruster setpoints |
| *Thruster Model*          | Maps thruster setpoints to forces acting on the vessel |
| *Wind Model*                 | Models wind forces acting on the vessel
| *Wave Model*                 | Models first and second order wave forces as disturbances in vessel position |
| *Winch*                 | Models the crane and winch |
| *DP Controller*                 | DP controller for keeping the vessel at a fixed position
| *Reference Model*                 | Reference model for smoothing the setpoint provided to DP

## Source Code
The source code for these FMUs can be found [here](https://github.com/open-simulation-platform/simulink-fmus)
