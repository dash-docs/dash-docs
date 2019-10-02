{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}

{% comment %}<!-- Terms; must have tooltip description in "quotes"; alphabetical order -->{% endcomment %}
[blocktransactions]: /en/developer-reference#blocktxn "A P2P Networking data structure used to provide some of the transactions in a block as requested"
[blocktransactionsrequest]: /en/developer-reference#getblocktxn "A P2P Networking data structure used to list transaction indexes in a block being requested by a peer"
[coinbase block height]: /en/developer-reference#term-coinbase-block-height "The current block's height encoded into the first bytes of the coinbase field"
[data-pushing opcode]: https://en.bitcoin.it/wiki/Script#Constants "Any opcode from 0x01 to 0x4e which pushes data on to the script evaluation stack"
[headerandshortids]: /en/developer-reference#cmpctblock "A P2P Networking data structure used to relay a block header, the short transactions IDs used for matching already-available transactions, and a select few transactions which a peer may be missing"
[key index]: /en/developer-guide#term-key-index "An index number used in the HD wallet formula to generate child keys from a parent key"
[key pair]: /en/developer-guide#term-key-pair "A private key and its derived public key"
<!-- Inventory Messages -->
[msg_tx]: /en/developer-reference#term-msg_tx "The TXID data type identifier of an inventory on the P2P network"
[msg_block]: /en/developer-reference#term-msg_block "The block header hash data type identifier of an inventory on the P2P network"
[msg_filtered_block]: /en/developer-reference#term-msg_block "An alternative to the block header hash data type identifier of an inventory on the P2P network used to request a merkle block"
<!-- Inventory Messages: Dash Specific -->
[msg_clsig]: /en/developer-reference#term-msg_clsig "The ChainLock Signature data type identifier of an inventory on the P2P network"
[msg_islock]: /en/developer-reference#term-msg_islock "The LLMQ-based InstantSend Lock data type identifier of an inventory on the P2P network"
[msg_txlock_request]: /en/developer-reference#term-msg_txlock_request "The InstantSend TX Lock request data type identifier of an inventory on the P2P network"
[msg_txlock_vote]: /en/developer-reference#term-msg_txlock_vote "The InstantSend TX Lock vote data type identifier of an inventory on the P2P network"
[msg_spork]: /en/developer-reference#term-msg_spork "The Spork ID data type identifier of an inventory on the P2P network"
[msg_masternode_payment_vote]: /en/developer-reference#term-msg_masternode_payment_vote "Masternode Payment Vote data type identifier of an inventory on the P2P network"
[msg_masternode_payment_block]: /en/developer-reference#term-msg_masternode_payment_block "Masternode Payment Block data type identifier of an inventory on the P2P network"
[msg_budget_vote]: /en/developer-reference#term-msg_budget_vote "Deprecated budget related data type identifier of an inventory on the P2P network"
[msg_budget_proposal]: /en/developer-reference#term-msg_budget_proposal "Deprecated budget related data type identifier of an inventory on the P2P network"
[msg_budget_finalized]: /en/developer-reference#term-msg_budget_finalized "Deprecated budget related data type identifier of an inventory on the P2P network"
[msg_budget_finalized_vote]: /en/developer-reference#term-msg_budget_finalized_vote "Deprecated budget related data type identifier of an inventory on the P2P network"
[msg_masternode_quorum]: /en/developer-reference#term-msg_masternode_quorum "Not implemented"
[msg_masternode_announce]: /en/developer-reference#term-msg_masternode_announce "Masternode broadcast data type identifier of an inventory on the P2P network"
[msg_masternode_ping]: /en/developer-reference#term-msg_masternode_ping "Masternode Ping data type identifier of an inventory on the P2P network"
[msg_dstx]: /en/developer-reference#term-msg_dstx "PrivateSend TX broadcast data type identifier of an inventory on the P2P network"
[msg_governance_object]: /en/developer-reference#term-msg_governance_object "Governance object data type identifier of an inventory on the P2P network"
[msg_governance_object_vote]: /en/developer-reference#term-msg_governance_object_vote "Governance object vote data type identifier of an inventory on the P2P network"
[msg_masternode_verify]: /en/developer-reference#term-msg_masternode_verify "Masternode Verify data type identifier of an inventory on the P2P network"
[msg_cmpct_block]: /en/developer-reference#term-msg_cmpct_block "An alternative to the block header hash data type identifier of an inventory on the P2P network used to request a compact block"
[msg_quorum_complaint]: /en/developer-reference#term-msg_quorum_complaint "The Long-Living Masternode Quorum Complaint data type identifier of an inventory on the P2P network"
[msg_quorum_contrib]: /en/developer-reference#term-msg_quorum_contrib "The Long-Living Masternode Quorum Contribution data type identifier of an inventory on the P2P network"
[msg_quorum_debug_status]: /en/developer-reference#term-msg_quorum_debug_status "The Long-Living Masternode Quorum Debug Status data type identifier of an inventory on the P2P network"
[msg_quorum_justification]: /en/developer-reference#term-msg_quorum_justification "The Long-Living Masternode Quorum Justification data type identifier of an inventory on the P2P network"
[msg_quorum_final_commitment]: /en/developer-reference#term-msg_quorum_final_commitment "The Long-Living Masternode Quorum Final Commitment data type identifier of an inventory on the P2P network"
[msg_quorum_premature_commitment]: /en/developer-reference#term-msg_quorum_premature_commitment "The Long-Living Masternode Quorum Premature Commitment data type identifier of an inventory on the P2P network"
[msg_quorum_recovered_sig]: /en/developer-reference#term-msg_quorum_recovered_sig "The Long-Living Masternode Quorum Recovered Signature data type identifier of an inventory on the P2P network"
[network]: /en/developer-guide#term-network "The Dash P2P network which broadcasts transactions and blocks"
[op_checkmultisig]: /en/developer-reference#term-op-checkmultisig "Opcode which returns true if one or more provided signatures (m) sign the correct parts of a transaction and match one or more provided public keys (n)"
[op_checksig]: /en/developer-reference#term-op-checksig "Opcode which returns true if a signature signs the correct parts of a transaction and matches a provided public key"
[op_dup]: /en/developer-reference#term-op-dup "Operation which duplicates the entry below it on the stack"
[op_equal]: /en/developer-reference#term-op-equal "Operation which returns true if the two entries below it on the stack are equivalent"
[op_equalverify]: /en/developer-reference#term-op-equalverify "Operation which terminates the script in failure unless the two entries below it on the stack are equivalent"
[op_hash160]: /en/developer-reference#term-op-hash160 "Operation which converts the entry below it on the stack into a RIPEMD(SHA256()) hashed version of itself"
[op_return]: /en/developer-reference#term-op-return "Operation which terminates the script in failure"
[op_verify]: /en/developer-reference#term-op-verify "Operation which terminates the script if the entry below it on the stack is non-true (zero)"
[output index]: /en/developer-guide#term-output-index "The sequentially-numbered index of outputs in a single transaction starting from 0"
[point function]: /en/developer-guide#term-point-function "The ECDSA function used to create a public key from a private key"
[prefilledtransaction]: /en/developer-reference#cmpctblock "A P2P Networking data structure used to represent a vector of a few transactions"
[previous block header hash]: /en/developer-reference#term-previous-block-header-hash "A field in the block header which contains the SHA256(SHA256()) hash of the previous block's header"
[proper money handling]: /en/developer-reference#term-proper-money-handling "Bitcoin amounts need to be correctly processed without introducing rounding errors that could cause monetary loss"
[standard block relay]: /en/developer-guide#term-standard-block-relay "The regular block relay method: announcing a block with an inv message and waiting for a response"
[transaction]: /en/developer-guide#transactions "A transaction spending satoshis"
[transaction version number]: /en/developer-guide#term-transaction-version-number "A version number prefixed to transactions to allow upgrading""
[transactions]: /en/developer-guide#transactions "A transaction spending satoshis"
[unencrypted wallet]: /en/developer-reference#encryptwallet "A wallet that has not been encrypted with the encryptwallet RPC"
[unique addresses]: /en/developer-guide#term-unique-address "Address which are only used once to protect privacy and increase security"
[unlocked wallet]: /en/developer-reference#walletpassphrase "An encrypted wallet that has been unlocked with the walletpassphrase RPC"
[unsolicited block push]: /en/developer-guide#term-unsolicited-block-push "When a miner sends a block message without sending an inv message first"
[v2 block]: /en/developer-reference#term-v2-block "The current version of Bitcoin blocks"
[wallet support]: /en/developer-reference#term-wallet-support "A Dash Core ./configure option that enables (default) or disables the wallet"

