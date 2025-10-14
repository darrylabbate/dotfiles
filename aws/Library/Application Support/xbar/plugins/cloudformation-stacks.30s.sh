#!/bin/bash

# Set PATH to include local bin for isengard
export PATH="/Users/drl/.local/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"

# Handle delete action if parameters are passed
if [[ "$1" == "delete" ]]; then
    /usr/local/bin/aws cloudformation delete-stack --stack-name "$2" --region "$3"
    exit 0
fi

# Try to find AWS CLI
if [[ -f "/usr/local/bin/aws" ]]; then
    AWS_CLI="/usr/local/bin/aws"
elif [[ -f "/opt/homebrew/bin/aws" ]]; then
    AWS_CLI="/opt/homebrew/bin/aws"
else
    AWS_CLI=$(which aws 2>/dev/null)
fi

if [[ -z "$AWS_CLI" ]]; then
    printf "☁️\b?\n"
    echo "---"
    echo "AWS CLI not found"
    exit 0
fi

# Get all regions
regions=$($AWS_CLI ec2 describe-regions --query 'Regions[].RegionName' --output text 2>/dev/null)

if [[ -z "$regions" ]]; then
    printf "☁️\b?\n"
    echo "---"
    echo "AWS CLI error"
    exit 0
fi

total_stacks=0
stack_data=""

for region in $regions; do
    stacks=$($AWS_CLI cloudformation list-stacks --region "$region" --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE UPDATE_ROLLBACK_COMPLETE DELETE_IN_PROGRESS --query 'StackSummaries[].[StackName,StackStatus]' --output text 2>/dev/null)
    
    if [[ -n "$stacks" && "$stacks" != "None" ]]; then
        while read -r stack_name stack_status; do
            if [[ -n "$stack_name" ]]; then
                total_stacks=$((total_stacks + 1))
                stack_data="${stack_data}${region}:${stack_name}:${stack_status}"$'\n'
            fi
        done <<< "$stacks"
    fi
done

# Menu bar display with overlaid number
printf "☁️\b%s\n" "$total_stacks"
echo "---"

# Dropdown menu
if [[ $total_stacks -gt 0 ]]; then
    echo "$stack_data" | while IFS=':' read -r region stack_name stack_status; do
        if [[ -n "$region" && -n "$stack_name" ]]; then
            echo "$region"
            if [[ "$stack_status" == "DELETE_IN_PROGRESS" ]]; then
                echo "--$stack_name (deleting...)"
            else
                echo "--$stack_name"
                echo "----Delete | bash=/Users/drl/dotfiles/macos/xbar/plugins/cloudformation-stacks.30s.sh param1=delete param2=$stack_name param3=$region terminal=false refresh=true"
            fi
        fi
    done
else
    echo "No active stacks"
fi
