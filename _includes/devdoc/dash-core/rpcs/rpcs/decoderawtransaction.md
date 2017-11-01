{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/decoderawtransaction.md" %}

##### DecodeRawTransaction
{% include helpers/subhead-links.md %}

{% assign summary_decodeRawTransaction="decodes a serialized transaction hex string into a JSON object describing the transaction." %}

{% autocrossref %}

The `decoderawtransaction` RPC {{summary_decodeRawTransaction}}

*Parameter #1---serialized transaction in hex*

{% itemplate ntpd1 %}
- n: "Serialized Transaction"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The transaction to decode in serialized transaction format"

{% enditemplate %}

*Result---the decoded transaction*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object describing the decoded transaction, or JSON `null` if the transaction could not be decoded"

{{INCLUDE_DECODE_RAW_TRANSACTION}}
{% enditemplate %}

*Example from Dash Core 0.12.2*

Decode a signed one-input, two-output transaction:

{% highlight bash %}
dash-cli decoderawtransaction 01000000016b490886c0198b028c6c5cb145c4eb3b10\
55a224a7a105aadeff41b69ec91e060100000069463043022033a61c56fa0867ed67b76b02\
3204a9dc0ee6b0d63305dc5f65fe94335445ff2f021f712f55399d5238fc7146497c431fc4\
182a1de0b96fc22716e0845f561d542e012102eacba539d92eb88d4e73bb32749d79f53f6e\
8d7947ac40a71bd4b26c13b6ec29ffffffff0200205fa0120000001976a914485485425fa9\
9504ec1638ac4213f3cfc9f32ef388acc0a8f9be010000001976a914811eacc14db8ebb5b6\
4486dc43400c0226b428a488ac00000000
{% endhighlight %}

Result:

{% highlight json %}
{
  "txid": "2f124cb550d9967b81914b544dea3783de23e85d67a9816f9bada665ecfe1cd5",
  "size": 224,
  "version": 1,
  "locktime": 0,
  "vin": [
    {
      "txid": "061ec99eb641ffdeaa05a1a724a255103bebc445b15c6c8c028b19c08608496b",
      "vout": 1,
      "scriptSig": {
        "asm": "3043022033a61c56fa0867ed67b76b023204a9dc0ee6b0d63305dc5f65fe94335445ff2f021f712f55399d5238fc7146497c431fc4182a1de0b96fc22716e0845f561d542e[ALL] 02eacba539d92eb88d4e73bb32749d79f53f6e8d7947ac40a71bd4b26c13b6ec29",
        "hex": "463043022033a61c56fa0867ed67b76b023204a9dc0ee6b0d63305dc5f65fe94335445ff2f021f712f55399d5238fc7146497c431fc4182a1de0b96fc22716e0845f561d542e012102eacba539d92eb88d4e73bb32749d79f53f6e8d7947ac40a71bd4b26c13b6ec29"
      },
      "sequence": 4294967295
    }
  ],
  "vout": [
    {
      "value": 800.00000000,
      "valueSat": 80000000000,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 485485425fa99504ec1638ac4213f3cfc9f32ef3 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914485485425fa99504ec1638ac4213f3cfc9f32ef388ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv"
        ]
      }
    },
    {
      "value": 74.99000000,
      "valueSat": 7499000000,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 811eacc14db8ebb5b64486dc43400c0226b428a4 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914811eacc14db8ebb5b64486dc43400c0226b428a488ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yY6AmGopsZS31wy1JLHR9P6AC6owFaXwuh"
        ]
      }
    }
  ]
}
{% endhighlight %}

*See also*

* [CreateRawTransaction][rpc createrawtransaction]: {{summary_createRawTransaction}}
* [SignRawTransaction][rpc signrawtransaction]: {{summary_signRawTransaction}}
* [SendRawTransaction][rpc sendrawtransaction]: {{summary_sendRawTransaction}}

{% endautocrossref %}