{% comment %}<!-- RPCs; alphabetical order -->{% endcomment %}
[rpc abandontransaction]: /en/developer-reference#abandontransaction
[rpc abortrescan]: /en/developer-reference#abortrescan
[rpc addmultisigaddress]: /en/developer-reference#addmultisigaddress
[rpc addnode]: /en/developer-reference#addnode
[rpc backupwallet]: /en/developer-reference#backupwallet
[rpc bls]: /en/developer-reference#bls
[rpc clearbanned]: /en/developer-reference#clearbanned
[rpc createmultisig]: /en/developer-reference#createmultisig
[rpc combinerawtransaction]: /en/developer-reference#combinerawtransaction
[rpc createrawtransaction]: /en/developer-reference#createrawtransaction
[rpc debug]: /en/developer-reference#debug
[rpc decoderawtransaction]: /en/developer-reference#decoderawtransaction
[rpc decodescript]: /en/developer-reference#decodescript
[rpc disconnectnode]: /en/developer-reference#disconnectnode
[rpc dumphdinfo]: /en/developer-reference#dumphdinfo
[rpc dumpprivkey]: /en/developer-reference#dumpprivkey
[rpc dumpwallet]: /en/developer-reference#dumpwallet
[rpc encryptwallet]: /en/developer-reference#encryptwallet
[rpc estimatefee]: /en/developer-reference#estimatefee
[rpc estimatepriority]: /en/developer-reference#estimatepriority
[rpc estimatesmartfee]: /en/developer-reference#estimatesmartfee
[rpc estimatesmartpriority]: /en/developer-reference#estimatesmartpriority
[rpc fundrawtransaction]: /en/developer-reference#fundrawtransaction
[rpc generate]: /en/developer-reference#generate
[rpc generatetoaddress]: /en/developer-reference#generatetoaddress
[rpc getaccount]: /en/developer-reference#getaccount
[rpc getaccountaddress]: /en/developer-reference#getaccountaddress
[rpc getaddednodeinfo]: /en/developer-reference#getaddednodeinfo
[rpc getaddressbalance]: /en/developer-reference#getaddressbalance
[rpc getaddressdeltas]: /en/developer-reference#getaddressdeltas
[rpc getaddressesbyaccount]: /en/developer-reference#getaddressesbyaccount
[rpc getaddressmempool]: /en/developer-reference#getaddressmempool
[rpc getaddresstxids]: /en/developer-reference#getaddresstxids
[rpc getaddressutxos]: /en/developer-reference#getaddressutxos
[rpc getbalance]: /en/developer-reference#getbalance
[rpc getbestblockhash]: /en/developer-reference#getbestblockhash
[rpc getbestchainlock]: /en/developer-reference#getbestchainlock
[rpc getblock]: /en/developer-reference#getblock
[rpc getblockchaininfo]: /en/developer-reference#getblockchaininfo
[rpc getblockcount]: /en/developer-reference#getblockcount
[rpc getblockhash]: /en/developer-reference#getblockhash
[rpc getblockhashes]: /en/developer-reference#getblockhashes
[rpc getblockheader]: /en/developer-reference#getblockheader
[rpc getblockheaders]: /en/developer-reference#getblockheaders
[rpc getblockstats]: /en/developer-reference#getblockstats
[rpc getblocktemplate]: /en/developer-reference#getblocktemplate
[rpc getchaintips]: /en/developer-reference#getchaintips
[rpc getchaintxstats]: /en/developer-reference#getchaintxstats
[rpc getconnectioncount]: /en/developer-reference#getconnectioncount
[rpc getdifficulty]: /en/developer-reference#getdifficulty
[rpc getgenerate]: /en/developer-reference#getgenerate
[rpc getgovernanceinfo]: /en/developer-reference#getgovernanceinfo
[rpc gethashespersec]: /en/developer-reference#gethashespersec
[rpc getinfo]: /en/developer-reference#getinfo
[rpc getmemoryinfo]: /en/developer-reference#getmemoryinfo
[rpc getmempoolancestors]: /en/developer-reference#getmempoolancestors
[rpc getmempooldescendants]: /en/developer-reference#getmempooldescendants
[rpc getmempoolentry]: /en/developer-reference#getmempoolentry
[rpc getmempoolinfo]: /en/developer-reference#getmempoolinfo
[rpc getmerkleblocks]: /en/developer-reference#getmerkleblocks
[rpc getmininginfo]: /en/developer-reference#getmininginfo
[rpc getnettotals]: /en/developer-reference#getnettotals
[rpc getnetworkhashps]: /en/developer-reference#getnetworkhashps
[rpc getnetworkinfo]: /en/developer-reference#getnetworkinfo
[rpc getnewaddress]: /en/developer-reference#getnewaddress
[rpc getpeerinfo]: /en/developer-reference#getpeerinfo
[rpc getpoolinfo]: /en/developer-reference#getpoolinfo
[rpc getrawchangeaddress]: /en/developer-reference#getrawchangeaddress
[rpc getrawmempool]: /en/developer-reference#getrawmempool
[rpc getrawtransaction]: /en/developer-reference#getrawtransaction
[rpc getreceivedbyaccount]: /en/developer-reference#getreceivedbyaccount
[rpc getreceivedbyaddress]: /en/developer-reference#getreceivedbyaddress
[rpc getspecialtxes]: /en/developer-reference#getspecialtxes
[rpc getspentinfo]: /en/developer-reference#getspentinfo
[rpc getsuperblockbudget]: /en/developer-reference#getsuperblockbudget
[rpc gettransaction]: /en/developer-reference#gettransaction
[rpc gettxout]: /en/developer-reference#gettxout
[rpc gettxoutproof]: /en/developer-reference#gettxoutproof
[rpc gettxoutsetinfo]: /en/developer-reference#gettxoutsetinfo
[rpc getunconfirmedbalance]: /en/developer-reference#getunconfirmedbalance
[rpc getwalletinfo]: /en/developer-reference#getwalletinfo
[rpc getwork]: /en/developer-reference#getwork
[rpc gobject]: /en/developer-reference#gobject
[rpc help]: /en/developer-reference#help
[rpc importaddress]: /en/developer-reference#importaddress
[rpc importelectrumwallet]: /en/developer-reference#importelectrumwallet
[rpc importmulti]: /en/developer-reference#importmulti
[rpc importprivkey]: /en/developer-reference#importprivkey
[rpc importprunedfunds]: /en/developer-reference#importprunedfunds
[rpc importpubkey]: /en/developer-reference#importpubkey
[rpc importwallet]: /en/developer-reference#importwallet
[rpc keepass]: /en/developer-reference#keepass
[rpc keypoolrefill]: /en/developer-reference#keypoolrefill
[rpc listaccounts]: /en/developer-reference#listaccounts
[rpc listaddressbalances]: /en/developer-reference#listaddressbalances
[rpc listaddressgroupings]: /en/developer-reference#listaddressgroupings
[rpc listbanned]: /en/developer-reference#listbanned
[rpc listlockunspent]: /en/developer-reference#listlockunspent
[rpc listreceivedbyaccount]: /en/developer-reference#listreceivedbyaccount
[rpc listreceivedbyaddress]: /en/developer-reference#listreceivedbyaddress
[rpc listsinceblock]: /en/developer-reference#listsinceblock
[rpc listtransactions]: /en/developer-reference#listtransactions
[rpc listunspent]: /en/developer-reference#listunspent
[rpc listwallets]: /en/developer-reference#listwallets
[rpc lockunspent]: /en/developer-reference#lockunspent
[rpc logging]: /en/developer-reference#logging
[rpc masternode]: /en/developer-reference#masternode
[rpc masternodebroadcast]: /en/developer-reference#masternodebroadcast
[rpc masternodelist]: /en/developer-reference#masternodelist
[rpc mnsync]: /en/developer-reference#mnsync
[rpc move]: /en/developer-reference#move
[rpc ping]: /en/developer-reference#ping-rpc
[rpc protx]: /en/developer-reference#protx
[rpc preciousblock]: /en/developer-reference#preciousblock
[rpc pruneblockchain]: /en/developer-reference#pruneblockchain
[rpc prioritisetransaction]: /en/developer-reference#prioritisetransaction
[rpc privatesend]: /en/developer-reference#privatesend
[rpc quorum]: /en/developer-reference#quorum
[rpc removeprunedfunds]: /en/developer-reference#removeprunedfunds
[rpc sendfrom]: /en/developer-reference#sendfrom
[rpc sendmany]: /en/developer-reference#sendmany
[rpc sendrawtransaction]: /en/developer-reference#sendrawtransaction
[rpc sendtoaddress]: /en/developer-reference#sendtoaddress
[rpc setaccount]: /en/developer-reference#setaccount
[rpc setban]: /en/developer-reference#setban
[rpc setgenerate]: /en/developer-reference#setgenerate
[rpc setnetworkactive]: /en/developer-reference#setnetworkactive
[rpc setprivatesendamount]: /en/developer-reference#setprivatesendamount
[rpc setprivatesendrounds]: /en/developer-reference#setprivatesendrounds
[rpc settxfee]: /en/developer-reference#settxfee
[rpc signmessage]: /en/developer-reference#signmessage
[rpc signmessagewithprivkey]: /en/developer-reference#signmessagewithprivkey
[rpc signrawtransaction]: /en/developer-reference#signrawtransaction
[rpc sentinelping]: /en/developer-reference#sentinelping
[rpc spork]: /en/developer-reference#spork-rpc
[rpc stop]: /en/developer-reference#stop
[rpc submitblock]: /en/developer-reference#submitblock
[rpc uptime]: /en/developer-reference#uptime
[rpc validateaddress]: /en/developer-reference#validateaddress
[rpc verifychain]: /en/developer-reference#verifychain
[rpc verifymessage]: /en/developer-reference#verifymessage
[rpc verifytxoutproof]: /en/developer-reference#verifytxoutproof
[rpc voteraw]: /en/developer-reference#voteraw
[rpc walletlock]: /en/developer-reference#walletlock
[rpc walletpassphrase]: /en/developer-reference#walletpassphrase
[rpc walletpassphrasechange]: /en/developer-reference#walletpassphrasechange

