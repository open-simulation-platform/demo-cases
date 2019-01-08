## Description of the simplified *DP-vessel* demo in OSP
This file contains a minimal description of the DP-vessel demonstrator.

### Introduction
This co-simulation demonstrator is based on the work presented in [1,2], and the reader is referred to these references and the references within for more details. Hence, any in-depth details regarding the submodels are considered out of scope here, except information useful for running the co-simulation demonstrator.

The demonstrator includes five different fmus, and a short description of these are given in Table 1.

**Table 1:** *List of FMUs in the DP-vessel demonstrator case.*

| FMU name                | Description                                                                                                                             |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| *OSOM*                  | This is a model of a simplified offshore DP-vessel [1,2].                                                                               |
| *NLPobserver*           | This is the wave-filter, a *Non-Linear Passive observer* [3].                                                                           |
| *ReferenceGenerator*    | This is a model that based on way-points, given as scenario parameters from the user, generates reference signals for the DP-system.    |
| *DPController*          | This is the DP-controller model that controls the position and the orientation of the vessel.                                           |
| *ThMPC*                 | This is the thrust allocation algorithm.                                                                                                |

Note that all these fmus contains binaries for both `win64` and `linux64`.

### Model Descriptions
In the following, each model in Table 1 is presented with focus on running the demonstrator. 


#### OSOM
This fmu contains a simplified vessel model including an irregular sea-state, currents and simple hydrodynamics based on potential theory (including second order wave forces) [4]. The vessel model also contains two rotatable main propulsors placed symmetrical at the stern and one tunnel thruster in the bow.

This model has been exported from *20Sim* and because of a limitation in the exporter, the model parameters cannot be changed by the user in a co-simulation. Some of the main parameters that are hard-coded are given in Table 2. The model I/O for the OSOM fmu are described in Table 3.

**Table 2:** *Main vessel parameters.*

| Parameter                 | Value     |
| ------------------------- | --------- |
| Mass                      | 2365000 kg|
| Length                    | 107 m     |
| Width                     | 22 m      |
| Draught                   | 5 m       |
| Significant wave hight    | 1.5 m     |
| Wave spektrum peak period | 8 s       |
| Wave encounter direction  | from north|
| Northward current         | -0.2 m/s  |
| Number of wave components | 50 -      |


**Table 3:** *Vessel model inputs and outputs (I/O).*


| Name          | I/O   | Description                                                       |
| ------------- | ----- | ----------------------------------------------------------------- |
| `Thrust_d[1]` | I     | Global thrust force always pointing towards north (NED convention)|
| `Thrust_d[2]` | I     | Global thrust force always pointing towards east (NED convention) |
| `Thrust_d[3]` | I     | Global thrust force (torque) in yaw (NED convention)              |
| `input[1]`    | I     | Port-side main thruster azimuth angle                             |
| `input[2]`    | I     | Starboard-side main thruster azimuth angle                        |
| `q[1]`        | O     | North position coordinate (global)<sup>1</sup>                    |
| `q[2]`        | O     | East position coordinate (global)                                 |
| `q[3]`        | O     | Yaw orientation coordinate (global, ≈ heading)                    |


#### NLPobserver
This fmu contains a wave filter (a Non-Linear Passive observer [3]). The purpose of this filter is to filter out the fastest oscillating wave-induced motion disturbances from the position and orientation measurements from the vessel, the ones that the onboard power and propulsion system cannot compensate for without drawing an enormous amount of power. The filter also estimates the position and orientation rates which the DP-controller needs for providing sufficient damping to the vessel motions. Note that also this fmu is generated from exported code from 20Sim, hence, no scenario parameters can be changed by the user. Nevertheless, the parameters hard-coded in the NLPO match the parameters in the vessel model.

The model I/O for the NLPobserver is given in Table 4.

**Table 4:** *Wave filter inputs and outputs (I/O).*

