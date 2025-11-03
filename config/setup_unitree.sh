#!/bin/zsh

# ============================================================================
# Unitree G1 ROS 2 Environment Setup
# ============================================================================

# Helper: check if file exists and source it
source_file() {
    [[ ! -f "$1" ]] && echo "ERROR: $2 not found at $1" && return 1
    source "$1" || { echo "ERROR: Failed to source $2"; return 1; }
}

# 1. Deactivate any existing Python virtual environment
[[ -n "$VIRTUAL_ENV" ]] && typeset -f deactivate >/dev/null && deactivate

# 2. Activate G1 workspace Python virtual environment
source_file "/home/nick-bell/g1_ws/.venv/bin/activate" "Python venv" || return 1
export PYTHONPATH=.venv/lib/python3.12/site-packages:$PYTHONPATH

# 3. Source ROS 2 Jazzy base installation
source_file "/opt/ros/jazzy/setup.zsh" "ROS 2 Jazzy" || return 1

# 4. Source CycloneDDS workspace
source_file "$HOME/unitree_ros2/cyclonedds_ws/install/setup.zsh" "CycloneDDS" || return 1

# 5. Configure ROS 2 environment variables
export RCUTILS_COLORIZED_OUTPUT=1
export RMW_IMPLEMENTATION=rmw_zenoh_cpp
export ROS_DOMAIN_ID=0
echo "ROS_DOMAIN_ID: $ROS_DOMAIN_ID"

# 6. Source G1 workspace
G1_WS="/home/nick-bell/g1_ws"
cd "$G1_WS" || { echo "ERROR: Failed to cd to $G1_WS"; return 1; }
source_file "$G1_WS/install/setup.zsh" "G1 workspace (run: colcon build)" || return 1

# 7. Setup ROS 2 tab completion (optional)
command -v register-python-argcomplete &> /dev/null && eval "$(register-python-argcomplete ros2)"

echo "✓ Unitree G1 ROS 2 Environment Setup Complete"