{% comment %}<!-- REST requests; alphabetical order -->{% endcomment %}
[rest get block]: /en/developer-reference#get-block
[rest get block-notxdetails]: /en/developer-reference#get-blocknotxdetails
[rest get chaininfo]: /en/developer-reference#get-chaininfo
[rest get getutxos]: /en/developer-reference#get-getutxos
[rest get headers]: /en/developer-reference#get-headers
[rest get mempool-contents]: /en/developer-reference#get-mempoolcontents
[rest get mempool-info]: /en/developer-reference#get-mempoolinfo
[rest get tx]: /en/developer-reference#get-tx

{% comment %}<!-- P2P protocol messages; alphabetical order -->{% endcomment %}
[addr message]: /en/developer-reference#addr "The P2P network message which relays IP addresses and port numbers of active nodes to other nodes and clients, allowing decentralized peer discovery."
[alert message]: /en/developer-reference#alert "The P2P network message which sends alerts in case of major software problems."
[block message]: /en/developer-reference#block "The P2P network message which sends a serialized block"
[blocktxn message]: /en/developer-reference#blocktxn "The P2P network message which sends a list of requested transactions from a compact block"
[cmpctblock message]: /en/developer-reference#cmpctblock "The P2P network message which sends a serialized compact block"
[clsig message]: /en/developer-reference#clsig "The P2P network message which sends a ChainLock signature"
[dsa message]: /en/developer-reference#dsa "A P2P network message used to join a mixing pool"
[dsc message]: /en/developer-reference#dsc "A P2P network message used to indicates a PrivateSend mixing session is complete"
[dsf message]: /en/developer-reference#dsf "A P2P network message sent as the final mixing transaction in a session asking users to sign the final mixing TX messages"
[dsi message]: /en/developer-reference#dsi "A P2P network message sending a user's inputs, collateral, and outputs for a mixing session"
[dss message]: /en/developer-reference#dss "A P2P network message which sends the user’s signed inputs for a group transaction in a mixing session"
[dssu message]: /en/developer-reference#dssu "A P2P network message providing a mixing pool status update"
[dsq message]: /en/developer-reference#dsq "A P2P network message sent to indicate the queue is ready and the user is expected to send the entry inputs to start mixing"
[dstx message]: /en/developer-reference#dstx "A P2P network message sent by masternodes to broadcast subsidized transactions without fees (provides security in mixing)"
{% comment %}<!-- Fee Filter not currently implemented in Dash Core. [feefilter message]: /en/developer-reference#feefilter "The P2P network message which requests the receiving peer not relay any transactions below the specified fee rate" -->{% endcomment %}
[filteradd message]: /en/developer-reference#filteradd "A P2P protocol message used to add a data element to an existing bloom filter."
[filterclear message]: /en/developer-reference#filterclear "A P2P protocol message used to remove an existing bloom filter."
[filterload message]: /en/developer-reference#filterload "A P2P protocol message used to send a filter to a remote peer, requesting that they only send transactions which match the filter."
[getaddr message]: /en/developer-reference#getaddr "A P2P protool message used to request an addr message containing connection information for other nodes"
[getblocks message]: /en/developer-reference#getblocks "A P2P protocol message used to request an inv message containing a range of block header hashes"
[getblocktxn message]: /en/developer-reference#getblocktxn "A P2P protocol message used to request transactions from a compact block"
[getdata message]: /en/developer-reference#getdata "A P2P protocol message used to request one or more transactions, blocks, or merkle blocks"
[getheaders message]: /en/developer-reference#getheaders "A P2P protocol message used to request a range of block headers"
[getmnlistd message]: /en/developer-reference#getmnlistd "A P2P protool message used to request a simplified masternode list"
[getsporks message]: /en/developer-reference#getsporks "A P2P network message used to request the status of sporks"
[govobj message]: /en/developer-reference#govobj "A P2P network message used to send governance objects (proposals, etc.)"
[govobjvote message]: /en/developer-reference#govobjvote "A P2P network message used to send governance object votes"
[govsync message]: /en/developer-reference#govsync "A P2P network message used to synchronize governance objects"
[headers message]: /en/developer-reference#headers "A P2P protocol message containing one or more block headers"
[inv message]: /en/developer-reference#inv "A P2P protocol message used to send inventories of transactions and blocks known to the transmitting peer"
[islock message]: /en/developer-reference#islock "A P2P protocol message which sends a LLQM-based InstantSend lock"
[ix message]: /en/developer-reference#ix "A P2P protocol message which sends a single serialized transaction via InstantSend"
[mempool message]: /en/developer-reference#mempool "A P2P protocol message used to request one or more inv messages with currently-unconfirmed transactions"
[merkleblock message]: /en/developer-reference#merkleblock "A P2P protocol message used to request a filtered block useful for SPV proofs"
[mnauth message]: /en/developer-reference#mnauth "A P2P protocol message used to authenticate connections between masternodes"
[mnlistdiff message]: /en/developer-reference#mnlistdiff "A P2P protocol message used to send a diff of simplified masternode list entries between two blocks"
[notfound message]: /en/developer-reference#notfound "A P2P protocol message sent to indicate that the requested data was not available"
[ping message]: /en/developer-reference#ping "A P2P network message used to see if the remote host is still connected"
[pong message]: /en/developer-reference#pong "A P2P network message used to reply to a P2P network ping message"
[qbsigs message]: /en/developer-reference#qbsigs "A P2P network message used to to send batched LLMQ signature shares"
[qcomplaint message]: /en/developer-reference#qcomplaint "A P2P network message used to send a complaint about another masternodes DKG contribution"
[qcontrib message]: /en/developer-reference#qcontrib "A P2P network message used to send LLMQ DKG contributions"
[qfcommit message]: /en/developer-reference#qfcommit "A P2P network message used to finalize the members of a long-living masternode quorum (LLMQ)"
[qgetsigs message]: /en/developer-reference#qgetsigs "A P2P network message used to request signature shares"
[qjustify message]: /en/developer-reference#qjustify "A P2P network message used to respond to another masternodes DKG complaint"
[qpcommit message]: /en/developer-reference#qpcommit "A P2P network message used to send an LLMQ premature commitment"
[qsendrecsigs message]: /en/developer-reference#qsendrecsigs "A P2P network message used to request that recovered quorum signatures be provided"
[qsigrec message]: /en/developer-reference#qsigrec "A P2P network message used to send recovered quorum signatures"
[qsigsesann message]: /en/developer-reference#qsigsesann "A P2P network message used to announce signing session details"
[qsigsinv message]: /en/developer-reference#qsigsinv "A P2P network message used to announce quorum signature share inventories"
[qwatch message]: /en/developer-reference#qwatch "A P2P network message used to ask a peer to relay LLMQ DKG messages"
[reject message]: /en/developer-reference#reject "A P2P network message used to indicate a previously-received message was rejected for some reason"
[sendcmpct message]: /en/developer-reference#sendcmpct "A P2P network message used to request new blocks be announced as compact blocks"
[senddsq message]: /en/developer-reference#senddsq "A P2P network message used to request that DSQ mixing messages be provided"
[sendheaders message]: /en/developer-reference#sendheaders "A P2P network message used to request new blocks be announced through headers messages rather than inv messages"
[spork message]: /en/developer-reference#spork "A P2P network message used to send the activation status of a spork"
[ssc message]: /en/developer-reference#ssc "A P2P network message used to track the sync status of masternode objects ()"
[tx message]: /en/developer-reference#tx "A P2P protocol message which sends a single serialized transaction"
[txlvote message]: /en/developer-reference#txlvote "A P2P protocol message which masternodes send in response to an ix (transaction lock request) message if the transaction inputs can be locked."
[verack message]: /en/developer-reference#verack "A P2P network message sent in reply to a version message to confirm a connection has been established"
[version message]: /en/developer-reference#version "A P2P network message sent at the begining of a connection to allow protocol version negotiation"