| Name          | I/O   | Description                                                       |
| ------------- | ----- | ----------------------------------------------------------------- |
| `tau[1]`      | I     | Global thrust force always pointing towards north (NED convention)|
| `tau[2]`      | I     | Global thrust force always pointing towards east (NED convention) |
| `tau[3]`      | I     | Global thrust force (torque) in yaw (NED convention)              |
| `y[1]`        | I     | North position coordinate (global)                                |
| `y[2]`        | I     | East position coordinate (global)                                 |
| `y[3]`        | I     | Yaw orientation coordinate (global, ≈ heading)                    |
| `y_hat[1]`    | O     | Filtered north position coordinate (global)                       |
| `y_hat[2]`    | O     | Filtered east position coordinate (global)                        |
| `yhat_[3]`    | O     | Filtered yaw orientation coordinate (global, ≈ heading)           |
| `v_hat[1]`    | O     | Filtered north position rate (d/dt y_hat[1])                      |
| `v_hat[2]`    | O     | Filtered east position rate (d/dt y_hat[2])                       |
| `v_hat[3]`    | O     | Filtered yaw orientation rate (d/dt y_hat[3])                     |

#### ReferenceGenerator
This fmu contains a reference position generator, which, based on user defined inputs, generates continuous reference signals for the DP-controller (north, east and yaw). This fmu is implemented in C++ and the parameters are accessable for the user and can be changed. The most important parameters are listed and described in Table 5.

**Table 5:** *Main parameters and I/Os in `ReferenceGenerator`.*

| Name          | Description                                               | Variability   | Causality | Start value   |
| ------------- | --------------------------------------------------------- | ------------- | --------- | ------------- |
| `Tpsi`        | Internal low-pass filter time constant for yaw reference  | parameter     | internal  | 50.0 s        |
| `Tx`          | Internal low-pass filter time constant for north reference| parameter     | internal  | 50.0 s        |
| `Ty`          | Internal low-pass filter time constant for east reference | parameter     | internal  | 50.0 s        |
| `dpsiMax`     | Maximal yaw-rate in yaw reference output                  | parameter     | internal  | 0.003 rad/s   |
| `dxMax`       | Maximal north-rate in north reference output              | parameter     | internal  | 0.1 m/s       |
| `dyMax`       | Maximal east-rate in north reference output               | parameter     | internal  | 0.1 m/s       |
| `timeStep`    | Local fmu solver time-step size                           | continuous    | internal  | 0.01 s        |
| `solverType`  | Type of numerical solver used                             | parameter     | internal  | "Euler"       | 
| `psi_wp`      | Yaw way-point input                                       | continuous    | input     | 0.0 rad       |
| `psi_tp`      | Global simulation time when `psi_wp` should be reached    | continuous    | input     | 0.0 s         |
| `x_wp`        | North way-point input                                     | continuous    | input     | 0.0 m         |
| `x_tp`        | Global simulation time when `x_wp` should be reached      | continuous    | input     | 0.0 s         |
| `y_wp`        | East way-point input                                      | continuous    | input     | 0.0 m         |
| `y_tp`        | Global simulation time when `y_tp` should be reached      | continuous    | input     | 0.0 s         |
| `psi_ref`     | Continuous yaw reference for DP-controller                | continuous    | ouput     | - rad         |
| `x_ref`       | Continuous north reference for DP-controller              | continuous    | ouput     | - m           |
| `y_ref`       | Continuous east reference for DP-controller               | continuous    | ouput     | - m           |
| `dpsi_ref`    | Continuous yaw-rate reference for DP-controller           | continuous    | ouput     | - rad/s       |
| `dx_ref`      | Continuous north-rate reference for DP-controller         | continuous    | ouput     | - m/s         |
| `dy_ref`      | Continuous east-rate reference for DP-controller          | continuous    | ouput     | - m/s         |


To illustrate how the `ReferenceGenerator` works, consider the following:  
At co-simulation time `t0` the vessel heading is `psi0` and the user sets
```
psi_wp = psi0 + pi/4
psi_tp = t0 + 50.0
```
Then, as long as 
```
pi/200.0 <= dpsiMax
```
The rate of the yaw-reference signal is set to `pi/200`. If not, it is set to dpsiMax. Next, this yaw-rate gets integrated and smoothed using low-pass filter (with filter time constant `Tpsi`). Note that also the signal rate (`dpsi_ref`) gets smoothed using a low-pass filter. Afterwards, both `dPsi_ref` and `psi_ref` are fed to the DP-controller.

