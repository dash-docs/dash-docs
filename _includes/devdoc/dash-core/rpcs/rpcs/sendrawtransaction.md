{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/sendrawtransaction.md" %}

##### SendRawTransaction
{% include helpers/subhead-links.md %}

{% assign summary_sendRawTransaction="validates a transaction and broadcasts it to the peer-to-peer network." %}

{% autocrossref %}

The `sendrawtransaction` RPC {{summary_sendRawTransaction}}

*Parameter #1---a serialized transaction to broadcast*

{% itemplate ntpd1 %}
- n: "Transaction"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The serialized transaction to broadcast encoded as hex"

{% enditemplate %}

*Parameter #2--whether to allow high fees*

{% itemplate ntpd1 %}
- n: "Allow High Fees"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to `true` to allow the transaction to pay a high transaction fee.  Set to `false` (the default) to prevent Bitcoin Core from broadcasting the transaction if it includes a high fee.  Transaction fees are the sum of the inputs minus the sum of the outputs, so this high fees check helps ensures user including a change address to return most of the difference back to themselves"

{% enditemplate %}

*Parameter #3--whether to use InstantSend*

{% itemplate ntpd1 %}
- n: "Use InstantSend"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "*Depcrecated and ignored since Dash Core 0.14.1*"

{% enditemplate %}

*Result---a TXID or error message*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "null/string (hex)"
  p: "Required<br>(exactly 1)"
  d: "If the transaction was accepted by the node for broadcast, this will be the TXID of the transaction encoded as hex in RPC byte order.  If the transaction was rejected by the node, this will set to `null`, the JSON-RPC error field will be set to a code, and the JSON-RPC message field may contain an informative error message"

{% enditemplate %}

*Examples from Dash Core 0.12.2*

Broadcast a signed transaction:

{% highlight bash %}
dash-cli -testnet sendrawtransaction 01000000016b490886c0198b\
028c6c5cb145c4eb3b1055a224a7a105aadeff41b69ec91e0601000000694630\
43022033a61c56fa0867ed67b76b023204a9dc0ee6b0d63305dc5f65fe943354\
45ff2f021f712f55399d5238fc7146497c431fc4182a1de0b96fc22716e0845f\
561d542e012102eacba539d92eb88d4e73bb32749d79f53f6e8d7947ac40a71b\
d4b26c13b6ec29ffffffff0200205fa0120000001976a914485485425fa99504\
ec1638ac4213f3cfc9f32ef388acc0a8f9be010000001976a914811eacc14db8\
ebb5b64486dc43400c0226b428a488ac00000000
{% endhighlight %}

Result:

{% highlight text %}
2f124cb550d9967b81914b544dea3783de23e85d67a9816f9bada665ecfe1cd5
{% endhighlight %}

*See also*

* [CombineRawTransaction][rpc combinerawtransaction]: {{summary_combineRawTransaction}}
* [CreateRawTransaction][rpc createrawtransaction]: {{summary_createRawTransaction}}
* [DecodeRawTransaction][rpc decoderawtransaction]: {{summary_decodeRawTransaction}}
* [SignRawTransaction][rpc signrawtransaction]: {{summary_signRawTransaction}}

{% endautocrossref %}
