import HelloWorld from 0x02

// Call the hello method on HelloAsset object
transaction {
    prepare(acct: AuthAccount) {
        // load resource from storage
        let helloResource <- acct.load<@HelloWorld.HelloAsset>(from: /storage/Hello)

        log(helloResource?.hello())

        // Put the resource back in storage
        acct.save(<-helloResource!, to: /storage/Hello)
    }
}