# To load the variables in the .env file
source .env

# To deploy our contracts
forge script script/RousseauProtocol.s.sol:Deploy --rpc-url $GOERLI_RPC_URL  --private-key $PRIVATE_KEY --broadcast