#### DPController
This fmu contains the DP-controller which controls the position and the orientation of the vessel. Also this fmu is implemented in C++ and the parameters (controller tuning gains) are accessable for the user and can be changed. However, the controller *has* been tuned and there is no need for changing these paremeters and it is recommended that these parameters are left as is. Table 6 lists the main paramters and I/Os in the fmu. The control law itself is a simple PID-based control law including the rotational matrix for the vessel orientation (yaw).

**Table 6:** *Main parameters and I/Os in `DPController`.*

| Name              | Description                                                               | Variability   | Causality | Start value   |
| ----------------- | ------------------------------------------------------------------------- | ------------- | --------- | ------------- |
| `ActivationTime`  | Global simulation time when the DP controller is activated                | parameter     | internal  | 0.0 s         |
| `ComTimeStep`     | The communication time-step size between the control system and the vessel| parameter     | internal  | 1.0 s         |
| `timeStep`        | Local fmu solver time-step size                                           | continuous    | internal  | 1.0 s         |
| `solverType`      | Type of numerical solver used                                             | parameter     | internal  | "Euler"       |
| `Kppsi`           | Proportional yaw gain                                                     | parameter     | internal  | 1.5e+08       |
| `Kpx`             | Proportional north gain                                                   | parameter     | internal  | 20000         |
| `Kpy`             | Proportional east gain                                                    | parameter     | internal  | 20000         |
| `Kdpsi`           | Derivative yaw gain                                                       | parameter     | internal  | 1e+09         |
| `Kdx`             | Derivative north gain                                                     | parameter     | internal  | 500000        |
| `Kdy`             | Derivative east gain                                                      | parameter     | internal  | 500000        |
| `Kipsi`           | Integral yaw gain                                                         | parameter     | internal  | 50000         |
| `Kix`             | Integral north gain                                                       | parameter     | internal  | 750           |
| `Kiy`             | Integral east gain                                                        | parameter     | internal  | 750           |
| `psi_ref`         | Continuous yaw reference from `ReferenceGenerator`                        | continuous    | input     | - rad         |
| `psi`             | Filtered yaw measurement from `NLPobserver`                               | continuous    | input     | - rad         |
| `x_ref`           | Continuous north reference from `ReferenceGenerator`                      | continuous    | input     | - m           |
| `x`               | Filtered north measurements from `NLPobserver`                            | continuous    | input     | - m           |
| `y_ref`           | Continuous east reference from `ReferenceGenerator`                       | continuous    | input     | - m           |
| `y`               | Filtered east measurements from `NLPobserver`                             | continuous    | input     | - m           |
| `dpsi_ref`        | Continuous yaw-rate reference from `ReferenceGenerator`                   | continuous    | input     | - rad/s       |
| `dpsi`            | Filtered yaw-rate measurements from `NLPobserver`                         | continuous    | input     | - rad/s       |
| `dx_ref`          | Continuous north-rate reference from `ReferenceGenerator`                 | continuous    | input     | - m/s         |
| `dx`              | Filtered north-rate measurements from `NLPobserver`                       | continuous    | input     | - m/s         |
| `dy_ref`          | Continuous east-rate reference from `ReferenceGenerator`                  | continuous    | input     | - m/s         |
| `dy`              | Filtered east-rate measurements from `NLPobserver`                        | continuous    | input     | - m/s         |
| `ControlMz        | Global thrust torque (yaw) from DP-controller                             | continuous    | ouput     | - Nm          |
| `Controlx         | Global thrust in north from DP-controller                                 | continuous    | output    | - N           |
| `Controly         | Global thrust in east from DP-controller                                  | continuous    | output    | - N           |

#### ThMPC
This fmu contains the thrust allocation algorithm that takes the commanded global thrust forces from the DP-controller and distributes them as local thruster signals in type of thruster orientation and thrust amplitude. This thrust allocation algorithm is based on *Model Predictive Control*-theory (MPC) and is thoroughly presented in [5]. Hence, no details will be given here.
The main parameters and I/Os in this fmu is given in Table 7.


**Table 7:** *Main parameters and I/Os in `ThMPC`.*

| Name              | Description                                                                                                       | Variability   | Causality | Start value   |
| ----------------- | ----------------------------------------------------------------------------------------------------------------- | ------------- | --------- | ------------- |
| `Fmax`            | Maximal local trust force generated by each thruster (constraint)                                                 | parameter     | internal  | 1e+07 N       |
| `MaxIter`         | Maximal number of interations allowed in the solution procecdure (QP solver)                                      | parameter     | internal  | 20 -          |
| `QF1x`            | Cost function weight for thrust force in x-direction (vessel coord. sys) for thruster 1 (main stern, port-side)   | parameter     | internal  | 0.1 -         |
| `QF1y`            | Cost function weight for thrust force in y-direction (vessel coord. sys) for thruster 1 (main stern, port-side)   | parameter     | internal  | 0.1 -         |
| `QF2x`            | Cost function weight for thrust force in x-direction (vessel coord. sys) for thruster 2 (main stern, starboard)   | parameter     | internal  | 0.1 -         |
| `QF2y`            | Cost function weight for thrust force in y-direction (vessel coord. sys) for thruster 2 (main stern, starboard)   | parameter     | internal  | 0.1 -         |
| `QF3`             | Cost function weight for thrust force in y-direction (vessel coord. sys) for thruster 3 (tunnel thruster, bow)    | parameter     | internal  | 0.1 -         |
| `QeMz`            | Cost function weight for global thrust error in Mz (torque) for the time steps in the horizon                     | parameter     | internal  | 100.0 -       |
| `QeMzN`           | Cost function weight for global thrust error in Mz (torque) for the time steps outside the horizon                | parameter     | internal  | 100.0 -       |
| `Qex`             | Cost function weight for global thrust error in north for the time steps in the horizon                           | parameter     | internal  | 100.0 -       |
| `QexN`            | Cost function weight for global thrust error in north for the time steps outside the horizon                      | parameter     | internal  | 100.0 -       |
| `Qey`             | Cost function weight for global thrust error in east for the time steps in the horizon                            | parameter     | internal  | 100.0 -       |
| `QeyN`            | Cost function weight for global thrust error in east for the time steps outside the horizon                       | parameter     | internal  | 100.0 -       |
| `Qu1x`            | Cost function weight for thrust force rate in x-direction (vessel coord. sys) for thruster 1                      | parameter     | internal  | 20.0 -        |
| `Qu1y`            | Cost function weight for thrust force rate in y-direction (vessel coord. sys) for thruster 1                      | parameter     | internal  | 20.0 -        |
| `Qu2x`            | Cost function weight for thrust force rate in x-direction (vessel coord. sys) for thruster 2                      | parameter     | internal  | 20.0 -        |
| `Qu2y`            | Cost function weight for thrust force rate in y-direction (vessel coord. sys) for thruster 2                      | parameter     | internal  | 20.0 -        |
| `Qu3`             | Cost function weight for thrust force rate in y-direction (vessel coord. sys) for thruster 3                      | parameter     | internal  | 20.0 -        |
| `QuF`             | Cost function weight balansing thrust rates and thrust magnitudes (see [5] for more details)                      | parameter     | internal  | 500.0 -       |
| `biasAngDeg`      | Bias angles for the two main thrusters placed at the stern                                                        | parameter     | internal  | 10.0 deg      |
| `dalphaMax`       | Maximal azimuth angle rathes for the thrusters                                                                    | parameter     | internal  | 0.2 rad/s     |
| `uFmax`           | Maximal local thrust rate magnitudes for the thrusters                                                            | parameter     | internal  | 2000.0 N/s    |
| (`x1`,`y1`)       | xy-position of thruster 1 (vessel coord. sys)                                                                     | parameter     | internal  | (-45.0,-7.0) m|
| (`x2`,`y2`)       | xy-position of thruster 2 (vessel coord. sys)                                                                     | parameter     | internal  | (-45.0, 7.0) m|
| `x3`              | x-position of thruster 3 (tunnel thruster, vessel coord. sys)                                                     | parameter     | internal  | 53 m          |
| `refMz`           | Global yaw thrust torque input                                                                                    | continuous    | input     | 0.0 Nm        |
| `refx`            | Global north thrust force input                                                                                   | continuous    | input     | 0.0 N         |
| `refy`            | Global east thrust force input                                                                                    | continuous    | input     | 0.0 N         |
| `F1c`             | Local commanded thrust force thruster 1                                                                           | continuous    | output    | 0.0 N         |
| `F2c`             | Local commanded thrust force thruster 2                                                                           | continuous    | output    | 0.0 N         |
| `F3c`             | Local commanded thrust force thruster 3                                                                           | continuous    | output    | 0.0 N         |
| `Fxg`             | Global commanded north-ward thrust based on local thrust commands                                                 | continuous    | output    | 0.0 N         |
| `Fyg`             | Global commanded east-ward thrust based on local thrust commands                                                  | continuous    | output    | 0.0 N         |
| `Mzg`             | Global commanded yaw thrust torque based on local thrust commands                                                 | continuous    | output    | 0.0 Nm        |
| `alpha1`          | Commanded azimuth angle for thruster 1                                                                            | continuous    | output    | 0.0 rad       |
| `alpha2`          | Commanded azimuth angle for thruster 2                                                                            | continuous    | output    | 0.0 rad       |

Note that there also exists other parameters and variables, but these are the most important. To see the others the readers are referred to the `ModelDescription.xml`-file in the fmu. Also note that the ThMPC-fmu  only runs the MPC solver routine every second, and uses the obtained thrust-rates to calculate thruster commands inbetween these quadratic problem  (QP) solver time steps.

### Model Connections
In this demonstrator case, the model connections are given as follows:
```
OSOM.Thrust_d[1]        <-  ThMPC.F1c
OSOM.Thrust_d[2]        <-  ThMPC.F2c
OSOM.Thrust_d[3]        <-  ThMPC.F3ci

