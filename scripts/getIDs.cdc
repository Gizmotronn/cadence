import HotShot from 0xf8d6e0586b0a20c7

pub fun main(acct: Address): [UInt64] {
    let publicRef = getAccount(acct).getCapability(/public/HotShot2)
        .borrow<&HotShot.Collection{HotShot.CollectionPublic}>()
        ?? panic ("This account doesn't have a collection there")

    return publicRef.getIDs()
}