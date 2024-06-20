targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-subscription-${uniqueString(deployment().name)}'
  location: deployment().location
}

// Invalid:

// resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
//   name: 'st${uniqueString(resourceGroup().id)}'
//   location: resourceGroup().location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {}
// }
