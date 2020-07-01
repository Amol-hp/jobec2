#!/bin/bash

#This will sort out EC2 Instances which having NIGHTLY_STOP tag enable

aws ec2 describe-instances --filters "Name=tag:NIGHTLY_STOP,Values=enable" > ec2stoptaginfo.txt

#This will sort out EC2 Instances on tag based internally and
#will fetch instances ids after that it will stored in ec2stop.txt

aws ec2 describe-instances --filters "Name=tag:NIGHTLY_STOP,Values=enable" --query 'Reservations[].Instances[].[InstanceId]' --output text > ec2stop.txt

# The file with the instance IDs

filename=ec2stop.txt

# Iterate through the lines

while read p; do
  echo "Stopping Nightly stop tag EC2 server $p"
  aws ec2 stop-instances --instance-ids $p
done <$filename
