const ERC20Maker = artifacts.require('./ERC20Maker.sol');

module.exports = async function (deployer) {
    const instance = await deployer.deploy(
        ERC20Maker,
    )
}