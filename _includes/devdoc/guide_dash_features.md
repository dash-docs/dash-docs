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
clear [roadmap](https://www.dash.org/roadmap/) for future development.

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
enable secure, instantaneous transactions. The network automatically attempts to
upgrade any qualifying transaction to InstantSend without a need for the sending
wallet to explicitly request it.

* To qualify for InstantSend, transaction inputs must either:
  * Be locked by InstantSend
  * Be in a block that has a ChainLock
  * Have at least the number confirmations (block depth) indicated by the table below

  | **Network** | **Confirmations Required** |
  |---------|--------------|
  | Mainnet | 6 Blocks |
  | Testnet / Regtest / Devnet | 2 Blocks |

The introduction of Long-Living Masternode Quorums in Dash Core 0.14 provided
a foundation to scale InstantSend. The transaction input locking process (and
resulting network traffic) now occurs only within the quorum. This minimizes
network congestion since only the `islock` message produced by the locking
process is relayed to the entire Dash network. This message contains all the
information necessary to verify a successful transaction lock.

Sporks 2 (`SPORK_2_INSTANTSEND_ENABLED`) and 20 (`SPORK_20_INSTANTSEND_LLMQ_BASED`)
are used to manage InstantSend. Spork 2 enables or disables the entire
InstantSend feature. Spork 20 was used to support the transition to LLMQ-based
InstantSend and is currently retained for backward compatibility. It will be
deprecated in a future release.

Note: A transaction will __not__ be included in the block template (from `getblocktemplate`) unless it:

 1. Has been locked, or
 2. Has been in the mempool for >=10 minutes (`WAIT_FOR_ISLOCK_TIMEOUT`)

A miner may still include any transaction, but blocks containing only locked
transactions (or ones older than the timeout) should achieve a ChainLock faster.
This is desirable to miners since it prevents any reorgs that might orphan their
block.

*InstantSend Data Flow*

| **InstantSend Client** | **Direction**  | **Peers**   | **Description** |
| `tx` message                | → |                         | Client sends InstantSend transaction
| **LLMQ Signing Sessions**   |   |                         | Quorums internally process locking |
|                             |   |                         | Quorum(s) responsible for the transaction's inputs lock the inputs via LLMQ signing sessions
|                             |   |                         | Once all inputs are locked, the quorum responsible for the overall transaction creates the transaction lock (`islock`) via an LLMQ signing session
| **LLMQ Results**             |   |                         | Quorum results broadcast to the network |
|                             | ← | `inv` message (islock)  | Quorum responds with lock inventory
| `getdata` message (islock)  | → |                         | Client requests lock message
|                             | ← | `islock` message        | Quorum responds with lock message

Once a transaction lock is approved, the `instantlock` field of various RPCs
is set to `true` (e.g. the `getmempoolentry` RPC).

{% endautocrossref %}

### ChainLocks
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash's ChainLock feature leverages [LLMQ Signing Requests/Sessions](#llmq<!--noref-->-signing-session)
to reduce uncertainty when receiving funds and remove the possibility of 51%
mining attacks.

For each block, an LLMQ of a few hundred masternodes (300-400) is selected and each
participating member signs the first block that it sees extending the active
chain at the current height. If enough members (at least 240) see the same block
as the first block, they will be able to create a `clsig` message and propagate
it to all nodes in the network.

If a valid `clsig` message is received by a node, it must reject all blocks (and
any descendants) at the same height that do not match the block specified in the
`clsig` message. This makes the decision on the active chain quick, easy and
unambiguous. It also makes reorganizations below this block impossible.

When LLMQ-based InstantSend is enabled, a ChainLock is only attempted once all
transactions in the block are locked via InstantSend. If a block contains
unlocked transactions, retroactive InstantSend locks are established prior to
a ChainLock.

Please read [DIP8 ChainLocks](https://github.com/dashpay/dips/blob/master/dip-0008.md)
for additional details.


{% endautocrossref %}

### PrivateSend
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash Core's PrivateSend feature provides a way to improve privacy by performing
coin-mixing without relinquishing custodial access. For additional details,
reference this [Official Documentation PrivateSend page](https://docs.dash.org/en/latest/introduction/features.html#privatesend<!--noref-->).

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

Protocol version 70213 added a 5th denomination (0.001 DASH).

{% endautocrossref %}

[Example Testnet denomination creation transaction](https://testnet-insight.dashevo.org/insight/tx/f0174fc87d68a18617c2990df4d9455c0459c601d2d6473934357a66f9b8b70a)

{% autocrossref %}

**Creating Collaterals**

PrivateSend collaterals are used to pay mixing fees, but are kept separate from
the denominations to maximize privacy. Since protocol version 70213, the minimum
collateral fee is 1/10 of the smallest denomination for all mixing sessions
regardless of denomination.
In Dash Core, collaterals are created with enough value to pay 4 collateral fees
(4 x 0.001 DASH). ([Dash Core Reference](https://github.com/dashpay/dash/blob/262454791c4b4f783b2533d1b16b757a71eb5f7d/src/privatesend<!--noref-->.h#L413))

In protocol version 70208, collateral inputs can be anything from 2x the
minimum collateral amount to the maximum collateral amount (currently defined as
4x the minimum collateral). In protocol versions > 70208, Dash Core can use any
input from 1x the minimum collateral amount to the maximum collateral amount.

{% endautocrossref %}

[Example Testnet collateral creation transaction](https://testnet-insight.dashevo.org/insight/tx/8f9b15973983876f7ce4eb2c32b09690dfb0432d2caf6c6df516196a8d17689f)

[Example Testnet collateral payment transaction](https://testnet-insight.dashevo.org/insight/tx/de51e6f7c5ef75aad0dbb0a808ef4873d7ef6d67b25f3a658d5a241db4f3eeeb)


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
  * Dash Core attempts to join an existing mixing pool and only requests creation of a new one if that fails, although this is not a requirement that alternative implementations would be required to follow

  _**Step 1 - Pool Request**_

  * The `dsa` message contains a collateral transaction
    * This transaction uses a collateral input created in the [Wallet Preparation](#privatesend<!--noref-->-wallet<!--noref-->-preparation) phase
    * The collateral is a signed transaction that pays the collateral back to a client address minus a fee of 0.001 DASH

  _**Step 3 - Queue**_

  * A masternode broadcasts `dsq` messages when it starts a new queue. These message are relayed by all peers.
  * As of protocol version 70214, mixing sessions have a variable number of participants defined by the range `nPoolMinParticipants` (3) to `nPoolMaxParticipants` (5). Prior protocol version mixing sessions always contained exactly 3 participants
  * Once the masternode has received valid `dsa` messages from the appropriate number of clients (`nSessionMaxParticipants`), it sends a `dsq` message with the ready bit set
    * Clients must respond to the Queue ready within 30 seconds or risk forfeiting the collateral they provided in the `dsa` message (Step 1) ([Dash Core Reference](https://github.com/dashpay/dash/blob/e9f7142ed01c0d7b53ef8b5f6f3f6375a68ef422/src/privatesend<!--noref-->.h#L23))

  _**Step 4 - Inputs**_

  * The collateral transaction can be the same in the `dsi` message as the one in the `dsa` message (Step 1) as long as it has not been spent
  * Each client can provide up to 9 (`PRIVATESEND_ENTRY_MAX_SIZE`) inputs (and an equal number of outputs) to be mixed ([Dash Core Reference](https://github.com/dashpay/dash/blob/e9f7142ed01c0d7b53ef8b5f6f3f6375a68ef422/src/privatesend<!--noref-->.h#L29))
  * This is the only message in the PrivateSend process that contains enough information to link a wallet's PrivateSend inputs with its outputs
    * This message is sent directly between a client and the mixing masternode (not relayed across the Dash network) so no other clients see it

  _**Step 6 - Final Transaction (unsigned)**_

  * Once the masternode has received valid `dsi` messages from all clients, it creates the final transaction and sends a `dsf` message
    * Inputs/outputs are ordered deterministically as defined by [BIP-69](https://github.com/dashevo/bips/blob/master/bip-0069.mediawiki#Abstract) to avoid leaking any data ([Dash Core Reference](https://github.com/dashpay/dash/blob/e596762ca22d703a79c6880a9d3edb1c7c972fd3/src/privatesend<!--noref-->-server.cpp#L321-#L322))
    * Clients must sign their inputs to the Final Transaction within 15 seconds or risk forfeiting the collateral they provided in the `dsi` message (Step 4) ([Dash Core Reference](https://github.com/dashpay/dash/blob/e9f7142ed01c0d7b53ef8b5f6f3f6375a68ef422/src/privatesend<!--noref-->.h#L24))

  _**Step 10 - Final Transaction broadcast**_

  * Prior to protocol version 70213, masternodes could only send a single
    un-mined `dstx` message at a time. As of protocol version 70213, up to 5
    (`MASTERNODE_MAX_MIXING_TXES`) un-mined `dstx` messages per masternode are
    allowed.

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

Since DIP3 (introduced in Dash Core 0.13.0), masternode reward payments are based
on the deterministic masternode list information found on-chain in each block.
This results in a transparent, deterministic process that operates using the
[algorithm described in DIP3](https://github.com/dashpay/dips/blob/master/dip-0003.md#masternode<!--noref-->-rewards).

On-chain masternode lists reduce the complexity of reward payments, make
payments much more predictable, and also allow masternode payments to be
enforced for all blocks (enforcement for superblocks was not possible in the
previous system).

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

{% endautocrossref %}

#### Initial Masternode<!--noref--> Sync
{% include helpers/subhead-links.md %}

{% autocrossref %}

The deterministic masternode lists introduced by DIP3 eliminated several steps
of the sync process related to the masternode list and masternode payments.
Since that information is now available on-chain, P2P messages related to those
steps were deprecated.

This diagram shows the order in which P2P messages are sent to perform
masternode synchronization initially after startup.

![Masternode Sync (Initial)](/img/dev/en-masternode-sync-initial-dip3.svg)

The following table details the data flow of P2P messages exchanged during
initial masternode synchronization after the activation of DIP3 and Spork 15.

| **Syncing Node Message** | **Direction**  | **Masternode Response**   | **Description** |
| **1. Sporks** |   |  |  |
| `getsporks` message                            | → |                           | Syncing node requests sporks
|                                                | ← | `spork` message(s)        |
| **2. Governance** |   |  | See [Governance sync](#governance) |

*Masternode Sync Status*

There are several status values used to track masternode synchronization. They
are used in both `ssc` messages and the `mnsync` RPC.

| **Value** | **Status**  | **Description** |
| -1  | `MASTERNODE_SYNC_FAILED`      | Synchronization failed |
| 0   | `MASTERNODE_SYNC_INITIAL`     | Synchronization just started, was reset recently, or is still in IBD |
| 1   | `MASTERNODE_SYNC_WAITING`     | Synchronization pending - waiting after initial to check for more headers/blocks |
| 2   | `MASTERNODE_SYNC_LIST`        | ![Warning icon](/img/icons/icon_warning.svg) _Deprecated following activation of DIP3 and Spork 15_<br><br>Synchronizing masternode list |
| 3   | `MASTERNODE_SYNC_MNW`         | ![Warning icon](/img/icons/icon_warning.svg) _Deprecated following activation of DIP3 and Spork 15_<br><br>Synchronizing masternode payments |
| 4   | `MASTERNODE_SYNC_GOVERNANCE`  | Synchronizing governance objects  |
| 999 | `MASTERNODE_SYNC_FINISHED`    | Synchronization finished |

#### Ongoing Masternode<!--noref--> Sync
{% include helpers/subhead-links.md %}

Once a masternode completes an initial full sync, continuing synchronization is
maintained by the exchange of P2P messages with other nodes. This diagram shows
an overview of the messages exchanged to keep the masternode list, masternode
payments, and governance objects synchronized between masternodes.

![Masternode Sync (Ongoing)](/img/dev/en-masternode-sync-ongoing.svg)

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
| 60  | Process MN Connections    | Disconnects some masternodes (masternodeman.cpp) |
| 60  | InstantSend<!--noref--> Check/Remove  | Remove expired/orphaned/invalid InstantSend candidates and votes (instantx.cpp) |
| 300 | Maintenance               | Check/remove/reprocess governance objects (governance.cpp) |

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

For Object Sync:

* First, the Masternode sends a `ssc` message (Sync Status Count) for `govobj`
objects. This message indicates how many inventory items will be sent.

* Second, the Masternode sends an `inv` message for the `govobj` and `govobjvote`
objects.

For Vote Sync:

* First, the Masternode sends a `ssc` message (Sync Status Count) for `govobjvote`
objects. This message indicates how many inventory items will be sent.

* Second, the Masternode sends an `inv` message for the `govobjvote` object(s).

Once the syncing node receives the counts and inventories, it may request any
`govobj` and `govobjvote` objects from the masternode via a `getdata` message.


*Governance Sync Data Flow*

| **Syncing Node Message** | **Direction**  | **Masternode Response**   | **Description** |
| **Initial request** | | | **Requests all governance objects (without votes)** |
| `govsync` message        | →              |                           | Syncing node initiates governance sync (hash set to all zeros)
|                          | ←              | `ssc` message (govobj)    | Number of governance objects (0 or more)
|                          | ←              | `inv` message (govobj)    | Governance object inventories
| `getdata` message (govobj) | →              |                           | (Optional) Syncing node requests govobj
|                          | ←              | `govobj` message          | (If requested) Governance object
| | | | |
| **Follow up requests** | | | **Requests governance object (with votes)** |
| `govsync` message        | →              |                           | Syncing node requests governance sync for a specific governance object
|                          | ←              | `ssc` message (govobjvote)| Number of governance object votes (0 or more)
|                          | ←              | `inv` message (govobjvote)| Governance object vote inventories
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

Sentinel runs periodically and performs three main tasks as described below:
governance sync, governance object pruning, and superblock management.
The governance object data is stored in a SQLite database.

##### Sentinel<!--noref--> Sync
{% include helpers/subhead-links.md %}

Sentinel issues a `gobject list` RPC command and updates its database with the
results returned from dashd. When objects are removed from the network, they are
purged from the Sentinel database.

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

Beginning ~3 days (1662 blocks) prior to a superblock, Sentinel selects one
masternode per block to rank proposals. This ranking is used to determine
what a candidate superblock (or "superblock trigger") should contain. Based on
the results, it creates and broadcasts a new superblock trigger if a matching
one was not found.

All masternodes vote for existing superblock triggers. Each masternode casts
only 1 superblock trigger "Yes" vote per superblock cycle. It will vote "No"
for any other triggers it receives.

Note: This means that proposal votes submitted _after_ superblock trigger
creation begins will _not_ be counted by some masternodes (those that have
already voted on a superblock trigger).

At the superblock height, the trigger with the most "Yes" votes is paid out by
that block's miner.

##### Sentinel<!--noref--> Ping
{% include helpers/subhead-links.md %}

![Warning icon](/img/icons/icon_warning.svg) NOTE: Deprecated by [Dash Core v0.14](https://github.com/dashpay/sentinel<!--noref-->/pull/64)

In Dash Core 12.2, use of the `watchdog` governance object type was replaced
by integrating sentinel information into the masternode ping (`mnp` message)
via [Pull Request #1491](https://github.com/dashpay/dash/pull/1491).

From Dash Core 0.12.2 through Dash Core 0.13, Sentinel used the `sentinelping` RPC
to update the masternode info and prevent it from entering a `MASTERNODE_WATCHDOG_EXPIRED` state.

{% endautocrossref %}


### Masternode Quorums
{% include helpers/subhead-links.md %}

Dash's masternode quorums are used to facilitate the operation of masternode provided
features in a decentralized, deterministic way. The original quorums (used
largely for InstantSend and masternode payments) were ephemeral and used for a
single purpose (e.g. voting on one specific InstantSend transaction).

Dash Core 0.14 (protocol version 70214) introduced the Long Living Masternode
Quorums (LLMQ) that are described in detail by [DIP6](https://github.com/dashpay/dips/blob/master/dip-0006.md).
These LLMQs are deterministic subsets of the global deterministic masternode
list that are formed via a distributed key generation (DKG) protocol and remain
active for a long periods of time (e.g. hours to days).

The main task of LLMQs is to perform threshold signing of consensus-related
messages (e.g. ChainLocks).

##### LLMQ Creation (DKG)
<!-- no subhead-links here -->

{% autocrossref %}

The following table details the data flow of P2P messages exchanged during
the distributed key generation (DKG) protocol used to establish an LLMQ.

NOTE: With the exception of the final step (`qfcommit` message broadcast), the message
exchanges happen only between masternodes participating in the DKG process via
the Intra-Quorum communication process described in the DIP.

*Quorum DKG Data Flow*

| **Masternode** | **Direction**  | **Peers**   | **Description** |
| **[Initialization Phase](https://github.com/dashpay/dips/blob/master/dip-0006.md#1-initialization-phase)**| | | **Deterministically evaluate if quorum participation necessary** |
| | | | Each quorum participant establishes connections to a set of quorum participants [as described in DIP6](https://github.com/dashpay/dips/blob/master/dip-0006.md#building-the-set-of-deterministic-connections) |
| **[Contribution Phase](https://github.com/dashpay/dips/blob/master/dip-0006.md#2-contribution-phase)** | | | **Send quorum contributions (intra-quorum communication)** |
|`inv` message (qcontrib)                        | → |                              | Masternode sends inventory for its quorum contribution _to other masternodes in the quorum_
|                                                | ← | `getdata` message (qcontrib) | Peer(s) respond with request for quorum contribution
| `qcontrib` message                             | → |                              | Masternode sends the requested quorum contribution
| **[Complaining Phase](https://github.com/dashpay/dips/blob/master/dip-0006.md#3-complaining-phase)** | | | **Send complaints for any peers with invalid or missing contributions (intra-quorum communication)** |
|`inv` message (qcomplaint)                      | → |                              | Masternode sends inventory for any complaints _to other masternodes in the quorum_
|                                                | ← | `getdata` message (qcomplaint) | Peer(s) respond with request for quorum complaints
| `qcomplaint` message                           | → |                              | Masternode sends the requested complaints
| **[Justification Phase](https://github.com/dashpay/dips/blob/master/dip-0006.md#4-justification-phase)** | | | **Send justification responses for any complaints against own contributions (intra-quorum communication)** |
|`inv` message (qjustify)                        | → |                              | Masternode sends inventory for any justifications _to other masternodes in the quorum_
|                                                | ← | `getdata` message (qjustify) | Peer(s) respond with request for quorum justifications
| `qjustify` message                             | → |                              | Masternode sends the requested justifications
| **[Commitment Phase](https://github.com/dashpay/dips/blob/master/dip-0006.md#5-commitment-phase)** | | | **Send premature commitment containing the quorum public key (intra-quorum communication)** |
|`inv` message (qpcommit)                        | → |                              | Masternode sends inventory for its premature commitment _to other masternodes in the quorum_
|                                                | ← | `getdata` message (qpcommit) | Peer(s) respond with request for quorum premature commitment
| `qpcommit` message                             | → |                              | Masternode sends the requested premature commitment
| **[Finalization Phase](https://github.com/dashpay/dips/blob/master/dip-0006.md#6-finalization-phase)** | | | **Send final commitment containing the quorum public key** |
|`inv` message (qfcommit)                        | → |                              | Masternode sends inventory for its premature commitment **to all peers**
|                                                | ← | `getdata` message (qfcommit) | Peer(s) respond with request for quorum final commitment
| `qfcommit` message                             | → |                              | Masternode sends the requested final commitment

{% endautocrossref %}


##### LLMQ Signing Session
<!-- no subhead-links here -->

{% autocrossref %}

The following table details the data flow of P2P messages exchanged during
an LLMQ signing session. These sessions take advantage of BLS threshold signatures
to enable quorums to sign arbitrary messages. For example, Dash Core 0.14 uses
this capability to create the quorum signature found in the `clsig` message that
enables ChainLocks.

Please read [DIP7 LLMQ Signing Requests / Sessions](https://github.com/dashpay/dips/blob/master/dip-0007.md)
for additional details.

*LLMQ Signing Session Data Flow*

| **Masternode** | **Direction**  | **Peers**   | **Description** |
| **[Siging Request Phase](https://github.com/dashpay/dips/blob/master/dip-0007.md#signing-request)** | | | Request quorum signing of a message (e.g. InstantSend transaction input) (intra-quorum communication) |
| `qsigsesann` message                             | → |                              | Masternode sends a signing session announcement _to other masternodes in the quorum_
| **[Share Propagation Phase](https://github.com/dashpay/dips/blob/master/dip-0007.md#propagating-signature<!--noref-->-shares)** | | | Members exchange signature shares within the quorum (intra-quorum communication) |
| `qsigsinv` message                             | → |                              | Masternode sends one or more quorum signature share inventories _to other masternodes in the quorum_<br>_May occur multiple times in this phase_
|                                                | ← | `qgetsigs` message (qcontrib) | Peer(s) respond with request for signature shares<br>_May occur multiple times in this phase_
| `qbsigs` message                             | → |                              | Masternode sends the requested batched signature share(s)<br>_May occur multiple times in this phase_
| **[Threshold Signature Recovery Phase](https://github.com/dashpay/dips/blob/master/dip-0007.md#recovered-threshold-signatures<!--noref-->)** | | | A recovered signature is created by a quorum member once valid signature shares from at least the threshold number of members have been received |
| `qsigrec` message                             | → |                              | Masternode sends the quorum recovered signature **to all peers** (except those that have asked to be excluded via a `qsendrecsigs` message)

Note the following timeouts defined by Dash Core related to signing sessions:

| Parameter | Timeout, sec | Description |
| `SESSION_NEW_SHARES_TIMEOUT` | 60 | Time to wait for new shares |
| `SIG_SHARE_REQUEST_TIMEOUT` | 5 | Time to wait for a requested share before requesting from a different node |
| `SESSION_TOTAL_TIMEOUT` | 300 | Time to wait for session to complete |

{% endautocrossref %}

#### Quorum Selection
{% include helpers/subhead-links.md %}

{% autocrossref %}

| Quorum Type | Members | Consensus | Description |
| ----------- | ------- | --------- | ----------- |
| Classic<br>(non-LLMQ) InstantSend | 10      | Majority  | A set of 10 masternodes are selected for _each_ input of the InstantSend transaction. A majority (6+) of them must agree to lock the input. If all inputs in the transaction can be locked, it becomes a successful InstantSend.
| MN Payments | 10      | Majority | A set of 10 masternodes are selected for each block. A majority (6+) of them must agree on the masternode payee for the next block.
| MN Broadcast | 10      | Majority | _Deprecated by DIP3 (deterministic masternode list) in Dash Core 0.13._<br><br>If a majority (6+) of nodes agree, a new `mnb` message is not required.

{% endautocrossref %}

### Proof of Service
{% include helpers/subhead-links.md %}

{% autocrossref %}

The Proof of Service (PoSe) scoring system helps incentivize masternodes to
provide network services. Masternodes that neglect to participate receive an
increased PoSe score which eventually results in them being excluded from
masternode payment eligibility.

The current PoSe scoring system is based on participation in the LLMQ DKG
process. This scoring system will expand over time to incorporate additional
service requirements in support of the future Dash Platform (Evolution)
functionality.

| Service | Percent of Score | Requirement |
| ----------- | ---- | ------------------- |
| LLMQ DKG    | 100% | Participate in the DKG process used to establish LLMQs. Requires exchanging messages with other quorum members. |

**PoSe Score Calculation**

As shown in the following table, the PoSe Score always decreases by 1 per block
as long as a masternode has not been banned. Once banned, the masternode can
only be restored by sending a Provider Update Service (ProUpServTx) special
transaction.

| PoSe Parameter | Value | Example Value |
|-|-|-|
| Maximum PoSe Score | Number of registered masternodes | 5000 |
| PoSe Score Increases | Maximum PoSe Score * 2/3 | 3333 |
| PoSe Score Decreases | 1 (per block) | Always `1` |

The current PoSe scoring algorithm increases the PoSe score by 66% of the
maximum score for each failed DKG session. Depending on timing, this allows for
no more than 2 failures for a masternode within a payment cycle (i.e a
number of blocks equal to the number of registered masternodes).

For example, using the values from above with 5000 masternodes:

- In the first 5000 block cycle, two DKG failures occur without the PoSe score exceeding the maximum. This happens since a sufficient number of blocks are mined prior to the second failure to drop the PoSe score below the threshold (`< 5000 - 3333`) that would result in banning.

- In the second 5000 block cycle, the second DKG failure occurs too close to the first and results in the PoSe score exceeding the maximum limit. This results in the masternode receiving a PoSe Ban.

| Payment Cycle | Block Number | Event | Score Change | PoSe Score | Masternode Status |
|-|-|-|-|-|-|
| 1 | 1 | DKG Failure (1) | +3333 | 3333 | Valid |
| 1 | 1734 | 1733 Blocks Mined | -1733 | 1600 | Valid |
| 1 | 1734 | DKG Failure (2) | +3333 | 4933 | Valid |
| 1 | 5000 | 3266 Blocks Mined | -3266 | 1667 | Valid |
| | | End of Payment Cycle 1| | | |
| 2 | 5500 | 500 Blocks Mined | -500 | 1167 | Valid |
| 2 | 5500 | DKG Failure (3) | +3333 | 4500 | Valid |
| 2 | 7000 | 1500 Blocks Mined | -1500 | 3000 | Valid |
| 2 | 7000 | DKG Failure (4) | +3333 | 6333 | PoSe Banned |
| 2 | 10000 | End of Payment Cycle 2 | - | 6333 | PoSe Banned |

{% endautocrossref %}

### Historical Reference
<!-- no subhead-links here -->

![Warning icon](/img/icons/icon_warning.svg) **The following information is
deprecated and for historical reference only. It describes features that have
been redesigned and no longer operate as described below.**

#### InstantSend (original)
{% include helpers/subhead-links.md %}

{% autocrossref %}

![Warning icon](/img/icons/icon_warning.svg) **Please see [here for details of the current InstantSend design](#instantsend<!--noref-->).**

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
* A “per-input” fee of 0.0001 DASH per input is required for non-simple transactions (inputs >=5) since they place a higher load on the masternodes. This fee was most
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


#### Masternode Payment (original)
{% include helpers/subhead-links.md %}

![Warning icon](/img/icons/icon_warning.svg) **The following information is for
historical reference only. It describes the masternode payment process that was
used prior to the deterministic masternode list update in Dash Core v0.13 that
implemented DIP3.**

Please see [here for details of the current system](#masternode-payment)

{% autocrossref %}

Prior to DIP3, the masternode payment process operated as described below.

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
detail, reference this [Official Documentation Payment Logic page](https://docs.dash.org/en/0.12.3/masternodes<!--noref-->/understanding.html#payment-logic).

Nodes receiving a `mnw` message verify the validity of the message before
relaying it to their peers. If the message is invalid, the sending node may be
treated as misbehaving and have its ban score increased.

{% endautocrossref %}


#### Masternode Sync (original)
<!-- no subhead-links here -->

![Warning icon](/img/icons/icon_warning.svg) **The following information is for
historical reference only. It describes the masternode sync process that was
used prior to the deterministic masternode list update in Dash Core v0.13 that
implemented DIP3.**

Please see [here for details of the current system](#masternode-sync)

##### Initial Sync
<!-- no subhead-links here -->

{% autocrossref %}

This diagram shows the order in which P2P messages are sent to perform
masternode synchronization initially after startup.

![Masternode Sync (Initial)](/img/dev/en-masternode-sync-initial.svg)

The following table details the data flow of P2P messages exchanged during
initial masternode synchronization before the activation of DIP3 and Spork 15.

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


##### Ongoing Sync
{% include helpers/subhead-links.md %}

Once a masternode completes an initial full sync, continuing synchronization is
maintained by the exchange of P2P messages with other nodes. This diagram shows
an overview of the messages exchanged to keep the masternode list, masternode
payments, and governance objects synchronized between masternodes.

![Masternode Sync (Ongoing)](/img/dev/en-masternode-sync-ongoing.svg)

**Recurring Ping**

![Warning icon](/img/icons/icon_warning.svg) NOTE: Deprecated following
activation of DIP3.

Each masternode issues a ping (`mnp` message) periodically to notify the network
that it is still online. Masternodes that do not issue a ping for 3 hours will
be put into the `MASTERNODE_NEW_START_REQUIRED` state and will need to issue a
masternode announce (`mnb` message).

**Masternode List**

![Warning icon](/img/icons/icon_warning.svg) NOTE: Deprecated following
activation of DIP3.

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

![Warning icon](/img/icons/icon_warning.svg) NOTE: Deprecated following
activation of DIP3.

After the initial masternode payment synchronization, payment information is
kept current via the `mnw` messages relayed on the network. Unsynchronized peers
may send a `mnget` message to request masternode payment sync.

##### Sync Schedule
{% include helpers/subhead-links.md %}

Prior to the deterministic masternode system introduced by DIP3 in Dash Core 0.13,
the following additional sync actions were also required.

| **Period (seconds)** | **Action** | **Description** |
| 1   | MN Check                  | ![Warning icon](/img/icons/icon_warning.svg) _Deprecated following activation of DIP3 and Spork 15_<br><br>Check the state of each masternode that is still funded and not banned. The action occurs once per second, but individual masternodes are only checked at most every 5 seconds (only a subset of masternodes are checked each time it runs) (masternodeman.cpp) |
| 60  | MN Check/Remove           | ![Warning icon](/img/icons/icon_warning.svg) _Deprecated following activation of DIP3 and Spork 15_<br><br>Remove spent masternodes and check the state of inactive ones (masternodeman.cpp) |
| 60  | MN Payment Check/Remove   | ![Warning icon](/img/icons/icon_warning.svg) _Deprecated following activation of DIP3 and Spork 15_<br><br>Remove old masternode payment votes/blocks (masternode-payments.cpp) |
| 300 | Full verification         | ![Warning icon](/img/icons/icon_warning.svg) _Deprecated following activation of DIP3 and Spork 15_<br><br>Verify masternodes via direct requests (`mnv` messages - note time constraints in the Developer Reference section) (masternodeman.cpp) |
| 600 | Manage State              | ![Warning icon](/img/icons/icon_warning.svg) _Deprecated following activation of DIP3 and Spork 15_<br><br>Sends masternode pings (`mnp` message). Also sends initial masternode broadcast (`mnb` message) for local masternodes. (activemasternode.cpp) |

{% endautocrossref %}
