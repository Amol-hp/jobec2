#!/bin/bash

#This will sort out EC2 Instances which having NIGHTLY_STOP tag enable

aws ec2 describe-instances --filters "Name=tag:SERVER,Values=qa" > ec2stoptaginfo.txt

#This will sort out EC2 Instances on tag based internally and
#will fetch instances ids after that it will stored in ec2stop.txt

aws ec2 describe-instances --filters "Name=tag:SERVER,Values=qa" --query 'Reservations[].Instances[].[InstanceId]' --output text > ec2stop.txt

# The file with the instance IDs

filename=ec2stop.txt

# Iterate through the lines

while read line; do
  echo "Stopping $line"
  aws ec2 stop-instances --instance-ids $line
done <$filename

