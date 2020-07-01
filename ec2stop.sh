#!/bin/bash
echo "Ec2 instances staring...which having MORNING_START enable"
aws ec2 describe-instances --filters "Name=tag:NIGHTLY_STOP,Values=enable" --query 'Reservations[].Instances[].[InstanceId]' --output text > ec2stop.txt


