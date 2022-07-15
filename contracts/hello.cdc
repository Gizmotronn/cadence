// "pub" is shorthand for "public", meaning this contract can be accessed by anyone 
pub contract HelloWorld {
    // Resource for one function
    pub resource HelloAsset {
        pub fun hello(): String {
            return "gm, World"
        }
    }

    // Declare a public field of type String.
    pub let greeting: String

    // The init() function is required if the contract contains any fields.
    init() {
        self.greeting = "gm, World!"

        // Create a new instance of HelloAsset
        let newHello <- create HelloAsset()

        // Store the resource in private acct storage
        self.account.save(<-newHello, to: /storage/Hello)

        log("HelloAsset created and stored")
    }

    // Public function that returns our friendly greeting!
    pub fun hello(): String {
        return self.greeting
    }
}