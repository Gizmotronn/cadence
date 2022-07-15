import HotShot from 0xf8d6e0586b0a20c7

transaction {
    prepare(acct: AuthAccount) {
        let collectionReference =
            acct.borrow<@HotShot.Collection>(from: /storage/HotShot)
            ?? panic("No Collection Found!")

        collectionReference.deposit(token: <- HotShot.mintNFT())
    }

    execute {
        log("Minted an NFT and stored it into the collection")
    }
}