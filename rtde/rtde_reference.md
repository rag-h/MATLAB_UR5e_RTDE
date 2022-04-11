# RTDE API Reference

## Function call for move c
Definition [poses,joints,jointVelocities,jointAccelerations,torques] = movec(via_point,pose_to,jointOrPose,a,v,r,mode)
Circular Move: Move to position (circular in tool-space)TCP moves on the circular arc segment from current pose, through pose_via to pose_to. Accelerates to and moves with constant tool speed v. Use the mode parameter to define the orientationinterpolation.

PARAMETERS:

*pose_via* = path point (note: only position is used). Pose_via can also be specified as joint positions, then forward kinematics is used to calculate the corresponding pose.

*pose_to* = arget pose (note: only position is used in Fixed orientation mode). Pose_to can also be specified as joint positions, then forward kinematics is used to calculate the corresponding pose.

*jointOrPose*= "joint" or "pose" to provide joint inputs or poseinputs

*a* = tool acceleration (m/s^2) (default = 1.2)

*v* = tool speed (m/s) (default = 0.25)

*r* = blend radius (of target pose) (m) (default = 0.05)

*mode* = (mode default = 1)
        0: Unconstrained mode. Interpolate orientation from current pose to target pose (pose_to)  1: Fixed mode. Keep orientation constant relative to the tangent of the circular arc(starting from current pose) 



 ## Function call for move j
 Definition: [poses,joints,jointVelocities,jointAccelerations,torques] = movej(target,jointOrPose,a,v,t,r)
 Move to position (linear in joint-space)  When using this command, the robot must be at a standstill or comefrom a movej or movel with a blend. The speed and acceleration parameters control the trapezoid speed profile of the move. Alternatively, the t parameter can be used to set the time for this move. Time setting has priority over speed and acceleration settings

 PARAMETERS:

 *target*: Joint positions or pose. If pose is given then inverse kinematics is used to calculate the corresponding joint positions
 
 *jointOrPose*= "joint" or "pose" to provide joint inputs or pose inputs
 
 *a* = joint acceleration of the leading axis (default = 1.4)
 
 *v* = joint speed of the leading axis (default = 1.05)
 
 *t* = time (s) (default = 0). If it were specified the command would ignore the a and v values
 
 *r* = blend radius (m) (default = 0). If blend radius is set, the robot arm trajectory will be modified to avoid the robot stopping at the point

## Function call for movel
 Definition: [poses,joints,jointVelocities,jointAccelerations,torques] = movel(target,a,v,t,r)
 Move to position (linear in tool-space)

 PARAMETERS:

 *target*: Target pose (pose can also be specified as joint positions, then forward kinematics is used to calculate the corresponding pose)
 
 *a* = joint acceleration of the leading axis (default = 1.2)
 
 *jointOrPose*= "joint" or "pose" to provide joint inputs or pose inputs
 
 *v* = joint speed of the leading axis (default = 0.25)
 
 *t* = time (s) (default = 0). If it were specified the command would ignore the a and v values
 
 *r* = blend radius (m) (default = 0). If blend radius is set, the robot arm trajectory will be modified to avoid the robot stopping at the point

## Function call for move p
 Definition: [poses,joints,jointVelocities,jointAccelerations,torques] = movep(obj,target,jointOrPose,a,v,r)
 Move Process
 Blend circular (in tool-space) and move linear (in tool-space) to position. Accelerates to and moves with constant tool speed v.
 
 PARAMETERS
 
 *target* = target pose (pose can also be specified as joint positions, then forward kinematics is used to calculate the corresponding pose)
 
 *a* = tool acceleration (m/s^2) (default = 1.2)
 
 *v* = tool speed (m/s) (default = 0.25
 
 *r* = blend radius (m) (default = 0)

## Check Robot Mode:
Definition : robotMode = checkRobotMode()

#### RETURN VALUES:
-1 : ROBOT_MODE_NO_CONTROLLER
 
 0 : ROBOT_MODE_DISCONNECTED
 
 1 : ROBOT_MODE_CONFIRM_SAFETY
 
 2 : ROBOT_MODE_BOOTING
 
 3 : ROBOT_MODE_POWER_OF
 
 4 : ROBOT_MODE_POWER_ON
 
 5 : ROBOT_MODE_IDLE
 
 6 : ROBOT_MODE_BACKDRIVE
 
 7 : ROBOT_MODE_RUNNING
 
 8 : ROBOT_MODE_UPDATING_FIRMWARE


## Check Safety Mode:
Definition : safetyMode = checkSafetyMode()

 #### RETURN VALUES:

 1 : SAFETY_MODE_NORMAL

 2 : SAFETY_MODE_REDUCED

3 : SAFETY_MODE_PROTECTIVE_STOP

 4 : SAFETY_MODE_RECOVERY

 5 : SAFETY_MODE_SAFEGUARD_STOP

 6 : SAFETY_MODE_SYSTEM_EMERGENCY_STOP

 7 : SAFETY_MODE_ROBOT_EMERGENCY_STOP

 8 : SAFETY_MODE_VIOLATION

 9 : SAFETY_MODE_FAULT

 10 : SAFETY_MODE_VALIDATE_JOINT_ID

 11 : SAFETY_MODE_UNDEFINED_SAFETY_MODE


 ## Get actual joint positions:
Definition: pos = actualJointPositions()

Returns the current joint position of the ur5e

## Get actual joint velocities:

Definition: pos = actualJointVelocities()

Returns the current joint velocities of the ur5e

## Get target joint positions:

Definition: pos = targetJointPositions()

Returns the target joint positions that were set.

## Get target joint accelerations:

Definition: pos = targetJointAccelerations()

Returns the target joint accelerations that were set.


## Get target tcp position:

Definition: pos = targetToolVector()

Returns the target pose of the tcp. Format: x,y,z,rx,ry,rz

## Get actual tcp position:

Definition: pos = toolVectorActual()

Returns the actual pose of the tcp. Format: x,y,z,rx,ry,rz


## Get actual tcpspeed:

Definition: pos = TCPSpeedActual()

## Get actual joint torques:

Definition: pos = targetJointTorques(obj)


## Draw joint positions:

Definition: drawJointPositions(jointPositions)

Given a set of of joint positions, they will be plotted.

## Draw joint velocities:

Definition: drawJointVelocities(jointVelocities)

## Draw Joint accelerations:

Definition: drawJointAccelerations(jointAccelerations)

## Draw joint torques:

Definition: drawJointTorques(torques)


## Draw TCP Path

Definition: drawPath(poses)

Given a list of poses, they will be plotted.