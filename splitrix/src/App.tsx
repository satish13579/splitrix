import React from "react";
import logo from "./logo.svg";
import "./App.css";
import {
  Aptos,
  AptosConfig,
  Network,
  AccountAddress,
  Account,
  Ed25519PrivateKey
} from "@aptos-labs/ts-sdk";
import { useEffect, useState } from "react";
import { sign } from "crypto";
import { WalletButton } from "./walletbutton";import './App.css';
import Home from './components/Home';


function App() {
  const [accountAddress, setAccountAddress] = useState(null);


  const setAccount = (address) => {
    setAccountAddress(address);
  };
  



  useEffect(() => {
    async function ab() {
      const config = new AptosConfig({ network: Network.DEVNET });
      const aptosClient = new Aptos(config);
      const privateKey = new Ed25519PrivateKey(
        "0xd44880bf8180e8b70cb116da16cdbe813262bca2f7f2ddfdb252cd69020c8c1f"
      );

      const CONTRACT_ADDRESS =
        "0xa21eb1a7a80b2fa320ce11f9a8e7e42634558117b3e8f5ac50dac1a08780cb74";
      const MODULE = "split";
      let method1 = "store_cap";
      let method2 = "get_groups";
      let method3 = "create_group";
      const account = await Account.fromPrivateKey({ privateKey });
      console.log(account.accountAddress.toString());

      const address = AccountAddress.from(
        "cbc8b8d91dcbd4b404d0627d249ce86fcff0991be851b53c7f69b940fefd6125"
      );

      console.log(address, privateKey);


      const transaction = await aptosClient.transaction.build.simple({
        sender: account.accountAddress,
        data: {
          function: `${CONTRACT_ADDRESS}::${MODULE}::${method1}`,
          functionArguments: [],
        },
      });

      const committedTransaction = await aptosClient.signAndSubmitTransaction({
        signer: account,
        transaction,
      });

      console.log(committedTransaction); 

      var members = ["0x1", "0x2", "0x3", "0x4", "0x5"];

      const transaction1 = await aptosClient.transaction.build.simple({
        sender: account.accountAddress,
        data: {
          function: `${CONTRACT_ADDRESS}::${MODULE}::${method3}`,
          typeArguments:[],
          functionArguments: [members],
        },
      });

      const committedTransaction1 = await aptosClient.signAndSubmitTransaction({
        signer: account,
        transaction: transaction1,
      });

      console.log(committedTransaction1);

      const response = await aptosClient.view({payload:{
        function: `${CONTRACT_ADDRESS}::${MODULE}::${method2}`,
        functionArguments: [address],
      }});


      
      console.log(response);

    }
    ab();  
  }, []);
  return (
    <div className="App">
      <Home/>
    </div>
  );
}

export default App;
