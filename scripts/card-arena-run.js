const { getContractFactory } = require("@nomiclabs/hardhat-ethers/types");

const main = async () => {
    const gameContractFactory = await hre.ethers.getContractFactory("CardArena");
    const gameContract = await gameContractFactory.deploy(
        ["Gizmo", "Opus", "Scrooby"], // Names -> character attributes
        [
            "",
            "",
            "",
            [100, 200, 300],
            [100, 50, 25],
        ]
    );
    await gameContract.deployed()
    console.log("Game Arena contract deployed to: ", gameContract.address);

    let txn;
    txn = await gameContract.mintCharacterNFT(2);
    await txn.wait();
    let returnedTokenUri = await gameContract.tokenURI(1); // get the value of the desired nft
    console.log("Token URI: ", returnedTokenUri);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();