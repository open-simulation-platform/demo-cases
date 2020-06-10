# Construction-Vessel

This demo simulates a marine vessel doing crane operations while dynamically positioned. System plants and controllers are modularized according to responsibility and to preserve numerical stability.

FMUs are listed in Table 1.

**Table 1:** *List of FMUs in the Construction Vessel demo.*

| FMU name                | Description                                                                                                                             |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| *[Vessel Model](#vessel-model)*              | Simulates the motions of a marine vessel exposed to environmental forces |
| *[Power Plant](#power-plant)*           | Simulates the vessel’s power plant |
| *[Thrust Allocation](#thrust-allocation)*    | Maps thrust orders from DP to thruster setpoints |
| *[Thruster Model](#thruster-model)*          | Maps thruster setpoints to forces acting on the vessel |
| *[Wind Model](#wind-model)*                 | Models wind forces acting on the vessel
| *[Wave Model](#wave-model)*                 | Models first and second order wave forces as disturbances in vessel position |
| *[Winch](#winch)*                 | Models the crane and winch |
| *[DP Controller](#dp-controller)*                 | DP controller for keeping the vessel at a fixed position
| *[Reference Model](#reference-model)*                 | Reference model for smoothing the setpoint provided to DP
