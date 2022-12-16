# Getting Started

We are using foundry for this project, you can get started with foundry here https://github.com/foundry-rs/foundry

Install the dependencies

```
forge install
```

Compile the contracts

```
forge build
```

Troubleshooting

If you are having issues try upgrading foundry with foundryup

## Deploying

Copy .env.example to .env

```
cp .env.example .env
```

and set the variables. Then run the deploy script

```
./deploy.sh
```

To deploy to a local network instead, first start anvil

```
anvil
```
Once, started you can use one of the private keys that was automatically generated for you. In `./deploy.sh` change the `--rpc-url` parameter to `--fork-url` and set it to `http://localhost:8545` (or whichever port anvil is running on)
