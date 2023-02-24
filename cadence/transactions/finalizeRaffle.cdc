import RaffleContract from 0xf3fcd2c1a78f5eee

transaction {

  let authAccount: AuthAccount
  
  prepare(authAccount: AuthAccount) {
    self.authAccount = authAccount
  }

  execute {
    let raffleAccount = getAccount(0xf3fcd2c1a78f5eee)
    let raffle = raffleAccount.getCapability<&{RaffleContract.RafflePublic}>(/public/RafflePublic)
    let raffleRef = raffle.borrow()!
    raffleRef.join(participant: self.authAccount.address)
  }
}
