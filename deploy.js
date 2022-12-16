const { 
    createDefaultTxMiddleware,
    createInMemorySignerMiddleware,
    createLocalAccount,
    Client,
    Crypto,
  } = require("@arcblock/forge-sdk");
  
  const { fromRandom } = Crypto;
  
  const client = new Client({
    // Replace with the URL of your Goerli testnet node
    chainHost: "https://test.goerli.node.arcblockio.com/api",
    chainId: "goerli",
    txMiddleware: createDefaultTxMiddleware(),
    signer: createInMemorySignerMiddleware(fromRandom()),
  });
  
  // Replace with the path to your compiled contracts
  const contractPath = "../contracts/src/core/modules"; //  path/to/compiled/contracts
  
  // Deploy the contracts to the Goerli testnet
  client.deployContract(contractPath).then(({ address }) => {
    console.log(`Contract deployed at address: ${address}`);
  });
  