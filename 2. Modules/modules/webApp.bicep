@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P0v3'
  'P1v3'
  'P2v3'
  'P3v3'
])
param skuName string
param applicationName string
param storageUri string
param instanceCount int = 1
param location string = resourceGroup().location

var appServicePlanName = 'asp-modules-${uniqueString(resourceGroup().id)}'
var appServiceName = 'app-modules-${applicationName}-${uniqueString(resourceGroup().id)}'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    capacity: instanceCount
  }
  properties: {}
}

resource appService 'Microsoft.Web/sites@2023-12-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

resource appSettings 'Microsoft.Web/sites/config@2021-03-01' = {
  parent: appService
  name: 'appsettings'
  properties: {
    Storage__ServiceUri: storageUri
  }
}
