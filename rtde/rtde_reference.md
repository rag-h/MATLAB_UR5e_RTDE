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
        0: Unconstrained mode. Interpolate orientation from current pose to target pose (pose_to) 

        1: Fixed mode. Keep orientation constant relative to the tangent of the circular arc(starting from current pose) 