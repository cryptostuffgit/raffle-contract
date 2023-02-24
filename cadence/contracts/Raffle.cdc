pub contract RaffleContract {

    pub event RaffleCreated(raffleName: String, creator: Address)
    pub event RaffleJoined(raffleName: String, participant: Address)
    pub event RaffleFinalized(raffleName: String)
    pub event WinnerAnnounced(raffleName: String, winner: Address)

    pub var oracleFee: Int

    pub resource interface RafflePublic {
        pub name: String
        pub description: String
        pub maxParticipants: Int
        pub participants: [Address]
        pub fun join(participant: Address)
    }

    pub resource interface RaffleOracle {
        pub fun submitVrf()
    }

    pub resource Raffle: RafflePublic {
        pub let name: String
        pub let description: String
        pub let maxParticipants: Int
        pub var participants: [Address]
        pub var isOpen: Bool

        init(_name: String, _description: String, _maxParticipants: Int) {
            self.name = _name
            self.description = _description
            self.maxParticipants = _maxParticipants
            self.participants = []
            self.isOpen = true
        }

        pub fun join(participant: Address) {
            pre {
                self.isOpen: "Sorry, this raffle has been finalized"
            }
            self.participants.append(participant)
            emit RaffleJoined(raffleName: self.name, participant: participant)
        }

        pub fun finalize() {
            pre {
                self.isOpen: "Sorry, you cannot finalize a raffle that has already been finalized"
            }
            self.isOpen = false
            emit RaffleFinalized(raffleName: self.name)
        }

        pub fun submitVrf() {
            
        }
    }

    init() {
        self.oracleFee = 1
    }

    pub fun createRaffle(authAccount: AuthAccount, name: String, description: String, maxParticipants: Int) {
        let raffle <- create Raffle(_name: name, _description: description, _maxParticipants: maxParticipants)
        authAccount.save(<- raffle, to: /storage/Raffle)
        authAccount.link<&{RafflePublic}>(/public/RafflePublic, target: /storage/Raffle)
        emit RaffleCreated(raffleName: name, creator: authAccount.address)
    }
}
