{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/ref_p2p_networking.md" %}

## P2P Network
{% include helpers/subhead-links.md %}

{% autocrossref %}

This section describes the Dash P2P network protocol (but it is [not a
specification][]). It does not describe the
[BIP70 payment protocol][/en/glossary/payment-protocol], the
[GetBlockTemplate mining protocol][section getblocktemplate], or any
network protocol never implemented in an official version of Dash Core.

All peer-to-peer communication occurs entirely over TCP.

{% highlight text %}
Note: unless their description says otherwise, all multi-byte
integers mentioned in this section are transmitted in little-endian order.
{% endhighlight %}

{% endautocrossref %}

### Constants And Defaults
{% include helpers/subhead-links.md %}

{% autocrossref %}

The following constants and defaults are taken from Dash Core's
[chainparams.cpp][core chainparams.cpp] source code file.

| Network | Default Port | Magic Value | [Start String][/en/glossary/start-string]{:#term-start-string}{:.term} | Max nBits
|---------|--------------|-----------------------------------------------|---------------
| Mainnet | 9999         | 0xBD6B0CBF  | 0xBF0C6BBD                      | 0x1e0ffff0
| Testnet | 19999        | 0xFFCAE2CE  | 0xCEE2CAFF                      | 0x1e0ffff0
| Regtest | 19994        | 0xDCB7C1FC  | 0xFCC1B7DC                      | 0x207fffff

Note: the testnet start string and nBits above are for testnet3.

Command line parameters can change what port a node listens on (see
`-help`). Start strings are hardcoded constants that appear at the start
of all messages sent on the Dash network; they may also appear in
data files such as Dash Core's block database. The Magic Value and nBits
displayed above are in big-endian order; they're sent over the network in
little-endian order. The Start String is simply the endian reversed Magic Value.

Dash Core's [chainparams.cpp][core chainparams.cpp] also includes
other constants useful to programs, such as the hash of the genesis
blocks for the different networks.

{% endautocrossref %}

### Protocol Versions
{% include helpers/subhead-links.md %}

{% autocrossref %}

The table below lists some notable versions of the P2P network protocol,
with the most recent versions listed first. (If you know of a protocol
version that implemented a major change but which is not listed here,
please [open an issue][docs issue].)

As of Dash Core 0.12.1.5, the most recent protocol version is 70206.

| Version | Initial Release                    | Major Changes
|---------|------------------------------------|--------------
| 70208  | Dash Core 0.12.2.x <br>(??? 2017)  |
| 70206  | Dash Core 0.12.1.x <br>(Mar 2017)  |
| 70103  | Dash Core 0.12.0.x <br>(Aug 2015)  |
| 70076  | Dash Core 0.11.2.x <br>(Apr 2015)  |
| 70066  | Dash Core 0.11.1.x <br>(Feb 2015)  |
| 70051  | Dash Core 0.10.0.x <br>(Feb 2015)  |
| 70002  | Dash Core 0.8.7 <br>(Jan 2014)     | Initial Dash release

Historical Bitcoin protocol versions for reference shown below.

| Version | Initial Release                    | Major Changes
|---------|------------------------------------|--------------
| 70012   | Bitcoin Core 0.12.0 <br>(Feb 2016) | [BIP130][]: <br>• Added `sendheaders` message.
| 70011   | Bitcoin Core 0.12.0 <br>(Feb 2016) | [BIP111][]: <br>• `filter*` messages are disabled without NODE_BLOOM after and including this version.
| 70002   | Bitcoin Core 0.9.0 <br>(Mar 2014)  | • Send multiple `inv` messages in response to a `mempool` message if necessary <br><br>[BIP61][]: <br>• Added `reject` message
| 70001   | Bitcoin Core 0.8.0 <br>(Feb 2013)  | • Added `notfound` message. <br><br>[BIP37][]: <br>• Added `filterload` message. <br>• Added `filteradd` message. <br>• Added `filterclear` message. <br>• Added `merkleblock` message. <br>• Added relay field to `version` message <br>• Added `MSG_FILTERED_BLOCK` inventory type to `getdata` message.
| 60002   | Bitcoin Core 0.7.0 <br>(Sep 2012)  | [BIP35][]: <br>• Added `mempool` message. <br>• Extended `getdata` message to allow download of memory pool transactions
| 60001   | Bitcoin Core 0.6.1 <br>(May 2012)  | [BIP31][]: <br>• Added nonce field to `ping` message <br>• Added `pong` message
| 60000   | Bitcoin Core 0.6.0 <br>(Mar 2012)  | [BIP14][]: <br>• Separated protocol version from Bitcoin Core version
| 31800   | Bitcoin Core 0.3.18 <br>(Dec 2010) | • Added `getheaders` message and `headers` message.
| 31402   | Bitcoin Core 0.3.15 <br>(Oct 2010) | • Added time field to `addr` message.
| 311     | Bitcoin Core 0.3.11 <br>(Aug 2010) | • Added `alert` message.
| 209     | Bitcoin Core 0.2.9 <br>(May 2010)  | • Added checksum field to message headers.
| 106     | Bitcoin Core 0.1.6 <br>(Oct 2009)  | • Added receive IP address fields to `version` message.

{% endautocrossref %}

### Message Headers
{% include helpers/subhead-links.md %}

{% autocrossref %}

All messages in the network protocol use the same container format,
which provides a required multi-field message header and an optional payload.
The message header format is:

| Bytes | Name         | Data Type | Description
|-------|--------------|-----------|-------------
| 4     | start string | char[4]   | Magic bytes indicating the originating network; used to seek to next message when stream state is unknown.
| 12    | command name | char[12]  | ASCII string which identifies what message type is contained in the payload.  Followed by nulls (0x00) to pad out byte count; for example: `version\0\0\0\0\0`.
| 4     | payload size | uint32_t  | Number of bytes in payload.  The current maximum number of bytes ([`MAX_SIZE`][max_size]) allowed in the payload by Dash Core is 32 MiB---messages with a payload size larger than this will be dropped or rejected.
| 4     | checksum     | char[4]   | *Added in protocol version 209.* <br><br>First 4 bytes of SHA256(SHA256(payload)) in internal byte order.<br /><br /> If payload is empty, as in `verack` and `getaddr` messages, the checksum is always 0x5df6e0e2 (SHA256(SHA256(\<empty string>))).

The following example is an annotated hex dump of a mainnet message
header from a `verack` message which has no payload.

{% highlight text %}
bf0c6bbd ................... Start string: Mainnet
76657261636b000000000000 ... Command name: verack + null padding
00000000 ................... Byte count: 0
5df6e0e2 ................... Checksum: SHA256(SHA256(<empty>))
{% endhighlight %}

{% endautocrossref %}

### Data Messages
{% include helpers/subhead-links.md %}

{% autocrossref %}

The following network messages all request or provide data related to
transactions and blocks.

![Overview Of P2P Protocol Data Request And Reply Messages](/img/dev/en-p2p-data-messages.svg)

Many of the data messages use
[inventories][/en/glossary/inventory]{:#term-inventory}{:.term} as unique identifiers
for transactions and blocks.  Inventories have a simple 36-byte
structure:

| Bytes | Name            | Data Type | Description
|-------|-----------------|-----------|-------------
| 4     | type identifier | uint32_t  | The type of object which was hashed.  See list of type identifiers below.
| 32    | hash            | char[32]  | SHA256(SHA256()) hash of the object in internal byte order.

The currently-available type identifiers are:

| Type Identifier | Name                                                                          | Description
|-----------------|-------------------------------------------------------------------------------|---------------
| 1               | [`MSG_TX`][msg_tx]{:#term-msg_tx}{:.term}                                     | The hash is a TXID.
| 2               | [`MSG_BLOCK`][msg_block]{:#term-msg_block}{:.term}                            | The hash is of a block header.
| 3               | [`MSG_FILTERED_BLOCK`][msg_filtered_block]{:#term-msg_filtered_block}{:.term} | The hash is of a block header; identical to `MSG_BLOCK`. When used in a `getdata` message, this indicates the response should be a `merkleblock` message rather than a `block` message (but this only works if a bloom filter was previously configured).  **Only for use in `getdata` messages.**
| 4               | [`MSG_TXLOCK_REQUEST`][msg_txlock_request]{:#term-msg_txlock_request}{:.term} | The hash is an Instant Send transaction lock request.
| 5               | [`MSG_TXLOCK_VOTE`][msg_txlock_vote]{:#term-msg_txlock_vote}{:.term}          | The hash is an Instant Send transaction vote.
| 6               | [`MSG_SPORK`][msg_spork]{:#term-msg_spork}{:.term}                            | The hash is Spork ID.
| 7               | [`MSG_MASTERNODE_PAYMENT_VOTE`][msg_masternode_payment_vote]{:#term-msg_masternode_payment_vote}{:.term}                                     | The hash is a Masternode Payment Vote.
| 8               | [`MSG_MASTERNODE_PAYMENT_BLOCK`][msg_masternode_payment_block]{:#term-msg_masternode_payment_block}{:.term}                                     | The hash is a Masternode Payment Block.
| _8_               | _`MSG_MASTERNODE_SCANNING_ERROR`_                                             | Replaced by `MSG_MASTERNODE_PAYMENT_BLOCK`
| _9_               | _[`MSG_BUDGET_VOTE`][msg_budget_vote]{:#term-msg_budget_vote}{:.term}_          | Deprecated
| _10_               | _[`MSG_BUDGET_PROPOSAL`][msg_budget_proposal]{:#term-msg_budget_proposal}{:.term}_                                     | Deprecated
| _11_               | _[`MSG_BUDGET_FINALIZED`][msg_budget_finalized]{:#term-msg_budget_finalized}{:.term}_                                     | Deprecated
| _12_               | _[`MSG_BUDGET_FINALIZED_VOTE`][msg_budget_finalized_vote]{:#term-msg_budget_finalized_vote}{:.term}_                                     | Deprecated
| _13_               | _[`MSG_MASTERNODE_QUORUM`][msg_masternode_quorum]{:#term-msg_masternode_quorum}{:.term}_                                     | Not Implemented
| 14               | [`MSG_MASTERNODE_ANNOUNCE`][msg_masternode_announce]{:#term-msg_masternode_announce}{:.term}                                     | The hash is a Masternode Broadcast.
| 15               | [`MSG_MASTERNODE_PING`][msg_masternode_ping]{:#term-msg_masternode_ping}{:.term}                                     | The hash is a Masternode Ping.
| 16               | [`MSG_DSTX`][msg_dstx]{:#term-msg_dstx}{:.term}                              | The hash is Private Send (Dark Send) Broadcast TX.
| 17               | [`MSG_GOVERNANCE_OBJECT`][msg_governance_object]{:#term-msg_governance_object}{:.term}                                     | The hash is a Governance Object.
| 18               | [`MSG_GOVERNANCE_OBJECT_VOTE`][msg_governance_object_vote]{:#term-msg_governance_object}{:.term}                                     | The hash is a Governance Object Vote.
| 19               | [`MSG_MASTERNODE_VERIFY`][msg_masternode_verify]{:#term-msg_masternode_verify}{:.term}                                     | The hash is a Masternode Verify.

Type identifier zero and type identifiers greater than nineteen are reserved
for future implementations. Dash Core ignores all inventories with
one of these unknown types.

{% endautocrossref %}

#### Block
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `block` message transmits a single serialized block in the format
described in the [serialized blocks section][section serialized blocks].
See that section for an example hexdump.  It can be sent for two
different reasons:

1. **GetData Response:** Nodes will always send it in response to a
   `getdata` message that requests the block with an inventory
   type of `MSG_BLOCK` (provided the node has that block available for
   relay).

2. **Unsolicited:** Some miners will send unsolicited `block` messages
   broadcasting their newly-mined blocks to all of their peers. Many
   mining pools do the same thing, although some may be misconfigured to
   send the block from multiple nodes, possibly sending the same block
   to some peers more than once.

{% endautocrossref %}

#### GetBlocks
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `getblocks` message requests an `inv` message that provides block
header hashes starting from a particular point in the block chain. It
allows a peer which has been disconnected or started for the first time
to get the data it needs to request the blocks it hasn't seen.

Peers which have been disconnected may have stale blocks in their
locally-stored block chain, so the `getblocks` message allows the
requesting peer to provide the receiving peer with multiple header
hashes at various heights on their local chain. This allows the
receiving peer to find, within that list, the last header hash they had
in common and reply with all subsequent header hashes.

Note: the receiving peer itself may respond with an `inv` message
containing header hashes of stale blocks.  It is up to the requesting
peer to poll all of its peers to find the best block chain.

If the receiving peer does not find a common header hash within the
list, it will assume the last common block was the genesis block (block
zero), so it will reply with in `inv` message containing header hashes
starting with block one (the first block after the genesis block).

| Bytes    | Name                 | Data Type        | Description
|----------|----------------------|------------------|----------------
| 4        | version              | uint32_t         | The protocol version number; the same as sent in the `version` message.
| *Varies* | hash count           | compactSize uint | The number of header hashes provided not including the stop hash.  There is no limit except that the byte size of the entire message must be below the [`MAX_SIZE`][max_size] limit; typically from 1 to 200 hashes are sent.
| *Varies* | block header hashes  | char[32]         | One or more block header hashes (32 bytes each) in internal byte order.  Hashes should be provided in reverse order of block height, so highest-height hashes are listed first and lowest-height hashes are listed last.
| 32       | stop hash            | char[32]         | The header hash of the last header hash being requested; set to all zeroes to request an `inv` message with all subsequent header hashes (a maximum of 500 will be sent as a reply to this message; if you need more than 500, you will need to send another `getblocks` message with a higher-height header hash as the first entry in block header hash field).

The following annotated hexdump shows a `getblocks` message.  (The
message header has been omitted.)

{% highlight text %}
71110100 ........................... Protocol version: 70001
02 ................................. Hash count: 2

d39f608a7775b537729884d4e6633bb2
105e55a16a14d31b0000000000000000 ... Hash #1

5c3e6403d40837110a2e8afb602b1c01
714bda7ce23bea0a0000000000000000 ... Hash #2

00000000000000000000000000000000
00000000000000000000000000000000 ... Stop hash
{% endhighlight %}

{% endautocrossref %}

#### GetData
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `getdata` message requests one or more data objects from another
node. The objects are requested by an inventory, which the requesting
node typically previously received by way of an `inv` message.

The response to a `getdata` message can be a `tx` message, `block`
message, `merkleblock` message, `ix` message, `txlvote` message,
`mnw` message, `mnb` message, `mnp` message, `dstx` message, `govobj` message,
`govobjvote` message, `mnv` message, or `notfound` message. <!-- What about spork? Only handled by getspork?-->

This message cannot be used to request arbitrary data, such as historic
transactions no longer in the memory pool or relay set. Full nodes may
not even be able to provide older blocks if they've pruned old
transactions from their block database. For this reason, the `getdata`
message should usually only be used to request data from a node which
previously advertised it had that data by sending an `inv` message.

The format and maximum size limitations of the `getdata` message are
identical to the `inv` message; only the message header differs.

{% endautocrossref %}

#### GetHeaders
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70077.*

The `getheaders` message requests a `headers` message that provides block headers
starting from a particular point in the block chain. It allows a
peer which has been disconnected or started for the first time to get
the headers it hasn’t seen yet.

The `getheaders` message is nearly identical to the `getblocks` message,
with one minor difference: the `inv` reply to the `getblocks` message
will include no more than 500 block header hashes; the `headers` reply
to the `getheaders` message will include as many as 2,000 block headers.

{% endautocrossref %}

#### Headers
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 31800 (of Bitcoin).*

The `headers` message sends block headers to a node which
previously requested certain headers with a `getheaders` message. A headers
message can be empty.

| Bytes    | Name    | Data Type        | Description
|----------|---------|------------------|-----------------
| *Varies* | count   | compactSize uint | Number of block headers up to a maximum of 2,000.  Note: headers-first sync assumes the sending node will send the maximum number of headers whenever possible.
| *Varies* | headers | block_header     | Block headers: each 80-byte block header is in the format described in the [block headers section][section block header] with an additional 0x00 suffixed.  This 0x00 is called the transaction count, but because the headers message doesn't include any transactions, the transaction count is always zero.

The following annotated hexdump shows a `headers` message.  (The message
header has been omitted.)

{% highlight text %}
01 ................................. Header count: 1

02000000 ........................... Block version: 2
b6ff0b1b1680a2862a30ca44d346d9e8
910d334beb48ca0c0000000000000000 ... Hash of previous block's header
9d10aa52ee949386ca9385695f04ede2
70dda20810decd12bc9b048aaab31471 ... Merkle root
24d95a54 ........................... Unix time: 1415239972
30c31b18 ........................... Target (bits)
fe9f0864 ........................... Nonce

00 ................................. Transaction count (0x00)
{% endhighlight %}

{% endautocrossref %}

#### Inv
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `inv` message (inventory message) transmits one or more inventories of
objects known to the transmitting peer.  It can be sent unsolicited to
announce new transactions or blocks, or it can be sent in reply to a
`getblocks` message or `mempool` message.

The receiving peer can compare the inventories from an `inv` message
against the inventories it has already seen, and then use a follow-up
message to request unseen objects.

| Bytes    | Name      | Data Type             | Description
|----------|-----------|-----------------------|-----------------
| *Varies* | count     | compactSize uint      | The number of inventory entries.
| *Varies* | inventory | inventory             | One or more inventory entries up to a maximum of 50,000 entries.

The following annotated hexdump shows an `inv` message with two
inventory entries.  (The message header has been omitted.)

{% highlight text %}
02 ................................. Count: 2

0f000000 ........................... Type: MSG_MASTERNODE_PING
dd6cc6c11211793b239c2e311f1496e2
2281b200b35233eaae465d2aa3c9d537 ... Hash (mnp)

05000000 ........................... Type: MSG_TXLOCK_VOTE
afc5b2f418f8c06c477a7d071240f5ee
ab17057f9ce4b50c2aef4fadf3729a2e ... Hash (txlvote)
{% endhighlight %}

{% endautocrossref %}

#### MemPool
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 60002 (of Bitcoin).*

The `mempool` message requests the TXIDs of transactions that the
receiving node has verified as valid but which have not yet appeared in
a block. That is, transactions which are in the receiving node's memory
pool. The response to the `mempool` message is one or more `inv`
messages containing the TXIDs in the usual inventory format.

Sending the `mempool` message is mostly useful when a program first
connects to the network. Full nodes can use it to quickly gather most or
all of the unconfirmed transactions available on the network; this is
especially useful for miners trying to gather transactions for their
transaction fees. SPV clients can set a filter before sending a
`mempool` to only receive transactions that match that filter; this
allows a recently-started client to get most or all unconfirmed
transactions related to its wallet.

The `inv` response to the `mempool` message is, at best, one node's
view of the network---not a complete list of unconfirmed transactions
on the network. Here are some additional reasons the list might not
be complete:

* Before Bitcoin Core 0.9.0, the response to the `mempool` message was
  only one `inv` message. An `inv` message is limited to 50,000
  inventories, so a node with a memory pool larger than 50,000 entries
  would not send everything.  Later versions of Bitcoin Core send as
  many `inv` messages as needed to reference its complete memory pool.

* The `mempool` message is not currently fully compatible with the
  `filterload` message's `BLOOM_UPDATE_ALL` and
  `BLOOM_UPDATE_P2PUBKEY_ONLY` flags. Mempool transactions are not
  sorted like in-block transactions, so a transaction (tx2) spending an
  output can appear before the transaction (tx1) containing that output,
  which means the automatic filter update mechanism won't operate until
  the second-appearing transaction (tx1) is seen---missing the
  first-appearing transaction (tx2). It has been proposed in [Bitcoin
  Core issue #2381][] that the transactions should be sorted before
  being processed by the filter.

There is no payload in a `mempool` message.  See the [message header
section][section message header] for an example of a message without a payload.

{% endautocrossref %}

#### MerkleBlock
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70001 as described by BIP37.*

The `merkleblock` message is a reply to a `getdata` message which
requested a block using the inventory type `MSG_MERKLEBLOCK`.  It is
only part of the reply: if any matching transactions are found, they will
be sent separately as `tx` messages.

If a filter has been previously set with the `filterload` message, the
`merkleblock` message will contain the TXIDs of any transactions in the
requested block that matched the filter, as well as any parts of the
block's merkle tree necessary to connect those transactions to the
block header's merkle root. The message also contains a complete copy
of the block header to allow the client to hash it and confirm its
proof of work.

| Bytes    | Name               | Data Type        | Description
|----------|--------------------|------------------|----------------
| 80       | block header       | block_header     | The block header in the format described in the [block header section][section block header].
| 4        | transaction count  | uint32_t         | The number of transactions in the block (including ones that don't match the filter).
| *Varies* | hash count         | compactSize uint | The number of hashes in the following field.
| *Varies* | hashes             | char[32]         | One or more hashes of both transactions and merkle nodes in internal byte order.  Each hash is 32 bytes.
| *Varies* | flag byte count    | compactSize uint | The number of flag bytes in the following field.
| *Varies* | flags              | byte[]           | A sequence of bits packed eight in a byte with the least significant bit first.  May be padded to the nearest byte boundary but must not contain any more bits than that.  Used to assign the hashes to particular nodes in the merkle tree as described below.

The annotated hexdump below shows a `merkleblock` message which
corresponds to the examples below.  (The message header has been
omitted.)

{% highlight text %}
01000000 ........................... Block version: 1
82bb869cf3a793432a66e826e05a6fc3
7469f8efb7421dc88067010000000000 ... Hash of previous block's header
7f16c5962e8bd963659c793ce370d95f
093bc7e367117b3c30c1f8fdd0d97287 ... Merkle root
76381b4d ........................... Time: 1293629558
4c86041b ........................... nBits: 0x04864c * 256**(0x1b-3)
554b8529 ........................... Nonce

07000000 ........................... Transaction count: 7
04 ................................. Hash count: 4

3612262624047ee87660be1a707519a4
43b1c1ce3d248cbfc6c15870f6c5daa2 ... Hash #1
019f5b01d4195ecbc9398fbf3c3b1fa9
bb3183301d7a1fb3bd174fcfa40a2b65 ... Hash #2
41ed70551dd7e841883ab8f0b16bf041
76b7d1480e4f0af9f3d4c3595768d068 ... Hash #3
20d2a7bc994987302e5b1ac80fc425fe
25f8b63169ea78e68fbaaefa59379bbf ... Hash #4

01 ................................. Flag bytes: 1
1d ................................. Flags: 1 0 1 1 1 0 0 0
{% endhighlight %}

Note: when fully decoded, the above `merkleblock` message provided the
TXID for a single transaction that matched the filter. In the network
traffic dump this output was taken from, the full transaction belonging
to that TXID was sent immediately after the `merkleblock` message as
a `tx` message.

##### Parsing A MerkleBlock Message
{:.no_toc}
{% include helpers/subhead-links.md %}

As seen in the annotated hexdump above, the `merkleblock` message
provides three special data types: a transaction count, a list of
hashes, and a list of one-bit flags.

You can use the transaction count to construct an empty merkle tree.
We'll call each entry in the tree a node; on the bottom are TXID
nodes---the hashes for these nodes are TXIDs; the remaining nodes
(including the merkle root) are non-TXID nodes---they may actually have
the same hash as a TXID, but we treat them differently.

![Example Of Parsing A MerkleBlock Message](/img/dev/animated-en-merkleblock-parsing.gif)

Keep the hashes and flags in the order they appear in the `merkleblock`
message. When we say "next flag" or "next hash", we mean the next flag
or hash on the list, even if it's the first one we've used so far.

Start with the merkle root node and the first flag. The table below
describes how to evaluate a flag based on whether the node being
processed is a TXID node or a non-TXID node. Once you apply a flag to a
node, never apply another flag to that same node or reuse that same
flag again.

| Flag  | TXID Node                                                                                | Non-TXID Node
|-------|------------------------------------------------------------------------------------------|----
| **0** | Use the next hash as this node's TXID, but this transaction didn't match the filter.     | Use the next hash as this node's hash.  Don't process any descendant nodes.
| **1** | Use the next hash as this node's TXID, and mark this transaction as matching the filter. | The hash needs to be computed.  Process the left child node to get its hash; process the right child node to get its hash; then concatenate the two hashes as 64 raw bytes and hash them to get this node's hash.

Any time you begin processing a node for the first time, evaluate the next
flag. Never use a flag at any other time.

When processing a child node, you may need to process its children (the
grandchildren of the original node) or further-descended nodes before
returning to the parent node. This is expected---keep processing depth
first until you reach a TXID node or a non-TXID node with a flag of 0.

After you process a TXID node or a non-TXID node with a flag of 0, stop
processing flags and begin to ascend the tree. As you ascend, compute
the hash of any nodes for which you now have both child hashes or for
which you now have the sole child hash. See the [merkle tree
section][section merkle trees] for hashing instructions. If you reach a
node where only the left hash is known, descend into its right child (if
present) and further descendants as necessary.

However, if you find a node whose left and right children both have the
same hash, fail.  This is related to CVE-2012-2459.

Continue descending and ascending until you have enough information to
obtain the hash of the merkle root node. If you run out of flags or
hashes before that condition is reached, fail. Then perform the
following checks (order doesn't matter):

* Fail if there are unused hashes in the hashes list.

* Fail if there are unused flag bits---except for the minimum number of
  bits necessary to pad up to the next full byte.

* Fail if the hash of the merkle root node is not identical to the
  merkle root in the block header.

* Fail if the block header is invalid. Remember to ensure that the hash
  of the header is less than or equal to the target threshold encoded by
  the nBits header field. Your program should also, of course, attempt
  to ensure the header belongs to the best block chain and that the user
  knows how many confirmations this block has.

For a detailed example of parsing a `merkleblock` message, please see
the corresponding [merkle block examples section][section merkleblock
example].

##### Creating A MerkleBlock Message
{:.no_toc}
{% include helpers/subhead-links.md %}

It's easier to understand how to create a `merkleblock` message after
you understand how to parse an already-created message, so we recommend
you read the parsing section above first.

Create a complete merkle tree with TXIDs on the bottom row and all the
other hashes calculated up to the merkle root on the top row. For each
transaction that matches the filter, track its TXID node and all of its
ancestor nodes.

![Example Of Creating A MerkleBlock Message](/img/dev/animated-en-merkleblock-creation.gif)

Start processing the tree with the merkle root node. The table below
describes how to process both TXID nodes and non-TXID nodes based on
whether the node is a match, a match ancestor, or neither a match nor a
match ancestor.

|                                      | TXID Node                                                              | Non-TXID Node
|--------------------------------------|------------------------------------------------------------------------|----
| **Neither Match Nor Match Ancestor** | Append a 0 to the flag list; append this node's TXID to the hash list. | Append a 0 to the flag list; append this node's hash to the hash list.  Do not descend into its child nodes.
| **Match Or Match Ancestor**          | Append a 1 to the flag list; append this node's TXID to the hash list. | Append a 1 to the flag list; process the left child node.  Then, if the node has a right child, process the right child.  Do not append a hash to the hash list for this node.

Any time you begin processing a node for the first time, a flag should be
appended to the flag list. Never put a flag on the list at any other
time, except when processing is complete to pad out the flag list to a
byte boundary.

When processing a child node, you may need to process its children (the
grandchildren of the original node) or further-descended nodes before
returning to the parent node. This is expected---keep processing depth
first until you reach a TXID node or a node which is neither a TXID nor
a match ancestor.

After you process a TXID node or a node which is neither a TXID nor a
match ancestor, stop processing and begin to ascend the tree until you
find a node with a right child you haven't processed yet. Descend into
that right child and process it.

After you fully process the merkle root node according to the
instructions in the table above, processing is complete.  Pad your flag
list to a byte boundary and construct the `merkleblock` message using the
template near the beginning of this subsection.

{% endautocrossref %}

#### NotFound
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70001.*

The `notfound` message is a reply to a `getdata` message which
requested an object the receiving node does not have available for
relay. (Nodes are not expected to relay historic transactions which
are no longer in the memory pool or relay set. Nodes may also have
pruned spent transactions from older blocks, making them unable to
send those blocks.)

The format and maximum size limitations of the `notfound` message are
identical to the `inv` message; only the message header differs.

{% endautocrossref %}

#### Tx
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `tx` message transmits a single transaction in the raw transaction
format. It can be sent in a variety of situations;

* **Transaction Response:** Dash Core will send it in response to a
  `getdata` message that requests the transaction with an inventory
  type of `MSG_TX`.

* **MerkleBlock Response:** Dash Core will send it in response to a
  `getdata` message that requests a merkle block with an inventory type
  of `MSG_MERKLEBLOCK`. (This is in addition to sending a `merkleblock`
  message.) Each `tx` message in this case provides a matched
  transaction from that block.

<!-- Is there any reason to leave this here?
* **Unsolicited:** BitcoinJ will send a `tx` message unsolicited for
  transactions it originates.
-->
For an example hexdump of the raw transaction format, see the [raw
transaction section][raw transaction format].

{% endautocrossref %}





### Control Messages
{% include helpers/subhead-links.md %}

{% autocrossref %}

The following network messages all help control the connection between
two peers or allow them to advise each other about the rest of the
network.

![Overview Of P2P Protocol Control And Advisory Messages](/img/dev/en-p2p-control-messages.svg)

Note that almost none of the control messages are authenticated in any
way, meaning they can contain incorrect or intentionally harmful
information. In addition, this section does not yet cover P2P protocol
operation over the [Tor network][tor]; if you would like to contribute
information about Tor, please [open an issue][docs issue].

{% endautocrossref %}

#### Addr
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `addr` (IP address) message relays connection information
for peers on the network. Each peer which wants to accept incoming
connections creates an `addr` message providing its connection
information and then sends that message to its peers unsolicited. Some
of its peers send that information to their peers (also unsolicited),
some of which further distribute it, allowing decentralized peer
discovery for any program already on the network.

An `addr` message may also be sent in response to a `getaddr` message.

| Bytes      | Name             | Data Type          | Description
|------------|------------------|--------------------|----------------
| *Varies*   | IP address count | compactSize uint   | The number of IP address entries up to a maximum of 1,000.
| *Varies*   | IP addresses     | network IP address | IP address entries.  See the table below for the format of a Dash network IP address.

Each encapsulated network IP address currently uses the following structure:

| Bytes | Name       | Data Type | Description
|-------|------------|-----------|---------------
| 4     | time       | uint32    | *Added in protocol version 31402.* <br><br>A time in Unix epoch time format.  Nodes advertising their own IP address set this to the current time.  Nodes advertising IP addresses they've connected to set this to the last time they connected to that node.  Other nodes just relaying the IP address should not change the time.  Nodes can use the time field to avoid relaying old `addr` messages.  <br><br>Malicious nodes may change times or even set them in the future.
| 8     | services   | uint64_t  | The services the node advertised in its `version` message.
| 16    | IP address | char      | IPv6 address in **big endian byte order**. IPv4 addresses can be provided as [IPv4-mapped IPv6 addresses][]
| 2     | port       | uint16_t  | Port number in **big endian byte order**.  Note that Dash Core will only connect to nodes with non-standard port numbers as a last resort for finding peers.  This is to prevent anyone from trying to use the network to disrupt non-Dash services that run on other ports.

The following annotated hexdump shows part of an `addr` message. (The
message header has been omitted and the actual IP address has been
replaced with a [RFC5737][] reserved IP address.)

{% highlight text %}
fde803 ............................. Address count: 1000

d91f4854 ........................... Epoch time: 1414012889
0100000000000000 ................... Service bits: 01 (network node)
00000000000000000000ffffc0000233 ... IP Address: ::ffff:192.0.2.51
208d ............................... Port: 8333

[...] .............................. (999 more addresses omitted)
{% endhighlight %}

{% endautocrossref %}


#### Alert
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 311.*
*Removed by Bitcoin in protocol version 70013, but retained by Dash.*

The `alert` message warns nodes of problems that may affect them or the
rest of the network. Each `alert` message is signed using a key controlled
by respected community members, mostly Dash Core developers.

To ensure all nodes can validate and forward `alert` messages,
encapsulation is used. Developers create an alert using the data
structure appropriate for the versions of the software they want to
notify; then they serialize that data and sign it. The serialized data
and its signature make up the outer `alert` message---allowing nodes
which don't understand the data structure to validate the signature and
relay the alert to nodes which do understand it. The nodes which
actually need the message can decode the serialized data to access the
inner `alert` message.

The outer `alert` message has four fields:

| Bytes       | Name            | Data Type        | Description
|-------------|-----------------|------------------|-------------
| *Variable*  | alert bytes     | compactSize uint | The number of bytes in following alert field.
| *Variable*  | alert           | uchar            | The serialized alert.  See below for a description of the current alert format.
| *Variable*  | signature bytes | compactSize uint | The number of bytes in the following signature field.
| *Variable*  | signature       | uchar            | A DER-encoded ECDSA (secp256k1) signature of the alert signed with the developer's alert key.

Although designed to be easily upgraded, the format of the inner
serialized alert has not changed since the `alert` message was first
introduced in protocol version 311.

| Bytes    | Name              | Data Type                 | Description
|----------|-------------------|---------------------------|-------------
| 4        | version           | int32_t                   | Alert format version.  Version 1 from protocol version 311 through at least protocol version 70002.
| 8        | relayUntil        | int64_t                   | The time beyond which nodes should stop relaying this alert.  Unix epoch time format.
| 8        | expiration        | int64_t                   | The time beyond which this alert is no longer in effect and should be ignored.  Unix epoch time format.
| 4        | ID                | int32_t                   | A unique ID number for this alert.
| 4        | cancel            | int32_t                   | All alerts with an ID number less than or equal to this number should be canceled: deleted and not accepted in the future.
| *Varies* | setCancel count   | compactSize uint          | The number of IDs in the following setCancel field.  May be zero.
| *Varies* | setCancel         | int32_t                   | Alert IDs which should be canceled.  Each alert ID is a separate int32_t number.
| 4        | minVer            | int32_t                   | This alert only applies to protocol versions greater than or equal to this version. Nodes running other protocol versions should still relay it.
| 4        | maxVer            | int32_t                   | This alert only applies to protocol versions less than or equal to this version. Nodes running other protocol versions should still relay it.
| *Varies* | user\_agent count | compactSize uint          | The number of user agent strings in the following setUser\_agent field.  May be zero.
| *Varies* | setUser\_agent    | compactSize uint + string | If this field is empty, it has no effect on the alert.  If there is at least one entry is this field, this alert only applies to programs with a user agent that exactly matches one of the strings in this field.  Each entry in this field is a compactSize uint followed by a string---the uint indicates how many bytes are in the following string.  This field was originally called setSubVer; since BIP14, it applies to user agent strings as defined in the `version` message.
| 4        | priority          | int32_t                   | Relative priority compared to other alerts.
| *Varies* | comment bytes     | compactSize uint          | The number of bytes in the following comment field.  May be zero.
| *Varies* | comment           | string                    | A comment on the alert that is not displayed.
| *Varies* | statusBar bytes   | compactSize uint          | The number of bytes in the following statusBar field.  May be zero.
| *Varies* | statusBar         | string                    | The alert message that is displayed to the user.
| *Varies* | reserved bytes    | compactSize uint          | The number of bytes in the following reserved field.  May be zero.
| *Varies* | reserved          | string                    | Reserved for future use.  Originally called RPC Error.  

The annotated hexdump below shows an `alert` message. (The message
header has been omitted.)

<!-- example below from Bitcoin Wiki but it's a network capture so I
(@harding) don't think it is subject to the wiki's copyright license; I
think it's public domain. TODO: replace with a more recent
alert the next time one is live on the network. -->

{% highlight text %}
73 ................................. Bytes in encapsulated alert: 115
01000000 ........................... Version: 1
3766404f00000000 ................... RelayUntil: 1329620535
b305434f00000000 ................... Expiration: 1330917376

f2030000 ........................... ID: 1010
f1030000 ........................... Cancel: 1009
00 ................................. setCancel count: 0

10270000 ........................... MinVer: 10000
48ee0000 ........................... MaxVer: 61000
00 ................................. setUser_agent bytes: 0
64000000 ........................... Priority: 100

00 ................................. Bytes In Comment String: 0
46 ................................. Bytes in StatusBar String: 70
53656520626974636f696e2e6f72672f
666562323020696620796f7520686176
652074726f75626c6520636f6e6e6563
74696e67206166746572203230204665
627275617279 ....................... Status Bar String: "See [...]"
00 ................................. Bytes In Reserved String: 0

47 ................................. Bytes in signature: 71
30450221008389df45f0703f39ec8c1c
c42c13810ffcae14995bb648340219e3
53b63b53eb022009ec65e1c1aaeec1fd
334c6b684bde2b3f573060d5b70c3a46
723326e4e8a4f1 ..................... Signature
{% endhighlight %}

**Alert key compromise:** Dash Core's source code defines a
particular set of alert parameters that can be used to notify users that
the alert signing key has been compromised and that they should upgrade
to get a new alert public key. Once a signed alert containing those
parameters has been received, no other alerts can cancel or override it.
See the `ProcessAlert()` function in the Dash Core [alert.cpp][core
alert.cpp] source code for the parameters of this message.

{% endautocrossref %}


#### FilterAdd
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70001 as described by BIP37.*

The `filteradd` message tells the receiving peer to add a single element to
a previously-set bloom filter, such as a new public key. The element is
sent directly to the receiving peer; the peer then uses the parameters set
in the `filterload` message to add the element to the bloom filter.

Because the element is sent directly to the receiving peer, there is no
obfuscation of the element and none of the plausible-deniability privacy
provided by the bloom filter. Clients that want to maintain greater
privacy should recalculate the bloom filter themselves and send a new
`filterload` message with the recalculated bloom filter.

| Bytes    | Name          | Data Type        | Description
|----------|---------------|------------------|-----------------
| *Varies* | element bytes | compactSize uint | The number of bytes in the following element field.
| *Varies* | element       | uint8_t[]        | The element to add to the current filter.  Maximum of 520 bytes, which is the maximum size of an element which can be pushed onto the stack in a pubkey or signature script.  Elements must be sent in the byte order they would use when appearing in a raw transaction; for example, hashes should be sent in internal byte order.

Note: a `filteradd` message will not be accepted unless a filter was
previously set with the `filterload` message.

The annotated hexdump below shows a `filteradd` message adding a TXID.
(The message header has been omitted.) This TXID appears in the same
block used for the example hexdump in the `merkleblock` message; if that
`merkleblock` message is re-sent after sending this `filteradd` message,
six hashes are returned instead of four.

{% highlight text %}
20 ................................. Element bytes: 32
fdacf9b3eb077412e7a968d2e4f11b9a
9dee312d666187ed77ee7d26af16cb0b ... Element (A TXID)
{% endhighlight %}

{% endautocrossref %}

#### FilterClear
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70001 as described by BIP37.*

The `filterclear` message tells the receiving peer to remove a
previously-set bloom filter.  This also undoes the effect of setting the
relay field in the `version` message to 0, allowing unfiltered access to
`inv` messages announcing new transactions.

Dash Core does not require a `filterclear` message before a
replacement filter is loaded with `filterload`.  It also doesn't require
a `filterload` message before a `filterclear` message.

There is no payload in a `filterclear` message.  See the [message header
section][section message header] for an example of a message without a payload.

{% endautocrossref %}


#### FilterLoad
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70001 as described by BIP37.*

The `filterload` message tells the receiving peer to filter all relayed
transactions and requested merkle blocks through the provided filter.
This allows clients to receive transactions relevant to their wallet
plus a configurable rate of false positive transactions which can
provide plausible-deniability privacy.

| Bytes    | Name         | Data Type | Description
|----------|--------------|-----------|---------------
| *Varies* | nFilterBytes | compactSize uint | Number of bytes in the following filter bit field.
| *Varies* | filter       | uint8_t[] | A bit field of arbitrary byte-aligned size. The maximum size is 36,000 bytes.
| 4        | nHashFuncs   | uint32_t  | The number of hash functions to use in this filter. The maximum value allowed in this field is 50.
| 4        | nTweak       | uint32_t  | An arbitrary value to add to the seed value in the hash function used by the bloom filter.
| 1        | nFlags       | uint8_t   | A set of flags that control how outpoints corresponding to a matched pubkey script are added to the filter. See the table in the Updating A Bloom Filter subsection below.

The annotated hexdump below shows a `filterload` message. (The message
header has been omitted.)  For an example of how this payload was
created, see the [filterload example][section creating a bloom filter].

{% highlight text %}
02 ......... Filter bytes: 2
b50f ....... Filter: 1010 1101 1111 0000
0b000000 ... nHashFuncs: 11
00000000 ... nTweak: 0/none
00 ......... nFlags: BLOOM_UPDATE_NONE
{% endhighlight %}

**Initializing A Bloom Filter**

Filters have two core parameters: the size of the bit field and the
number of hash functions to run against each data element. The following
formulas from BIP37 will allow you to automatically select appropriate
values based on the number of elements you plan to insert into the
filter (*n*) and the false positive rate (*p*) you desire to maintain
plausible deniability.

* Size of the bit field in bytes (*nFilterBytes*), up to a maximum of
  36,000: `(-1 / log(2)**2 * n * log(p)) / 8`

* Hash functions to use (*nHashFuncs*), up to a maximum of 50:
  `nFilterBytes * 8 / n * log(2)`

Note that the filter matches parts of transactions (transaction
elements), so the false positive rate is relative to the number of
elements checked---not the number of transactions checked. Each normal
transaction has a minimum of four matchable elements (described in the
comparison subsection below), so a filter with a false-positive rate of
1 percent will match about 4 percent of all transactions at a minimum.

According to BIP37, the formulas and limits described above provide
support for bloom filters containing 20,000 items with a false positive
rate of less than 0.1 percent or 10,000 items with a false positive rate
of less than 0.0001 percent.

Once the size of the bit field is known, the bit field should be
initialized as all zeroes.

**Populating A Bloom Filter**

The bloom filter is populated using between 1 and 50 unique hash
functions (the number specified per filter by the *nHashFuncs*
field). Instead of using up to 50 different hash function
implementations, a single implementation is used with a unique seed
value for each function.

The seed is `nHashNum * 0xfba4c795 + nTweak` as a *uint32\_t*, where the values
are:

* **nHashNum** is the sequence number<!--noref--> for this hash
  function, starting at 0 for the first hash iteration and increasing up
  to the value of the *nHashFuncs* field (minus one) for the last hash
  iteration.

* **0xfba4c795** is a constant optimized to create large differences in
  the seed for different values of *nHashNum*.

* **nTweak** is a per-filter constant set by the client to require the use
  of an arbitrary set of hash functions.

If the seed resulting from the formula above is larger than four bytes,
it must be truncated to its four most significant bytes (for example,
`0x8967452301 & 0xffffffff → 0x67452301`).

The actual hash function implementation used is the [32-bit Murmur3 hash
function][murmur3].

![Warning icon](/img/icons/icon_warning.svg)
**Warning:** the Murmur3 hash function has separate 32-bit and 64-bit
versions that produce different results for the same input.  Only the
32-bit Murmur3 version is used with Dash bloom filters.

The data to be hashed can be any transaction element which the bloom
filter can match. See the next subsection for the list of transaction
elements checked against the filter. The largest element which can be
matched is a script data push of 520 bytes, so the data should never
exceed 520 bytes.

The example below from Dash Core [bloom.cpp][core bloom.cpp hash] combines
all the steps above to create the hash function template. The seed is
the first parameter; the data to be hashed is the second parameter. The
result is a uint32\_t modulo the size of the bit field in bits.

{% highlight c++ %}
MurmurHash3(nHashNum * 0xFBA4C795 + nTweak, vDataToHash) % (vData.size() * 8)
{% endhighlight %}

Each data element to be added to the filter is hashed by *nHashFuncs*
number of hash functions. Each time a hash function is run, the result
will be the index number (*nIndex*) of a bit in the bit field. That bit
must be set to 1. For example if the filter bit field was `00000000` and
the result is 5, the revised filter bit field is `00000100` (the first bit
is bit 0).

It is expected that sometimes the same index number will be returned
more than once when populating the bit field; this does not affect the
algorithm---after a bit is set to 1, it is never changed back to 0.

After all data elements have been added to the filter, each set of eight
bits is converted into a little-endian byte. These bytes are the value
of the *filter* field.

**Comparing Transaction Elements To A Bloom Filter**

To compare an arbitrary data element against the bloom filter, it is
hashed using the same parameters used to create the bloom filter.
Specifically, it is hashed *nHashFuncs* times, each time using the same
*nTweak* provided in the filter, and the resulting output is modulo the
size of the bit field provided in the *filter* field.  After each hash is
performed, the filter is checked to see if the bit at that indexed
location is set.  For example if the result of a hash is `5` and the
filter is `01001110`, the bit is considered set.

If the result of every hash points to a set bit, the filter matches. If
any of the results points to an unset bit, the filter does not match.

The following transaction elements are compared against bloom filters.
All elements will be hashed in the byte order used in blocks (for
example, TXIDs will be in internal byte order).

* **TXIDs:** the transaction's SHA256(SHA256()) hash.

* **Outpoints:** each 36-byte outpoint used this transaction's input
  section is individually compared to the filter.

* **Signature Script Data:** each element pushed onto the stack by a
  data-pushing opcode in a signature script from this transaction is
  individually compared to the filter.  This includes data elements
  present in P2SH redeem scripts when they are being spent.

* **PubKey Script Data:** each element pushed onto the the stack by a
  data-pushing opcode in any pubkey script from this transaction is
  individually compared to the filter. (If a pubkey script element
  matches the filter, the filter will be immediately updated if the
  `BLOOM_UPDATE_ALL` flag was set; if the pubkey script is in the P2PKH
  format and matches the filter, the filter will be immediately updated
  if the `BLOOM_UPDATE_P2PUBKEY_ONLY` flag was set. See the subsection
  below for details.)

The following annotated hexdump of a transaction is from the [raw
transaction format section][raw transaction format]; the elements which
would be checked by the filter are emphasized in bold. Note that this
transaction's TXID (**`01000000017b1eab[...]`**) would also be checked,
and that the outpoint TXID and index number below would be checked as a
single 36-byte element.

<pre><code>01000000 ................................... Version

01 ......................................... Number of inputs
|
| <b>7b1eabe0209b1fe794124575ef807057</b>
| <b>c77ada2138ae4fa8d6c4de0398a14f3f</b> ......... Outpoint TXID
| <b>00000000</b> ................................. Outpoint index number
|
| 49 ....................................... Bytes in sig. script: 73
| | 48 ..................................... Push 72 bytes as data
| | | <b>30450221008949f0cb400094ad2b5eb3</b>
| | | <b>99d59d01c14d73d8fe6e96df1a7150de</b>
| | | <b>b388ab8935022079656090d7f6bac4c9</b>
| | | <b>a94e0aad311a4268e082a725f8aeae05</b>
| | | <b>73fb12ff866a5f01</b> ..................... Secp256k1 signature
|
| ffffffff ................................. Sequence number: UINT32_MAX

01 ......................................... Number of outputs
| f0ca052a01000000 ......................... Satoshis (49.99990000 BTC)
|
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | <b>cbc20a7664f2f69e5355aa427045bc15</b>
| | | <b>e7c6c772</b> ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG

00000000 ................................... locktime: 0 (a block height)
</code></pre>

**Updating A Bloom Filter**

Clients will often want to track inputs that spend outputs (outpoints)
relevant to their wallet, so the filterload field *nFlags* can be set to
allow the filtering node to update the filter when a match is found.
When the filtering node sees a pubkey script that pays a pubkey,
address, or other data element matching the filter, the filtering node
immediately updates the filter with the outpoint corresponding to that
pubkey script.

![Automatically Updating Bloom Filters](/img/dev/en-bloom-update.svg)

If an input later spends that outpoint, the filter will match it,
allowing the filtering node to tell the client that one of its
transaction outputs has been spent.

The *nFlags* field has three allowed values:

| Value | Name                       | Description
|-------|----------------------------|---------------
| 0     | BLOOM_UPDATE_NONE          | The filtering node should not update the filter.
| 1     | BLOOM_UPDATE_ALL           | If the filter matches any data element in a pubkey script, the corresponding outpoint is added to the filter.
| 2     | BLOOM_UPDATE_P2PUBKEY_ONLY | If the filter matches any data element in a pubkey script and that script is either a P2PKH or non-P2SH pay-to-multisig script, the corresponding outpoint is added to the filter.

In addition, because the filter size stays the same even though
additional elements are being added to it, the false positive rate
increases. Each false positive can result in another element being added
to the filter, creating a feedback loop that can (after a certain point)
make the filter useless. For this reason, clients using automatic filter
updates need to monitor the actual false positive rate and send a new
filter when the rate gets too high.

{% endautocrossref %}

#### GetAddr
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `getaddr` message requests an `addr` message from the receiving
node, preferably one with lots of IP addresses of other receiving nodes.
The transmitting node can use those IP addresses to quickly update its
database of available nodes rather than waiting for unsolicited `addr`
messages to arrive over time.

There is no payload in a `getaddr` message.  See the [message header
section][section message header] for an example of a message without a payload.

{% endautocrossref %}


#### GetSporks
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `getsporks` message requests `spork` messages from the receiving node.

There is no payload in a `getsporks` message.  See the [message header
section][section message header] for an example of a message without a payload.

{% endautocrossref %}


#### Ping
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `ping` message helps confirm that the receiving peer is still
connected. If a TCP/IP error is encountered when sending the `ping`
message (such as a connection timeout), the transmitting node can assume
that the receiving node is disconnected. The response to a `ping`
message is the `pong` message.

Before protocol version 60000, the `ping` message had no payload. As of
protocol version 60001 and all later versions, the message includes a
single field, the nonce.

| Bytes | Name  | Data Type | Description
|-------|-------|-----------|---------------
| 8     | nonce | uint64_t  | *Added in protocol version 60001 as described by BIP31.* <br><br>Random nonce assigned to this `ping` message.  The responding `pong` message will include this nonce to identify the `ping` message to which it is replying.

The annotated hexdump below shows a `ping` message. (The message
header has been omitted.)

{% highlight text %}
0094102111e2af4d ... Nonce
{% endhighlight %}

{% endautocrossref %}

#### Pong
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 60001 as described by BIP31.*

The `pong` message replies to a `ping` message, proving to the pinging
node that the ponging node is still alive. Dash Core will, by
default, disconnect from any clients which have not responded to a
`ping` message within 20 minutes.

To allow nodes to keep track of latency, the `pong` message sends back
the same nonce received in the `ping` message it is replying to.

The format of the `pong` message is identical to the `ping` message;
only the message header differs.

{% endautocrossref %}

#### Reject
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70002 as described by BIP61.*

The `reject` message informs the receiving node that one of its previous
messages has been rejected.

| Bytes    | Name          | Data Type        | Description
|----------|---------------|------------------|--------------
| *Varies* | message bytes | compactSize uint | The number of bytes in the following message field.
| *Varies* | message       | string           | The type of message rejected as ASCII text *without null padding*.  For example: "tx", "block", or "version".
| 1        | code          | char             | The reject message code.  See the table below.
| *Varies* | reason bytes  | compactSize uint | The number of bytes in the following reason field.  May be 0x00 if a text reason isn't provided.
| *Varies* | reason        | string           | The reason for the rejection in ASCII text.  This should not be displayed to the user; it is only for debugging purposes.
| *Varies* | extra data    | *varies*         | Optional additional data provided with the rejection.  For example, most rejections of `tx` messages or `block` messages include the hash of the rejected transaction or block header.  See the code table below.

The following table lists message reject codes.  Codes are tied to the
type of message they reply to; for example there is a 0x10 reject code
for transactions and a 0x10 reject code for blocks.

<!-- several descriptions below copied verbatim from BIP61; sort order:
ascending code number (primary) and alphabetic in reply to (secondary) -->

| Code | In Reply To       | Extra Bytes | Extra Type | Description
|------|-------------------|-------------|------------|----------------
| 0x01 | *any message*     | 0           | N/A        | Message could not be decoded.  Be careful of `reject` message feedback loops where two peers each don't understand each other's `reject` messages and so keep sending them back and forth forever.
| 0x10 | `block` message   | 32          | char[32]   | Block is invalid for some reason (invalid proof-of-work, invalid signature, etc).  Extra data may include the rejected block's header hash.
| 0x10 | `tx` message      | 32          | char[32]   | Transaction is invalid for some reason (invalid signature, output value greater than input, etc.).  Extra data may include the rejected transaction's TXID.
| 0x10 | `ix` message      | 32          | char[32]   | InstantSend transaction is invalid for some reason (invalid tx lock request, conflicting tx lock request, etc.).  Extra data may include the rejected transaction's TXID.
| 0x11 | `block` message   | 32          | char[32]   | The block uses a version that is no longer supported.  Extra data may include the rejected block's header hash.
| 0x11 | `version` message | 0           | N/A        | Connecting node is using a protocol version that the rejecting node considers obsolete and unsupported.
| 0x12 | `tx` message      | 32          | char[32]   | Duplicate input spend (double spend): the rejected transaction spends the same input as a previously-received transaction.  Extra data may include the rejected transaction's TXID.
| 0x12 | `version` message | 0           | N/A        | More than one `version` message received in this connection.
| 0x40 | `tx` message      | 32          | char[32]   | The transaction will not be mined or relayed because the rejecting node considers it non-standard---a transaction type or version unknown by the server.  Extra data may include the rejected transaction's TXID.
| 0x41 | `tx` message      | 32          | char[32]   | One or more output amounts are below the dust threshold.  Extra data may include the rejected transaction's TXID.
| 0x42 | `tx` message      |             | char[32]   | The transaction did not have a large enough fee or priority to be relayed or mined.  Extra data may include the rejected transaction's TXID.
| 0x43 | `block` message   | 32          | char[32]   | The block belongs to a block chain which is not the same block chain as provided by a compiled-in checkpoint.  Extra data may include the rejected block's header hash.

Reject Codes

| Code | Description
|------|--------------
| 0x01 | Malformed
| 0x10 | Invalid
| 0x11 | Obsolete
| 0x12 | Duplicate
| 0x40 | Non-standard
| 0x41 | Dust
| 0x42 | Insufficient fee
| 0x43 | Checkpoint

The annotated hexdump below shows a `reject` message. (The message
header has been omitted.)

{% highlight text %}
02 ................................. Number of bytes in message: 2
7478 ............................... Type of message rejected: tx
12 ................................. Reject code: 0x12 (duplicate)
15 ................................. Number of bytes in reason: 21
6261642d74786e732d696e707574732d
7370656e74 ......................... Reason: bad-txns-inputs-spent
394715fcab51093be7bfca5a31005972
947baf86a31017939575fb2354222821 ... TXID
{% endhighlight %}

{% endautocrossref %}

#### SendHeaders
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `sendheaders` message tells the receiving peer to send new block
announcements using a `headers` message rather than an `inv` message.

There is no payload in a `sendheaders` message.  See the [message header
section][section message header] for an example of a message without a payload.

{% endautocrossref %}


#### Spork
{% include helpers/subhead-links.md %}

{% autocrossref %}
Sporks are a mechanism by which updated code is released to the network, but
not immediately made active (or “enforced”). Enforcement of the updated code
can be activated remotely. Should problems arise, the code can be deactivated
in the same manner, without the need for a network-wide rollback or client update.

A `spork` message may be sent in response to a `getsporks` message.

The `spork` message tells the receiving peer the status of the spork defined by
the SporkID field. Upon receiving a spork message, the client must verify the
signature before accepting the spork message as valid.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 4 | nSporkID | int | Required | ID assigned in spork.h
| 8 | nValue | int64_t | Required | Value assigned to spork
| 8 | nTimeSigned | int64_t | Required | Time the spork value was signed
| 66 | vchSig | char[] | Required | Length (1 byte) + Signature (65 bytes)

Defined Sporks (per [`src/spork.h`][spork.h])

| Spork ID | Number | Name | Description |
| ---------- | ---------- | ----------- | ----------- |
| 10001 | 2 | `INSTANTSEND_ENABLED` | Turns on and off InstantSend network wide
| 10002 | 3 | `INSTANTSEND_BLOCK_FILTERING` | Turns on and off InstantSend block filtering
| 10004 | 5 | `INSTANTSEND_MAX_VALUE` | Controls the max value for an InstantSend transaction (currently 2000 dash)
| 10007 | 8 | `MASTERNODE_PAYMENT_ENFORCEMENT` | Requires masternodes to be paid by miners when blocks are processed
| 10008 | 9 | `SUPERBLOCKS_ENABLED` | Superblocks are enabled (the 10% comes to fund the dash treasury)
| 10009 | 10 | `MASTERNODE_PAY_UPDATED_NODES` | Only current protocol version masternode's will be paid (not older nodes)
| 10011 | 12 | `RECONSIDER_BLOCKS` |
| 10012 | 13 | `OLD_SUPERBLOCK_FLAG` |
| 10013 | 14 | `REQUIRE_SENTINEL_FLAG` | Only masternode's running sentinel will be paid

To verify `vchSig`, compare the hard-coded spork public key (`strSporkPubKey`
from [`src/chainparams.cpp`][spork pubkey]) with the public key recovered from
the `spork` message's hash and `vchSig` value (implementation details for Dash
Core can be found in `CPubKey::RecoverCompact`). The hash is a double SHA-256 hash of:

* The spork magic message (`"DarkCoin Signed Message:\n"`)
* nSporkID + nValue + nTimeSigned

| Network | Spork Pubkey (wrapped) |
| ---------- | ---------- |
| Mainnet | 04549ac134f694c0243f503e8c8a9a986f5de6610049c40b07816809b0d1<br>d06a21b07be27b9bb555931773f62ba6cf35a25fd52f694d4e1106ccd237<br>a7bb899fdd |
| Testnet3 | 046f78dcf911fbd61910136f7f0f8d90578f68d0b3ac973b5040fb7afb50<br>1b5939f39b108b0569dca71488f5bbf498d92e4d1194f6f941307ffd95f7<br>5e76869f0e |
| RegTest | Undefined |

The following annotated hexdump shows a `spork` message.

{% highlight text %}
11270000 .................................... Spork ID: Spork 2 InstantSend enabled (10001)
0000000000000000 ............................ Value (0)
2478da5900000000 ............................ Epoch time: 2017-10-08 19:10:28 UTC (1507489828)

41 .......................................... Signature length: 65

1b6762d3e70890b5cfaed5d1fd72121c
d32020c827a89f8128a00acd210f4ea4
1b36c26c3767f8a24f48663e189865ed
403ed1e850cdb4207cdd466419d9d183
45 .......................................... Masternode Signature
{% endhighlight %}

{% endautocrossref %}

#### VerAck
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `verack` message acknowledges a previously-received `version`
message, informing the connecting node that it can begin to send
other messages. The `verack` message has no payload; for an example
of a message with no payload, see the [message headers
section][section message header].

{% endautocrossref %}

#### Version
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `version` message provides information about the transmitting node
to the receiving node at the beginning of a connection. Until both peers
have exchanged `version` messages, no other messages will be accepted.

If a `version` message is accepted, the receiving node should send a
`verack` message---but no node should send a `verack` message
before initializing its half of the connection by first sending a
`version` message.

| Bytes    | Name                  | Data Type        | Required/Optional                        | Description
|----------|-----------------------|------------------|------------------------------------------|-------------
| 4        | version               | int32_t          | Required                                 | The highest protocol version understood by the transmitting node.  See the [protocol version section][section protocol versions].
| 8        | services              | uint64_t         | Required                                 | The services supported by the transmitting node encoded as a bitfield.  See the list of service codes below.
| 8        | timestamp             | int64_t          | Required                                 | The current Unix epoch time according to the transmitting node's clock.  Because nodes will reject blocks with timestamps more than two hours in the future, this field can help other nodes to determine that their clock is wrong.
| 8        | addr_recv services    | uint64_t         | Required                                 | *Added in protocol version 106.* <br><br>The services supported by the receiving node as perceived by the transmitting node.  Same format as the 'services' field above. Dash Core will attempt to provide accurate information.
| 16       | addr_recv IP address  | char             | Required                                 | *Added in protocol version 106.* <br><br>The IPv6 address of the receiving node as perceived by the transmitting node in **big endian byte order**. IPv4 addresses can be provided as [IPv4-mapped IPv6 addresses][]. Dash Core will attempt to provide accurate information.
| 2        | addr_recv port        | uint16_t         | Required                                 | *Added in protocol version 106.* <br><br>The port number of the receiving node as perceived by the transmitting node in **big endian byte order**.
| 8        | addr_trans services   | uint64_t         | Required                                 | The services supported by the transmitting node.  Should be identical to the 'services' field above.
| 16       | addr_trans IP address | char             | Required                                 | The IPv6 address of the transmitting node in **big endian byte order**. IPv4 addresses can be provided as [IPv4-mapped IPv6 addresses][].  Set to ::ffff:127.0.0.1 if unknown.
| 2        | addr_trans port       | uint16_t         | Required                                 | The port number of the transmitting node in **big endian byte order**.
| 8        | nonce                 | uint64_t         | Required                                 | A random nonce which can help a node detect a connection to itself.  If the nonce is 0, the nonce field is ignored.  If the nonce is anything else, a node should terminate the connection on receipt<!--noref--> of a `version` message with a nonce it previously sent.
| *Varies* | user_agent bytes      | compactSize uint | Required                                 | Number of bytes in following user\_agent field.  If 0x00, no user agent field is sent.
| *Varies* | user_agent            | string           | Required if user_agent bytes > 0         | *Renamed in protocol version 60000.* <br><br>User agent as defined by BIP14. Previously called subVer.<br><br>Dash Core limits the length to 256 characters.
| 4        | start_height          | int32_t          | Required                                 | The height of the transmitting node's best block chain or, in the case of an SPV client, best block header chain.
| 1        | relay                 | bool             | Optional                                 | *Added in protocol version 70001 as described by BIP37.* <br><br>Transaction relay flag.  If 0x00, no `inv` messages or `tx` messages announcing new transactions should be sent to this client until it sends a `filterload` message or `filterclear` message.  If the relay field is not present or is set to 0x01, this node wants `inv` messages and `tx` messages announcing new transactions.


The following service identifiers have been assigned.

| Value | Name         | Description
|-------|--------------|---------------
| 0x00  | *Unnamed*    | This node is not a full node.  It may not be able to provide any data except for the transactions it originates.
| 0x01  | NODE_NETWORK | This is a full node and can be asked for full blocks.  It should implement all protocol features available in its self-reported protocol version.
| 0x02  | NODE_GETUTXO | This node is capable of responding to the getutxo protocol request. *Dash Core does not support this service.*
| 0x04  | NODE_BLOOM | This node is capable and willing to handle bloom-filtered connections.  Dash Core nodes used to support this by default, without advertising this bit, but no longer do as of protocol version 70201 (= NO_BLOOM_VERSION)

The following annotated hexdump shows a `version` message. (The
message header has been omitted and the actual IP addresses have been
replaced with [RFC5737][] reserved IP addresses.)

{% highlight text %}
3e120100 .................................... Protocol version: 70206
0500000000000000 ............................ Services: NODE_NETWORK (1) + NODE_BLOOM (4)
bc8f5e5400000000 ............................ Epoch time: 1415483324

0100000000000000 ............................ Receiving node's services
00000000000000000000ffffc61b6409 ............ Receiving node's IPv6 address
270f ........................................ Receiving node's port number

0500000000000000 ............................ Transmitting node's services
00000000000000000000ffffcb0071c0 ............ Transmitting node's IPv6 address
270f ........................................ Transmitting node's port number

128035cbc97953f8 ............................ Nonce

14 .......................................... Bytes in user agent string: 20
2f4461736820436f72653a302e31322e312e352f..... User agent: /Satoshi:0.9.2.1/

851f0b00 .................................... Start height: 728965
01 .......................................... Relay flag: true
{% endhighlight %}

{% endautocrossref %}



### InstantSend Messages
{% include helpers/subhead-links.md %}

{% autocrossref %}

The following network messages all help control the InstantSend feature of Dash.
InstantSend uses the masternode network to lock transaction inputs and enable
secure, instantaneous transactions.

{% endautocrossref %}

#### ix
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `ix` message (transaction lock request) has the same structure as the `tx` message.
The masternode network responds with `txlvote` messages if the transaction inputs
can be locked.

{% endautocrossref %}


#### txlvote
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `txlvote` message ([transaction lock vote][msg_txlock_vote]{:#term-msg_txlock_vote}{:.term})
is sent by masternodes to indicate approval of a transaction lock request
`ix` message.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 32 | txHash | uint256 | Required | TXID of the transaction to lock
| 36 | outPoint | outpoint | Required | The unspent outpoint to lock in this transaction
| 36 | outpointMasternode | outpoint | Required | The outpoint of the masternode which is signing the vote
| 66* | vchMasternodeSignature | char[] | Required | 66 bytes in most cases. Length (1 byte) + Signature (65 bytes)

The following annotated hexdump shows a `txlvote` message. (The
message header has been omitted.)

{% highlight text %}
3c121fb4a12b2f715e2f70a9fa282115
be197dde14073959fb2a2b8e95a7418f ..... TXID

Outpoint to lock
| bb607995757c6a6efd6429215dcb3688
| b252d34d835c81fed310fd905f487020 ... Outpoint TXID
| 01000000 ........................... Outpoint index number: 1

Masternode Outpoint
| de9029c7e9b7eb7cd11f27ba670b2349
| 0c3f0717b86ed949c316874589405cd2 ... Outpoint TXID
| 00000000 ........................... Outpoint index number: 0

41 ................................... Signature length: 65

1ccc39ffb9c62111a8c82823d3ce61d2
380db4e8f76ec238d568908f37558a90
4e79566a53663de12ec2be1183c87d61
250e8ebd57be171be1d4b5e89b69c263
88 ................................... Masternode Signature
{% endhighlight %}

{% endautocrossref %}


### PrivateSend Messages
{% include helpers/subhead-links.md %}

{% autocrossref %}

The following network messages all help control the PrivateSend (formerly
DarkSend) coin mixing features built in to Dash and facilitated by the
masternode network.

{% endautocrossref %}

#### dsa
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dsa` message allows a node to join a mixing pool. A collateral fee is
required and may be forfeited if the client acts maliciously.  The message
operates in two ways:

1. When sent to a masternode without a current mixing queue, it initiates the
  start of a new mixing queue

2. When sent to a masternode with a current mixing queue, it attempts to join the
  existing queue

Dash Core starts a new queue ~33% of the time and attempts to join an existing
queue the remainder of the time.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 4 | nDenom | int | Required | Denomination that will be exclusively used when submitting inputs into the pool
| 41+ | txCollateral | txIn | Required | Collateral TX that will be charged if this client acts maliciously

The following annotated hexdump shows a `dsa` message. (The message header has
been omitted.)

{% highlight text %}
02000000 ................................... Denomination: 1 Dash (2)

Collateral Transaction
| Previous Output
| |
| | 010000000183bd1980c71c38f035db9b
| | 14d7f934f7d595181b3436e362899026 ....... Outpoint TXID
| | 19f3f7d3 ............................... Outpoint index number: 3556242201
|
| 83 ....................................... Bytes in sig. script: 131
|
| 000000006b483045022100f4d8fa0ae4132235fe
| cd540a62715ccfb1c9a97f8698d066656e30bb1e
| 1e06b90220301b4cc93f38950a69396ed89dfcc0
| 8e72ec8e6e7169463592a0bf504946d98b812102
| fa4b9c0f9e76e06d57c75cab9c8368a62a1ce8db
| 6eb0c25c3e0719ddd9ab549cffffffff01e09304
| 00000000001976a914f895 ................... Secp256k1 signature: None
|
| 6a4eb0e5 ................................. Sequence number: 3853536874
{% endhighlight %}

{% endautocrossref %}


#### dsc
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dsc` message indicates a PrivateSend mixing session is complete.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 4 | nSessionID | int | Required | ID of the mixing session
| 4 | nMessageID | int | Required | Collateral TX that will be charged if this client acts maliciously

Message IDs

| Code | Description
|------|--------------
| 0x00 | ERR_ALREADY_HAVE
| 0x01 | ERR_DENOM
| 0x02 | ERR_ENTRIES_FULL
| 0x03 | ERR_EXISTING_TX
| 0x04 | ERR_FEES
| 0x05 | ERR_INVALID_COLLATERAL
| 0x06 | ERR_INVALID_INPUT
| 0x07 | ERR_INVALID_SCRIPT
| 0x08 | ERR_INVALID_TX
| 0x09 | ERR_MAXIMUM
| 0x0A | ERR_MN_LIST
| 0x0B | ERR_MODE
| 0x0C | ERR_NON_STANDARD_PUBKEY
| 0x0D | ERR_NOT_A_MN (Not used)
| 0x0E | ERR_QUEUE_FULL
| 0x0F | ERR_RECENT
| 0x10 | ERR_SESSION
| 0x11 | ERR_MISSING_TX
| 0x12 | ERR_VERSION
| 0x13 | MSG_NOERR
| 0x14 | MSG_SUCCESS
| 0x15 | MSG_ENTRIES_ADDED

The following annotated hexdump shows a `dsc` message. (The
message header has been omitted.)

{% highlight text %}
d9070700 ............................. Session ID: 460761
14000000 ............................. Message ID: MSG_SUCCESS (0x14)
{% endhighlight %}

{% endautocrossref %}


#### dsf
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dsf` message is sent as the final mixing transaction in a PrivateSend
mixing session.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 4 | nSessionID | int | Required | ID of the mixing session
| # | txFinal | `tx` message | Required | Collateral TX that will be charged if this client acts maliciously

The following annotated hexdump shows a `dsf` message. (The
message header has been omitted.)

{% highlight text %}
d9070700 ............................. Session ID: 460761

Transaction Message
| 01000000 ................................. Version: 1
|
| 11 ......................................... Number of inputs: 17
|
| Transaction input #1
| |
| | 312b2eef73770de0c75647b1fda96d85
| | fe83b06867abf11057a241a3cf8d2a84 ......... Outpoint TXID
| | 00000000 ................................. Outpoint index number: 0
| |
| | 00 ....................................... Bytes in sig. script: 0
| | .......................................... Secp256k1 signature: None
| |
| | ffffffff ................................. Sequence number: UINT32_MAX
|
| [...] ...................................... 16 more transaction inputs omitted
|
|
| 11 ......................................... Number of outputs: 17
|
| Transaction output #1
| | 4a420f0000000000 ......................... Duffs (0.01000010 Dash)
| |
| | 19 ....................................... Bytes in pubkey script: 25
| | | 76 ..................................... OP_DUP
| | | a9 ..................................... OP_HASH160
| | | 14 ..................................... Push 20 bytes as data
| | | | 0041cc11dac1386e0d8676fda6c5b122
| | | | 9d8c61e2 ............................. PubKey hash
| | | 88 ..................................... OP_EQUALVERIFY
| | | ac ..................................... OP_CHECKSIG
|
| [...] ...................................... 16 more transaction outputs omitted
|
|
| 00000000 ................................... locktime: 0 (a block height)
{% endhighlight %}

{% endautocrossref %}


#### dsi
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dsi` message indicates the queue is ready and the user is expected to send
the entry inputs to start mixing.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| ? | vecTxDSIn | CTxDSIn[] | Required | Vector of users inputs (CTxDSIn serialization is equal to CTxIn serialization)
| 8 | nAmount | int64_t | Required | Deprecated since 12.1. Used for backwards compatibility only and can be removed with future protocol bump
| ? | txCollateral | `tx` message | Required |Collateral transaction which is used to prevent misbehavior and also to charge fees randomly
| ? | vecTxDSOut | CTxDSOut[] | Required | Vector of user outputs (CTxDSOut serialization is equal to CTxOut serialization)

<!-- No examples have been observed in Wireshark -->

{% endautocrossref %}


#### dsq
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dsq` message provides nodes with mixing queue details and notifies them
when to sign final mixing TX messages.

If the message indicates the queue is not ready, the node verifies the message
is valid. It also verifies that the masternode is not flooding the network with
`dsq` messages in an attempt to dominate the queuing process. It then relays the
message to its connected peers.

If the message indicates the queue is ready, the node responds with a `dsi`
message.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 4 | nDenom | int | Required | Denomination allowed in this mixing session
| 41+ | vin | txIn | Required | Unspent output from masternode which is hosting this session
| 8 | nTime | int64_t | Required | Time this `dsq` message was created
| 1 | fReady | bool | Required | Indicates if the mixing pool is ready to be executed
| 66* | vchSig | char[] | Required | Signature of this message by masternode verifiable via pubKeyMasternode (Length (1 byte) + Signature (65 bytes))

Denominations (per [`src/privatesend.cpp`][privatesend denominations])

| Value | Denomination
|------|--------------
| 1 | 10 Dash
| 2 | 1 Dash
| 4 | 0.1 Dash
| 8 | 0.01 Dash

The following annotated hexdump shows a `dsq` message. (The
message header has been omitted.)

{% highlight text %}
08000000 ............................. Denomination: 0.01 Dash (8)

Masternode Outpoint
| aeed0e77c6db30a616507a37a129bc88
| 1811f08afc51dd485d5322f36c1f04c5 ... Outpoint TXID
| 01000000 ........................... Outpoint index number: 1

1318a85900000000 ..................... Create Time: 2017-08-31 14:07:15 UTC

00 ................................... Ready: 0

41 ................................... Signature length: 65

1bd74386ea4e111197f1b4b4660c1415
13486745ca10ba0632426ed3a644d941
047e43c988680904d4a4fcf551d8813c
ec12d47ae9b00e870db294cd66708ab7
dc ................................... Masternode Signature
{% endhighlight %}

{% endautocrossref %}


#### dss
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dss` message sends the user's signed inputs for a group transaction in a
mixing session.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| # | inputs | txIn[] | Required | Signed inputs for mixing session



{% endautocrossref %}


#### dssu
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dssu` message provides a mixing pool status update.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 4 | nMsgSessionID | int | Required | Session ID
| 4 | nMsgState | int | Required | Current state of mixing process
| 4 | nMsgEntriesCount | int | Required | Number of entries in the mixing pool
| 4 | nMsgStatusUpdate | int | Required | Update state and/or signal if entry was accepted or not
| 4 | nMsgMessageID | int | Required | ID of the typical masternode reply message

Pool State

| State | Description
|------|--------------
| 0 | POOL_STATE_IDLE
| 1 | POOL_STATE_QUEUE
| 2 | POOL_STATE_ACCEPTING_ENTRIES
| 3 | POOL_STATE_SIGNING
| 4 | POOL_STATE_ERROR
| 5 | POOL_STATE_SUCCESS

Pool Status Update

| Status | Description
|------|--------------
| 0 | STATUS_REJECTED
| 1 | STATUS_ACCEPTED

The following annotated hexdump shows a `dssu` message. (The
message header has been omitted.)

{% highlight text %}
e6ce0c00 ............................. Session ID
02000000 ............................. State: POOL_STATE_ACCEPTING_ENTRIES (2)
01000000 ............................. Entries: 1
01000000 ............................. Status Update: STATUS_ACCEPTED (1)
13000000 ............................. Message ID: MSG_NOERR (0x13)
{% endhighlight %}

{% endautocrossref %}


#### dstx
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dstx` message allows masternodes to broadcast subsidized transactions without
fees (to provide security in mixing).

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| # | tx | `tx` message | Required | The transaction
| 41 | vin | txIn | Required | Masternode unspent output
| 66* | vchSig | char[] | Required | Signature of this message by masternode verifiable via pubKeyMasternode (66 bytes in most cases. Length (1 byte) + Signature (65 bytes))
| 8 | sigTime | int64_t | Require | Time this message was signed


The following annotated hexdump shows a `dstx` message. (The
message header has been omitted.)

{% highlight text %}
Transaction Message
| 01000000 ................................. Version: 1
|
| 0b ......................................... Number of inputs: 11
|
| Transaction input #1
| |
| | 0adb782b2170018eada54534be880e70
| | 74ed8307a566731119b1782362af43ad ......... Outpoint TXID
| | 05000000 ................................. Outpoint index number: 5
| |
| | 6a ....................................... Bytes in sig. script: 106
| | 47304402204ed56f525ae6df707f9cbe
| | 55c78d82bbcc02daa1fb27b0bf54588a
| | 446dcc804102200c4e03c4a2b9a90aef
| | 9f01de7c28812a0e8b280e6c153b0bd8
| | 26d2ff660102e18121028c96903b2709
| | 7b331d55abd1f42d2ff6cc7c784ab839
| | 7c232b73a34a149a348e ..................... Secp256k1 signature
| |
| | ffffffff ................................. Sequence number: UINT32_MAX
|
| [...] ...................................... 10 more transaction inputs omitted
|
|
| 0b ......................................... Number of outputs: 11
|
| Transaction output #1
| | e8e4f50500000000 ......................... Duffs (1.00001000 Dash)
| |
| | 19 ....................................... Bytes in pubkey script: 25
| | | 76 ..................................... OP_DUP
| | | a9 ..................................... OP_HASH160
| | | 14 ..................................... Push 20 bytes as data
| | | | 0febbeaa8818b2c2f80fb8c98f90bdae
| | | | 41fe5c26 ............................. PubKey hash
| | | 88 ..................................... OP_EQUALVERIFY
| | | ac ..................................... OP_CHECKSIG
|
| [...] ...................................... 10 more transaction outputs omitted
|
|
| 00000000 ................................... locktime: 0 (a block height)

Masternode Unspent Output
| 387d522def2abfb9bdd15be899f074f3
| 49b414cef078ec642e1d14b42996b9fc ......... Outpoint TXID
| 00000000 ................................. Outpoint index number: 0
|
| 00 ....................................... Bytes in sig. script: 0
| .......................................... Secp256k1 signature (None)
|
| ffffffff ................................. Sequence number: UINT32_MAX

1b6fb8f90f0df6e502bc10aab9604e49
2d14214e05331c9761c834d55c7536e3
3369e5909479ea88116aad7ea64587d9
59364326c97d7f249f7b9293e120a5b6
1c ................................... Masternode Signature

ece5a95900000000 ..................... Signature Timestamp
{% endhighlight %}

{% endautocrossref %}


### Masternode Messages
{% include helpers/subhead-links.md %}

{% autocrossref %}

The following network messages enable the Masternode features built in to Dash.

{% endautocrossref %}

#### dseg
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `dseg` message requests either the entire masternode list or a specific
entry. To request the list of all masternodes, use an empty txIn (TXID of all
zeros and an index of 0xFFFFFFFF).  To request information about a specific
masternode, use the unspent output associated with that masternode.

The response to a `dseg` message is an `mnb` message inventory and an
`mnp` message inventory for each requested masternode. Masternodes ignore this
request if they are not fully synced.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 41 | vin | txIn | Required | Request options:<br>`All Entries` - empty txIn<br>`Single Entry` - Masternode's unspent output which is holding 1000 DASH


{% highlight text %}
Note: Dash Core only allows nodes to request the entire list every 3 hours.
Additional requests sent prior to then may result in the node being banned.
{% endhighlight %}

The following annotated hexdump shows a `dseg` message requesting **all**
masternodes. (The message header has been omitted.)

{% highlight text %}
Masternode Unspent Output
| 00000000000000000000000000000000
| 00000000000000000000000000000000 ......... Outpoint TXID
| ffffffff ................................. Outpoint index number: 0
|
| 00 ....................................... Bytes in sig. script: 0
| .......................................... Secp256k1 signature: None
|
| ffffffff ................................. Sequence number: UINT32_MAX
{% endhighlight %}

The following annotated hexdump shows a `dseg` message requesting a specific
masternode. (The message header has been omitted.)

{% highlight text %}
Masternode Unspent Output
| 7fe33a2901aa654598ae0af572d4fbec
| ee97af2d0276f189d177dee5848ef3da ......... Outpoint TXID
| 00000000 ................................. Outpoint index number: 0
|
| 00 ....................................... Bytes in sig. script: 0
| .......................................... Secp256k1 signature: None
|
| ffffffff ................................. Sequence number: UINT32_MAX
{% endhighlight %}

{% endautocrossref %}

#### mnb
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `mnb` message is sent whenever a masternode comes online or a client is
syncing.  The masternode will send this message which describes the masternode
entry and how to validate messages from it.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 41 | vin | txIn | Required | The unspent output which is holding 1000 DASH
| # | addr | CService | Required | IPv4 address of the masternode
| 33-65 | pubKeyCollateralAddress | CPubKey | Required | CPubKey of the main 1000 DASH unspent output. Length determined by if it is a compressed public key or not.
| 33-65 | pubKeyMasternode | CPubKey | Required | CPubKey of the secondary signing key (For all messaging other than the announce message). Length determined by if it is a compressed public key or not.
| 66 | sig | char[] | Required | Signature of this message verifiable via pubKeyMasternode (Length (1 byte) + Signature (65 bytes))
| 8 | sigTime | int64_t | Required | Time which the signature was created
| 4 | nProtocolVersion | int | Required | The protocol version of the masternode
| # | lastPing | `mnp` message | Required | The last known ping of the masternode
| 8 | nLastDsq | int64_t | Deprecated | The last time the masternode sent a `dsq` message (for mixing) (DEPRECATED)

The following annotated hexdump shows a `mnb` message. (The
message header has been omitted and the actual IP address has been replaced
with a RFC5737 reserved IP address.)

{% highlight text %}
Masternode Unspent Output
| 3fbc7d4a8f68ba6ecb02a8db34d1f5b6
| 2dc105f0b5c3505243435cf815d02394 ......... Outpoint TXID
| 01000000 ................................. Outpoint index number: 1
|
| 00 ....................................... Bytes in sig. script: 0
| .......................................... Secp256k1 signature: None
|
| ffffffff ................................. Sequence number: UINT32_MAX

Masternode Address
| 00000000000000000000ffffc0000233 ......... IP Address: ::ffff:192.0.2.51
| 270f ..................................... Port: 9999

Collateral Public Key
| 21 ....................................... Key Size: 33
| 02 ....................................... Key Type: 2 - Compressed (even)
| 02a47a6845936a4199e126d35399dd09
| 97c1aaf89a3fe70d474c53f29624a43a5b ....... Public Key

Masternode Public Key
| 41 ....................................... Key Size: 65
| 04 ....................................... Key Type: 4 - Uncompressed
| 04da252243305d604cab90480880af4a
| b5cea3a934c91393452e9b7b4c97a87e
| 198bc809916ac2c27436a1db9c28d0aa
| bfefec4dc3c2193835fd9a56c31150c633 ....... Public Key

Message Signature
| 41 ....................................... Bytes in signature: 65
| 1fb80f9ba8c110835e4a7dd4c8deccd7
| 89027663d00084d9a99ef579a9b5601f
| 40727b27e91aab2897a078f63976ae25
| 3ff8f01e56862e953278f432530f6ee080 ....... Signature

4728ef5800000000 ........................... Sig. Timestamp: 2017-04-13 07:27:03 UTC

3e120100 ................................... Protocol Version: 70206

Masternode Ping Message
| Masternode Unspent Output
| | 3fbc7d4a8f68ba6ecb02a8db34d1f5b6
| | 2dc105f0b5c3505243435cf815d02394 ........ Outpoint TXID
| | 01000000 ................................ Outpoint index number: 1
| |
| | 00 ...................................... Bytes in sig. script: 0
| | ......................................... Secp256k1 signature: None
| |
| | ffffffff ................................ Sequence number: UINT32_MAX
|
| 94fc0fad18b166c2fedf1a5dc0511372
| 26c353d57e086737ff05000000000000 ......... Chaintip block hash
|
| 66c1a95900000000 ......................... Sig. Timestamp: 2017-10-01 21:21:58 UTC
|
| Masternode Signature
| | 41 ..................................... Bytes in signature: 65
| | 1b3017c49a03e2d77083f3c92a8c2e4c
| | d815d068b6256498a719e3cb6a34f774
| | ec6434cfcbb7a5a51704350a05903287
| | eecc82e6b40ac2fcfa2df29ddaa6c4fc
| | b8 ..................................... Masternode Signature
{% endhighlight %}

{% endautocrossref %}

#### mnget
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `mnget` message requests masternode payment sync. The response to an
`mnget` message is an `mnb` message inventory and an `mnp` message inventory for
each requested masternode. Masternodes ignore this request if they are not fully synced.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 4 | nMnCount | int | Required | Number of masternode payment votes to request

{% highlight text %}
Note: Dash Core limits how frequently a masternode payment sync can be
requested. Frequent requests will result in the node being banned.
{% endhighlight %}

The following annotated hexdump shows a `mnget` message. (The
message header has been omitted.)

{% highlight text %}
a8170000 ................................... Count: 6056
{% endhighlight %}

{% endautocrossref %}

#### mnp
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `mnp` message is sent by masternodes every few minutes to ping the network
with a message that propagates across the whole network. Dash Core currently
uses a minimum masternode ping time of 10 minutes.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 41 | vin | txIn | Required | The unspent output of the masternode (holding 1000 DASH) which is signing the message
| 32 | blockHash | uint256 | Required | Block hash from 12 blocks ago (current chaintip minus 12). This offset allows nodes to be slightly out of sync.
| 8 | sigTime | int64_t | Required | Time which the signature was created
| 66* | vchSig | char[] | Required | Signature of this message by masternode - verifiable via pubKeyMasternode (66 bytes in most cases. Length (1 byte) + Signature (65 bytes))

The following annotated hexdump shows a `mnp` message. (The
message header has been omitted.)

{% highlight text %}
Masternode Unspent Output
| 0bfa3616099771bb5f36181ff4060a9b
| 9afe7b3e47d7f4327800f0f8ce586c6e ......... Outpoint TXID
| 01000000 ................................. Outpoint index number: 1
|
| 00 ....................................... Bytes in sig. script: 0
| .......................................... Secp256k1 signature: None
|
| ffffffff ................................. Sequence number: UINT32_MAX

a26a68ebb733192c1c40f9b42f872ac0
e23d4c360e20d5ab6608000000000000 ........... Chaintip block hash

1bbfa95900000000 ........................... Sig. Timestamp: 2017-10-01 20:12:11 UTC

Masternode Signature
| 41 ....................................... Bytes in signature: 65
| 1c2b205bd6ba472d7a9495f049ef66dc
| f844154846e25f2389385ba2d3e95cde
| cf3ccf82bc26d94c6fdafcd7b965bb61
| db02d05483595196ea4d92b2e797612b
| 79 ....................................... Masternode Signature
{% endhighlight %}

{% endautocrossref %}

#### mnv
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `mnv` message is used by masternodes to verify each other. Several `mnv`
messages are exchanged in the process. This results in the IP address of
masternode 1 being validated as of the provided block height.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 41 | vin1 | txIn | Required | The unspent output which is holding 1000 DASH for masternode 1
| 41 | vin2 | txIn | Required | The unspent output which is holding 1000 DASH for masternode 2
| # | addr | CService | Required | IPv4 address and port of masternode 1
| 4 | nonce | int | Required | Random nonce
| 4 | nBlockHeight | int | Required | Block height
| 66 | vchSig1 | char[] | Required*<br><br>Added in Step 2 | Signature of this message by masternode 1 - verifiable via pubKeyMasternode (Length (1 byte) + Signature (65 bytes))<br><br>
| 66 | vchSig2 | char[] | Required*<br><br>Added in Step 3 | Signature of this message by masternode 2 - verifiable via pubKeyMasternode (Length (1 byte) + Signature (65 bytes))<br><br>

Initially, both `vchSig1` and `vchSig2` are empty. They are updated as the
exchange of messages between the masternodes occurs as detailed in the table
below.

*Masternode Verify Data Flow*

| Step  | **MN 2 (Verifier)** | **Direction**  | **MN 1 (Being verified)**   | **Description** |
|   | **Verification request** | |                   | **`mnv` message with no signatures** |
| 1 | `mnv` message    | → |                   | Contains `addr`, `nonce`, and `nBlockHeight`
| 2 |                  | ← | `mnv` message     | Add `vchSig1` (signature of the IP address + nonce + hash of the requested block)
| 3 | `mnv` message    | → |                   | Verify `vchSig1` <br><br>Add `vchSig2` (signature of the IP address + nonce + hash of the requested block + `vin1` prevout + `vin2` prevout) and relay message to peers if valid

Nodes receiving a relayed `mnv` message (one in which both `vchSig1` and
`vchSig2` are already present) use it to update the PoSe ban score. If the ban
score reaches `MASTERNODE_POSE_BAN_MAX_SCORE` (5), the masternode will be
considered malicious and banned.

{% highlight text %}
Important Notes:
* Dash Core limits how frequently a masternode verify request can be
  requested. Frequent requests will result in the node being banned.

* Only masternodes in the top `MAX_POSE_RANK` (10) can send an `mnv` request
  (to no more than `MAX_POSE_CONNECTIONS` (10)).

{% endhighlight %}

<!-- Need example from Wireshark -->

{% endautocrossref %}

#### mnw
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `mnw` message is used to pick the next winning masternode. When a new block
is found on the network, a masternode quorum will be determined and those 10
selected masternodes will issue the masternode payment vote message.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 41 | vin | txIn | Required | The unspent output which is holding 1000 DASH
| 4 | nBlockHeight | int | Required | The blockheight which the payee should be paid
| ? | payeeAddress | CScript | Required | The address receiving payment
| 66* | vchSig | char[] | Required | Signature of the masternode which is signing the message (66 bytes in most cases. Length (1 byte) + Signature (65 bytes))

The following annotated hexdump shows a `mnw` message. (The
message header has been omitted.)

{% highlight text %}
Masternode Unspent Output
| 0c1b5c5846792b25b05eeea9586d8c34
| ecb996c566bedb4ecf6a68fe8ffa9582 ......... Outpoint TXID
| 00000000 ................................. Outpoint index number: 0
|
| 00 ....................................... Bytes in sig. script: 0
| .......................................... Secp256k1 signature: None
|
| ffffffff ................................. Sequence number: UINT32_MAX

fb4f0a00 ................................... Block pay height: 675835

Payee Address
| 19 ....................................... Address Length: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | 1767c363646be7d8e4475c0aa85ea454
| | | 9fd102c4 ............................. Pubkey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG

Masternode Signature
| 41 ....................................... Bytes in signature: 65
| 1c25da47190a83937fb5ef607235703a
| 7cdda155bf5a1ae6139929024750f899
| a90a4f57cdf9d54c9d9603c1f31009f8
| e257355b49c0484fb4c31bc412c73dd9
| 20 ....................................... Signature
{% endhighlight %}

{% endautocrossref %}

#### mnwb
{% include helpers/subhead-links.md %}

{% autocrossref %}

There is no message for `mnwb` (`inv` message only).

The following annotated hexdump shows an `inv` message with a `mnwb`
inventory entry.  (The message header has been omitted.)

{% highlight text %}
01 ................................. Count: 1

08000000 ........................... Type: MSG_MASTERNODE_PAYMENT_BLOCK (8)
dd6cc6c11211793b239c2e311f1496e2
2281b200b35233eaae465d2aa3c9d537 ... Hash: mnwb
{% endhighlight %}

{% endautocrossref %}

#### ssc
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `ssc` message is used to track the sync status of masternode objects. This
message is sent in response to sync requests for the list of masternodes
(`dseg` message), masternode payments (`mnget` message), governance objects
(`govsync` message), and governance object votes (`govsync` message).

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 4 | nItemID | int | Required | Masternode Sync Item ID
| 4 | nCount | int | Required | Number of items to sync

Sync Item IDs

| ID | Description | Response To
|------|--------------|---------------
| 2 | MASTERNODE_SYNC_LIST | `dseg` message
| 3 | MASTERNODE_SYNC_MNW | `mnget` message
| 10 | MASTERNODE_SYNC_GOVOBJ | `govsync` message
| 11 | MASTERNODE_SYNC_GOVOBJ_VOTE | `govsync` message with non-zero hash

The following annotated hexdump shows a `ssc` message. (The
message header has been omitted.)

{% highlight text %}
02000000 ................................... Item ID: MASTERNODE_SYNC_LIST (2)
bf110000 ................................... Count: 4543
{% endhighlight %}

{% endautocrossref %}


### Governance Messages
{% include helpers/subhead-links.md %}

{% autocrossref %}

The following network messages enable the Governance features built in to Dash.
For additional details on the governance system, see this [Budget System page](https://dashpay.atlassian.net/wiki/spaces/DOC/pages/8585246/Budget+System+Funding+Voting+DGBB).

![Overview Of P2P Protocol Governance Request And Reply Messages](/img/dev/en-p2p-governance-messages.svg)

For additional details, refer to the Developer Guide [Governance section](developer-guide#governance).

{% endautocrossref %}

#### govobj
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `govobj` message contains a governance object that is generally a proposal,
contract, or setting. Masternodes ignore this request if they are not fully synced.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 32 | nHashParent | uint256 | Required | Parent object (a hash of all zeros here indicates this is the root object, not a child object).
| 4 | nRevision | int | Required | Object revision in the system
| 8 | nTime | int64_t | Required | Time which this object was created
| 32 | nCollateralHash | uint256 | Required* | Hash of the collateral fee transaction for proposals.<br><br>Set to all zeros for Triggers/Watchdogs.
| 0-16384 | strData | string | Required | Data field - can be used for anything (leading varint indicates size of data)
| 4 | nObjectType | int | Required | Type of governance object: <br>• `0` - Unknown<br>• `1` - Proposal<br>• `2` - Trigger<br>• `3` - Watchdog
| 41 | vinMasternode | CTxIn | Required* | Unspent output for the masternode which is signing this object.<br><br>Set to all zeros for proposals since they can be created by non-masternodes.
| 66* | vchSig | char[] | Required* | Signature of the masternode (Length (1 byte) + Signature (65 bytes))<br><br>Not required for proposals - they will have a length of 0x00 and no Signature.

Governance Object Types (defined by src/governance-object.h)

| Type | Name                    | Description
|------|-------------------------|------------
| 0 | `GOVERNANCE_OBJECT_UNKNOWN`  |
| 1 | `GOVERNANCE_OBJECT_PROPOSAL` | Submitted proposal (requires collateral transaction - currently 5 Dash)
| 2 | `GOVERNANCE_OBJECT_TRIGGER`  | Masternode generated. Removed after activation/execution. Used for superblocks.
| 3 | `GOVERNANCE_OBJECT_WATCHDOG` | Masternode generated. Two hour expiration time.

The following annotated hexdump shows a `govobj` message for a Proposal object.
Notice the presence of a non-zero collateral hash, a vinMasternode that is an
empty CTxIn (hash of all zeros, index/sequence of 0xffffffff, no Signature),
and no vchSig.
(The message header has been omitted.)

{% highlight text %}
00000000000000000000000000000000
00000000000000000000000000000000 ..... Parent Hash (0 = root)
01000000 ............................. Revision: 1
c8dfd65900000000 ..................... Create timestamp: 2017-10-06 01:43:31 UTC
633611d2f3e7481325242f200c7f3485
e3a9b4b6301e7f7d18d87d8231f3880b ..... Collateral Hash

Data
| 3e02 ............................... Data length: 574
| 356235623232373 ... 376435643564 ... Data (truncated)

01000000 ............................. Object Type: GOVERNANCE_OBJECT_PROPOSAL (1)

Transaction input
| Previous Output
| | 00000000000000000000000000000000
| | 00000000000000000000000000000000 ... Outpoint TXID
| | ffffffff ........................... Outpoint index number: 0
| 00 ................................... Script length: 0
| ...................................... Signature: None
| ffffffff ............................. Sequence

00 ................................... Signature length: 0

| .................................... Masternode Signature (None required)
{% endhighlight %}

The following annotated hexdump shows a `govobj` message for a Trigger object.
Notice the collateral hash of all zeros.
(The message header has been omitted.)

{% highlight text %}
00000000000000000000000000000000
00000000000000000000000000000000 ..... Parent Hash (0 = root)
01000000 ............................. Revision: 1
911ea85900000000 ..................... Create timestamp: 2017-08-31 14:34:57 UTC
00000000000000000000000000000000
00000000000000000000000000000000 ..... Collateral Hash (None required)

Data
| ae11 ............................... Data length: 4526
| fdae11356235623 ... 376435643564 ... Data (truncated)

02000000 ............................. Object Type: GOVERNANCE_OBJECT_TRIGGER (2)

Transaction input
| Previous Output
| | ffefbe4959085907bcd2ba29e357a441
| | fa7b6e26e25896d8127332bba2419e97 ... Outpoint TXID
| | 00000000 ........................... Outpoint index number: 0
| 00 ................................... Script length: 0
| ...................................... Signature: None
| ffffffff ............................. Sequence

41 ................................... Signature length: 65

1ce3b782f66be8ae9fc4158680128864
341202b6006384083ab2d9cfa73795e2
6000668e84af4ef6a284a52b53843524
72037d51bd9079ffd5c087d9632865ee
75 ................................... Masternode Signature
{% endhighlight %}

{% endautocrossref %}

#### govobjvote
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `govobjvote` message is used to indicate the voting status of a governance
object.  Voting status is comprised of the vote outcome (how the masternode
voted) and the vote signal (the network support status). A sufficient number of
yes votes results in the proposed funding being payed out in the next
superblock (assuming their are sufficient funds available in the budget).

The initial `govobjvote` message is created by a masternode to vote on a
governance object (proposal, etc.). When the masternode votes, it broadcasts
the `govobjvote` message to all its peers.

When a node receives a valid, **new** `govobjvote` message, it relays the message
to all its connected peers to propagate the vote.

Additionally, nodes can request `govobjvote` messages for specific governance
objects via a `govsync` message. Masternodes ignore requests for votes if they
are not fully synced.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 41+ | vinMasternode | CTxIn | Required | Unspent output for the masternode which is voting
| 32 | nParentHash | uint256 | Required | Object (`govobj`) being voted on (proposal, contract, setting or final budget)
| 4 | nVoteOutcome | int | Required | None (0), Yes (1), No (2), Abstain (3)
| 4 | nVoteSignal | int | Required |  None (0), Funding (1), Valid (2), Delete (3), Endorsed (4)
| 8 | nTime | int64_t | Required | Time the vote was created
| 66* | vchSig | char[] | Required | Signature of the masternode (66 bytes in most cases. Length (1 byte) + Signature (65 bytes))

Governance Object Vote Signals (defined by src/governance-object.h)

| Value | Name | Description
|------|-------|------------
| 1 | Funding  | Minimum network support has been reached for this object to be funded (doesn't mean it will for sure though)
| 2 | Valid    | Minimum network support has been reached flagging this object as a valid and understood governance object (e.g, the serialized data is correct format, etc.)
| 3 | Delete   | Minimum network support has been reached saying this object should be deleted from the system entirely
| 4 | Endorsed | Minimum network support has been reached flagging this object as endorsed by an elected representative body

The following annotated hexdump shows a `govobjvote` message. (The
message header has been omitted.)

{% highlight text %}
Transaction input
| Previous Output
| | 57566a0ef85e6cac3415ced67b0b07e1
| | 781bafb853650d7c9d56d8bc132cc3b4 ... Outpoint TXID
| | 00000000 ........................... Outpoint index number: 0
| 00 ................................... Script length: 0
| ...................................... Signature: None
| ffffffff ............................. Sequence

ad9579d5c181eee904156df1c88b050f
b8b4d39e5fda71f015996dbf14a51bff...... Parent Hash (0 = root)
01000000 ............................. Vote Outcome: VOTE_OUTCOME_NONE (1)
02000000 ............................. Vote Signal: VOTE_SIGNAL_VALID (2)
b517a85900000000 ..................... Vote Create Timestamp: 2017-08-31 14:05:41 UTC
00000000000000000000000000000000 ..... Collateral Hash

1b049113a81fe913f061ad295561d267
00b8135a021ab0356a1e89b18d663d0b
dc45e9c09ee0427223e332b52e8d709e
6d64e86b6435d7bdf207d8f23b6ae0db
6f ................................... Masternode Signature
{% endhighlight %}

{% endautocrossref %}

#### govsync
{% include helpers/subhead-links.md %}

{% autocrossref %}

The `govsync` message is used to request syncing of governance objects
(`govobj` message and `govobjvote` message) with peers. Masternodes ignore this
request if they are not fully synced.

This message responds in one of two ways depending on the request:

1. Object Sync - When a masternode receives a `govsync` message with a hash of all zeros, it
responds with one `ssc` message for `govobj` objects and one for `govobjvote`
objects. The masternode also sends an `inv` message (MSG_GOVERNANCE_OBJECT - 0x17)
for all valid `govobj` governance objects.
*Governance object votes are excluded in this type of response.*

2. Vote Sync - When a masternode receives a `govsync` message with a specific hash, it
responds with one `ssc` message for `govobj` objects and one for `govobjvote`
objects. The masternode also sends both a `govobj` inventory message
(MSG_GOVERNANCE_OBJECT - 0x17) and `govobjvote` inventory messages
(MSG_GOVERNANCE_OBJECT_VOTE - 0x18) for the single governance object requested.

| Bytes | Name | Data type | Required | Description |
| ---------- | ----------- | --------- | -------- | -------- |
| 32 | nHash | uint256 | Required | Hash of governance object to request<br>Set to all zeros to request all objects (excludes votes)
| # | filter | CBloomFilter | Required | Can be set to all zeros.<br>Only supported since [protocol version 70206][section protocol versions]

{% highlight text %}
Dash Core limits how frequently the first type of sync (object sync) can be
requested. Frequent requests will result in the node being banned.
{% endhighlight %}

The following annotated hexdump shows a `govsync` message. (The
message header has been omitted.)

{% highlight text %}
2e46ea5418e097a3dbcccbee3cf2a911
6fb94ba635153f276dcb2123efcb73ff ..... Hash
00000000000000000000 ................. Bloom Filter
{% endhighlight %}

{% endautocrossref %}


### Deprecated Messages
{% include helpers/subhead-links.md %}

{% autocrossref %}

The following network messages have been deprecated and should not longer be used.

{% endautocrossref %}

#### mnvs
{% include helpers/subhead-links.md %}

{% autocrossref %}

Masternode Budget Sync - Deprecated since 12.1

{% endautocrossref %}

#### mvote
{% include helpers/subhead-links.md %}

{% autocrossref %}

Masternode Budget Vote - Deprecated since 12.1

{% endautocrossref %}

#### mprop
{% include helpers/subhead-links.md %}

{% autocrossref %}

Masternode Budget Proposal - Deprecated since 12.1

{% endautocrossref %}

#### fbs
{% include helpers/subhead-links.md %}

{% autocrossref %}

Masternode Budget Final - Deprecated since 12.1

{% endautocrossref %}

#### fbvote
{% include helpers/subhead-links.md %}

{% autocrossref %}

Masternode Budget Final Vote - Deprecated since 12.1

{% endautocrossref %}

#### mn quorum
{% include helpers/subhead-links.md %}

{% autocrossref %}

Not Implemented

{% endautocrossref %}
