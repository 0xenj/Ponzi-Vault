const getGasCost = async (env: any) => {
    try {
        // Get current gas price
        const currentGasPrice = await env.ethers.provider.getGasPrice()
        console.log('\x1b[32m%s\x1b[0m', 'Connected to network: ', env.network.name)
        console.log('\x1b[34m%s\x1b[0m', 'Current gas price: ', env.ethers.BigNumber.from(currentGasPrice).toNumber())
        return currentGasPrice
    } catch (err) {
        console.log('\x1b[33m%s\x1b[0m', `Error: ${err}`)
    }
}

export default getGasCost
