const { task } = require("hardhat/config");

function getEnvVariable(key, defaultValue) {
    if (process.env[key]) {
        return process.env[key];
    }
    if (!defaultValue) {
        throw `${key} is not defined and no default value was provided`;
    }
    return defaultValue;
}

function getProvider() {
    return ethers.getDefaultProvider(getEnvVariable("NETWORK", "rinkeby"), {
        alchemy: getEnvVariable("ALCHEMY_KEY"),
    });
}

function getAccount() {
    return new ethers.Wallet(getEnvVariable("ACCOUNT_PRIVATE_KEY"), getProvider());
}

task("deploy", "Deploys the Lottery contract").setAction(async function (taskArguments, hre) {
    const lotteryFactory = await hre.ethers.getContractFactory("Lottery", getAccount());
    const lottery = await lotteryFactory.deploy();
    console.log(`Contract deployed to address: ${lottery.address}`);
    await lottery.deployed()
});