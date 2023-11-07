
[![license](https://img.shields.io/github/license/jamesisaac/react-native-background-task.svg)](https://opensource.org/licenses/MIT)
[![npm version](https://badge.fury.io/js/transaction-retry-tool.svg)](https://badge.fury.io/js/transaction-retry-tool)

# transaction-retry-tool

```

     _                                  _   _                            _                     _              _ 
    | |                                | | (_)                          | |                   | |            | |
    | |_ _ __ __ _ _ __  ___  __ _  ___| |_ _  ___  _ __ ______ _ __ ___| |_ _ __ _   _ ______| |_ ___   ___ | |
    | __| '__/ _' | '_ \/ __|/ _' |/ __| __| |/ _ \| '_ \______| '__/ _ \ __| '__| | | |______| __/ _ \ / _ \| |
    | |_| | | (_| | | | \__ \ (_| | (__| |_| | (_) | | | |     | | |  __/ |_| |  | |_| |      | || (_) | (_) | |
     \__|_|  \__,_|_| |_|___/\__,_|\___|\__|_|\___/|_| |_|     |_|  \___|\__|_|   \__, |       \__\___/ \___/|_|
                                                                                   __/ |                        
                                                                                  |___/                         
```

This Hardhat plugin provides two tasks and two functions to help you manage and optimize your transactions on Ethereum compatible blockchain. The two tasks include the ability to retry a transaction and retrieve the current gas cost.

## Install Transaction-Retry-Tool

To install the Hardhat Transaction-Retry-Tool Plugin, run the following command in your project directory:

```bash
npm i transaction-retry-tool
```

Next, add the plugin to your hardhat.config.js file:

```js
require("transaction-retry-tool");
```

And that's it! You can now use the two tasks and functions provided by this plugin to manage and optimize your transactions.


## Directories
 - [.vscode/](./.vscode/) - [src/](./src/)

 - [.eslintrc.js](./.eslintrc.js)
 - [.npmignore](./.npmignore)
 - [.prettierrc](./.prettierrc)
 - [CONTRIBUTING.md](./CONTRIBUTING.md)
 - [LICENSE](./LICENSE)
 - [awesome-readme.config.js](./awesome-readme.config.js)
 - [package-lock.json](./package-lock.json)
 - [package.json](./package.json)
 - [tsconfig.json](./tsconfig.json)
 - [tsconfig.prod.json](./tsconfig.prod.json)
 - [tslint.json](./tslint.json)


    

## Tasks

The plugin adds two tasks to the Hardhat CLI:

```bash
npx hardhat retry
```

### Task: retry

This task is used to retry a transaction with the current gas price or a specified one.

Usage: hardhat [GLOBAL OPTIONS] retry --tx-hash <STRING> --signer-key <STRING> [--gas-price <STRING>]

OPTIONS:

- --tx-hash             The transaction hash of the transaction to retry
- --signer-key          The signer private key (or type hardhat to use hardhat.config private key)
- --gas-price           Specify a gas price to retry the transaction with (default: current network gas price) (default: "")

retry: Retry a transaction with the current gas price or specify one

### Task: gas-cost

This task is used to retrieve the current gas price on the selected network in wei.

Usage: hardhat [GLOBAL OPTIONS] gas-cost

gas-cost: Get the current gas price on the selected network in wei

## Functions

Function allow you to use the transaction retry tool OR get the current gas cost.

```js
const { transactionRetry } = require('hardhat');

transactionRetry.retry(
    txHash: string,
    signerKey: string,
    gasPrice?: string
)
transactionRetry.gasCost()
```

## Directory Tree
```
transaction-retry-tool/
│   .eslintrc.js
│   .npmignore
│   .prettierrc
│   CONTRIBUTING.md
│   LICENSE
│   awesome-readme.config.js
│   package-lock.json
│   package.json
│   tsconfig.json
│   tsconfig.prod.json
│   tslint.json
└─── .vscode/
└─── src/
   │   README.md
   │   settings.json
   │   README.md
   │   TransactionRetry.ts
   │   getGasCost.ts
   │   index.ts
   │   retryTransaction.ts
   │   serveTasks.ts
   │   type-extensions.ts
   │   utils.ts
```
## Don't hesitate to contribute to this project.
