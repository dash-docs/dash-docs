{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/ref_transactions.md" %}

## Transactions
{% include helpers/subhead-links.md %}

<!-- __ -->

The following subsections briefly document core transaction details.

#### OpCodes
{% include helpers/subhead-links.md %}

{% autocrossref %}

The opcodes used in the pubkey scripts of standard transactions are:

* Various data pushing opcodes from 0x00 to 0x4e (1--78). These aren't
  typically shown in examples, but they must be used to push
  signatures and public keys onto the stack. See the link below this list
  for a description.

* `OP_TRUE`/`OP_1` (0x51) and `OP_2` through `OP_16` (0x52--0x60), which
  push the values 1 through 16 to the stack.

* [`OP_CHECKSIG`][op_checksig]{:#term-op-checksig}{:.term} (0xac) consumes a signature and a full public key, and pushes
  true onto the stack if the transaction data specified by the SIGHASH flag was
  converted into the signature using the same ECDSA private key that
  generated the public key.  Otherwise, it pushes false onto the stack.

* [`OP_DUP`][op_dup]{:#term-op-dup}{:.term} (0x76) pushes a copy of the topmost stack item on to the stack.

* [`OP_HASH160`][op_hash160]{:#term-op-hash160}{:.term} (0xa9) consumes the topmost item on the stack,
  computes the RIPEMD160(SHA256()) hash of that item, and pushes that hash onto the stack.

* [`OP_EQUAL`][op_equal]{:#term-op-equal}{:.term} (0x87) consumes the top two items on the stack, compares them, and
  pushes true onto the stack if they are the same, false if not.

* [`OP_VERIFY`][op_verify]{:#term-op-verify}{:.term} (0x69) consumes the topmost item on the stack.
  If that item is zero (false) it terminates the script in failure.

* [`OP_EQUALVERIFY`][op_equalverify]{:#term-op-equalverify}{:.term} (0x88) runs `OP_EQUAL` and then `OP_VERIFY` in sequence.

* [`OP_CHECKMULTISIG`][op_checkmultisig]{:#term-op-checkmultisig}{:.term} (0xae) consumes the value (n) at the top of the stack,
  consumes that many of the next stack levels (public keys), consumes
  the value (m) now at the top of the stack, and consumes that many of
  the next values (signatures) plus one extra value.

    The "one extra value" it consumes is the result of an off-by-one
    error in the Bitcoin Core implementation. This value is not used, so
    signature scripts prefix the list of secp256k1 signatures with a
    single OP_0 (0x00).

    `OP_CHECKMULTISIG` compares the first signature against each public
    key until it finds an ECDSA match. Starting with the subsequent
    public key, it compares the second signature against each remaining
    public key until it finds an ECDSA match. The process is repeated
    until all signatures have been checked or not enough public keys
    remain to produce a successful result.

    Because public keys are not checked again if they fail any signature
    comparison, signatures must be placed in the signature script using
    the same order as their corresponding public keys were placed in
    the pubkey script or redeem script. See the `OP_CHECKMULTISIG` warning
    below for more details.

* [`OP_RETURN`][op_return]{:#term-op-return}{:.term} (0x6a) terminates the script in failure when executed.

A complete list of opcodes can be found on the Bitcoin Wiki [Script
Page][wiki script], with an authoritative list in the `opcodetype` enum
of the Dash Core [script header file][core script.h]

![Warning icon](/img/icons/icon_warning.svg)
**<span id="signature_script_modification_warning">Signature script modification warning</span>:**
Signature scripts are not signed, so anyone can modify them. This
means signature scripts should only contain data and data-pushing opcodes
which can't be modified without causing the pubkey script to fail.
Placing non-data-pushing opcodes in the signature script currently
makes a transaction non-standard, and future consensus rules may forbid
such transactions altogether. (Non-data-pushing opcodes are already
forbidden in signature scripts when spending a P2SH pubkey script.)

![Warning icon](/img/icons/icon_warning.svg)
**`OP_CHECKMULTISIG` warning:** The multisig verification process
described above requires that signatures in the signature script be
provided in the same order as their corresponding public keys in
the pubkey script or redeem script. For example, the following
combined signature and pubkey script will produce the stack and
comparisons shown:

{% highlight text %}
OP_0 <A sig> <B sig> OP_2 <A pubkey> <B pubkey> <C pubkey> OP_3

Sig Stack       Pubkey Stack  (Actually a single stack)
---------       ------------
B sig           C pubkey
A sig           B pubkey
OP_0            A pubkey

1. B sig compared to C pubkey (no match)
2. B sig compared to B pubkey (match #1)
3. A sig compared to A pubkey (match #2)

Success: two matches found
{% endhighlight %}

But reversing the order of the signatures with everything else the same
will fail, as shown below:

{% highlight text %}
OP_0 <B sig> <A sig> OP_2 <A pubkey> <B pubkey> <C pubkey> OP_3

Sig Stack       Pubkey Stack  (Actually a single stack)
---------       ------------
A sig           C pubkey
B sig           B pubkey
OP_0            A pubkey

1. A sig compared to C pubkey (no match)
2. A sig compared to B pubkey (no match)

Failure, aborted: two signature matches required but none found so
                  far, and there's only one pubkey remaining
{% endhighlight %}

{% endautocrossref %}

#### Address Conversion
{% include helpers/subhead-links.md %}

{% autocrossref %}

The hashes used in P2PKH and P2SH outputs are commonly encoded as Dash
addresses.  This is the procedure to encode those hashes and decode the
addresses.

First, get your hash.  For P2PKH, you RIPEMD-160(SHA256()) hash a ECDSA
public key derived from your 256-bit ECDSA private key (random data).
For P2SH, you RIPEMD-160(SHA256()) hash a redeem script serialized in the
format used in raw transactions (described in a [following
sub-section][raw transaction format]).  Taking the resulting hash:

1. Add an address version byte in front of the hash.  The version
bytes commonly used by Dash are:

    * 0x4c for P2PKH addresses on the main Dash network (mainnet)

    * 0x8c for P2PKH addresses on the Dash testing network (testnet)

    * 0x10 for P2SH addresses on mainnet

    * 0x13 for P2SH addresses on testnet

2. Create a copy of the version and hash; then hash that twice with SHA256: `SHA256(SHA256(version . hash))`

3. Extract the first four bytes from the double-hashed copy.
   These are used as a checksum to ensure the base hash gets transmitted
   correctly.

4. Append the checksum to the version and hash, and encode it as a base58
   string: <!--[-->`BASE58(version . hash . checksum)`<!--]-->

Dash's base58 encoding, called [Base58Check][/en/glossary/base58check]{:#term-base58check}{:.term} may not match other implementations. Tier
Nolan provided the following example encoding algorithm to the Bitcoin
Wiki [Base58Check
encoding](https://en.bitcoin.it/wiki/Base58Check_encoding) page under
the [Creative Commons Attribution 3.0 license][]:

{% highlight c %}
code_string = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
x = convert_bytes_to_big_integer(hash_result)

output_string = ""

while(x > 0)
   {
       (x, remainder) = divide(x, 58)
       output_string.append(code_string[remainder])
   }

repeat(number_of_leading_zero_bytes_in_hash)
   {
   output_string.append(code_string[0]);
   }

output_string.reverse();
{% endhighlight %}

Dash's own code can be traced using the [base58 header
file][core base58.h].

To convert addresses back into hashes, reverse the base58 encoding, extract
the checksum, repeat the steps to create the checksum and compare it
against the extracted checksum, and then remove the version byte.

{% endautocrossref %}

#### Raw Transaction Format
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash transactions are broadcast between peers
in a serialized byte format, called [raw format][/en/glossary/serialized-transaction]{:#term-raw-format}{:.term}.
It is this form of a transaction which is SHA256(SHA256()) hashed to create
the TXID and, ultimately, the merkle root of a block containing the
transaction---making the transaction format part of the consensus rules.

Dash Core and many other tools print and accept raw transactions
encoded as hex.

Transactions prior to protocol version 70209 defaulted to version 1. Transaction
version 2 was the default in protocol versions => 70209 and < 70213. Version 2
transactions have the same format, but the `lock_time` parameter was redefined
by BIP68 to enable relative lock-times.
(Note: transactions in the block chain are allowed to list a higher version
number to permit soft forks, but they are treated as version 2 transactions
by current software.)

Dash Core 0.13.0 (protocol version 70213) introduced transaction version 3 as
part of the [DIP2 - Special Transactions](https://github.com/dashpay/dips/blob/master/dip-0002.md)
 implementation. Details of the changes introduced by
this feature and currently implemented special transactions can be found in the
[Special Transactions section](#special-transactions) below as well as in the
[DIP](https://github.com/dashpay/dips/blob/master/dip-0002.md).

A raw transaction has the following top-level format:

| Bytes    | Name         | Data Type           | Description
|----------|--------------|---------------------|-------------
| 2        | version      | uint16_t            | *Converted from 4 bytes to 2 bytes by DIP2 in v0.13.0*<br><br>Transaction version number; currently version 3.  Programs creating transactions using newer consensus rules may use higher version numbers.
| 2        | type         | uint16_t            | *Added by DIP2 in v0.13.0. Uses 2 bytes that were previously part of `version`*<br><br>Transaction type number; 0 for classical transactions; Non-zero for DIP2 special transactions.
| *Varies* | tx_in count  | compactSize uint    | Number of inputs in this transaction.
| *Varies* | tx_in        | txIn                | Transaction inputs.  See description of txIn below.
| *Varies* | tx_out count | compactSize uint    | Number of outputs in this transaction.
| *Varies* | tx_out       | txOut               | Transaction outputs.  See description of txOut below.
| 4        | lock_time    | uint32_t            | A time (Unix epoch time) or block number.  See the [locktime parsing rules][].
| *Varies* | extra_payload size | compactSize uint | *Added by DIP2 in v0.13.0*<br><br>Variable number of bytes of extra payload for DIP2-based special transactions
| *Varies* | extra_payload | blob               | *Added by DIP2 in v0.13.0*<br><br>Special transaction payload.

A transaction may have multiple inputs and outputs, so the txIn and
txOut structures may recur within a transaction. CompactSize unsigned
integers are a form of variable-length integers; they are described in
the [CompactSize section][section CompactSize unsigned integer].

##### JSON-RPC<!--noref--> Responses
{% include helpers/subhead-links.md %}

When retrieving transaction data via Dash Core RPCs (e.g. the `getrawtransaction` RPC),
the transaction data is returned in the following format.

Version 1 and 2 Transaction Structure (prior to DIP2 activation in Dash Core v0.13.0):
{% highlight json %}
{
  "txid": <string>,
  "size": <int>,
  "version": 2,
  "locktime": 0,
  "vin": [ ],
  "vout": [ ]
}
{% endhighlight %}

Version 3 Transaction Structure (Dash Core v0.13.0+ and activated DIP2):
{% highlight json %}
{
  "txid": <string>,
  "size": <int>,
  "version": 3,
  "type": <int>,
  "locktime": 0,
  "vin": [ ],
  "vout": [ ],
  "extraPayloadSize": <variable int>,
  "extraPayload": …
}
{% endhighlight %}

For special transactions (those using the extraPayload fields), JSON-RPC
responses contain a parsed JSON representation of the Transaction Payload.

The sample transaction below shows the response for a quorum commitment special
transaction:

{% highlight json %}
{
  "txid": "592a09d08348d970b4d9ba216246a23dac866717b460d3f369a86293b9839eea",
  "size": 342,
  "version": 3,
  "type": 6,
  "locktime": 0,
  "vin": [
  ],
  "vout": [
  ],
  "extraPayloadSize": 329,
  "extraPayload": "0100841b0000010001211cd3e4230b2bc47530e200447e998a38e960d4ed5f5251e26892130c000000320000000000000032000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "qcTx": {
    "version": 1,
    "height": 7044,
    "commitment": {
      "version": 1,
      "llmqType": 1,
      "quorumHash": "0000000c139268e251525fedd460e9388a997e4400e23075c42b0b23e4d31c21",
      "signersCount": 0,
      "validMembersCount": 0,
      "quorumPublicKey": "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    }
  },
  "instantlock": false
}

{% endhighlight %}

{% endautocrossref %}

##### TxIn: A Transaction Input (Non-Coinbase) {#txin}
{:.no_toc}
{% include helpers/subhead-links.md %}

{% autocrossref %}

Each non-coinbase input spends an outpoint from a previous transaction.
(Coinbase inputs are described separately after the example section below.)

| Bytes    | Name             | Data Type            | Description
|----------|------------------|----------------------|--------------
| 36       | previous_output  | outpoint             | The previous outpoint being spent.  See description of outpoint below.
| *Varies* | script bytes     | compactSize uint     | The number of bytes in the signature script.  Maximum is 10,000 bytes.
| *Varies* | signature script | char[]               | A script-language script which satisfies the conditions placed in the outpoint's pubkey script.  Should only contain data pushes; see the [signature script modification warning][].
| 4        | sequence         | uint32_t             | Sequence number.  Default for Dash Core and almost all other programs is 0xffffffff.

{% endautocrossref %}

##### Outpoint: The Specific Part Of A Specific Output {#outpoint}
{:.no_toc}
{% include helpers/subhead-links.md %}

{% autocrossref %}

Because a single transaction can include multiple outputs, the outpoint
structure includes both a TXID and an output index number to refer to
specific output.

| Bytes | Name  | Data Type | Description
|-------|-------|-----------|--------------
| 32    | hash  | char[32]  | The TXID of the transaction holding the output to spend.  The TXID is a hash provided here in internal byte order.
| 4     | index | uint32_t  | The output index number of the specific output to spend from the transaction. The first output is 0x00000000.

{% endautocrossref %}

##### TxOut: A Transaction Output {#txout}
{:.no_toc}
{% include helpers/subhead-links.md %}

{% autocrossref %}

Each output spends a certain number of duffs, placing them under
control of anyone who can satisfy the provided pubkey script.

| Bytes    | Name            | Data Type        | Description
|----------|-----------------|------------------|--------------
| 8        | value           | int64_t          | Number of duffs to spend.  May be zero; the sum of all outputs may not exceed the sum of duffs previously spent to the outpoints provided in the input section.  (Exception: coinbase transactions spend the block subsidy and collected transaction fees.)
| 1+       | pk_script bytes | compactSize uint | Number of bytes in the pubkey script.  Maximum is 10,000 bytes.
| *Varies* | pk_script       | char[]           | Defines the conditions which must be satisfied to spend this output.

**Example**

The sample raw transaction itemized below is the one created in the
[Simple Raw Transaction section][section simple raw transaction] of the
Developer Examples. It spends a previous pay-to-pubkey output by paying
to a new pay-to-pubkey-hash (P2PKH) output.

{% highlight text %}
01000000 ................................... Version

01 ......................................... Number of inputs
|
| 7b1eabe0209b1fe794124575ef807057
| c77ada2138ae4fa8d6c4de0398a14f3f ......... Outpoint TXID
| 00000000 ................................. Outpoint index number: 0
|
| 49 ....................................... Bytes in sig. script: 73
| | 48 ..................................... Push 72 bytes as data
| | | 30450221008949f0cb400094ad2b5eb3
| | | 99d59d01c14d73d8fe6e96df1a7150de
| | | b388ab8935022079656090d7f6bac4c9
| | | a94e0aad311a4268e082a725f8aeae05
| | | 73fb12ff866a5f01 ..................... Secp256k1 signature
|
| ffffffff ................................. Sequence number: UINT32_MAX

01 ......................................... Number of outputs
| f0ca052a01000000 ......................... Duffs (49.99990000 Dash)
|
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | cbc20a7664f2f69e5355aa427045bc15
| | | e7c6c772 ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG

00000000 ................................... locktime: 0 (a block height)
{% endhighlight %}

{% endautocrossref %}

##### Coinbase Input: The Input Of The First Transaction In A Block {#coinbase}
{:.no_toc}
{% include helpers/subhead-links.md %}

{% autocrossref %}

The first transaction in a block, called the coinbase transaction, must
have exactly one input, called a coinbase. The coinbase input currently
has the following format.

| Bytes    | Name               | Data Type            | Description
|----------|--------------------|----------------------|--------------
| 32       | hash (null)        | char[32]             | A 32-byte null, as a coinbase has no previous outpoint.
| 4        | index (UINT32_MAX) | uint32_t             | 0xffffffff, as a coinbase has no previous outpoint.
| *Varies* | script bytes       | compactSize uint     | The number of bytes in the coinbase script, up to a maximum of 100 bytes.
| *Varies* (4) | height         | script               | The [block height][/en/glossary/coinbase]{:#term-coinbase-block-height}{:.term} of this block as required by BIP34.  Uses script language: starts with a data-pushing opcode that indicates how many bytes to push to the stack followed by the block height as a little-endian unsigned integer.  This script must be as short as possible, otherwise it may be rejected.<br/><br/>  The data-pushing opcode will be 0x03 and the total size four bytes until block 16,777,216 about 300 years from now.
| *Varies* | coinbase script    | *None*               | The [coinbase field][/en/glossary/coinbase]{:#term-coinbase-field}{:.term}: Arbitrary data not exceeding 100 bytes minus the (4) height bytes.  Miners commonly place an extra nonce in this field to update the block header merkle root during hashing.
| 4        | sequence           | uint32_t             | Sequence number.

<!--
Most (but not all) blocks prior to block height 227,836 used block
version 1 which did not require the height parameter to be prefixed to
the coinbase script.  The block height parameter is now required.
-->
Although the coinbase script is arbitrary data, if it includes the
bytes used by any signature-checking operations such as `OP_CHECKSIG`,
those signature checks will be counted as signature operations (sigops)
towards the block's sigop limit.  To avoid this, you can prefix all data
with the appropriate push operation.

An itemized coinbase transaction:

{% highlight text %}
01000000 .............................. Version

01 .................................... Number of inputs
| 00000000000000000000000000000000
| 00000000000000000000000000000000 ...  Previous outpoint TXID
| ffffffff ............................ Previous outpoint index
|
| 18 .................................. Bytes in coinbase: 24
| |
| | 03 ................................ Bytes in height
| | | b8240b .......................... Height: 730296
| |
| | 03b8240b049d29aa59080400077efa95
| | 0000052f6d70682f .................. Arbitrary data
| 00000000 ............................ Sequence

02 .................................... Output count
| Transaction Output 1
| | f20cbe0a00000000 .................... Duffs (1.80227314 Dash)
| | 1976a9142cd46be3ceeacca983e0fea3
| | b88f26b08a26c29b88ac ................ P2PKH script
|
| Transaction Output 2
| | eb0cbe0a00000000 .................... Duffs (1.80227307 Dash)
| | 1976a914868180414905937a68fadeb0
| | f33e64d102c9591a88ac ................ P2PKH script
|
| 00000000 ............................ Locktime
{% endhighlight %}

Note: currently the normal coinbase has 2 outputs (1 for the miner and 1 for
the selected masternode). Superblocks ([superblock example][superblock example])
have multiple outputs depending on the number of proposals being funded.

{% endautocrossref %}

### Special Transactions
{% include helpers/subhead-links.md %}

{% autocrossref %}

The Special Transaction framework established by DIP2 enabled the implementation
of new on-chain features and consensus mechanisms. These transactions provide the
flexibility to expand beyond the financial uses of classical transactions. DIP2
transactions modified classical transactions by:

1. Splitting the 32 bit `version` field into two 16 bit fields (`version` and `type`)
2. Adding support for a generic extra payload following the `lock_time` field. The
   maximum allowed size for a transaction version 3 extra payload is 10000 bytes
   (`MAX_TX_EXTRA_PAYLOAD`).

Classical (financial) transactions have a `type` of 0 while special transactions
have a `type` defined in the DIP describing them. A list of current special
transaction types is maintained in the [DIP repository](https://github.com/dashpay/dips/blob/master/dip-0002-special-transactions.md).

**Implemented Special Transactions**

| Release | Tx Version | Tx Type | Payload Size | Payload | Payload JSON | Tx Purpose
| - | - | - | - | - | - |
| v0.12.3 | 2 | - | n/a | n/a | n/a |
| v0.13.0 | 3 | 0 | n/a | n/a | n/a | Standard (Classical) Transaction
| v0.13.0 | 3 | 1 | compactSize uint | hex | ProRegTx | Masternode Registration
| v0.13.0 | 3 | 2 | compactSize uint | hex | ProUpServTx | Update Masternode Service
| v0.13.0 | 3 | 3 | compactSize uint | hex | ProUpRegTx| Update Masternode Operator
| v0.13.0 | 3 | 4 | compactSize uint | hex | ProUpRevTx| Masternode Operator Revocation
| v0.13.0 | 3 | 5 | compactSize uint | hex | CbTx| Masternode List Merkle Proof
| v0.13.0 | 3 | 6 | compactSize uint | hex | QcTx| Long-Living Masternode Quorum Commitment

{% endautocrossref %}

#### ProRegTx
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70213 of Dash Core as described by DIP3*

The Masternode Registration (ProRegTx) special transaction is used to join the
masternode list by proving ownership of the 1000 DASH necessary to create a
masternode.

A ProRegTx is created and sent using the `protx` RPC. The ProRegTx must either
include an output with 1000 DASH (`protx register`) or refer to an existing
unspent output holding 1000 DASH (`protx fund_register`). If the 1000 DASH is an
output of the ProRegTx, the collateralOutpoint hash field should be null.

The special transaction type is 1 and the extra payload consists of the following
data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | Provider transaction version number. Currently set to 1.
| 2 | type | uint_16 | Masternode type. Default set to 0.
| 2 | mode | uint_16 | Masternode mode. Default set to 0.
| 36 | collateralOutpoint | COutpoint | The collateral outpoint.<br>**Note:** The hash will be null if the collateral is part of this transaction, otherwise it will reference an existing collateral.
| 16 | ipAddress | byte[] | IPv6 address in network byte order. Only IPv4 mapped addresses are allowed (to be extended in the future)
| 2 | port | uint_16 | Port (network byte order)
| 20 | KeyIdOwner | CKeyID | The public key hash used for owner related signing (ProTx updates, governance voting)
| 48 | PubKeyOperator | CBLSPublicKey | The BLS public key used for operational related signing (network messages, ProTx updates)
| 20 | KeyIdVoting | CKeyID | The public key hash used for voting.
| 2 | operatorReward | uint_16 | A value from 0 to 10000.
| 1-9 | scriptPayoutSize | compactSize uint | Size of the Payee Script.
| Variable | scriptPayout | Script | Payee script (p2pkh/p2sh)
| 32 | inputsHash | uint256 | Hash of all the outpoints of the transaction inputs
| 1-9 | payloadSigSize |compactSize uint | Size of the Signature
| Variable | payloadSig | vector | Signature of the hash of the ProTx fields. Signed with the key corresponding to the collateral outpoint in case the collateral is not part of the ProRegTx itself, empty otherwise.

The following annotated hexdump shows a ProRegTx transaction referencing an
existing collateral. (Parts of the classical transaction section have been omitted.)

{% highlight text %}
0300 ....................................... Version (3)
0100 ....................................... Type (1 - ProRegTx)

[...] ...................................... Transaction inputs omitted
[...] ...................................... Transaction outputs omitted

00000000 ................................... locktime: 0 (a block height)

fd1201 ..................................... Extra payload size (274)

ProRegTx Payload
| 0100 ..................................... Version (1)
| 0000 ..................................... Type (0)
| 0000 ..................................... Mode (0)
|
| 4859747b0eb19bb2dae5a12ef7b6a69b
| 03712bfeded1174de0b6ab1334ab2e8b ......... Outpoint TXID
| 01000000 ................................. Outpoint index number: 1
|
| 00000000000000000000ffffc0000233 ......... IP Address: ::ffff:192.0.2.51
| 270f ..................................... Port: 9999
|
|
| 1636e84d02310b0b458f3eb51d8ea8b2e684b7ce . Owner pubkey hash (ECDSA)
| 88d719278eef605d9c19037366910b59bc28d437
| de4a8db4d76fda6d6985dbdf10404fb9bb5cd0e8
| c22f4a914a6c5566 ......................... Operator public key (BLS)
| 1636e84d02310b0b458f3eb51d8ea8b2e684b7ce . Voting pubkey hash (ECDSA)
|
| f401 ..................................... Operator reward (500 -> 5%)
|
| Payout script
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | fc136008111fcc7a05be6cec66f97568
| | | 727a9e51 ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG
|
| 0fcfb7d939078ba6a6b81ecf1dc2e05d
| e2776f49f7b503ac254798be6a672699 ......... Inputs hash
|
| Payload signature
| 41 ....................................... Signature Size (65)
| 200476f193b465764093014ba44bd4ff
| de2b3fc92794c4acda9cad6305ca172e
| 9e3d6b1cd6e30f86678dae8e6595e53d
| 2b30bc32141b6c0151eb58479121b3e6a4 ....... Signature
{% endhighlight %}

The following annotated hexdump shows a ProRegTx transaction creating a new
collateral.

**Note the presence of the output, a null Outpoint TXID and the
absence of a signature (since it isn't referring to an existing collateral).**
(Parts of the classical transaction section have been omitted.)

{% highlight text %}
0300 ....................................... Version (3)
0100 ....................................... Type (1 - ProRegTx)

[...] ...................................... Transaction inputs omitted

02 ......................................... Number of outputs
| [...] .................................... 1 output omitted
|
| Masternode collateral output
| | 00e8764817000000 ....................... Duffs (1000 DASH)
| | 1976a9149e648c7e4b61482aa3
| | 9bd10e0bf0b5268768005f88ac ............. Script

00000000 ................................... locktime: 0 (a block height)

d1 ......................................... Extra payload size (209)

ProRegTx Payload
| 0100 ..................................... Version (1)
| 0000 ..................................... Type (0)
| 0000 ..................................... Mode (0)
|
| 00000000000000000000000000000000
| 00000000000000000000000000000000 ......... Outpoint TXID
| 01000000 ................................. Outpoint index number: 1
|
| 00000000000000000000ffffc0000233 ......... IP Address: ::ffff:192.0.2.51
| 270f ..................................... Port: 9999
|
| 757a2171bbf92517e358249f20c37a8ad2d7a5bc . Owner pubkey hash (ECDSA)
| 0e02146e9c34cfbcb3f3037574a1abb35525e2ca
| 0c3c6901dbf82ac591e30218d1711223b7ca956e
| df39f3d984d06d51 ......................... Operator public key (BLS)
| 757a2171bbf92517e358249f20c37a8ad2d7a5bc . Voting pubkey hash (ECDSA)
|
| f401 ..................................... Operator reward (500 -> 5%)
|
| Payout script
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | 9e648c7e4b61482aa39bd10e0bf0b526
| | | 8768005f ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG
|
| 57b115d681b9aff82824ff7e22af99d4
| ac4b39ad7be7cb70b662e9011827d589 ......... Inputs hash
|
| Payload signature
| 00 ....................................... Signature Size (0)
| .......................................... Signature (Empty)
{% endhighlight %}

{% endautocrossref %}

#### ProUpServTx
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70213 of Dash Core as described by DIP3*

The Masternode Provider Update Service (ProUpServTx) special transaction is used
to update the IP Address and port of a masternode. If a non-zero operatorReward
was set in the initial ProRegTx, the operator may also set the scriptOperatorPayout
field in the ProUpServTx.

A ProUpServTx is only valid for masternodes in the registered masternodes subset.
When processed, it updates the metadata of the masternode entry and revives the
masternode if it was previously marked as PoSe-banned.

A ProUpServTx is created and sent using the `protx update_service` RPC.

The special transaction type used for ProUpServTx Transactions is 2 and the extra
payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | ProUpServTx version number. Currently set to 1.
| 32 | proTXHash | uint256 | The hash of the initial ProRegTx
| 16 | ipAddress | byte[] | IPv6 address in network byte order. Only IPv4 mapped addresses are allowed (to be extended in the future)
| 2 | port | uint_16 | Port (network byte order)
| 1-9 | scriptOperator<br>PayoutSize | compactSize uint | Size of the Operator Payee Script.
| Variable | scriptOperator<br>Payout | Script | Operator Payee script (p2pkh/p2sh)
| 32 | inputsHash | uint256 | Hash of all the outpoints of the transaction inputs
| 1-9 | payloadSigSize |compactSize uint | Size of the Signature<br>**Note:** not present in BLS implementation
| 96 | payloadSig | vector | BLS Signature of the hash of the ProUpServTx fields. Signed by the Operator.

The following annotated hexdump shows a ProUpServTx transaction. (Parts of the
classical transaction section have been omitted.)

{% highlight text %}
0300 ....................................... Version (3)
0200 ....................................... Type (2 - ProUpServTx)

[...] ...................................... Transaction inputs omitted
[...] ...................................... Transaction outputs omitted

00000000 ................................... locktime: 0 (a block height)

b5 ......................................... Extra payload size (181)

ProUpServTx Payload
| 0100 ..................................... Version (1)
|
| db60b8cecae691a3d078a2341d460b06
| b2914f6b092f1906b5c815589399b0ff ......... ProRegTx Hash
|
| 00000000000000000000ffffc0000233 ......... IP Address: ::ffff:192.0.2.51
| 270f ..................................... Port: 9999
|
| 00 ....................................... Operator payout script size (0)
| .......................................... Operator payout script (Empty)
|
| a9569d037b0eacc8bca05c5829c95283
| 4ac27d1c7e7df610500b7ba70fd46507 ......... Inputs hash
|
| Payload signature (BLS)
| 0267702ef85d186ef7fa32dc40c65f2f
| eca0a7465715eb7c30f81beb69e35ee4
| 1f6ff7f292b82a9caebb5aa961b0f915
| 02501becf629e93c0a01c76162d56a6c
| 65a9675c3ca9d5297f053e68f91393dd
| 789beed8ef7e8839695a334c2e1bd37c ......... BLS Signature (96 bytes)
{% endhighlight %}

{% endautocrossref %}

#### ProUpRegTx
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70213 of Dash Core as described by DIP3*

The Masternode Provider Update Registrar (ProUpRegTx) special transaction is used
by a masternode owner to update masternode metadata (e.g. operator/voting key
details or the payout script).

A ProUpRegTx is created and sent using the `protx update_registrar` RPC.

The special transaction type is 3 and the extra payload consists of the following
data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | Provider update registrar transaction version number. Currently set to 1.
| 32 | proTXHash | uint256 | The hash of the initial ProRegTx
| 2 | mode | uint_16 | Masternode mode. Default set to 0.
| 48 | PubKeyOperator | CBLSPublicKey | The BLS public key used for operational related signing (network messages, ProTx updates)
| 20 | KeyIdVoting | CKeyID | The public key hash used for voting.
| 1-9 | scriptPayoutSize | compactSize uint | Size of the Payee Script.
| Variable | scriptPayout | Script | Payee script (p2pkh/p2sh)
| 32 | inputsHash | uint256 | Hash of all the outpoints of the transaction inputs
| 1-9 | payloadSigSize |compactSize uint | Size of the Signature
| Variable | payloadSig | vector | Signature of the hash of the ProTx fields. Signed with the key corresponding to the collateral outpoint in case the collateral is not part of the ProRegTx itself, empty otherwise.

The following annotated hexdump shows a ProUpRegTx transaction referencing an
existing collateral. (Parts of the classical transaction section have been omitted.)

<!--devnet-dashdocs getrawtransaction 702390ef06b10c174841ad7b863df23c166c27815e3be2438e2fee6f87882b91 true-->

{% highlight text %}
0300 ....................................... Version (3)
0300 ....................................... Type (3 - ProUpRegTx)

[...] ...................................... Transaction inputs omitted
[...] ...................................... Transaction outputs omitted

00000000 ................................... locktime: 0 (a block height)

e4 ......................................... Extra payload size (228)

ProRegTx Payload
| 0100 ..................................... Version (1)
|
| ddaf13bf1b02de39711de911e646c63e
| f089b6cee786a1b776086ae130331bba ......... ProRegTx Hash
|
| 0000 ..................................... Mode (0)
|
| 0e02146e9c34cfbcb3f3037574a1abb35525e2ca
| 0c3c6901dbf82ac591e30218d1711223b7ca956e
| df39f3d984d06d51 ......................... Operator public key (BLS)
| 757a2171bbf92517e358249f20c37a8ad2d7a5bc . Voting pubkey hash (ECDSA)
|
| Payout script
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | 9e648c7e4b61482aa39bd10e0bf0b526
| | | 8768005f ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG
|
| 50b50b24193b2b16f0383125c1f4426e
| 883d256eeadee96d500f8c08b0e0f9e4 ......... Inputs hash
|
| Payload signature
| 41 ....................................... Signature Size (65)
| 1ffa8a27ae0301e414176d4c876cff2e
| 20b810683a68ab7dcea95de1f8f36441
| 4c56368f189a3ef7a59b83bd77f22431
| a73d347841a58768b94c771819dc2bbce3 ....... Signature
{% endhighlight %}

{% endautocrossref %}

#### ProUpRevTx
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70213 of Dash Core as described by DIP3*

The Masternode Operator Revocation (ProUpRevTx) special transaction allows an
operator to revoke their key in case of compromise or if they wish to terminate
service. If a masternode's operator key is revoked, the masternode becomes
ineligible for payment until the owner provides a new operator key (via a ProUpRegTx).

A ProUpRevTx is created and sent using the `protx revoke` RPC.

The special transaction type used for ProUpServTx Transactions is 4 and the extra
payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | ProUpRevTx version number. Currently set to 1.
| 32 | proTXHash | uint256 | The hash of the initial ProRegTx
| 2 | reason | uint_16 | The reason for revoking the key.<br>`0` - Not specified<br>`1` - Termination of Service<br>`2` - Compromised Key<br>`3` - Change of key
| 32 | inputsHash | uint256 | Hash of all the outpoints of the transaction inputs
| 1-9 | payloadSigSize |compactSize uint | Size of the Signature<br>**Note:** not present in BLS implementation
| 96 | payloadSig | vector | BLS Signature of the hash of the ProUpServTx fields. Signed by the Operator.

The following annotated hexdump shows a ProUpRevTx transaction. (Parts of the
classical transaction section have been omitted.)

{% highlight text %}
0300 ....................................... Version (3)
0400 ....................................... Type (4 - ProUpRevTx)

[...] ...................................... Transaction inputs omitted
[...] ...................................... Transaction outputs omitted

00000000 ................................... locktime: 0 (a block height)

a4 ......................................... Extra payload size (164)

ProUpRevTx Payload
| 0100 ..................................... Version (1)
|
| ddaf13bf1b02de39711de911e646c63e
| f089b6cee786a1b776086ae130331bba ......... ProRegTx Hash
|
| 0000 ..................................... Reason: 0 (Not specified)
|
| cb0dfe113c87f8e9cde2c5d18aae12fc
| 8d0617c42c34ca5c2f2f6ab4b1dae164 ......... Inputs hash
|
| Payload signature (BLS)
| 0adaef4bf1a904308f1b0efbdfaffc93
| 864f9e047fd83415c831589180303711
| 0f0d8adb312ab43ddd7f8086042d3f5b
| 09029a6a16c341c9d2a62789b495fef4
| e068da711dac28106ff354db7249ae88
| 05877d82ff7d1af00ae2d303dea5eb3b ......... BLS Signature (96 bytes)
{% endhighlight %}

{% endautocrossref %}

#### CbTx
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70213 of Dash Core as described by DIP4*

The Coinbase (CbTx) special transaction adds information to the block’s coinbase
transaction that enables verification of the deterministic masternode list without
the full chain (e.g. from SPV clients). This allows light-clients to properly
verify InstantSend transactions and support additional deterministic masternode
list functionality in the future.

The special transaction type used for CbTx Transactions is 5 and the extra
payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | CbTx version number. Currently set to 1.
| 4 | height | uint32_t | Height of the block
| 32 | merkleRootMNList | uint256 | Merkle root of the masternode list

The following annotated hexdump shows a CbTx transaction.

<!--devnet-DRA getrawtransaction 072b8eb47a87799a1242a8bd959a9c5eab93a346700d2f674420cfea70b2ed1c true-->

An itemized coinbase transaction:

{% highlight text %}
0300 ....................................... Version (3)
0500 ....................................... Type (5 - Coinbase)

01 ......................................... Number of inputs
| 00000000000000000000000000000000
| 00000000000000000000000000000000 ......... Previous outpoint TXID
| ffffffff ................................. Previous outpoint index
|
| 05 ....................................... Bytes in coinbase: 5
| |
| | 02 ..................................... Bytes in height
| | | 0608 ................................. Height: 2054
| |
| | 0101 ................................... Arbitrary data
| ffffffff ................................. Sequence

02 ......................................... Output count
| Transaction Output 1
| | 00902f5009000000 ....................... Duffs (400 DASH)
| | 2102c633b7022b4dab169c8a8459d83b7e0
| | 6e0f8da0f89bf7e788ec98c8038107989ac .... Script
|
| Transaction Output 2
| | 00e40b5402000000 ....................... Duffs (100 DASH)
| | 1976a914ebafa153cffbb5b37c30fb93
| | 886f2fe0f1d549ed88ac ................... P2PKH script

00000000 ................................... Locktime

26 ......................................... Extra payload size (38)

Coinbase Transaction Payload
| 0100 ..................................... Version (1)
|
| 06080000 ................................. Block height: 2054
|
| 69010fa8b729b53c78a1e209946c82e2
| 3159439022ea4055aa60d4393fffba46 ......... MN List merkle root
{% endhighlight %}

{% endautocrossref %}

#### QcTx
{% include helpers/subhead-links.md %}

{% autocrossref %}

*Added in protocol version 70213 of Dash Core as described by DIP6*

**NOTE: This special transaction has no inputs and no outputs and thus also
pays no fee.**

The Quorum Commitment (QcTx) special transaction adds the best final commitment from a
Long-Living Masternode Quorum (LLMQ) Distributed Key Generation (DKG) session to
the chain.

Since this special transaction pays no fees, it is mandatory by consensus rules
to ensure that miners include it. Exactly one quorum commitment transaction MUST
be included in every block while in the mining phase of the LLMQ process until a
valid commitment is present in a block.

If a DKG failed or a miner did not receive a final commitment in-time, a null
commitment has to be included in the special transaction payload. A null
commitment must have the `signers` and `validMembers` bitsets set to the
`quorumSize` and all bits set to zero. All other fields must be set to the null
representation of the field’s types.

The special transaction type used for Quorum Commitment Transactions is 6 and
the extra payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | Quorum Commitment version number. Currently set to 1.
| 4 | height | uint32_t | Height of the block
| Variable | commitment | qfcommit | The payload of the `qfcommit` message

The following annotated hexdump shows a QcTx transaction.

<!--getrawtransaction f218f2d5b8003bc530016dc510b3d982a5cf43ff76313b991ac5aa90a91065b7 true-->

An itemized quorum commitment transaction:

{% highlight text %}
0300 ....................................... Version (3)
0600 ....................................... Type (6 - Quorum Commitment)

00 ......................................... Number of inputs
00 ......................................... Number of outputs

00000000 ................................... Locktime

fd4901 ..................................... Extra payload size (329)

Quorum Commitment Transaction Payload
| 0100 ..................................... Version (1)
|
| 921d0000 ................................. Block height: 7570
|
| Payload from the qfcommit message
| | 01 ..................................... LLMQ Type (1)
| |
| | 8d80561839648b844ade10b6e81069fa
| | 6c4bde6166dd59242be3487a00000000 ....... Quorum hash
| |
| | 32 ..................................... Number of signers (50)
| | ff7effffbebe02 ......................... Aggregrated signers bitvector
| |
| | 32 ..................................... Number of valid members (50)
| | ff7effffbebe02 ......................... Valid members bitvector
| |
| | 81d0717b893b557f54daacbd060bcffa
| | 2dc341175d0b89c7974dc57ef482ae27
| | e10fb273eda534596993999950817cd4 ....... Quorum public key (BLS)
| |
| | ed93bc215d15350bd7030be811cf1df2
| | c114f6b34df9bd4095161af93608ed90 ....... Quorum verification vector hash
| |
| | Quorum threshold signature (BLS)
| | 8d2bbb0b9c5b8626eb852ea0ff4f2509
| | 19becc2d24653910fb8e11cf5573062f
| | 9f64c03a5031f1d462163ce98e8bf78a
| | 1470f7074a8e6fe23ccb53d73635ecd5
| | ad71b26a938fc21638bcae7d272af9fa
| | 919f296a17e77191e3d4c708bc6e1b9a ....... BLS Signatures (96 bytes)
| |
| | Aggregated signatures from all commitments (BLS)
| | 19e702ff84ff851312cceba1de528ee7
| | ffe33647ae28ef895b35558512901394
| | b430c804c7c42494a3312545606b5598
| | 0480985494fa2c49f50c65d47570380f
| | 13c2851ce33d8584b64e8b659146d732
| | 67d821c78d09ba7caea3d03641f78c7a ....... BLS Signature (96 bytes)
{% endhighlight %}

{% endautocrossref %}

### CompactSize Unsigned Integers
{% include helpers/subhead-links.md %}

{% autocrossref %}

The raw transaction format and several peer-to-peer network messages use
a type of variable-length integer to indicate the number of bytes in a
following piece of data.

Dash Core code and this document refers to these variable length
integers as compactSize. Many other documents refer to them as var_int
or varInt, but this risks conflation with other variable-length integer
encodings---such as the CVarInt class used in Dash Core for
serializing data to disk.  Because it's used in the transaction format,
the format of compactSize unsigned integers is part of the consensus
rules.

For numbers from 0 to 252 (0xfc), compactSize unsigned integers look like
regular unsigned integers. For other numbers up to 0xffffffffffffffff, a
byte is prefixed to the number to indicate its length---but otherwise
the numbers look like regular unsigned integers in little-endian order.

| Value                                   | Bytes Used | Format
|-----------------------------------------|------------|-----------------------------------------
| >= 0 && <= 0xfc (252)                   | 1          | uint8_t
| >= 0xfd (253) && <= 0xffff              | 3          | 0xfd followed by the number as uint16_t
| >= 0x10000 && <= 0xffffffff             | 5          | 0xfe followed by the number as uint32_t
| >= 0x100000000 && <= 0xffffffffffffffff | 9          | 0xff followed by the number as uint64_t

For example, the number 515 is encoded as 0xfd0302.

{% endautocrossref %}
