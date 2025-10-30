#!/bin/zsh

set -e # Stop if any command fails

# Deactivate Python envs if active
if [[ -n "$VIRTUAL_ENV" ]] && typeset -f deactivate >/dev/null; then
    deactivate
fi

source /home/nick-bell/g1_ws/.venv/bin/activate
source /opt/ros/jazzy/setup.zsh
source $HOME/unitree_ros2/cyclonedds_ws/install/setup.zsh

export RCUTILS_COLORIZED_OUTPUT=1
export RMW_IMPLEMENTATION=rmw_zenoh_cpp
export ROS_DOMAIN_ID=0
echo "Current ROS_DOMAIN_ID $ROS_DOMAIN_ID"
  
cd /home/nick-bell/g1_ws
source install/setup.zsh
eval "$(register-python-argcomplete ros2)"

echo "Unitree G1 ros2 Env Setup"