{% comment %}<!-- Other internal site links; alphabetical order -->{% endcomment %}
[bcc contribute code]: /{{page.lang}}/{% translate development url %}

[dashd initial setup]: /en/developer-examples
[bitcoinpdf]: https://bitcoin.org/en/bitcoin-paper
[choose your wallet]: https://www.dash.org/wallets/
[communities]: https://www.dash.org/community/
[core executable]: https://www.dash.org/wallets/#wallets
[dev communities]: https://www.dash.org/community/
[developer documentation]: /en/developer-documentation
[devex complex raw transaction]: /en/developer-examples#complex-raw-transaction
[devexamples]: /en/developer-examples
[devguide]: /en/developer-guide
[devguide avoiding key reuse]: /en/developer-guide#avoiding-key-reuse
[devguide hardened keys]: /en/developer-guide#hardened-keys
[devguide wallets]: /en/developer-guide#wallets
[devref]: /en/developer-reference
[devref wallets]: /en/developer-reference#wallets
[locktime parsing rules]: /en/developer-guide#locktime_parsing_rules
[micropayment channel]: /en/developer-guide#term-micropayment-channel
[not a specification]: /en/developer-reference#not-a-specification
[raw transaction format]: /en/developer-reference#raw-transaction-format
[REST]: /en/developer-reference#http-rest
[RPC]: /en/developer-reference#remote-procedure-calls-rpcs
[RPCs]: /en/developer-reference#remote-procedure-calls-rpcs
[section block chain]: /en/developer-guide#block-chain
[section block header]: /en/developer-reference#block-headers
[section block versions]: /en/developer-reference#block-versions
[section creating a bloom filter]: /en/developer-examples#creating-a-bloom-filter
[section compactSize unsigned integer]: /en/developer-reference#compactsize-unsigned-integers
[section detecting forks]: /en/developer-guide#detecting-forks
[section getblocktemplate]: /en/developer-guide#getblocktemplate-rpc
[section hash byte order]: /en/developer-reference#hash-byte-order
[section merkle trees]: /en/developer-reference#merkle-trees
[section merkleblock example]: /en/developer-examples#parsing-a-merkleblock
[section message header]: /en/developer-reference#message-headers
[section p2p reference]: /en/developer-reference#p2p-network
[section protocol versions]: /en/developer-reference#protocol-versions
[section rpc quick reference]: /en/developer-reference#rpc-quick-reference
[section serialized blocks]: /en/developer-reference#serialized-blocks
[section simple raw transaction]: /en/developer-examples#simple-raw-transaction
[secure your wallet]: /en/secure-your-wallet
[signature script modification warning]: /en/developer-reference#signature_script_modification_warning
[v0.8 chain fork]: /en/alert/2013-03-11-chain-fork

