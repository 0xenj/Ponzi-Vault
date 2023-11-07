import { getNewGasPrice, getSigner, getTransaction, replaceTransactionIfNecessary } from './utils'

const retryTransaction = async (env: any, txHash: string, signerKey: string, gasPrice?: string) => {
    try {
        const signer = await getSigner(env, signerKey)
        const tx = await getTransaction(signer, txHash)
        if (tx === null) return null

        // Check if transaction is mined
        if (tx.blockNumber)
            console.log('\x1b[32m%s\x1b[0m', `Transaction ${txHash} was mined, in block ${tx.blockNumber}`)
        else if (tx.from === signer.address && tx.gasPrice !== undefined && tx.gasLimit !== undefined) {
            return replaceTransactionIfNecessary(env, signer, tx, txHash, gasPrice)
        } else
            console.log(
                '\x1b[33m%s\x1b[0m',
                `${
                    tx.from === signer.address
                        ? `Error: tx.gasPrice or tx.gasLimit is undefined`
                        : `Transaction ${txHash} is not from the same sender, original sender: ${tx.from}, current sender: ${signer.address}`
                }`
            )
    } catch (err) {
        console.log('\x1b[33m%s\x1b[0m', `Error: ${err}`)
    }
}

export default retryTransaction