OSOM.input[1]           <-  ThMPC.alpha1
OSOM.input[2]           <-  ThMPC.alpha2

DPController.x          <-  NLPobserver.y_hat[1]
DPController.y          <-  NLPobserver.y_hat[2]
DPController.psi        <-  NLPobserver.y_hat[3]

DPController.dx         <-  NLPobserver.v_hat[1]
DPController.dy         <-  NLPobserver.v_hat[2]
DPController.dpsi       <-  NLPobserver.v_hat[3]

DPController.x_ref      <-  ReferenceGenerator.x_ref
DPController.y_ref      <-  ReferenceGenerator.y_ref
DPController.psi_ref    <- ReferenceGenerator.psi_ref

DPController.dx_ref     <-  ReferenceGenerator.dx_ref
DPController.dy_ref     <-  ReferenceGenerator.dy_ref
DPController.dpsi_ref   <- ReferenceGenerator.dpsi_ref

NLPobserver.y[1]        <-  OSOM.q[1]
NLPobserver.y[2]        <-  OSOM.q[2]
NLPobserver.y[3]        <-  OSOM.q[3]

NLPobserver.tau[1]      <-  ThMPC.Fxg
NLPobserver.tau[2]      <-  ThMPC.Fyg
NLPobserver.tau[3]      <-  ThMPC.Mzg

