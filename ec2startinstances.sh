#!/bin/bash

#This will sort out EC2 Instances which having MORNING_START tag enable

aws ec2 describe-instances --filters "Name=tag:MORNING_START,Values=enable" > ec2starttaginfo.txt

#This will sort out EC2 Instances on tag based internally and
#will fetch instances ids after that it will stored in ec2start.txt

aws ec2 describe-instances --filters "Name=tag:MORNING_START,Values=enable" --query 'Reservations[].Instances[].[InstanceId]' --output text > ec2start.txt

# The file with the instance IDs

input='ec2start.txt'

# Iterate through the lines

while read line; do
  echo "starting $line"
  aws ec2 start-instances --instance-ids $line
done < $input

