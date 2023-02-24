import * as fcl from "@onflow/fcl"
import { utils, ecvrf, sortition } from 'vrf.js'

const finalizeRaffle = async () => {
    const X = Buffer.from('test')
    const [publicKey, privateKey] = utils.generatePair()
    const {value, proof} = ecvrf.vrf(publicKey, privateKey, X)
}

finalizeRaffle()