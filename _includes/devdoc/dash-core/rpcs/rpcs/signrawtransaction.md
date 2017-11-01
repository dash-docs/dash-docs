{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/signrawtransaction.md" %}

##### SignRawTransaction
{% include helpers/subhead-links.md %}

{% assign summary_signRawTransaction="signs a transaction in the serialized transaction format using private keys stored in the wallet or provided in the call." %}

{% autocrossref %}

The `signrawtransaction` RPC {{summary_signRawTransaction}}

*Parameter #1---the transaction to sign*

{% itemplate ntpd1 %}
- n: "Transaction"
  t: "string (hex"
  p: "Required<br>(exactly 1)"
  d: "The transaction to sign as a serialized transaction"

{% enditemplate %}

*Parameter #2---unspent transaction output details*

{% itemplate ntpd1 %}
- n: "Dependencies"
  t: "array"
  p: "Optional<br>(0 or 1)"
  d: "The previous outputs being spent by this transaction"

- n: "→<br>Output"
  t: "object"
  p: "Optional<br>(0 or more)"
  d: "An output being spent"

- n: "→ →<br>`txid`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the transaction the output appeared in.  The TXID must be encoded in hex in RPC byte order"

- n: "→ →<br>`vout`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The index number of the output (vout) as it appeared in its transaction, with the first output being 0"

- n: "→ →<br>`scriptPubKey`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The output's pubkey script encoded as hex"

- n: "→ →<br>`redeemScript`"
  t: "string (hex)"
  p: "Optional<br>(0 or 1)"
  d: "If the pubkey script was a script hash, this must be the corresponding redeem script"

{% enditemplate %}

*Parameter #3---private keys for signing*

{% itemplate ntpd1 %}
- n: "Private Keys"
  t: "array"
  p: "Optional<br>(0 or 1)"
  d: "An array holding private keys.  If any keys are provided, only they will be used to sign the transaction (even if the wallet has other matching keys).  If this array is empty or not used, and wallet support is enabled, keys from the wallet will be used"

- n: "→<br>Key"
  t: "string (base58)"
  p: "Required<br>(1 or more)"
  d: "A private key in base58check format to use to create a signature for this transaction"

{% enditemplate %}

*Parameter #4---signature hash type*

{% itemplate ntpd1 %}
- n: "SigHash"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "The type of signature hash to use for all of the signatures performed.  (You must use separate calls to the `signrawtransaction` RPC if you want to use different signature hash types for different signatures.  The allowed values are: `ALL`, `NONE`, `SINGLE`, `ALL|ANYONECANPAY`, `NONE|ANYONECANPAY`, and `SINGLE|ANYONECANPAY`"

{% enditemplate %}

*Result---the transaction with any signatures made*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "The results of the signature"

- n: "→<br>`hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The resulting serialized transaction encoded as hex with any signatures made inserted.  If no signatures were made, this will be the same transaction provided in parameter #1"

- n: "→<br>`complete`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "The value `true` if transaction is fully signed; the value `false` if more signatures are required"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Sign the hex generated in the example section for the `createrawtransaction`
RPC:

{% highlight bash %}
dash-cli -testnet signrawtransaction signrawtransaction 01000000016b4908\
86c0198b028c6c5cb145c4eb3b1055a224a7a105aadeff41b69ec91e060100000000ffff\
ffff0200205fa0120000001976a914485485425fa99504ec1638ac4213f3cfc9f32ef388\
acc0a8f9be010000001976a914811eacc14db8ebb5b64486dc43400c0226b428a488ac00\
000000
{% endhighlight %}

Result:

{% highlight json %}
{
  "hex": "01000000016b490886c0198b028c6c5cb145c4eb3b1055a224a7a105aadeff41b69ec91e060100000069463043022033a61c56fa0867ed67b76b023204a9dc0ee6b0d63305dc5f65fe94335445ff2f021f712f55399d5238fc7146497c431fc4182a1de0b96fc22716e0845f561d542e012102eacba539d92eb88d4e73bb32749d79f53f6e8d7947ac40a71bd4b26c13b6ec29ffffffff0200205fa0120000001976a914485485425fa99504ec1638ac4213f3cfc9f32ef388acc0a8f9be010000001976a914811eacc14db8ebb5b64486dc43400c0226b428a488ac00000000",
  "complete": true
}
{% endhighlight %}

*See also*

* [CreateRawTransaction][rpc createrawtransaction]: {{summary_createRawTransaction}}
* [DecodeRawTransaction][rpc decoderawtransaction]: {{summary_decodeRawTransaction}}
* [SendRawTransaction][rpc sendrawtransaction]: {{summary_sendRawTransaction}}

{% endautocrossref %}
