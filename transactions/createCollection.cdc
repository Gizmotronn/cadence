import HotShot from 0xf8d6e0586b0a20c7

transaction {
    prepare(acct: AuthAccount) {
        acct.save(<- HotShot.createCollection(), to: /storage/HotShot2)

        acct.link<&HotShow.Collection{HotShot.CollectionPublic}> // link both resources in different storage domains
            (/public/HotShot2, target: /storage/HotShot2)
    }

    execute {
        log("Stored a collection for the empty NFTs")
    }
}