{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rest/requests/get_tx.md" %}

##### GET Tx
{% include helpers/subhead-links.md %}

{% assign summary_restGetTx="gets a hex-encoded serialized transaction or a JSON object describing the transaction. By default, Dash Core only stores complete transaction data for UTXOs and your own transactions, so this method may fail on historic transactions unless you use the non-default `txindex=1` in your Dash Core startup settings." %}
<!-- __ -->
{% autocrossref %}

The `GET tx` operation {{summary_restGetTx}}

{{reindexNote}}

*Request*

{% highlight text %}
GET /tx/<txid>.<format>
{% endhighlight %}

*Parameter #1---the TXID of the transaction to retrieve*

{% itemplate ntpd1 %}
- n: "TXID"
  t: "path (hex)"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the transaction to get, encoded as hex in RPC byte order"

{% enditemplate %}

*Parameter #2---the output format*

{% itemplate ntpd1 %}
- n: "Format"
  t: "suffix"
  p: "Required<br>(exactly 1)"
  d: "Set to `.json` for decoded transaction contents in JSON, or `.bin` or `hex` for a serialized transaction in binary or hex"

{% enditemplate %}

*Response as JSON*

{% assign DEPTH="" %}
{% include helpers/vars.md %}

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object describing the request transaction"

{{INCLUDE_DECODE_RAW_TRANSACTION}}
- n: "→<br>`blockhash`"
  t: "string (hex)"
  p: "Optional<br>(0 or 1)"
  d: "If the transaction has been included in a block on the local best block chain, this is the hash of that block encoded as hex in RPC byte order"

- n: "→<br>`height`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The height of this block on its block chain"

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

Request a transaction in hex-encoded serialized transaction format:

{% highlight bash %}
curl http://localhost:19998/rest/tx/b06edec446fbcc0fc04a6e2774a843823f5238c2e15de40e61767a44f6788d32.hex
{% endhighlight %}

Result (wrapped):

{% highlight text %}
0100000001c91d4bb14e061f8f6b775ca8e62ec8a66739b375f169bce1964cee\
a2368197e5000000006a473044022050644e406be3e463d94868c617309dc021\
174551dbb340665f48119e110a72b2022022f3cc93deeb4c44ce70bebe8e7f0f\
69c462f120eb64b47eeb77f0a62e9bd361012102f542dde7c155717ac8df05d0\
fc8f65e2ecc078ecad42b23462f27832b441ffa5feffffff0200e1f505000000\
001976a91443d11ad5889532f22f069b18b24489b1f94f253188ac7dbafa0800\
0000001976a914bb900427682b8f7cae6779fb955a610ff71d68c888acce940000
{% endhighlight %}

Get the same transaction in JSON:

{% highlight bash %}
curl http://localhost:19998/rest/tx/b06edec446fbcc0fc04a6e2774a843823f5238c2e15de40e61767a44f6788d32.json
{% endhighlight %}

Result (whitespaced added):

{% highlight json %}
{  
   "txid":"b06edec446fbcc0fc04a6e2774a843823f5238c2e15de40e61767a44f6788d32",
   "size":225,
   "version":1,
   "locktime":38094,
   "vin":[  
      {  
         "txid":"e5978136a2ee4c96e1bc69f175b33967a6c82ee6a85c776b8f1f064eb14b1dc9",
         "vout":0,
         "scriptSig":{  
            "asm":"3044022050644e406be3e463d94868c617309dc021174551dbb340665f48119e110a72b2022022f3cc93deeb4c44ce70bebe8e7f0f69c462f120eb64b47eeb77f0a62e9bd361[ALL] 02f542dde7c155717ac8df05d0fc8f65e2ecc078ecad42b23462f27832b441ffa5",
            "hex":"473044022050644e406be3e463d94868c617309dc021174551dbb340665f48119e110a72b2022022f3cc93deeb4c44ce70bebe8e7f0f69c462f120eb64b47eeb77f0a62e9bd361012102f542dde7c155717ac8df05d0fc8f65e2ecc078ecad42b23462f27832b441ffa5"
         },
         "sequence":4294967294
      }
   ],
   "vout":[  
      {  
         "value":1.00000000,
         "valueSat":100000000,
         "n":0,
         "scriptPubKey":{  
            "asm":"OP_DUP OP_HASH160 43d11ad5889532f22f069b18b24489b1f94f2531 OP_EQUALVERIFY OP_CHECKSIG",
            "hex":"76a91443d11ad5889532f22f069b18b24489b1f94f253188ac",
            "reqSigs":1,
            "type":"pubkeyhash",
            "addresses":[  
               "ySW2cuvm2wJ4EU5KzX4waYfFPV3xQni6Nm"
            ]
         }
      },
      {  
         "value":1.50649469,
         "valueSat":150649469,
         "n":1,
         "scriptPubKey":{  
            "asm":"OP_DUP OP_HASH160 bb900427682b8f7cae6779fb955a610ff71d68c8 OP_EQUALVERIFY OP_CHECKSIG",
            "hex":"76a914bb900427682b8f7cae6779fb955a610ff71d68c888ac",
            "reqSigs":1,
            "type":"pubkeyhash",
            "addresses":[  
               "ydRBjVr78ejCqXuGs2wbtYoFpGbDkqV8V4"
            ]
         }
      }
   ],
   "blockhash":"0000000003b6a57e3614176e5b93caf9498009853e06d16028ebffeb361afda5",
   "height":38095,
   "confirmations":9,
   "time":1512596315,
   "blocktime":1512596315
}
{% endhighlight %}

*See also*

* [GetRawTransaction][rpc getrawtransaction] RPC: {{summary_getRawTransaction}}
* [GetTransaction][rpc gettransaction] RPC: {{summary_getTransaction}}

{% endautocrossref %}