{% comment %}<!-- Official reference documents (BIPs should not use zero padding:
     BIP32 not BIP0032); alphabetical order -->{% endcomment %}
[BIP9]: https://github.com/bitcoin/bips/blob/master/bip-0009.mediawiki
[BIP9 assignments]: https://github.com/bitcoin/bips/blob/master/bip-0009/assignments.mediawiki
[BIP14]: https://github.com/bitcoin/bips/blob/master/bip-0014.mediawiki
[BIP16]: https://github.com/bitcoin/bips/blob/master/bip-0016.mediawiki
[BIP21]: https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki
[BIP22]: https://github.com/bitcoin/bips/blob/master/bip-0022.mediawiki
[BIP23]: https://github.com/bitcoin/bips/blob/master/bip-0023.mediawiki
[BIP30]: https://github.com/bitcoin/bips/blob/master/bip-0030.mediawiki
[BIP31]: https://github.com/bitcoin/bips/blob/master/bip-0031.mediawiki
[BIP32]: https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki
[BIP34]: https://github.com/bitcoin/bips/blob/master/bip-0034.mediawiki
[BIP35]: https://github.com/bitcoin/bips/blob/master/bip-0035.mediawiki
[BIP37]: https://github.com/bitcoin/bips/blob/master/bip-0037.mediawiki
[BIP39]: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
[BIP50]: https://github.com/bitcoin/bips/blob/master/bip-0050.mediawiki
[BIP61]: https://github.com/bitcoin/bips/blob/master/bip-0061.mediawiki
[BIP62]: https://github.com/bitcoin/bips/blob/master/bip-0062.mediawiki
[BIP65]: https://github.com/bitcoin/bips/blob/master/bip-0065.mediawiki
[BIP66]: https://github.com/bitcoin/bips/blob/master/bip-0066.mediawiki
[BIP68]: https://github.com/bitcoin/bips/blob/master/bip-0068.mediawiki
[BIP70]: https://github.com/bitcoin/bips/blob/master/bip-0070.mediawiki
[BIP71]: https://github.com/bitcoin/bips/blob/master/bip-0071.mediawiki
[BIP72]: https://github.com/bitcoin/bips/blob/master/bip-0072.mediawiki
[BIP90]: https://github.com/bitcoin/bips/blob/master/bip-0090.mediawiki
[BIP111]: https://github.com/bitcoin/bips/blob/master/bip-0111.mediawiki
[BIP112]: https://github.com/bitcoin/bips/blob/master/bip-0112.mediawiki
[BIP113]: https://github.com/bitcoin/bips/blob/master/bip-0113.mediawiki
[BIP125]: https://github.com/bitcoin/bips/blob/master/bip-0125.mediawiki
[BIP130]: https://github.com/bitcoin/bips/blob/master/bip-0130.mediawiki
[BIP133]: https://github.com/bitcoin/bips/blob/master/bip-0133.mediawiki
[BIP141]: https://github.com/bitcoin/bips/blob/master/bip-0141.mediawiki
[BIP147]: https://github.com/bitcoin/bips/blob/master/bip-0147.mediawiki
[BIP151]: https://github.com/bitcoin/bips/blob/master/bip-0151.mediawiki
[BIP152]: https://github.com/bitcoin/bips/blob/master/bip-0152.mediawiki
[CVE-2012-2459]: https://en.bitcoin.it/wiki/CVEs#CVE-2012-2459
[RFC5737]: http://tools.ietf.org/html/rfc5737
[secp256k1]: http://www.secg.org/sec2-v2.pdf

