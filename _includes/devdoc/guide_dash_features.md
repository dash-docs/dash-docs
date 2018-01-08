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
enable secure, instantaneous transactions.

*InstantSend Data Flow*

| **InstantSend Client** | **Direction**  | **Peers**   | **Description** |
| `inv` message (ix)          | → |                         | Client sends inventory for transaction lock request
|                             | ← | `getdata` message (ix)  | Peer responds with request for transaction lock request
| `ix` message                | → |                         | Client sends InstantSend transaction lock request
|                             | ← | `inv` message (txlvote) | Masternodes in the [quorum](#quorum-selection) respond with votes
| `getdata` message (txlvote) | → |                         | Client requests vote
|                             | ← | `txlvote` message       | Peer responds with vote

Once a sufficient number of votes approve the transaction lock, the InstantSend
transaction is approved and shows 5 confirmations (`DEFAULT_INSTANTSEND_DEPTH`).
If an InstantSend transaction is a valid transaction but does not receive a
transaction lock, it reverts to being a standard transaction.

There are a number of limitations on InstantSend transactions:

* To be used in an InstantSend transaction, an input must have 6+ confirmations (`INSTANTSEND_CONFIRMATIONS_REQUIRED`)
* The lock request will timeout 15 seconds after the first vote is seen (`INSTANTSEND_LOCK_TIMEOUT_SECONDS`)
* The lock request will fail if it has not been locked after 60 seconds (`INSTANTSEND_FAILED_TIMEOUT_SECONDS`)
* A minimum fee (0.001 Dash) is required since the transaction involves the masternodes in addition to miners. Activation of [DIP-0001](https://github.com/dashpay/dips/blob/master/dip-0001.md) will reduce the fee by an order of magnitude (to 0.0001 Dash).

{% endautocrossref %}


### PrivateSend
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash Core's PrivateSend feature provides a way to improve privacy by performing
coin-mixing without relinquishing custodial access. For additional details,
reference this [Official Documentation PrivateSend page](https://dashpay.atlassian.net/wiki/spaces/DOC/pages/1146924/PrivateSend<!--noref-->).

*PrivateSend Data Flow*

| **PrivateSend Clients** | **Direction**  | **Masternode**   | **Description** |
| `dsa` message                            | → |                            | Clients asks to join mixing pool (or have MN start a new one)
|                                                | ← | `dssu` message       | Masternode provides a mixing pool status update (Typical - State: `POOL_STATE_QUEUE`, Message: `MSG_NOERR`)
|                                                | ← | `dsq` message        | Masternode notifies clients when it is ready to mix
| `dsi` message                                 | → |                       | Clients each provide a list of their inputs (unsigned) to be mixed, collateral, and a list of outputs where mixed funds should be sent
|                                                | ← | `dssu` message       | Masternode provides a mixing pool status update (typical - State: `POOL_STATE_ACCEPTING_ENTRIES`, Message: `MSG_ENTRIES_ADDED`)
|                                                | ← | `dsf` message        | Masternode sends the final transaction containing all clients inputs (unsiged) and all client outputs to each client for verification
|                                                | ← | `dssu` message       | Masternode provides a mixing pool status update (Typical - State: `POOL_STATE_SIGNING`, Message: `MSG_NOERR`)
| `dss` message                                 | → |                       | After verifying the final transaction, clients each sign their own inputs and send them back
|                                                | ← | `dsc` message        | Masternode verifies the signed inputs, creates a `dstx` message to broadcast the transaction, and notifies clients that the mixing transaction is complete (Typical - Message: `MSG_SUCCESS`)
|                                                | ← | `inv` message        | Masternode broadcasts a `dstx` inventory message
| `getdata` message (dstx)                                 | → |            | (Optional)

{% endautocrossref %}


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
masternodes in sync with each other. This information is derived from
`ThreadCheckPrivateSend` in `src/privatesend<!--noref-->.cpp`.

| **Period (seconds)** | **Action** | **Description** |
| 6   | MN Sync                   | Synchronizes sporks, masternode list, masternode payments, and governance objects |

The following actions only run when the masternode sync is past `MASTERNODE_SYNC_WAITING` status.

| **Period (seconds)** | **Action** | **Description** |
| 1   | MN Check                  | Check the state of each masternode that is still funded and not banned. The action occurs once per second, but individual masternodes are only checked at most every 5 seconds (only a subset of masternodes are checked each time it runs) |
| 60  | Process MN Connections    | Disconnects some masternodes |
| 60  | MN Check/Remove           | Remove spent masternodes and check the state of inactive ones |
| 60  | MN Payment Check/Remove   | Remove old masternode payment votes/blocks  |
| 60  | InstantSend<!--noref--> Check/Remove  | Remove expired/orphaned/invalid InstantSend candidates and votes |
| 300 | Full verification         | Verify masternodes via direct requests (`mnv` messages - note time constraints in the Developer Reference section) |
| 300 | Maintenance               | Check/remove/reprocess governance objects |
| 600 | Manage State              | Sends masternode pings (`mnp` message). Also sends initial masternode broadcast (`mnb` message) for local masternodes. |

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
| **Inital request** | | | **Requests all governance objects (without votes)** |
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
