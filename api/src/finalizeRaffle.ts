import * as fcl from "@onflow/fcl"
import * as t from "@onflow/types";
import * as fs from "fs";

import { utils, ecvrf, sortition } from 'vrf.js'

const finalizeRaffle = async () => {
    fcl.config()
    .put("accessNode.api", "http://localhost:8888")
    .put("challenge.handshake", "http://localhost:8701/flow/authenticate");
    
    const flowJson = JSON.parse(fs.readFileSync("../flow.json", "utf8"));

    const account = flowJson.accounts.default;
    const accountData = await fcl.account(account.address);

    const publicKey = accountData.keys[0].publicKey
    const privateKey = account.key;

    const X = Buffer.from('test')
    const {value, proof} = ecvrf.vrf(publicKey, privateKey, X)

    console.log("value", value)
    console.log("proof", proof)

    console.log("isValid?", ecvrf.verify(publicKey, X, proof, value))
}

finalizeRaffle()