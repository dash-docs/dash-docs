{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/gettxout.md" %}

##### GetTxOut
{% include helpers/subhead-links.md %}

{% assign summary_getTxOut="returns details about an unspent transaction output (UTXO)." %}
<!-- __ -->
{% autocrossref %}

The `gettxout` RPC {{summary_getTxOut}}

*Parameter #1---the TXID of the output to get*

{% itemplate ntpd1 %}
- n: "TXID"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the transaction containing the output to get, encoded as hex in RPC byte order"

{% enditemplate %}


*Parameter #2---the output index number (vout) of the output to get*

{% itemplate ntpd1 %}
- n: "Vout"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The output index number (vout) of the output within the transaction; the first output in a transaction is vout 0"

{% enditemplate %}

*Parameter #3---whether to display unconfirmed outputs from the memory pool*

{% itemplate ntpd1 %}
- n: "Unconfirmed"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to `true` to display unconfirmed outputs from the memory pool; set to `false` (the default) to only display outputs from confirmed transactions"

{% enditemplate %}

*Result---a description of the output*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object/null"
  p: "Required<br>(exactly 1)"
  d: "Information about the output.  If output wasn't found, if it was spent, or if an error occurred, this will be JSON `null`"

- n: "→<br>`bestblock`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the header of the block on the local best block chain which includes this transaction.  The hash will encoded as hex in RPC byte order.  If the transaction is not part of a block, the string will be empty"

- n: "→<br>`confirmations`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The number of confirmations received for the transaction containing this output or `0` if the transaction hasn't been confirmed yet"

- n: "→<br>`value`"
  t: "number (Dash)"
  p: "Required<br>(exactly 1)"
  d: "The amount of Dash spent to this output.  May be `0`"

- n: "→<br>`scriptPubKey`"
  t: "string : object"
  p: "Optional<br>(0 or 1)"
  d: "An object with information about the pubkey script.  This may be `null` if there was no pubkey script"

- n: "→ →<br>`asm`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The pubkey script in decoded form with non-data-pushing opcodes listed"

- n: "→ →<br>`hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The pubkey script encoded as hex"

- n: "→ →<br>`reqSigs`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "The number of signatures required; this is always `1` for P2PK, P2PKH, and P2SH (including P2SH multisig because the redeem script is not available in the pubkey script).  It may be greater than 1 for bare multisig.  This value will not be returned for `nulldata` or `nonstandard` script types (see the `type` key below)"

- n: "→ →<br>`type`"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "The type of script.  This will be one of the following:<br>• `pubkey` for a P2PK script<br>• `pubkeyhash` for a P2PKH script<br>• `scripthash` for a P2SH script<br>• `multisig` for a bare multisig script<br>• `nulldata` for nulldata scripts<br>• `nonstandard` for unknown scripts"

- n: "→ →<br>`addresses`"
  t: "string : array"
  p: "Optional<br>(0 or 1)"
  d: "The P2PKH or P2SH addresses used in this transaction, or the computed P2PKH address of any pubkeys in this transaction.  This array will not be returned for `nulldata` or `nonstandard` script types"

- n: "→ → →<br>Address"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "A P2PKH or P2SH address"

- n: "→<br>`coinbase`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Set to `true` if the transaction output belonged to a coinbase transaction; set to `false` for all other transactions.  Coinbase transactions need to have 101 confirmations before their outputs can be spent"

{% enditemplate %}

*Example from Dash Core 0.14.1*

Get the UTXO from the following transaction from the first output index ("0"),
searching the memory pool if necessary.


{% highlight bash %}
dash-cli -testnet gettxout \
  e0a06b47f0de6f3851a228d5ac377ac38b495adf04298c43e951e679c5b0aa8f \
  0 true
{% endhighlight %}

Result:

{% highlight json %}
{
  "bestblock": "000000005651f6d7859793dee07d476a2f2a7338e66bbb41caf4b544c5b0318d",
  "confirmations": 2,
  "value": 25.00000000,
  "scriptPubKey": {
    "asm": "OP_DUP OP_HASH160 b66266c5017a759817f3bb99e8d9124bf5bb2e74 OP_EQUALVERIFY OP_CHECKSIG",
    "hex": "76a914b66266c5017a759817f3bb99e8d9124bf5bb2e7488ac",
    "reqSigs": 1,
    "type": "pubkeyhash",
    "addresses": [
      "ycwoiAibTjpwnoCZSX7S4kiB2H8wULw9qo"
    ]
  },
  "coinbase": false
}
{% endhighlight %}

*See also*

* [GetRawTransaction][rpc getrawtransaction]: {{summary_getRawTransaction}}
* [GetTransaction][rpc gettransaction]: {{summary_getTransaction}}

{% endautocrossref %}
