{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getrawtransaction.md" %}

##### GetRawTransaction
{% include helpers/subhead-links.md %}

<!-- __ -->

{% assign summary_getRawTransaction="gets a hex-encoded serialized transaction or a JSON object describing the transaction. By default, Dash Core only stores complete transaction data for UTXOs and your own transactions, so the RPC may fail on historic transactions unless you use the non-default `txindex=1` in your Dash Core startup settings." %}

{% autocrossref %}

The `getrawtransaction` RPC {{summary_getRawTransaction}}

Note: By default this function only works for mempool transactions. If the
`-txindex` option is enabled, it also works for blockchain transactions. For now,
it also works for transactions with unspent outputs although this feature is
deprecated.

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
  d: "*Updated in Dash Core 0.12.3 / Bitcoin Core 0.14.0*<br><br>Set to `false` (the default) to return the serialized transaction as hex.  Set to `true` to return a decoded transaction.  Before 0.12.3, use `0` and `1`, respectively"

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

- n: "<br>`instantlock`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "If set to `true`, this transaction is locked"

{% enditemplate %}

*Examples from Dash Core 0.13.0*

A classical transaction in serialized transaction format:

{% highlight bash %}
dash-cli getrawtransaction \
  f4de3be04efa18e203c9d0b7ad11bb2517f5889338918ed300a374f5bd736ed7
{% endhighlight %}

Result (wrapped):

{% highlight text %}
02000000015d0b26079696875e9fc3cb480420aae3c8b1da628fbb14cc718066\
df7fe7c5fd010000006a47304402202cfa683981898ad9adb8953423a38f7185\
ed41e163aa195d608fbe5bc3034910022034e2376aaed1c6576c0dad79d626ee\
27f706baaed86dabb105979c3e6f6e1cb9012103d14eb001cf0908f3a2333d17\
1f6236497a82318a6a6f649b4d7fd8e5c8922e08feffffff021e3f4b4c000000\
001976a914b02ae52066542b4aec5cf45c7cae3183d7bd322788ac00f9029500\
0000001976a914252c9de3a0ebd5c95886187b24969d4ccdb5576e88ac943d0000
{% endhighlight %}

Get the same transaction in JSON:

{% highlight bash %}
dash-cli getrawtransaction \
f4de3be04efa18e203c9d0b7ad11bb2517f5889338918ed300a374f5bd736ed7 \
1
{% endhighlight %}

Result:

{% highlight json %}
{
  "hex": "02000000015d0b26079696875e9fc3cb480420aae3c8b1da628fbb14cc718066df7fe7c5fd010000006a47304402202cfa683981898ad9adb8953423a38f7185ed41e163aa195d608fbe5bc3034910022034e2376aaed1c6576c0dad79d626ee27f706baaed86dabb105979c3e6f6e1cb9012103d14eb001cf0908f3a2333d171f6236497a82318a6a6f649b4d7fd8e5c8922e08feffffff021e3f4b4c000000001976a914b02ae52066542b4aec5cf45c7cae3183d7bd322788ac00f90295000000001976a914252c9de3a0ebd5c95886187b24969d4ccdb5576e88ac943d0000",
  "txid": "f4de3be04efa18e203c9d0b7ad11bb2517f5889338918ed300a374f5bd736ed7",
  "size": 225,
  "version": 2,
  "type": 0,
  "locktime": 15764,
  "vin": [
    {
      "txid": "fdc5e77fdf668071cc14bb8f62dab1c8e3aa200448cbc39f5e87969607260b5d",
      "vout": 1,
      "scriptSig": {
        "asm": "304402202cfa683981898ad9adb8953423a38f7185ed41e163aa195d608fbe5bc3034910022034e2376aaed1c6576c0dad79d626ee27f706baaed86dabb105979c3e6f6e1cb9[ALL] 03d14eb001cf0908f3a2333d171f6236497a82318a6a6f649b4d7fd8e5c8922e08",
        "hex": "47304402202cfa683981898ad9adb8953423a38f7185ed41e163aa195d608fbe5bc3034910022034e2376aaed1c6576c0dad79d626ee27f706baaed86dabb105979c3e6f6e1cb9012103d14eb001cf0908f3a2333d171f6236497a82318a6a6f649b4d7fd8e5c8922e08"
      },
      "sequence": 4294967294
    }
  ],
  "vout": [
    {
      "value": 12.79999774,
      "valueSat": 1279999774,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 b02ae52066542b4aec5cf45c7cae3183d7bd3227 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914b02ae52066542b4aec5cf45c7cae3183d7bd322788ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "ycNwAN4DQ7Xnw5XLKg84SR4U1GE22FfLNQ"
        ]
      }
    },
    {
      "value": 25.00000000,
      "valueSat": 2500000000,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 252c9de3a0ebd5c95886187b24969d4ccdb5576e OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914252c9de3a0ebd5c95886187b24969d4ccdb5576e88ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yPi1JKw5fn8bMFsCCtnkGagogW6GXwGktZ"
        ]
      }
    }
  ],
  "blockhash": "0000000005f395d62a40ef9f2a13000bd4076e2131c8671db8333a5b31e4403f",
  "height": 15765,
  "confirmations": 1,
  "time": 1546278750,
  "blocktime": 1546278750,
  "instantlock": true
}
{% endhighlight %}


