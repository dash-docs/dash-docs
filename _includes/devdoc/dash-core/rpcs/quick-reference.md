{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/quick-reference.md" %}

#### Quick Reference {#rpc-quick-reference}
{% include helpers/subhead-links.md %}
<!-- __ -->
{% comment %}
Styling notes: use highly-visible style for upcoming changes (not yet
released) and changes made in the last 6 months.  Use less-visible
style for changes made up to two years ago.  Don't point out
changes made more than two years ago.

Use v0.n.n in abbreviation title to prevent autocrossrefing.
{% endcomment %}

<!-- Dash - Not Implemented -->
{% assign DASH_NOT_IMPLEMENTED='**<abbr title="Not Implemented in Dash">Not Implemented</abbr>**' %}

<!-- Dash Core 0.12.1.0 Feb 2017 -->
{% assign DASH_NEW0_12_1='*<abbr title="New in Dash Core v0.12.1">New in Dash Core 0.12.1</abbr>*' %}
{% assign DASH_UPDATED0_12_1='**<abbr title="Updated in Dash Core v0.12.1">Updated in Dash Core 0.12.1</abbr>**' %}

<!-- Deprecated -->
{% assign DEPRECATED='**<abbr title="Deprecated; will be removed in a future version of Bitcoin Core">Deprecated</abbr>**' %}

<!-- Bitcoin Core 0.14.1 April 2017 -->
{% assign UPDATED0_14_0='**<abbr title="Updated in Bitcoin Core v0.14.1">Updated in Bitcoin Core 0.14.1</abbr>**' %}

<!-- Bitcoin Core 0.14.0 March 2017 -->
{% assign NEW0_14_0='**<abbr title="New in Bitcoin Core v0.14.0">New in Bitcoin Core 0.14.0</abbr>**' %}
{% assign UPDATED0_14_0='**<abbr title="Updated in Bitcoin Core v0.14.0">Updated in Bitcoin Core 0.14.0</abbr>**' %}

<!-- Bitcoin Core 0.13.1 September 2016 -->
{% assign UPDATED0_13_1='*<abbr title="Updated in Bitcoin Core v0.13.1">Updated in Bitcoin Core 0.13.1</abbr>*' %}

<!-- Bitcoin Core 0.13.0 August 2016 -->
{% assign NEW0_13_0='*<abbr title="New in Bitcoin Core v0.13.0">New in Bitcoin Core 0.13.0</abbr>*' %}
{% assign UPDATED0_13_0='*<abbr title="Updated in Bitcoin Core v0.13.0">Updated in Bitcoin Core 0.13.0</abbr>*' %}

<!-- Bitcoin Core 0.12.1 April 2016 -->
{% assign UPDATED0_12_1='*<abbr title="Updated in Bitcoin Core v0.12.1">Updated in Bitcoin Core 0.12.1</abbr>*' %}

<!-- Bitcoin Core 0.12.0 February 2016 -->
{% assign NEW0_12_0='*<abbr title="New in Bitcoin Core v0.12.0">New in Bitcoin Core 0.12.0</abbr>*' %}
{% assign UPDATED0_12_0='*<abbr title="Updated in Bitcoin Core v0.12.0">Updated in Bitcoin Core 0.12.0</abbr>*' %}

<!-- Bitcoin Core 0.11.0 July 2015 -->
{% assign NEW0_11_0='*<abbr title="New in Bitcoin Core v0.11.0">New in Bitcoin Core 0.11.0</abbr>*' %}

<!-- the summaries used below are defined in the files for the
     particular RPC and aggregated into this helper file by the makefile
     function manual-update-summaries-file. For example, to edit the
     summary for GetBestBlockHash, edit
     _includes/rpc/getbestblockhash.md and run `make manual-update-summaries`. -->
{% include helpers/summaries.md %}

####RPC Summary Table

{% include layout/base/rpc-table.html %}

#### Addressindex RPCs
{:.no_toc}
<!-- no subhead-links here -->
These RPCs are all Dash-specific and not found in Bitcoin Core

{% autocrossref %}

* [GetAddressBalance][rpc getaddressbalance]: {{summary_getAddressBalance}}
* [GetAddressDeltas][rpc getaddressdeltas]: {{summary_getAddressDeltas}}
* [GetAddressMempool][rpc getaddressmempool]: {{summary_getAddressMempool}}
* [GetAddressTxids][rpc getaddresstxids]: {{summary_getAddressTxids}}
* [GetAddressUtxos][rpc getaddressutxos]: {{summary_getAddressUtxos}}

{% endautocrossref %}


#### Block Chain RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [GetBestBlockHash][rpc getbestblockhash]: {{summary_getBestBlockHash}}
* [GetBlock][rpc getblock]: {{summary_getBlock}} {{UPDATED0_13_0}}
* [GetBlockChainInfo][rpc getblockchaininfo]: {{summary_getBlockChainInfo}} {{UPDATED0_12_1}}
* [GetBlockCount][rpc getblockcount]: {{summary_getBlockCount}}
* [GetBlockHash][rpc getblockhash]: {{summary_getBlockHash}}
* [GetBlockHashes][rpc getblockhashes]: {{summary_getBlockHashes}} {{DASH_NEW0_12_1}}
* [GetBlockHeader][rpc getblockheader]: {{summary_getBlockHeader}} {{NEW0_12_0}}
* [GetBlockHeaders][rpc getblockheaders]: {{summary_getBlockHeaders}} {{DASH_NEW0_12_1}}
* [GetChainTips][rpc getchaintips]: {{summary_getChainTips}} {{DASH_UPDATED0_12_1}}
* [GetDifficulty][rpc getdifficulty]: {{summary_getDifficulty}}
* [GetMemPoolInfo][rpc getmempoolinfo]: {{summary_getMemPoolInfo}} {{UPDATED0_12_0}}
* [GetRawMemPool][rpc getrawmempool]: {{summary_getRawMemPool}} {{UPDATED0_13_0}}
* [GetSpentInfo][rpc getspentinfo]: {{summary_getSpentInfo}} {{DASH_NEW0_12_1}}
* [GetTxOut][rpc gettxout]: {{summary_getTxOut}}
* [GetTxOutProof][rpc gettxoutproof]: {{summary_getTxOutProof}} {{NEW0_11_0}}
* [GetTxOutSetInfo][rpc gettxoutsetinfo]: {{summary_getTxOutSetInfo}}
* [VerifyChain][rpc verifychain]: {{summary_verifyChain}}
* [VerifyTxOutProof][rpc verifytxoutproof]: {{summary_verifyTxOutProof}} {{NEW0_11_0}}

{% endautocrossref %}

**Not implemented in Dash**

{% autocrossref %}

* {{DASH_NOT_IMPLEMENTED}}  [GetMemPoolAncestors][rpc getmempoolancestors]: {{summary_getMemPoolAncestors}} {{NEW0_13_0}}
* {{DASH_NOT_IMPLEMENTED}}  [GetMemPoolDescendants][rpc getmempooldescendants]: {{summary_getMemPoolDescendants}} {{NEW0_13_0}}
* {{DASH_NOT_IMPLEMENTED}}  [GetMemPoolEntry][rpc  getmempoolentry]: {{summary_getMemPoolEntry}} {{NEW0_13_0}}
* {{DASH_NOT_IMPLEMENTED}}  [PreciousBlock][rpc preciousblock]: {{summary_preciousBlock}} {{NEW0_14_0}}
* {{DASH_NOT_IMPLEMENTED}}  [PruneBlockChain][rpc pruneblockchain]: {{summary_pruneBlockChain}} {{NEW0_14_0}}

{% endautocrossref %}

#### Control RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [Debug][rpc debug]: {{summary_debug}}
* [GetInfo][rpc getinfo]: {{summary_getInfo}} {{DEPRECATED}}
* [Help][rpc help]: {{summary_help}}
* [Stop][rpc stop]: {{summary_stop}}

{% endautocrossref %}

#### Dash RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [GetGovernanceInfo][rpc getgovernanceinfo]: {{summary_getGovernanceInfo}}
* [GetPoolInfo][rpc getpoolinfo]: {{summary_getPoolInfo}}
* [GetSuperblockBudget][rpc getsuperblockbudget]: {{summary_getSuperblockBudget}}
* [GObject][rpc gobject]: {{summary_gObject}}
* [Masternode][rpc masternode]: {{summary_masternode}}
* [MasternodeBroadcast][rpc masternodebroadcast]: {{summary_masternodeBroadcast}}
* [MasternodeList][rpc masternodelist]: {{summary_masternodeList}}
* [MnSync][rpc mnsync]: {{summary_mnSync}}
* [PrivateSend][rpc privatesend]: {{summary_privateSend}}
* [SentinelPing][rpc sentinelping]: {{summary_sentinelPing}}
* [Spork][rpc spork]: {{summary_spork-rpc}}
* [VoteRaw][rpc voteraw]: {{summary_voteRaw}}

{% endautocrossref %}

#### Generating RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [Generate][rpc generate]: {{summary_generate}} {{NEW0_11_0}}, {{UPDATED0_13_0}}
* [GetGenerate][rpc getgenerate]: {{summary_getGenerate}}
* [SetGenerate][rpc setgenerate]: {{summary_setGenerate}}
* {{DASH_NOT_IMPLEMENTED}}  [GenerateToAddress][rpc generatetoaddress]: {{summary_generateToAddress}} {{NEW0_13_0}}

{% endautocrossref %}

#### Mining RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [GetBlockTemplate][rpc getblocktemplate]: {{summary_getBlockTemplate}}
* [GetMiningInfo][rpc getmininginfo]: {{summary_getMiningInfo}} {{UPDATED0_14_0}}
* [GetNetworkHashPS][rpc getnetworkhashps]: {{summary_getNetworkHashPS}}
* [PrioritiseTransaction][rpc prioritisetransaction]: {{summary_prioritiseTransaction}}
* [SubmitBlock][rpc submitblock]: {{summary_submitBlock}}

{% endautocrossref %}

#### Network RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [AddNode][rpc addnode]: {{summary_addNode}} {{UPDATED0_14_0}}
* [ClearBanned][rpc clearbanned]: {{summary_clearBanned}} {{NEW0_12_0}}
* [DisconnectNode][rpc disconnectnode]: {{summary_disconnectNode}} {{NEW0_12_0}} {{UPDATED0_14_1}}
* [GetAddedNodeInfo][rpc getaddednodeinfo]: {{summary_getAddedNodeInfo}} {{UPDATED0_14_0}}
* [GetConnectionCount][rpc getconnectioncount]: {{summary_getConnectionCount}}
* [GetNetTotals][rpc getnettotals]: {{summary_getNetTotals}} {{UPDATED0_12_0}}
* [GetNetworkInfo][rpc getnetworkinfo]: {{summary_getNetworkInfo}} {{UPDATED0_13_0}}
* [GetPeerInfo][rpc getpeerinfo]: {{summary_getPeerInfo}} {{UPDATED0_13_0}}
* [ListBanned][rpc listbanned]: {{summary_listBanned}} {{NEW0_12_0}}
* [Ping][rpc ping]: {{summary_ping-rpc}}
* [SetBan][rpc setban]: {{summary_setBan}} {{NEW0_12_0}}
* [SetNetworkActive][rpc setnetworkactive]: {{summary_setNetworkActive}} {{NEW0_14_0}}

{% endautocrossref %}

#### Raw Transaction RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [CreateRawTransaction][rpc createrawtransaction]: {{summary_createRawTransaction}} {{UPDATED0_14_1}}
* [DecodeRawTransaction][rpc decoderawtransaction]: {{summary_decodeRawTransaction}} {{UPDATED0_13_0}}
* [DecodeScript][rpc decodescript]: {{summary_decodeScript}}
* [FundRawTransaction][rpc fundrawtransaction]: {{summary_fundRawTransaction}} {{NEW0_12_0}}, {{UPDATED0_14_0}}
* [GetRawTransaction][rpc getrawtransaction]: {{summary_getRawTransaction}} {{UPDATED0_14_0}}
* [SendRawTransaction][rpc sendrawtransaction]: {{summary_sendRawTransaction}}
* [SignRawTransaction][rpc signrawtransaction]: {{summary_signRawTransaction}}

{% endautocrossref %}

#### Utility RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [CreateMultiSig][rpc createmultisig]: {{summary_createMultiSig}}
* [EstimateFee][rpc estimatefee]: {{summary_estimateFee}}
* [EstimatePriority][rpc estimatepriority]: {{summary_estimatePriority}}
* [EstimateSmartFee][rpc estimatesmartfee]: {{summary_estimateSmartFee}} {{DEPRECATED}}
* [EstimateSmartPriority][rpc estimatesmartpriority]: {{summary_estimateSmartPriority}} {{DEPRECATED}}
* [ValidateAddress][rpc validateaddress]: {{summary_validateAddress}} {{UPDATED0_13_0}}
* [VerifyMessage][rpc verifymessage]: {{summary_verifyMessage}}

* {{DASH_NOT_IMPLEMENTED}}  [GetMemoryInfo][rpc getmemoryinfo]: {{summary_getMemoryInfo}} {{NEW_14_0}}

{% endautocrossref %}

#### Wallet RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

**Note:** the wallet RPCs are only available if Dash Core was built
with [wallet support][]{:#term-wallet-support}{:.term}, which is the
default.

* [AbandonTransaction][rpc abandontransaction]: {{summary_abandonTransaction}} {{NEW0_12_0}}
* [AddMultiSigAddress][rpc addmultisigaddress]: {{summary_addMultiSigAddress}}
* [BackupWallet][rpc backupwallet]: {{summary_backupWallet}}
  * [DumpHDInfo][rpc dumphdinfo]: {{summary_dumpHdInfo}}
* [DumpPrivKey][rpc dumpprivkey]: {{summary_dumpPrivKey}}
* [DumpWallet][rpc dumpwallet]: {{summary_dumpWallet}}
* [EncryptWallet][rpc encryptwallet]: {{summary_encryptWallet}}
* [GetAccount][rpc getaccount]: {{summary_getAccount}}
* [GetAccountAddress][rpc getaccountaddress]: {{summary_getAccountAddress}} {{DEPRECATED}}
* [GetAddressesByAccount][rpc getaddressesbyaccount]: {{summary_getAddressesByAccount}} {{DEPRECATED}}
* [GetBalance][rpc getbalance]: {{summary_getBalance}}
* [GetNewAddress][rpc getnewaddress]: {{summary_getNewAddress}}
* [GetRawChangeAddress][rpc getrawchangeaddress]: {{summary_getRawChangeAddress}}
* [GetReceivedByAccount][rpc getreceivedbyaccount]: {{summary_getReceivedByAccount}} {{DEPRECATED}}
* [GetReceivedByAddress][rpc getreceivedbyaddress]: {{summary_getReceivedByAddress}}
* [GetTransaction][rpc gettransaction]: {{summary_getTransaction}} {{UPDATED0_12_0}}
* [GetUnconfirmedBalance][rpc getunconfirmedbalance]: {{summary_getUnconfirmedBalance}}
* [GetWalletInfo][rpc getwalletinfo]: {{summary_getWalletInfo}}
* [ImportAddress][rpc importaddress]: {{summary_importAddress}}
    * [ImportElectrumWallet][rpc importelecturmwallet]: {{summary_importElectrumWallet}} {{DASH_NEW0_12_1}}
* [ImportPrivKey][rpc importprivkey]: {{summary_importPrivKey}}
    * [ImportPubKey][rpc importpubkey]: {{summary_importPubKey}}
* [ImportWallet][rpc importwallet]: {{summary_importWallet}}
  * [InstantSendToAddress][rpc instantsendtoaddress]: {{summary_instantSendToAddress}}
  * [Keepass][rpc keepass]: {{summary_keepass}}
* [KeyPoolRefill][rpc keypoolrefill]: {{summary_keyPoolRefill}}
* [ListAccounts][rpc listaccounts]: {{summary_listAccounts}} {{DEPRECATED}}
* [ListAddressGroupings][rpc listaddressgroupings]: {{summary_listAddressGroupings}}
* [ListLockUnspent][rpc listlockunspent]: {{summary_listLockUnspent}}
* [ListReceivedByAccount][rpc listreceivedbyaccount]: {{summary_listReceivedByAccount}} {{DEPRECATED}}
* [ListReceivedByAddress][rpc listreceivedbyaddress]: {{summary_listReceivedByAddress}}
* [ListSinceBlock][rpc listsinceblock]: {{summary_listSinceBlock}}
* [ListTransactions][rpc listtransactions]: {{summary_listTransactions}} {{UPDATED0_12_1}}
* [ListUnspent][rpc listunspent]: {{summary_listUnspent}} {{UPDATED0_13_0}}
* [LockUnspent][rpc lockunspent]: {{summary_lockUnspent}}
* [Move][rpc move]: {{summary_move}} {{DEPRECATED}}
* [SendFrom][rpc sendfrom]: {{summary_sendFrom}} {{DEPRECATED}}
* [SendMany][rpc sendmany]: {{summary_sendMany}}
* [SendToAddress][rpc sendtoaddress]: {{summary_sendToAddress}}
* [SetAccount][rpc setaccount]: {{summary_setAccount}} {{DEPRECATED}}
* [SetTxFee][rpc settxfee]: {{summary_setTxFee}}
* [SignMessage][rpc signmessage]: {{summary_signMessage}}
* [WalletLock][rpc walletlock]: {{summary_walletLock}}
* [WalletPassphrase][rpc walletpassphrase]: {{summary_walletPassphrase}}
* [WalletPassphraseChange][rpc walletpassphrasechange]: {{summary_walletPassphraseChange}}

* {{DASH_NOT_IMPLEMENTED}}  [AddWitnessAddress][rpc addwitnessaddress]: {{summary_addWitnessAddress}} {{NEW0_13_0}}
* {{DASH_NOT_IMPLEMENTED}}  [BumpFee][rpc bumpfee]: {{summary_bumpFee}} {{NEW0_14_0}}
* {{DASH_NOT_IMPLEMENTED}}  [ImportMulti][rpc importmulti]: {{summary_importMulti}} {{NEW0_14_0}}
* {{DASH_NOT_IMPLEMENTED}}  [ImportPrunedFunds][rpc importprunedfunds]: {{summary_importPrunedFunds}} {{NEW0_13_0}}
* {{DASH_NOT_IMPLEMENTED}}  [RemovePrunedFunds][rpc removeprunedfunds]: {{summary_removePrunedFunds}} {{NEW0_13_0}}
* {{DASH_NOT_IMPLEMENTED}}  [SignMessageWithPrivKey][rpc signmessagewithprivkey]: {{summary_signMessageWithPrivKey}}  {{NEW0_13_0}}

{% endautocrossref %}

#### Removed RPCs
{:.no_toc}
<!-- no subhead-links here -->

{% autocrossref %}

* [GetHashesPerSec][rpc gethashespersec]: {{summary_getHashesPerSec}}
* [GetWork][rpc getwork]: {{summary_getWork}}
<!-- Still in Dash
* [GetGenerate][rpc getgenerate]: {{summary_getGenerate}}
* [SetGenerate][rpc setgenerate]: {{summary_setGenerate}}
-->
{% endautocrossref %}
