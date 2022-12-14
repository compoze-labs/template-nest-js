#!/usr/bin/env bash

set -euo pipefail

restart() {
    
    SERVICE=$1
    STAGE=$2
    echo "creating deployment for ${SERVICE}-${STAGE}"
    
    
    output=$(aws ecs update-service --cluster ${SERVICE}-${STAGE} --service ${SERVICE}-${STAGE} --force-new-deployment 2>&1)
    echo "${output}" | jq ".service.taskDefinition"
    
    echo "waiting for deployment to become stable"
    aws ecs wait services-stable --cluster "${SERVICE}-${STAGE}" --service "${SERVICE}-${STAGE}"
}