A special transaction (CbTx) in serialized transaction format:

{% highlight bash %}
dash-cli getrawtransaction \
  414a3911a274053beb867c79ad9a19bf508041554f147a1a2c73f8f9bc029717
{% endhighlight %}

Result (wrapped):

{% highlight text %}
0300050001000000000000000000000000000000000000000000000000000000\
0000000000ffffffff4b02953d045e572a5c08fabe6d6d666637343633363633\
3230616162346432366264616530386339366263623534010000000000000010\
00000eaf0000000d2f6e6f64655374726174756d2f0000000002b4e322370100\
00001976a914cb594917ad4e5849688ec63f29a0f7f3badb5da688acaae32237\
010000001976a914a3c5284d3cd896815ac815f2dd76a3a71cb3d8e688ac0000\
0000260100953d00007b8577a1c051bcab40e08c72209f3eddc476d859c8054c\
57a7287700b2de2db4
{% endhighlight %}

Get the same transaction in JSON:

{% highlight bash %}
dash-cli getrawtransaction \
414a3911a274053beb867c79ad9a19bf508041554f147a1a2c73f8f9bc029717 \
1
{% endhighlight %}

Result:

{% highlight json %}
{
  "hex": "03000500010000000000000000000000000000000000000000000000000000000000000000ffffffff4b02953d045e572a5c08fabe6d6d666637343633363633323061616234643236626461653038633936626362353401000000000000001000000eaf0000000d2f6e6f64655374726174756d2f0000000002b4e32237010000001976a914cb594917ad4e5849688ec63f29a0f7f3badb5da688acaae32237010000001976a914a3c5284d3cd896815ac815f2dd76a3a71cb3d8e688ac00000000260100953d00007b8577a1c051bcab40e08c72209f3eddc476d859c8054c57a7287700b2de2db4",
  "txid": "414a3911a274053beb867c79ad9a19bf508041554f147a1a2c73f8f9bc029717",
  "size": 233,
  "version": 3,
  "type": 5,
  "locktime": 0,
  "vin": [
    {
      "coinbase": "02953d045e572a5c08fabe6d6d666637343633363633323061616234643236626461653038633936626362353401000000000000001000000eaf0000000d2f6e6f64655374726174756d2f",
      "sequence": 0
    }
  ],
  "vout": [
    {
      "value": 52.20000692,
      "valueSat": 5220000692,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 cb594917ad4e5849688ec63f29a0f7f3badb5da6 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914cb594917ad4e5849688ec63f29a0f7f3badb5da688ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yereyozxENB9jbhqpbg1coE5c39ExqLSaG"
        ]
      }
    },
    {
      "value": 52.20000682,
      "valueSat": 5220000682,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 a3c5284d3cd896815ac815f2dd76a3a71cb3d8e6 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914a3c5284d3cd896815ac815f2dd76a3a71cb3d8e688ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "ybFPBD7hm9KVd2Dubj97K5mw2ymR8gWJre"
        ]
      }
    }
  ],
  "extraPayloadSize": 38,
  "extraPayload": "0100953d00007b8577a1c051bcab40e08c72209f3eddc476d859c8054c57a7287700b2de2db4",
  "cbTx": {
    "version": 1,
    "height": 15765,
    "merkleRootMNList": "b42ddeb2007728a7574c05c859d876c4dd3e9f20728ce040abbc51c0a177857b"
  },
  "blockhash": "0000000005f395d62a40ef9f2a13000bd4076e2131c8671db8333a5b31e4403f",
  "height": 15765,
  "confirmations": 5,
  "time": 1546278750,
  "blocktime": 1546278750,
  "instantlock": false
}
{% endhighlight %}

*See also*

* [GetTransaction][rpc gettransaction]: {{summary_getTransaction}}

{% endautocrossref %}
