import {
    useWallet,
    WalletReadyState,
    Wallet,
    isRedirectable,
    WalletName,
  } from "@aptos-labs/wallet-adapter-react";
import React, { useEffect, useState } from "react";

export const WalletButton = () => {
    const { account, wallets, connected, disconnect, isLoading } = useWallet();

    const displayAccountAddress = () => {
        if (account) {
          return <div>Account Address: {account.address}</div>;
        }
        return null;
      };

    if (connected) {
        return (
            <>
            <button onClick={disconnect}>Disconnect</button>
            {displayAccountAddress()}
            </>
        )
    }

    if (isLoading) {
        return <button disabled>Loading...</button>
    }

    return wallets ? <WalletView wallet={wallets[0]} /> : null;

}

const WalletView = ({ wallet }: { wallet: Wallet }) => {
    const { connect } = useWallet();
    const isWalletReady =
        wallet.readyState === WalletReadyState.Installed ||
        wallet.readyState === WalletReadyState.Loadable;

    
    const onWalletConnectRequest = async (walletName: WalletName) => {
        try {
            await connect(walletName)
        } catch (error) {
            console.warn(error);
            window.alert("Failed to connect wallet");
        }
    };

    return (
        <button
            disabled={!isWalletReady}
            onClick={() => onWalletConnectRequest(wallet.name)}
        >
            Connect Wallet
        </button>
    );
}