ThMPC.refx              <-  DPController.Controlx
ThMPC.refy              <-  DPController.Controly
ThMPC.refMz             <-  DPController.ControlMz

```

### References and Footnotes

[1] S. Skjong, M. Rindarøy, L. T. Kyllingstad, V. Æsøy, and E. Pedersen, “Virtual prototyping of maritime systems and operations: applications of distributed co-simulations,” J. Mar. Sci. Technol., pp. 1–19, 2017.  
[2] S. Skjong and E. Pedersen, “Co-Simulation of a Marine Offshore Vessel in DP-Operations including Hardware-In-the-Loop (HIL),” in Proceedings of the ASME 2017 36th International Conference on Ocean, Offshore, and Arctic Engineering OMAE 2017, 2017.  
[3] T. I. Fossen and J. P. Strand, “Passive nonlinear observer design for ships using lyapunov methods: full-scale experiments with a supply vessel,” Automatica, vol. 35, no. 1, pp. 3–16, Jan. 1999.  
[4] O. Faltinsen, Sea Loads on Ships and Offshore Structures. Cambridge University Press, 1993.
[5] S. Skjong and E. Pedersen, “Non-angular MPC-based Thrust Allocation Algorithm for Marine Vessels -A Study of Optimal Thruster Commands.”

--------
<sup>1</sup>Note that `q` is used here as name for the vector containing the vessel position and orientation. This has to do with the name convensions in bond graph modelling theory, where q is often used for the state vector containing position and orientations in mechanical systems.