[DIP1]: https://github.com/dashpay/dips/blob/master/dip-0001.md
[DIP2]: https://github.com/dashpay/dips/blob/master/dip-0002.md
[DIP3]: https://github.com/dashpay/dips/blob/master/dip-0003.md
[DIP4]: https://github.com/dashpay/dips/blob/master/dip-0004.md
[DIP5]: https://github.com/dashpay/dips/blob/master/dip-0005.md
[DIP6]: https://github.com/dashpay/dips/blob/master/dip-0006.md
[DIP7]: https://github.com/dashpay/dips/blob/master/dip-0007.md
[DIP8]: https://github.com/dashpay/dips/blob/master/dip-0008.md

{% comment %}<!-- Other external site links; alphabetical order -->{% endcomment %}
[#bitcoin]: https://webchat.freenode.net/?channels=bitcoin&uio=d4
[#bitcoin-dev]: https://webchat.freenode.net/?channels=bitcoin-dev&uio=d4
[#bitcoin-mining]: https://webchat.freenode.net/?channels=bitcoin-mining&uio=d4
[#bitcoin-wiki]: https://webchat.freenode.net/?channels=bitcoin-wiki&uio=d4
[0bin]: http://0bin.net/
[bcc automated testing]: https://github.com/dashpay/dash/blob/master/README.md#automated-testing
[bcc configuration]: https://en.bitcoin.it/wiki/Running_Bitcoin
[bcc data directory]: https://en.bitcoin.it/wiki/Data_directory
[bcc issues]: https://github.com/dashpay/dash/issues
[bcc new issue]: https://github.com/dashpay/dash/issues/new
[bcc pulls]: https://github.com/dashpay/dash/pulls
[bcc tor]: https://en.bitcoin.it/wiki/Tor
[bcc tor hs]: https://en.bitcoin.it/wiki/Tor#Hidden_services
[core github tag]: https://github.com/bitcoin-dot-org/bitcoin.org/labels/Core
[BFGMiner]: https://github.com/luke-jr/bfgminer
[Bitcoin beginners]: http://www.reddit.com/r/bitcoinbeginners
[Bitcoin Core]: https://bitcoin.org/en/download
[Bitcoin Core 0.1.6]: https://github.com/bitcoin/bitcoin/commit/cc0b4c3b62367a2aebe5fc1f4d0ed4b97e9c2ac9
[Bitcoin Core 0.2.9]: https://github.com/bitcoin/bitcoin/commit/42605ce8bcc9bd01b86491c74fee14de77960868
[Bitcoin Core 0.3.11]: https://github.com/bitcoin/bitcoin/commit/343328c6b8db85e58a1feea85f0d10e62967fa19
[Bitcoin Core 0.3.15]: https://github.com/bitcoin/bitcoin/commit/c891967b6fcab2e8dc4ce0c787312b36c07efa4d
[Bitcoin Core 0.3.18]: https://github.com/bitcoin/bitcoin/commit/82201801336f64ee77851b9eaab9383ee4e442f0
[Bitcoin Core build unix]: https://github.com/dashpay/dash/blob/master/doc/build-unix.md
[Bitcoin Core docs directory]: https://github.com/dashpay/dash/tree/master/doc
[bitcoin core fee drop commit]: https://github.com/bitcoin/bitcoin/commit/6a4c196dd64da2fd33dc7ae77a8cdd3e4cf0eff1
[Bitcoin Core issue #2381]: https://github.com/bitcoin/bitcoin/issues/2381
[Bitcoin Core master]: https://github.com/dashpay/dash
[Bitcoin Core pull #4468]: https://github.com/bitcoin/bitcoin/pull/4468
[Bitcoin core transifex]: https://www.transifex.com/projects/p/bitcoin/
[Bitcoin reddit]: http://www.reddit.com/r/dashpay
[Bitcoin reddit new]: http://www.reddit.com/r/dashpay/new
[Bitcoin stackexchange]: http://bitcoin.stackexchange.com
[Bitcoin stackexchange tag bitcoin-qt]: http://bitcoin.stackexchange.com/questions/tagged/bitcoin-qt
<!--[bitcoin-documentation mailing list]: https://groups.google.com/forum/#!forum/bitcoin-documentation-->
[BitcoinJ]: http://bitcoinj.github.io
[BitcoinJ documentation about pending transaction safety]: https://bitcoinj.github.io/security-model#pending-transactions
[bitcoinj micropayment tutorial]: https://bitcoinj.github.io/working-with-micropayments
[block170]: https://www.biteasy.com/block/00000000d1145790a8694403d4063f323d499e655c83426834d4ce2f8dd4a2ee
[casascius address utility]: https://github.com/casascius/Bitcoin-Address-Utility
[coinbase special tx]: /en/developer-reference#cbtx
[core base58.h]: https://github.com/dashpay/dash/blob/master/src/base58.h
[core chainparams.cpp]: https://github.com/dashpay/dash/blob/master/src/chainparams.cpp
[core git]: https://github.com/dashpay/dash/
[core paymentrequest.proto]: https://github.com/dashpay/dash/blob/master/src/qt/paymentrequest.proto
[core script.h]: https://github.com/dashpay/dash/blob/master/src/script/script.h
[creative commons attribution 3.0 license]: https://creativecommons.org/licenses/by/3.0/
[Dash Masternode Tool]: https://github.com/Bertrand256/dash-masternode-tool
[Dash Seeder]: https://github.com/nightlydash/dash-seeder/tree/master
[DashJ]: https://github.com/HashEngineering/dashj
[dashmnb]: https://github.com/chaeplin/dashmnb
[DER]: https://en.wikipedia.org/wiki/X.690#DER_encoding
[dig command]: https://en.wikipedia.org/wiki/Dig_%28Unix_command%29
[Discord channels]: http://www.dashchat.org
[DNS A records]: http://tools.ietf.org/html/rfc1035#section-3.2.2
[DNS Seed Policy]: https://github.com/dashpay/dash/blob/master/doc/dnsseed-policy.md
[docs issue]: https://github.com/dash-docs/dash-docs/issues
[ECDSA]: https://en.wikipedia.org/wiki/Elliptic_Curve_DSA
[edit bandwidth sharing guide]: https://github.com/bitcoin-dot-org/bitcoin.org/edit/master/en/full-node.md
[Electrum server]: https://github.com/spesmilo/electrum-server
[Eloipool]: https://github.com/luke-jr/eloipool
[errors in docs]: https://github.com/dash-docs/dash-docs/issues?q=is%3Aissue+label%3A%22Dev+Docs%22
[fake satoshi transaction]: https://www.reddit.com/r/Bitcoin/comments/3fv42j/blockchaininfo_spoofed_transactions_problem_aug_4/
[forum tech support]: https://www.dash.org/forum/categories/dash-support.61/
[ghash betcoin double spend]: https://bitcointalk.org/index.php?topic=321630.msg3445371
[gitian sigs]: https://github.com/bitcoin/gitian.sigs
[high-speed block relay network]: https://www.mail-archive.com/bitcoin-development@lists.sourceforge.net/msg03189.html
[HMAC-SHA512]: https://en.wikipedia.org/wiki/HMAC
[HTTP basic authentication]: https://en.wikipedia.org/wiki/Basic_access_authentication
[HTTP longpoll]: https://en.wikipedia.org/wiki/Push_technology#Long_polling
[information theoretic security]: https://en.wikipedia.org/wiki/Information_theoretic_security
[inherit bitcoins]: http://bitcoin.stackexchange.com/q/38692/21052
[IP-to-IP payment protocol]: https://en.bitcoin.it/wiki/IP_Transactions
[IPv4-mapped IPv6 addresses]: http://en.wikipedia.org/wiki/IPv6#IPv4-mapped_IPv6_addresses
[irc channels]: https://en.bitcoin.it/wiki/IRC_channels
[JSON-RPC version 1.0]: http://json-rpc.org/wiki/specification
[JSON-RPC request batching]: http://www.jsonrpc.org/specification#batch
[july 2015 chain forks]: https://en.bitcoin.it/wiki/July_2015_chain_forks
[libblkmaker]: https://github.com/bitcoin/libblkmaker
[localhost]: https://en.wikipedia.org/wiki/Localhost
[lying consistently is hard]: https://groups.google.com/forum/#!msg/bitcoinj/Ys13qkTwcNg/9qxnhwnkeoIJ
[makeseeds script]: https://github.com/dashpay/dash/tree/master/contrib/seeds
[mozilla's bug reporting documentation]: https://developer.mozilla.org/en-US/docs/Mozilla/QA/Bug_writing_guidelines#Writing_precise_steps_to_reproduce
[murmur3]: https://en.wikipedia.org/wiki/MurmurHash
[man-in-the-middle]: https://en.wikipedia.org/wiki/Man-in-the-middle_attack
[MIME]: https://en.wikipedia.org/wiki/Internet_media_type
[MIT license]: http://opensource.org/licenses/MIT
[mozrootstore]: https://www.mozilla.org/en-US/about/governance/policies/security-group/certs/
[native irc client]: https://en.wikipedia.org/wiki/List_of_IRC_clients
[netcat]: https://en.wikipedia.org/wiki/Netcat
[nop opcodes]: https://en.bitcoin.it/wiki/Script#Reserved_words
[offline transactions]: http://bitcoin.stackexchange.com/a/34122/21052
[open a pull request]: https://github.com/dash-docs/dash-docs#working-with-github
[open an issue]: https://github.com/dash-docs/dash-docs/issues/new
[Payment Request Generator]: https://github.com/gavinandresen/paymentrequest/blob/master/php/demo_website/createpaymentrequest.php
[Piotr Piasecki's testnet faucet]: https://tpfaucet.appspot.com/
[prime symbol]: https://en.wikipedia.org/wiki/Prime_%28symbol%29
[protobuf]: https://developers.google.com/protocol-buffers/
[proregtx special tx]: /en/developer-reference#proregtx
[proupregtx special tx]: /en/developer-reference#proupregtx
[prouprevtx special tx]: /en/developer-reference#prouprevtx
[proupservtx special tx]: /en/developer-reference#proupservtx
[python-bitcoinlib]: https://github.com/petertodd/python-bitcoinlib
[python-blkmaker]: https://gitorious.org/bitcoin/python-blkmaker
[quorum commitment special tx]: /en/developer-reference#qctx
[Satoshi Nakamoto]: https://en.bitcoin.it/wiki/Satoshi_Nakamoto
[setup tor]: https://www.torproject.org/
[SHA256]: https://en.wikipedia.org/wiki/SHA-2
[Stratum mining protocol]: http://mining.bitcoin.cz/stratum-mining
[study of SPV privacy over tor]: http://arxiv.org/abs/1410.6079
[superblock example]: https://chainz.cryptoid.info/dash/block.dws?731104.htm
[Testnet Faucet - Dash.org]: https://test.faucet.dash.org/
[Testnet Faucet - Masternode.io]: http://test.faucet.masternode.io/
[Testnet Faucet - Dashninja.pl]: https://test.faucet.dashninja.pl/
[Testnet Faucet - Crowdnode.io]: http://faucet.test.dash.crowdnode.io/
[Tor]: https://en.wikipedia.org/wiki/Tor_%28anonymity_network%29
[transifex]: https://www.transifex.com/projects/p/bitcoinorg/
[unix epoch time]: https://en.wikipedia.org/wiki/Unix_time
[URI encoded]: https://tools.ietf.org/html/rfc3986
[wiki bitcoin core compatible devices arm]: https://en.bitcoin.it/wiki/Bitcoin_Core_compatible_devices#ARM-based_Chipsets
[wiki bitcoin core documentation]: https://en.bitcoin.it/wiki/Category:Bitcoin_Core_documentation
[wiki create account]: https://en.bitcoin.it/w/index.php?title=Special:UserLogin&type=signup
[wiki enable editing]: https://en.bitcoin.it/wiki/Bitcoin_Wiki:Editing_privileges
[wiki getblocktemplate]: https://en.bitcoin.it/wiki/Getblocktemplate
[wiki proper money handling]: https://en.bitcoin.it/wiki/Proper_Money_Handling_%28JSON-RPC%29
[wiki template bitcoin core documentation]: https://en.bitcoin.it/wiki/Template:Bitcoin_Core_documentation
[wiki script]: https://en.bitcoin.it/wiki/Script
[x509]: https://en.wikipedia.org/wiki/X.509

{% comment %}<!-- Direct links to code; link to a specific commit to prevent code
changes from moving the referenced object, but also update links
periodically to point to recent code. Last update: 2017-09-05 --> {% endcomment %}
[core bloom.cpp hash]: https://github.com/dashpay/dash/blob/333e1eaeea80344e5a28db6efbce2691c85e2b25/src/bloom.cpp#L58
[MAX_SIZE]: https://github.com/dashpay/dash/blob/c31ba8ba4c07e72620bd71753f2103ca103bb1c2/src/serialize.h#L26
[privatesend denominations]: https://github.com/dashpay/dash/blob/753b1e486b2757b1dba59998ee477e7ceff04f2d/src/privatesend.cpp#L149-L171
[rpcprotocol.h]: https://github.com/dashpay/dash/blob/3e0eee4c84f40b3cf277e8d03e004249d03c081d/src/rpcprotocol.h
[spork.h]: https://github.com/dashpay/dash/blob/a4f5ba38b65384fb9243ce78c111feceb377e1a9/src/spork.h#L20
[spork pubkey]: https://github.com/dashpay/dash/blob/eaf90b77177efbaf9cbed46e822f0d794f1a0ee5/src/chainparams.cpp#L158
[masternode payments pubkey]: https://github.com/dashpay/dash/blob/eaf90b77177efbaf9cbed46e822f0d794f1a0ee5/src/chainparams.cpp#L159
[block subsidy]: https://github.com/dashpay/dash/blob/9ed9474a9eb007bba70278ce19df68e84aeeb712/src/main.cpp#L1741
[governance vote signature format]: https://github.com/dashpay/dash/blob/48d63ab296f5613c727306ea39524f51d157a04c/src/governance-vote.cpp#L240-#L241
