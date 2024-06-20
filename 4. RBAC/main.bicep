param location string = resourceGroup().location

var storageBlobDataReaderRoleDefinitionId = '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'
var appServicePlanName = 'asp-rbac-${uniqueString(resourceGroup().id)}'
var appServiceName = 'app-rbac-${uniqueString(resourceGroup().id)}'

resource storageBlobDataReaderRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: storageBlobDataReaderRoleDefinitionId
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'st${uniqueString(resourceGroup().id)}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'P0v3'
    capacity: 1
  }
  properties: {}
}

resource appService 'Microsoft.Web/sites@2023-12-01' = {
  name: appServiceName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

resource appSettings 'Microsoft.Web/sites/config@2021-03-01' = {
  parent: appService
  name: 'appsettings'
  properties: {
    Storage__ServiceUri: storageAccount.properties.primaryEndpoints.blob
  }
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, appService.id, storageBlobDataReaderRoleDefinition.id)
  properties: {
    roleDefinitionId: storageBlobDataReaderRoleDefinition.id
    principalId: appService.identity.principalId
    principalType: 'ServicePrincipal'
  }
}
