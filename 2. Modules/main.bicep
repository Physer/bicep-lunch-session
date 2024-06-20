module storageAccount 'modules/storage.bicep' = {
  name: 'deployStorageAccount'
  params: {
    storageAccountName: 'stmodules${uniqueString(resourceGroup().id)}'
    storageAccountType: 'Standard_LRS'
  }
}

module cheapWebApp 'modules/webApp.bicep' = {
  name: 'deployCheapWebApp'
  params: {
    applicationName: 'cheap'
    skuName: 'D1'
    storageUri: storageAccount.outputs.primaryBlobEndpoint
  }
}

module expensiveWebApp 'modules/webApp.bicep' = {
  name: 'deployExpensiveWebApp'
  params: {
    applicationName: 'expensive'
    skuName: 'P0v3'
    storageUri: storageAccount.outputs.primaryBlobEndpoint
  }
}
