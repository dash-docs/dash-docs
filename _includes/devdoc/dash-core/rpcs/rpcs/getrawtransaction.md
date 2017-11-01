{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getrawtransaction.md" %}

##### GetRawTransaction
{% include helpers/subhead-links.md %}

{% assign summary_getRawTransaction="gets a hex-encoded serialized transaction or a JSON object describing the transaction. By default, Dash Core only stores complete transaction data for UTXOs and your own transactions, so the RPC may fail on historic transactions unless you use the non-default `txindex=1` in your Dash Core startup settings." %}

{% autocrossref %}

The `getrawtransaction` RPC {{summary_getRawTransaction}}

{{reindexNote}}

*Parameter #1---the TXID of the transaction to get*

{% itemplate ntpd1 %}
- n: "TXID"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the transaction to get, encoded as hex in RPC byte order"

{% enditemplate %}

*Parameter #2---whether to get the serialized or decoded transaction*

{% itemplate ntpd1 %}
- n: "Format"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "For Dash:<br>Set to `0` (the default) to return the serialized transaction as hex.  Set to `1` to return a decoded transaction.<br><br>*Updated in Bitcoin Core 0.14.0*<br><br>Set to `false` (the default) to return the serialized transaction as hex.  Set to `true` to return a decoded transaction.  Before 0.14.0, use `0` and `1`, respectively"

{% enditemplate %}

*Result (if transaction not found)---`null`*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "null"
  p: "Required<br>(exactly 1)"
  d: "If the transaction wasn't found, the result will be JSON `null`.  This can occur because the transaction doesn't exist in the block chain or memory pool, or because it isn't part of the transaction index.  See the Dash Core `-help` entry for `-txindex`"

{% enditemplate %}

*Result (if verbose=`false`)---the serialized transaction*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "If the transaction was found, this will be the serialized transaction encoded as hex"

{% enditemplate %}

*Result (if verbose=`true`)---the decoded transaction*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "If the transaction was found, this will be an object describing it"

- n: "{{DEPTH}} →<br>`hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The serialized, hex-encoded data for the provided `txid`"   
{{INCLUDE_DECODE_RAW_TRANSACTION}}
- n: "→<br>`blockhash`"
  t: "string (hex)"
  p: "Optional<br>(0 or 1)"
  d: "If the transaction has been included in a block on the local best block chain, this is the hash of that block encoded as hex in RPC byte order"

- n: "→<br>`confirmations`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "If the transaction has been included in a block on the local best block chain, this is how many confirmations it has.  Otherwise, this is `0`"

- n: "→<br>`time`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "If the transaction has been included in a block on the local best block chain, this is the block header time of that block (may be in the future)"

- n: "→<br>`blocktime`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "This field is currently identical to the time field described above"

{% enditemplate %}

*Examples from Dash Core 0.12.2*

A transaction in serialized transaction format:

{% highlight bash %}
dash-cli getrawtransaction \
  2f124cb550d9967b81914b544dea3783de23e85d67a9816f9bada665ecfe1cd5
{% endhighlight %}

Result (wrapped):

{% highlight text %}
01000000016b490886c0198b028c6c5cb145c4eb3b1055a224a7a105aadeff41\
b69ec91e060100000069463043022033a61c56fa0867ed67b76b023204a9dc0e\
e6b0d63305dc5f65fe94335445ff2f021f712f55399d5238fc7146497c431fc4\
182a1de0b96fc22716e0845f561d542e012102eacba539d92eb88d4e73bb3274\
9d79f53f6e8d7947ac40a71bd4b26c13b6ec29ffffffff0200205fa012000000\
1976a914485485425fa99504ec1638ac4213f3cfc9f32ef388acc0a8f9be0100\
00001976a914811eacc14db8ebb5b64486dc43400c0226b428a488ac00000000
{% endhighlight %}

Get the same transaction in JSON:

{% highlight bash %}
dash-cli getrawtransaction \
2f124cb550d9967b81914b544dea3783de23e85d67a9816f9bada665ecfe1cd5 \
1
{% endhighlight %}

Result:

{% highlight json %}
{
  "hex": "01000000016b490886c0198b028c6c5cb145c4eb3b1055a224a7a105aadeff41b69ec91e060100000069463043022033a61c56fa0867ed67b76b023204a9dc0ee6b0d63305dc5f65fe94335445ff2f021f712f55399d5238fc7146497c431fc4182a1de0b96fc22716e0845f561d542e012102eacba539d92eb88d4e73bb32749d79f53f6e8d7947ac40a71bd4b26c13b6ec29ffffffff0200205fa0120000001976a914485485425fa99504ec1638ac4213f3cfc9f32ef388acc0a8f9be010000001976a914811eacc14db8ebb5b64486dc43400c0226b428a488ac00000000",
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
      "value": 874.99879200,
      "valueSat": 87499879200,
      "address": "yNpezfFDfoikDuT1f4iK75AiLp2YLPsGAb",
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
  ],
  "blockhash": "00000000e679e76eabc913b15c7f202e7ea831b8fb07beb28ca2a047b03ff3cc",
  "height": 19560,
  "confirmations": 6,
  "time": 1509568811,
  "blocktime": 1509568811
}
{% endhighlight %}

*See also*

* [GetTransaction][rpc gettransaction]: {{summary_getTransaction}}

{% endautocrossref %}
