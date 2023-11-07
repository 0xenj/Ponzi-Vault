import inquirer from 'inquirer'

import getGasCost from './getGasCost'
import retryTransaction from './retryTransaction'

const inquirerTransactionHashInput = [
    {
        type: 'input',
        name: 'signerKey',
        message: 'What is the signer private key?',
        default: 'hardhat'
    },
    {
        type: 'input',
        name: 'txHash',
        message: 'What is the transaction hash to retry?'
    },
    {
        type: 'input',
        name: 'gasPrice',
        message: 'Retry the transaction with a specific gas price (leave empty: current network gas price)'
    }
]
const serveRetryTransaction = async (args: any, env: any) => {
    if (!args.txHash || args.txHash === '')
        await inquirer
            .prompt(inquirerTransactionHashInput)
            .then(async (answers: { signerKey: string; txHash: string; gasPrice: string }) =>
                retryTransaction(env, answers.txHash, answers.signerKey, answers.gasPrice)
            )
            .catch((err: any) => {
                console.log(err)
            })
            .finally(() => {
                process.exit(0)
            })
    else await retryTransaction(env, args.txHash, args.signerKey, args.gasPrice !== undefined ? args.gasPrice : '')
}

const serveGetGasCost = async (args: any, env: any) => {
    await getGasCost(env)
}

const serveCLI = async (task: string) => {
    if (task === '')
        return (
            await inquirer.prompt([
                {
                    type: 'list',
                    name: 'action',
                    message: 'What do you want to do?',
                    choices: ['retry-transaction', 'get-current-gas-cost']
                }
            ])
        ).action
    else return task
}

const serveFunction = async (task: string, args: any, env: any) => {
    const action = await serveCLI(task)
    switch (action) {
        case 'retry-transaction':
            await serveRetryTransaction(args, env)
            break
        case 'get-current-gas-cost':
            await serveGetGasCost(args, env)
            break
        default:
            break
    }
}

const serveTasks = async (task: string, args: any, env: any) => {
    console.log('Transaction retry tools for Gluwa')
    return serveFunction(task, args, env)
}

export default serveTasks
