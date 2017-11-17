#!/bin/bash -ex

kubectl apply -f override-defalt-rbac-settings.yaml

#curl -L https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
#chmod 700 get_helm.sh
./get_helm.sh
helm init
