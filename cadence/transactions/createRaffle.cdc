import RaffleContract from 0xf3fcd2c1a78f5eee

transaction {

  let authAccount: AuthAccount
  
  prepare(authAccount: AuthAccount) {
    self.authAccount = authAccount
  }

  execute {
    RaffleContract.createRaffle(
      authAccount: self.authAccount, 
      name: "test", 
      description: "hello world", 
      maxParticipants: 10
    )
  }
}