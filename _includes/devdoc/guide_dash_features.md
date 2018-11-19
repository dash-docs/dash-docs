{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/guide_dash_features.md" %}

## Dash Features
{% include helpers/subhead-links.md %}

{% autocrossref %}

<!-- __ -->

Dash aims to be the most user-friendly and scalable payments-focused
cryptocurrency in the world. The Dash network features instant transaction
confirmation, double spend protection, anonymity equal to that of physical cash,
a self-governing, self-funding model driven by incentivized full nodes and a
clear roadmap for on-chain scaling to up to 400MB blocks using custom-developed
open source hardware.

While Dash is based on Bitcoin and compatible with many key components of the
Bitcoin ecosystem, its two-tier network structure offers significant
improvements in transaction speed, anonymity and governance. This section of the
documentation describes these key features that set Dash apart in the blockchain
economy.

{% endautocrossref %}


### InstantSend
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash Core's InstantSend feature provides a way to lock transaction inputs and
enable secure, instantaneous transactions. Since Dash Core 0.13.0, any qualifying
transaction is automatically upgraded to InstantSend by the network without a
need for the sending wallet to explicitly request it. For these simple
transactions (those containing 4 or fewer inputs), the previous requirement for
a special InstantSend transaction fee was also removed. The criteria for
determining eligibility can be found in the lists of limitations below.

The following video provides an overview with a good introduction to the details
including the InstantSend vulnerability that was fixed in Dash Core 0.12.2.
Some specific points in the video are listed here for quick reference:

 - 2:00 - InstantSend restrictions
 - 5:00 - Masternode quorum creation
 - 6:00 - Input locking
 - 7:45 - Quorum score calculation / Requirement for block confirmations
 - 9:00 - Description of Dash Core pre-0.12.2 InstantSend vulnerability
 - 13:00 - Description of vulnerability fix / Post Dash Core 0.12.2 operation

{% endautocrossref %}

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/n4PELomRiFY?rel=0;start=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

{% autocrossref %}

*InstantSend Data Flow*

| **InstantSend Client** | **Direction**  | **Peers**   | **Description** |
| `inv` message (ix)          | → |                         | Client sends inventory for transaction lock request
|                             | ← | `getdata` message (ix)  | Peer responds with request for transaction lock request
| `ix` message                | → |                         | Client sends InstantSend transaction lock request
|                             | ← | `inv` message (txlvote) | Masternodes in the [quorum](#quorum-selection) respond with votes
| `getdata` message (txlvote) | → |                         | Client requests vote
|                             | ← | `txlvote` message       | Peer responds with vote

Once an InstantSend lock has been requested, the `instantsend` field of various
RPCs (e.g. the `getmempoolentry` RPC) is set to `true`. Then, if a sufficient
number of votes approve the transaction lock, the InstantSend transaction is approved
the `instantlock` field of the RPC is set to `true`.

If an InstantSend transaction is a valid transaction but does not receive a
transaction lock, it reverts to being a standard transaction.

There are a number of limitations on InstantSend transactions:

* The lock request will timeout 15 seconds after the first vote is seen (`INSTANTSEND_LOCK_TIMEOUT_SECONDS`)
* The lock request will fail if it has not been locked after 60 seconds (`INSTANTSEND_FAILED_TIMEOUT_SECONDS`)
* A minimum fee (0.0001 Dash) is required for non-simple transactions since they place a higher load on the masternodes. This fee was most
recently decreased by [DIP-0001](https://github.com/dashpay/dips/blob/master/dip-0001.md).
* To be used in an InstantSend transaction, an input must have at least the number confirmations (block depth) indicated by the table below

| **Network** | **Confirmations Required** |
|---------|--------------|
| Mainnet | 6 Blocks |
| Testnet | 2 Blocks |
| Regtest | 2 Blocks |
| Devnet  | 2 Blocks |

There are some further limitations on Automatic InstantSend transactions:

* DIP3 must be active
* Spork 16 must be enabled
* Mempool usage must be lower than 10% (`AUTO_IX_MEMPOOL_THRESHOLD`). As of Dash Core 0.13.0, this corresponds to a mempool size of 30 MB (`DEFAULT_MAX_MEMPOOL_SIZE` = 300 MB).

**Historical Note**

Prior to Dash Core 0.13.0, `instantsend` and `instantlock` values were not
available via RPC. At that time, the InstantSend system worked as described below.

Once a sufficient number of votes approved the transaction lock, the InstantSend
transaction was approved and showed 5 confirmations (`DEFAULT_INSTANTSEND_DEPTH`).

NOTE: The 5 "pseudo-confirmations" were shown to convey confidence that the
transaction was secure from double-spending and DID NOT indicate the transaction
had already been confirmed to a block depth of 5 in the blockchain.

{% endautocrossref %}


### PrivateSend
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash Core's PrivateSend feature provides a way to improve privacy by performing
coin-mixing without relinquishing custodial access. For additional details,
reference this [Official Documentation PrivateSend page](https://dashpay.atlassian.net/wiki/spaces/DOC/pages/1146924/PrivateSend<!--noref-->).

The following video provides an overview with a good introduction to the details:

{% endautocrossref %}

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/vgCId3wJc5Y?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


#### PrivateSend Wallet Preparation
{% include helpers/subhead-links.md %}

{% autocrossref %}

The wallet completes two operations in this phase:

1. Split value into inputs matching the PrivateSend denominations by sending transactions to itself
2. Split value into inputs to use for collateral by sending transactions to itself

**Note**: Both these operations incur standard transaction fees like any other
transaction

**Creating Denominations<!--noref-->**

The PrivateSend denominations include a bit mapping to easily differentiate them.
The `dsa` message and `dsq` message use this bit shifted integer instead of
sending the actual denomination. The table below lists the bit, its associated
integer value used in P2P messages, and the actual Dash value.

| **Bit** | **Denom. (Integer)** | **Denomination (DASH)** |
| 0   |  1 | 10.0001              |
| 1   |  2 | 01.00001             |
| 2   |  4 | 00.100001            |
| 3   |  8 | 00.0100001           |
| 4   | 16 | 00.00100001          |

Protocol version 70212 added a 5th denomination (0.001 DASH).

The denominations are structured to allow converting between denominations
directly without requiring additional inputs or creating change (for example,
1 x 10.0001 = 10 x 1.00001, 1 x 0.100001 = 10 x 0.0100001, etc.).

{% endautocrossref %}

[Example Testnet denomination creation transaction](https://testnet-insight.dashevo.org/insight/tx/702e77d19dcb0fbfe7d7daa5543bcfeacec0f552c49e398b27fb8141ae52d3e2)

{% autocrossref %}

**Creating Collaterals**

PrivateSend collaterals are used to pay mixing fees, but are kept separate from
the denominations to maximize privacy. Since protocol version 70212, the minimum
collateral fee is 1/10 of the smallest denomination for all mixing sessions
regardless of denomination.
In Dash Core, collaterals are created with enough value to pay 4 collateral fees
(4 x 0.001 DASH). ([Dash Core Reference](https://github.com/dashpay/dash/blob/262454791c4b4f783b2533d1b16b757a71eb5f7d/src/privatesend<!--noref-->.h#L413))

In protocol version 70208, collateral inputs can be anything from 2x the
minimum collateral amount to the maximum collateral amount (currently defined as
4x the minimum collateral). In protocol versions > 70208, Dash Core can use any
input from 1x the minimum collateral amount to the maximum collateral amount.

{% endautocrossref %}

[Example Testnet collateral creation transaction](https://testnet-insight.dashevo.org/insight/tx/c2fc4af6a9940bf33446f3dddf6892c3dac4351fd0add89157666ca1019454ca)

[Example Testnet collateral payment transaction](https://testnet-insight.dashevo.org/insight/tx/70404808f1871e600cc8d30ad1eaf2bab63906dd1f3ae4a799b7182e1689721b)


#### PrivateSend Mixing
{% include helpers/subhead-links.md %}

{% autocrossref %}

The mixing phase involves exchanging a sequence of messages with a masternode so
it can construct a mixing transaction with inputs from the clients in its
mixing pool.

{% endautocrossref %}


*PrivateSend Data Flow*

{% autocrossref %}

|   | **PrivateSend Clients** | **Direction**  | **Masternode**   | **Description** |
| 0 | | | | Client determines whether to join an existing mixing pool or create a new one |
| 1 | `dsa` message                            | → |                            | Client asks to join mixing pool or have the masternode create a new one
| 2 |                                                | ← | `dssu` message       | Masternode provides a mixing pool status update (Typical - State: `POOL_STATE_QUEUE`, Message: `MSG_NOERR`)
| 3 |                                                | ← | `dsq` message        | Masternode notifies clients when it is ready to mix
| 4 | `dsi` message                                 | → |                       | Upon receiving a `dsq` message with the Ready bit set, clients each provide a list of their inputs (unsigned) to be mixed, collateral, and a list of outputs where mixed funds should be sent
| 5 |                                                | ← | `dssu` message       | Masternode provides a mixing pool status update (typical - State: `POOL_STATE_ACCEPTING_ENTRIES`, Message: `MSG_ENTRIES_ADDED`)
| 6 |                                                | ← | `dsf` message        | Masternode sends the final transaction containing all clients inputs (unsigned) and all client outputs to each client for verification
| 7 |                                                | ← | `dssu` message       | Masternode provides a mixing pool status update (Typical - State: `POOL_STATE_SIGNING`, Message: `MSG_NOERR`)
| 8 | `dss` message                                 | → |                       | After verifying the final transaction, clients each sign their own inputs and send them back
| 9 |                                                | ← | `dsc` message        | Masternode verifies the signed inputs, creates a `dstx` message to broadcast the transaction, and notifies clients that the mixing transaction is complete (Typical - Message: `MSG_SUCCESS`)
| 10 |                                                | ← | `inv` message        | Masternode broadcasts a `dstx` inventory message
| 11 | `getdata` message (dstx)                                 | → |            | (Optional)

**Additional notes**

  _**Step 0 - Pool Selection**_

  * Existing mixing pool information is derived from the Queue messages seen by the client
  * Dash Core attempts to join an existing mixing pool 2/3 of the time although this is not a requirement that alternative implementations would be required to follow ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/privatesend<!--noref-->-client.cpp#L817-#L826))

  _**Step 1 - Pool Request**_

  * The `dsa` message contains a collateral transaction
    * This transaction uses a collateral input created in the [Wallet Preparation](#privatesend<!--noref-->-wallet<!--noref-->-preparation) phase
    * The collateral is a signed transaction that pays the collateral back to a client address minus a fee of 0.001 DASH
  * As of protocol version 70209, the `dsa` message indicates how many inputs will be provided to the pool when Spork 6 is active

  _**Step 3 - Queue**_

  * A masternode broadcasts `dsq` messages when it starts a new queue. These message are relayed by all peers.
  * As of protocol version 70209, when Spork 6 is active the `dsq` message indicates how many inputs must be provided to participate in the pool.
  * Once the masternode has received valid `dsa` messages from 3 clients (`nPoolMaxTransactions`), it sends a `dsq` message with the ready bit set ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/chainparams.cpp#L173))
    * Clients must respond to the Queue ready within 30 seconds or risk forfeiting the collateral they provided in the `dsa` message (Step 1) ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/privatesend<!--noref-->.h#L22))

  _**Step 4 - Inputs**_

  * The collateral transaction can be the same in the `dsi` message as the one in the `dsa` message (Step 1) as long as it has not been spent
  * Each client can provide up to 9 (`PRIVATESEND_ENTRY_MAX_SIZE`) inputs (and an equal number of outputs) to be mixed ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/privatesend<!--noref-->.h#L28))
  * This is the only message in the PrivateSend process that contains enough information to link a wallet's PrivateSend inputs with its outputs
    * This message is sent directly between a client and the mixing masternode (not relayed across the Dash network) so no other clients see it

  _**Step 6 - Final Transaction (unsigned)**_

  * Once the masternode has received valid `dsi` messages from all clients, it creates the final transaction and sends a `dsf` message
    * Inputs/outputs are ordered deterministically as defined by [BIP-69](https://github.com/quantumexplorer/bips/blob/master/bip-0069.mediawiki#Abstract) to avoid leaking any data ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/privatesend<!--noref-->-server.cpp#L321-#L322))
    * Clients must sign their inputs to the Final Transaction within 15 seconds or risk forfeiting the collateral they provided in the `dsi` message (Step 4) ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/privatesend<!--noref-->.h#L23))

  _**General**_

  With the exception of the `dsq` message and the `dstx` message (which need
  to be public and do not expose any private information), all PrivateSend P2P
  messages are sent directly between the mixing masternode and relevant client(s).

{% endautocrossref %}

#### PrivateSend Fees
{% include helpers/subhead-links.md %}

{% autocrossref %}

**Mixing Fees**

* If mixing completes successfully, Dash Core charges the collateral randomly in 1/10 mixing transactions to pay miners ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/privatesend<!--noref-->-server.cpp#L458-#L478))
* Clients that abuse the mixing system by failing to respond to `dsq` messages or `dsf` messages within the timeout periods may forfeit their collateral. Dash Core charges the abuse fee in 2/3 cases ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/privatesend<!--noref-->-server.cpp#L397-#L398))


**Sending Fees**

To maintain privacy when using PrivateSend, PrivateSend transactions must fully
spend all inputs to a single output (with the remainder becoming the fee - i.e.
no change outputs). This can result in large fees depending on the value being
sent.

For example, an extreme case is sending the minimum non-dust value (546 duffs)
via PrivateSend. This results in an extremely large transaction fee because the
minimum PrivateSend denomination (0.0100001 DASH or 1,000,010 duffs) must be
fully spent with no change. This results in a fee of 0.00999464 DASH and a sent
value of only 0.00000546 DASH as shown by the calculation below.

1000010 duffs (smallest PrivateSend denomination) - 546 duffs (value to send) = 999464 duffs (fee)

{% endautocrossref %}

[Example Testnet PrivateSend transaction spending 546 duffs](https://testnet-insight.dashevo.org/insight/address/yWWNYVEQ84RM1xXJekj62wJPF3h1TKh9fS)


### Masternode Payment
{% include helpers/subhead-links.md %}

{% autocrossref %}

Masternode payment uses a verifiable process to determine which masternode is
paid in each block. When a new block is processed, a quorum of
`MNPAYMENTS_SIGNATURES_TOTAL` (10) masternodes vote on the next masternode
payee. The quorum is calculated deterministically based on the distance between
masternode's hash and the block's proof of work.

Each member of the quorum issues a 'mnw' message that is relayed to the
network. The payee is selected from a subset of masternodes made up of 10%
of eligible nodes that have been waiting the longest since their last payment.
The winner is then determined based on a number of parameters including the
distance between the its hash and the block's proof of work. For additional
detail, reference this [Official Documentation Payment Logic page](https://dashpay.atlassian.net/wiki/spaces/DOC/pages/8880184/Payment+Logic).

Nodes receiving a `mnw` message verify the validity of the message before
relaying it to their peers. If the message is invalid, the sending node may be
treated as misbehaving and have its ban score increased.

{% endautocrossref %}

### Masternode Sync
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash Core performs full masternode synchronization as required. There are
several conditions that initiate a start/restart the sync process:

* Initial startup of Dash Core
* More than 60 minutes have passed since the last activation
* A failure occurred during the last sync attempt (after a 1 minute cooldown before sync restarts)
* Issuing a `mnsync reset` RPC command

#### Initial Masternode<!--noref--> Sync
{% include helpers/subhead-links.md %}

This diagram shows the order in which P2P messages are sent to perform
masternode synchronization initially after startup.

![Masternode Sync (Initial)](/img/dev/en-masternode-sync-initial.svg)

The following table details the data flow of P2P messages exchanged during
initial masternode synchronization.

| **Syncing Node Message** | **Direction**  | **Masternode Response**   | **Description** |
| **1. Sporks** |   |  |  |
| `getsporks` message                            | → |                           | Syncing node requests sporks
|                                                | ← | `spork` message(s)        |
| **2. Masternode List** |   |  | Sync Masternode list from other connected clients |
| `dseg` message                                 | → |                           | Syncing node requests masternode list
|                                                | ← | `ssc` message | Number of entries in masternode list (MASTERNODE_SYNC_LIST)<br><br>Only sent if requesting entire list
|                                                | ← | `inv` message(s) (mnb)         | MSG_MASTERNODE_ANNOUNCE
|                                                | ← | `inv` message(s) (mnp)         | MSG_MASTERNODE_PING
| `getdata` message(s) (mnb) | → |                           | (Optional)
| `getdata` message(s) (mnp)     | → |                           | (Optional)
|                                                | ← | `mnb` message(s)          | (If requested) Masternode announce message
|                                                | ← | `mnp` message(s)          | (If requested) Masternode ping message
| **3. Masternode payments** |   |  | Ask node for all payment votes it has (new nodes will only return votes for future payments) |
| `mnget` message                                | → |                           | Syncing node requests masternode payment sync
|                                                | ← | `ssc` message | Number of entries in masternode payment list
|                                                | ← | `inv` message(s) (mnw)         | MSG_MASTERNODE_PAYMENT_VOTE
| `getdata` message(s) (mnw) | → |                           | (Optional)
|                                                | ← | `mnw` message(s)          | (If requested) Masternode payment vote message
| **4. Governance** |   |  | See [Governance sync](#governance) |


*Masternode Sync Status*

There are several status values used to track masternode synchronization. They
are used in both `ssc` messages and the `mnsync` RPC.

| **Value** | **Status**  | **Description** |
| -1  | `MASTERNODE_SYNC_FAILED`      | Synchronization failed |
| 0   | `MASTERNODE_SYNC_INITIAL`     | Synchronization just started, was reset recently, or is still in IBD |
| 1   | `MASTERNODE_SYNC_WAITING`     | Synchronization pending - waiting after initial to check for more headers/blocks |
| 2   | `MASTERNODE_SYNC_LIST`        | Synchronizing masternode list |
| 3   | `MASTERNODE_SYNC_MNW`         | Synchronizing masternode payments |
| 4   | `MASTERNODE_SYNC_GOVERNANCE`  | Synchronizing governance objects  |
| 999 | `MASTERNODE_SYNC_FINISHED`    | Synchronization finished |


#### Ongoing Masternode<!--noref--> Sync
{% include helpers/subhead-links.md %}

Once a masternode completes an initial full sync, continuing synchronization is
maintained by the exchange of P2P messages with other nodes. This diagram shows
an overview of the messages exchanged to keep the masternode list, masternode
payments, and governance objects synchronized between masternodes.

![Masternode Sync (Ongoing)](/img/dev/en-masternode-sync-ongoing.svg)

**Recurring Ping**

Each masternode issues a ping (`mnp` message) periodically to notify the network
that it is still online. Masternodes that do not issue a ping for 3 hours will
be put into the `MASTERNODE_NEW_START_REQUIRED` state and will need to issue a
masternode announce (`mnb` message).

**Masternode List**

After the initial masternode list has been received, it is kept current by a
combination of the periodic `mnp` messages received from other masternodes,
the `mnb` messages sent by masternodes as they come online, and `mnv` messages
to verify that other masternodes are valid.

Also, `dseg` messages can be sent to request masternode info when messages are
received that have been signed by an unrecognized masternode (most masternode/governance
messages include a `vin` value that can be used to verify the masternode's
unspent 1000 Dash).

Unsynchronized peers may send a `dseg` message to request the entire masternode list.

**Masternode Payment**

After the initial masternode payment synchronization, payment information is
kept current via the `mnw` messages relayed on the network. Unsynchronized peers
may send a `mnget` message to request masternode payment sync.

**Governance**

After the initial governance synchronization, governance information is kept
current by the `govobj` messages and `govobjvote` messages relayed on the
network. Unsynchronized peers may send `govsync` messages to request governance
sync.

#### Masternode<!--noref--> Sync Schedule
{% include helpers/subhead-links.md %}

The following tables detail the timing of various functions used to keep the
masternodes in sync with each other. This information is derived from the
scheduler section of `AppInitMain` in `src/init.cpp`.

| **Period (seconds)** | **Action** | **Description** |
| 6   | MN Sync                   | Synchronizes sporks, masternode list, masternode payments, and governance objects (masternode-sync.cpp) |

The following actions only run when the masternode sync is past `MASTERNODE_SYNC_WAITING` status.

| **Period (seconds)** | **Action** | **Description** |
| 1   | MN Check                  | Check the state of each masternode that is still funded and not banned. The action occurs once per second, but individual masternodes are only checked at most every 5 seconds (only a subset of masternodes are checked each time it runs) (masternodeman.cpp) |
| 60  | Process MN Connections    | Disconnects some masternodes (masternodeman.cpp) |
| 60  | MN Check/Remove           | Remove spent masternodes and check the state of inactive ones (masternodeman.cpp) |
| 60  | MN Payment Check/Remove   | Remove old masternode payment votes/blocks (masternode-payments.cpp) |
| 60  | InstantSend<!--noref--> Check/Remove  | Remove expired/orphaned/invalid InstantSend candidates and votes (instantx.cpp) |
| 300 | Full verification         | Verify masternodes via direct requests (`mnv` messages - note time constraints in the Developer Reference section) (masternodeman.cpp) |
| 300 | Maintenance               | Check/remove/reprocess governance objects (governance.cpp) |
| 600 | Manage State              | Sends masternode pings (`mnp` message). Also sends initial masternode broadcast (`mnb` message) for local masternodes. (activemasternode.cpp) |

{% endautocrossref %}

### Governance
{% include helpers/subhead-links.md %}

{% autocrossref %}

#### Synchronization
{% include helpers/subhead-links.md %}

Dash Core synchronizes the governance system via the Masternode network as the
last stage of the Masternode sync process (following the sync of sporks, the
Masternode list, and Masternode payments).

The `govsync` message initiates a sync of the governance system. Masternodes
ignore this request if they are not fully synced.  

There are two distinct stages of governance sync:

1. Initial request (object sync) - requests the governance objects only via a
`govsync` message sent with a hash of all zeros.  

2. Follow up request(s) (vote sync) - request governance object votes for a
specific object via a `govsync` message containing the hash of the object. One
message is required for each object. Dash Core periodically (~ every 6 seconds)
sends messages to connected nodes until all the governance objects have been
synchronized.

{% highlight text %}
Dash Core limits how frequently the first type of sync (object sync) can be
requested. Frequent requests will result in the node being banned.
{% endhighlight %}


Masternodes respond to the `govsync` message with several items:

* First, the Masternode sends one `ssc` message (Sync Status Count) for `govobj`
objects and one for `govobjvote` objects. These messages indicate how many
inventory items will be sent.

* Second, the Masternode sends `inv` messages for the `govobj` and `govobjvote`
objects.

Once the syncing node receives the counts and inventories, it may request any
`govobj` and `govobjvote` objects from the masternode via a `getdata` message.


*Governance Sync Data Flow*

| **Syncing Node Message** | **Direction**  | **Masternode Response**   | **Description** |
| **Initial request** | | | **Requests all governance objects (without votes)** |
| `govsync` message        | →              |                           | Syncing node initiates governance sync (hash set to all zeros)
|                          | ←              | `ssc` message (govobj)    | Number of governance objects (0 or more)
|                          | ←              | `ssc` message (govobjvote)| Number of governance object votes *(0 since votes are only returned if a specific hash is provided with the `govsync` message)*
|                          | ←              | `inv` message (govobj)    | Governance object inventories
| `getdata` message (govobj) | →              |                           | (Optional) Syncing node requests govobj
|                          | ←              | `govobj` message          | (If requested) Governance object
| | | | |
| **Follow up requests** | | | **Requests governance object (with votes)** |
| `govsync` message        | →              |                           | Syncing node requests governance sync for a specific governance object
|                          | ←              | `ssc` message (govobj)    | Number of governance objects (1)
|                          | ←              | `ssc` message (govobjvote)| Number of governance object votes (0 or more)
|                          | ←              | `inv` message (govobj)    | Governance object inventory
|                          | ←              | `inv` message (govobjvote)| Governance object vote inventories
| `getdata` message (govobj) | →              |                           | (Optional) Syncing node requests govobj
|                          | ←              | `govobj` message          | (If requested) Governance object
| `getdata` message (govobjvote) | →              |                           | (Optional) Syncing node requests govobjvote
|                          | ←              | `govobjvote` message      | (If requested) Governance object vote

#### Sentinel<!--noref-->
{% include helpers/subhead-links.md %}

[Sentinel](https://github.com/dashpay/sentinel<!--noref-->/) is a Python application that connects to a masternode's local dashd
instance to run as an autonomous agent for persisting, processing, and automating
Dash 12.1+ governance objects and tasks. Sentinel abstracts some governance
details away from Dash Core for easier extensibility of the governance system in
the future. This will allow the integration between Evolution and Dash Core to
proceed more smoothly and enable new governance object additions with minimal
impact to Dash Core.

Sentinel runs periodically and performs four main tasks as described below:
governance sync, ping, governance object pruning, and superblock management.
The governance object data is stored in a SQLite database.

##### Sentinel<!--noref--> Sync
{% include helpers/subhead-links.md %}

Sentinel issues a `gobject list` RPC command and updates its database with the
results returned from dashd. When objects are removed from the network, they are
purged from the Sentinel database.

##### Sentinel<!--noref--> Ping
{% include helpers/subhead-links.md %}

In Dash Core 12.2, use of the `watchdog` governance object type was replaced
by integrating sentinel information into the masternode ping (`mnp` message)
via [Pull Request #1491](https://github.com/dashpay/dash/pull/1491).
Sentinel calls the `sentinelping` RPC which updates the masternode info to
prevent it from entering a `MASTERNODE_WATCHDOG_EXPIRED` state.

##### Sentinel<!--noref--> Prune
{% include helpers/subhead-links.md %}

Sentinel 1.1.0 introduced proposal pruning which automatically votes to delete
expired proposals following approximately half of a superblock cycle. This delay
period ensures that proposals are not deleted prematurely. Prior to this,
proposals remained in memory unless a sufficient number of masternodes manually
voted to delete them.

##### Sentinel<!--noref--> Superblock<!--noref-->
{% include helpers/subhead-links.md %}

Sentinel manages superblock creation, voting, and submission to dashd for
network propagation.

{% endautocrossref %}


### Quorum Selection
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash quorums are used to facilitate the operation of masternode provided
features in a decentralized, deterministic way.

| Quorum Type | Members | Consensus | Description |
| ----------- | ------- | --------- | ----------- |
| InstantSend | 10      | Majority  | A set of 10 masternodes are selected for _each_ input of the InstantSend transaction. A majority (6+) of them must agree to lock the input. If all inputs in the transaction can be locked, it becomes a successful InstantSend.
| MN Payments | 10      | Majority | A set of 10 masternodes are selected for each block. A majority (6+) of them must agree on the masternode payee for the next block.
| MN Broadcast | 10      | Majority | If a majority (6+) of nodes agree, a new `mnb` message is not required.

{% endautocrossref %}
