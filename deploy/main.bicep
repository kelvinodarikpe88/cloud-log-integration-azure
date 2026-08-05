// deploy/main.bicep - Azure SOC infrastructure (Sentinel + Log Analytics)
targetScope = 'resourceGroup'

param workspaceName string = 'law-soc'
param location string = 'eastus'

resource law 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 90
  }
}

resource sentinel 'Microsoft.OperationalInsights/workspaces/providers/Microsoft.SecurityInsights@2023-02-01' = {
  name: '${workspaceName}/default'
  location: location
  dependsOn: [ law ]
}
