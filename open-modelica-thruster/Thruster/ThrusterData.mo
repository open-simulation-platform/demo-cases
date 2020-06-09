within Thruster ;

record ThrusterData

parameter Modelica.SIunits.Power Pmax = 4.8e6;

  parameter Real scale = 5e6 / Pmax;

  parameter Modelica.SIunits.Density rho = 1025;
  parameter Integer k_g = 4;
  parameter Modelica.SIunits.Torque Qmax = 93e4;
  parameter Real K_omega = 720;
  parameter Real Qfriction = 6.2;
  
  parameter Modelica.SIunits.Angle alpha_min = -Modelica.Constants.inf;
  parameter Modelica.SIunits.Angle alpha_max = Modelica.Constants.inf;
  parameter Real Talpha = 0.01;
  
  parameter Modelica.SIunits.Length positionX;
  parameter Modelica.SIunits.Length positionY;
  parameter Modelica.SIunits.Length positionZ;
  
  parameter Modelica.SIunits.Length D = 4;
  parameter Modelica.SIunits.Length radius = D/2;
  
  parameter Real KT0 = 0.445;
  parameter Real KQ0 = 0.0666;
  parameter Real KP0 = 2 * Modelica.Constants.pi * KQ0 / (sqrt(rho) * radius * 2 *KT0^(1.5));
  
  parameter Real KT0r = 0.347;
  parameter Real KQ0r = 0.0628;
  parameter Real KP0r = 2* Modelica.Constants.pi* KQ0r / (sqrt(rho) * radius * 2 * KT0r^1.5);
  
  parameter Real AT[21] = { 2.5350E-02,	1.7820E-01,	1.4674E-02,	2.8054E-02,	-1.6328E-02, -5.3041E-02, 6.0605E-04, 3.6823E-02, -2.5429E-03, -1.7680E-02, 2.7331E-03,	2.1436E-02,	-2.4782E-03, 1.2317E-03, 5.0980E-03, 7.8076E-03, -3.7816E-03, 3.5353E-03, 5.3014E-03, 2.1940E-03, -2.8306E-03};

  parameter Real BT[21] = { 0.0000E-00,	-7.4777E-01,	-1.3822E-02,	1.0077E-01,	-1.1318E-02,	4.7186E-02,	1.0666E-02,	-9.0239E-03,	-7.8452E-03,	2.3941E-02,	8.0787E-03,	-1.4942E-04,	-3.1925E-03,	9.2620E-03,	1.5527E-03,	-6.5683E-03,	-6.1655E-04,	5.1033E-03,	-6.0263E-04,	-8.2244E-03,	-6.3789E-04};

  parameter Real AQ[21] = {	2.4645E-03,	2.6718E-02,	1.6056E-03,	6.5822E-03,	-2.2497E-03,	-7.8062E-03,	2.4126E-04,	6.1475E-03,	-1.6065E-03,	-3.3291E-03,	1.2311E-03,	3.1123E-03,	-1.2559E-03,	1.3948E-03,	8.8397E-04,	5.0358E-05,	-7.9990E-04,	1.3345E-03,	1.1928E-03,	-1.3556E-04,	-7.0825E-04};

  parameter Real BQ[21] = {	0.0000E-00,	-1.1081E-01,	1.5909E-04,	1.6455E-02,	-2.0601E-03,	8.5343E-03,	8.7856E-04,	-3.1327E-03,	-9.6650E-04,	4.3190E-03,	1.2453E-03,	9.5986E-05,	-7.9986E-04,	1.5073E-03,	2.4595E-04,	-1.6918E-03,	5.1603E-04,	1.1504E-03,	-4.7976E-04,	-1.4566E-03,	2.3280E-04};

  
  parameter Real omega_ref_tau = 2;
  parameter Modelica.SIunits.Force initialThrust = 0.0;
  
  parameter Real power_available_tau = 0.01;
  parameter Modelica.SIunits.Time power_available_positive_ramp_time = 3;

  parameter Modelica.SIunits.Force ratedThrust = 490e3;
  parameter Modelica.SIunits.Power rated_power = 4000e3;
  
  parameter Modelica.SIunits.Time turn_time = 60;
  
  parameter Motor.MotorData motorData(J = 25e3, maxReversePower = Pmax*0.05);


    
end ThrusterData;