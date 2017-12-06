{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rest/requests/get_getutxos.md" %}

##### GET GetUtxos
{% include helpers/subhead-links.md %}

{% assign summary_restGetGetUtxos="returns an UTXO set given a set of outpoints." %}
<!-- __ -->
{% autocrossref %}

The `GET getutxos` operation {{summary_restGetGetUtxos}}

*Request*

{% highlight text %}
GET /getutxos/<checkmempool>/<txid>-<n>/<txid>-<n>/.../<txid>-<n>.<bin|hex|json>
{% endhighlight %}

*Parameter #1---Include memory pool transactions*

{% itemplate ntpd1 %}
- n: "Check mempool "
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "Set to `checkmempool` to include transactions that are currently in the memory pool to the calculation"

{% enditemplate %}

*Parameter #2---List of Outpoints*

{% itemplate ntpd1 %}
- n: "Outpoint"
  t: "vector"
  p: "Required<br>(1 or more)"
  d: "The list of outpoints to be queried. Each outpoint is the TXID of the transaction, encoded as hex in RPC byte order with an additional `-n` parameter for the output index (vout) number, with the index starting from 0"

{% enditemplate %}

*Parameter #3---the output format*

{% itemplate ntpd1 %}
- n: "Format"
  t: "suffix"
  p: "Required<br>(exactly 1)"
  d: "Set to `.json` for decoded block contents in JSON, or `.bin` or `hex` for a serialized block in binary or hex"

{% enditemplate %}

*Response as JSON*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "The requested UTXO set"

- n: "→→<br>`chainHeight`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The height of the chain at the moment the result was calculated"

- n: "→<br>`chaintipHash`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The block hash of the top of the chain at the moment the result was calculated"

- n: "→<br>`bitmap`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "Whether each requested output was found in the UTXO set or not.  A `1` is returned for those that were found and a `0` is returned for those that were not found.  Results are returned in the same order as outpoints were requested in the input parameters"

- n: "→<br>`utxos`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array of objects each describing an outpoint that is unspent"

- n: "→→`Unspent Outpoint`"
  t: "object"
  p: "Optional<br>(0 or more)"
  d: "A UTXO match based on the query"

- n: "→→→<br>`txvers`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The version number of the transaction the UTXO was found in"

- n: "→<br>`height`"
  t: "number (int)"
  p: "Required (exactly 1)"
  d: "The height of the block containing the defining transaction, or 0x7FFFFFFF if the tx is in the mempool"

- n: "→ → →<br>`value`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The value of the transaction"

- n: "→ → →<br>`scriptPubKey`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object describing the pubkey script"

- n: "→ → → →<br>`asm`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The pubkey script in decoded form with non-data-pushing opcodes listed"

- n: "→ → → →<br>`hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The pubkey script encoded as hex"

- n: "→ → → →<br>`reqSigs`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "The number of signatures required; this is always `1` for P2PK, P2PKH, and P2SH (including P2SH multisig because the redeem script is not available in the pubkey script).  It may be greater than 1 for bare multisig.  This value will not be returned for `nulldata` or `nonstandard` script types (see the `type` key below)"

- n: "→ → → →<br>`type`"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "The type of script.  This will be one of the following:<br>• `pubkey` for a P2PK script<br>• `pubkeyhash` for a P2PKH script<br>• `scripthash` for a P2SH script<br>• `multisig` for a bare multisig script<br>• `nulldata` for nulldata scripts<br>• `nonstandard` for unknown scripts"

- n: "→ → → →<br>`addresses`"
  t: "string : array"
  p: "Optional<br>(0 or 1)"
  d: "Array of P2PKH or P2SH addresses used in this transaction, or the computed P2PKH address of any pubkeys in this transaction.  This array will not be returned for `nulldata` or `nonstandard` script types"

- n: "→ → → → →<br>Address"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "A P2PKH or P2SH address"

{% enditemplate %}

*Examples from Dash Core 0.12.2*

Request the UTXO set:

{% highlight bash %}
curl http://localhost:19998/rest/getutxos/checkmempool/7b6caf68c33794b0bda65e63691739919f13156b57c7ec20a0b4de1f33c580bd-0.hex
{% endhighlight %}

Result (wrapped):

{% highlight bash %}
c39400005ac8db505390f3c77635132117a7fdf07b2eb45c3d9fe38535b77b05\
0000000001010101000000c394000050ae3b16000000001976a9146f4def95a3\
15e83bef5e1197ace4aa7ec55f2ecc88ac
{% endhighlight %}

Same request in JSON:

{% highlight bash %}
curl http://localhost:19998/rest/getutxos/checkmempool/7b6caf68c33794b0bda65e63691739919f13156b57c7ec20a0b4de1f33c580bd-0.json
{% endhighlight %}

Result (whitespaced added):

{% highlight json %}
{  
   "chainHeight":38083,
   "chaintipHash":"00000000057bb73585e39f3d5cb42e7bf0fda71721133576c7f3905350dbc85a",
   "bitmap":"1",
   "utxos":[  
      {  
         "txvers":1,
         "height":38083,
         "value":3.73010000,
         "scriptPubKey":{  
            "asm":"OP_DUP OP_HASH160 6f4def95a315e83bef5e1197ace4aa7ec55f2ecc OP_EQUALVERIFY OP_CHECKSIG",
            "hex":"76a9146f4def95a315e83bef5e1197ace4aa7ec55f2ecc88ac",
            "reqSigs":1,
            "type":"pubkeyhash",
            "addresses":[  
               "yWTyDaMb1KZSRYwrq2DDW3Q4rKYuuPutDS"
            ]
         }
      }
   ]
}
{% endhighlight %}

*See also*

* [GetTxOutSetInfo][rpc gettxoutsetinfo] RPC: {{summary_getTxOutSetInfo}}

{% endautocrossref %}
