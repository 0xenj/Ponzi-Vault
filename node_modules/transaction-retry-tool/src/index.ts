#!/usr/bin/env node

import '@nomiclabs/hardhat-ethers'
import { extendConfig, extendEnvironment, task } from 'hardhat/config'
import { lazyObject } from 'hardhat/plugins'
import { HardhatConfig, HardhatUserConfig } from 'hardhat/types'
import path from 'path'

import serveTasks from './serveTasks'
import { TransactionRetry } from './TransactionRetry'
import './type-extensions'

extendConfig(async (config: HardhatConfig, userConfig: HardhatUserConfig) => {
    const userPath = userConfig.paths?.retry
    let retry: string
    if (userPath === undefined) retry = path.join(config.paths.root, 'retry')
    else {
        if (path.isAbsolute(userPath)) retry = userPath
        else retry = path.normalize(path.join(config.paths.root, userPath))
    }
    config.paths.retry = retry
})

extendEnvironment(async (hre: any) => {
    hre.transactionRetry = lazyObject(() => new TransactionRetry(hre))
})

/**
 * retry task implementation
 * @param  {HardhatUserArgs} args
 * @param  {HardhatEnv} env
 */
task('retry', 'Retry a transaction with the current gas price or specify one')
    .addParam('signerKey', 'The signer private key (or type hardhat to use hardhat.config private key)')
    .addParam('txHash', 'The transaction hash of the transaction to retry')
    .addOptionalParam(
        'gasPrice',
        'Specify a gas price to retry the transaction with (default: current network gas price)',
        ''
    )
    .setAction(async function (args, env) {
        // Call function
        await serveTasks('retry-transaction', args, env)
    })

/**
 * gas-cost task implementation
 * @param  {HardhatUserArgs} args
 * @param  {HardhatEnv} env
 */
task('gas-cost', 'Get the current gas price on the selected network in wei').setAction(async function (args, env) {
    // Call function
    await serveTasks('get-current-gas-cost', args, env)
})
