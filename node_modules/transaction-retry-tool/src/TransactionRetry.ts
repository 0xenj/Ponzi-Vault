import { extendEnvironment, task } from 'hardhat/config'

import getGasCost from './getGasCost'
import retryTransaction from './retryTransaction'

export class TransactionRetry {
    private readonly _env: any

    constructor(hre: any) {
        this._env = hre
    }

    public async retry(txHash: string, signerKey: string, gasPrice?: string) {
        await retryTransaction(this._env, txHash, signerKey, gasPrice)
    }

    public async gasCost() {
        await getGasCost(this._env)
    }
}
