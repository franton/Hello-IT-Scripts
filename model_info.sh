#!/bin/bash

Model=$( system_profiler SPHardwareDataType | grep "Model Identifier:" | cut -d":" -f2 )

echo "hitp-enabled: YES"
echo "hitp-title: Model:$Model"
echo "hitp-state: none"
