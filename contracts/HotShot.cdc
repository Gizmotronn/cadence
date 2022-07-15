pub contract HotShot {
    pub var totalSupply: UInt64 // mint calculator

    // Declare nft resource type
    pub resource NFT {
        pub let id: UInt64

        // String mapping to hold metadata
        //pub var metadata: {String: String}

        init() {
            self.id = HotShot.totalSupply
            HotShot.totalSupply = HotShot.totalSupply + (1 as UInt64)
        }
    }

    // Expose the getIDs function
    pub resource interface CollectionPublic {
        pub fun getIDs(): [UInt64]
    }

    // All the NFTs any one account owns
    pub resource Collection: CollectionPublic {
        // Dictionary -> maps ID integers with NFT resources
        pub var ownedNFTs: @{UInt64: NFT}

        // Deposit an NFT into the collection
        pub fun deposit(token: @NFT) {
            self.ownedNFTs[token.id] <-! token // Move the NFT into the ownedNFTs dictionary
        }

        pub fun withdraw(id: UInt64): @NFT {
            let token <- self.ownedNFTs.remove(key: id) ?? // Pull out the NFT resource from the dictionary
                panic("This collection doesn't contain an NFT with that ID")

            return <- token
        }

        // Array of ints
        pub fun getIDs(): [UInt64] {
            return self.ownedNFTs.keys // Each key is an NFT ID
        }

        init() {
            self.ownedNFTs <- {}
        }

        destroy() {
            destroy self.ownedNFTs // burns entire collection
        }
    }

    pub fun createCollection(): @Collection {
        return <- create Collection()
    }

    pub fun mintNFT(): @NFT {
        return <- create NFT()
    }

    init() {
        self.totalSupply = 0
    }

    /*init() {
        self.account.save<@NFT>(<-create NFT(initID: 1), to: /storage/HotShot1)
    }*/
}