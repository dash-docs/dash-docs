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

{{INCLUDE_DECODE_RAW_TRANSACTION}}
- n: "→<br>`hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The serialized, hex-encoded data for the provided `txid`"   

- n: "→<br>`blockhash`"
  t: "string (hex)"
  p: "Optional<br>(0 or 1)"
  d: "If the transaction has been included in a block on the local best block chain, this is the hash of that block encoded as hex in RPC byte order"

- n: "→<br>`height`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "The block height where the transaction was mined"

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
  d: "If set to `true`, this transaction is locked (by InstantSend or a ChainLock)"

- n: "→<br>`instantlock_internal`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "If set to `true`, this transaction has an InstantSend lock"

- n: "<br>`chainlock`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "*Added in Dash Core 0.14.0*<br><br>If set to `true`, this transaction is in a block that is locked (not susceptible to a chain re-org)"

{% enditemplate %}

*Examples from Dash Core 0.14.0*

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
  "txid": "f4de3be04efa18e203c9d0b7ad11bb2517f5889338918ed300a374f5bd736ed7",
  "version": 2,
  "type": 0,
  "size": 225,
  "locktime": 15764,
  "vin": [
    {
      "txid": "fdc5e77fdf668071cc14bb8f62dab1c8e3aa200448cbc39f5e87969607260b5d",
      "vout": 1,
      "scriptSig": {
        "asm": "304402202cfa683981898ad9adb8953423a38f7185ed41e163aa195d608fbe5bc3034910022034e2376aaed1c6576c0dad79d626ee27f706baaed86dabb105979c3e6f6e1cb9[ALL] 03d14eb001cf0908f3a2333d171f6236497a82318a6a6f649b4d7fd8e5c8922e08",
        "hex": "47304402202cfa683981898ad9adb8953423a38f7185ed41e163aa195d608fbe5bc3034910022034e2376aaed1c6576c0dad79d626ee27f706baaed86dabb105979c3e6f6e1cb9012103d14eb001cf0908f3a2333d171f6236497a82318a6a6f649b4d7fd8e5c8922e08"
      },
      "value": 37.80000000,
      "valueSat": 3780000000,
      "address": "yTsGq4wV8WF5GKLaYV2C43zrkr2sfTtysT",
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
      },
      "spentTxId": "85b40136f077cded9587022645fde82389e2f01b0bec697d8cd22ccab930f3d3",
      "spentIndex": 19,
      "spentHeight": 20631
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
      },
      "spentTxId": "90aa8902dbab71c07a5ac06dfe45c5e5fa1f032788b5f916951d0969c9feef39",
      "spentIndex": 1,
      "spentHeight": 24630
    }
  ],
  "hex": "02000000015d0b26079696875e9fc3cb480420aae3c8b1da628fbb14cc718066df7fe7c5fd010000006a47304402202cfa683981898ad9adb8953423a38f7185ed41e163aa195d608fbe5bc3034910022034e2376aaed1c6576c0dad79d626ee27f706baaed86dabb105979c3e6f6e1cb9012103d14eb001cf0908f3a2333d171f6236497a82318a6a6f649b4d7fd8e5c8922e08feffffff021e3f4b4c000000001976a914b02ae52066542b4aec5cf45c7cae3183d7bd322788ac00f90295000000001976a914252c9de3a0ebd5c95886187b24969d4ccdb5576e88ac943d0000",
  "blockhash": "0000000005f395d62a40ef9f2a13000bd4076e2131c8671db8333a5b31e4403f",
  "height": 15765,
  "confirmations": 153657,
  "time": 1546278750,
  "blocktime": 1546278750,
  "instantlock": true,
  "instantlock_internal": false,
  "chainlock": true
}
{% endhighlight %}


A special transaction (CbTx) in serialized transaction format:

{% highlight bash %}
dash-cli getrawtransaction \
  25632685ed0d7286901a80961c924c1ddd952e764754dbd8b40d0956413c8b56
{% endhighlight %}

Result (wrapped):

{% highlight text %}
030005000100000000000000000000000000000000000000000000000000000000000\
00000ffffffff2703ae50011a4d696e656420627920416e74506f6f6c2021000b0120\
1da9196f0000000007000000ffffffff02809e4730000000001976a914cbd7bfcc503\
51180132b2c0698cb90ad74c473c788ac809e4730000000001976a91488a060bc2dfe\
05780ae4dcb6c98b12436c35a93988ac00000000460200ae50010078e5c08b3996088\
7bf95185c381bdb719e60b6925fa12af78a8824fade927387c757acb6bac63da84f92\
45e20cfd5d830382ac634d434725ca6349ab5db920a3
{% endhighlight %}

Get the same transaction in JSON:

{% highlight bash %}
dash-cli getrawtransaction \
25632685ed0d7286901a80961c924c1ddd952e764754dbd8b40d0956413c8b56 \
1
{% endhighlight %}

Result:

{% highlight json %}
{
  "txid": "25632685ed0d7286901a80961c924c1ddd952e764754dbd8b40d0956413c8b56",
  "version": 3,
  "type": 5,
  "size": 229,
  "locktime": 0,
  "vin": [
    {
      "coinbase": "03ae50011a4d696e656420627920416e74506f6f6c2021000b01201da9196f0000000007000000",
      "sequence": 4294967295
    }
  ],
  "vout": [
    {
      "value": 8.10000000,
      "valueSat": 810000000,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 cbd7bfcc50351180132b2c0698cb90ad74c473c7 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914cbd7bfcc50351180132b2c0698cb90ad74c473c788ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yeuGUfPMrbEqAS2Pw1wonYgEPbM4LAA9LK"
        ]
      },
      "spentTxId": "1790b286922d1a439bdc056939bc902a222f9d66ee63d8427805617eedf835bd",
      "spentIndex": 83,
      "spentHeight": 94680
    },
    {
      "value": 8.10000000,
      "valueSat": 810000000,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 88a060bc2dfe05780ae4dcb6c98b12436c35a939 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a91488a060bc2dfe05780ae4dcb6c98b12436c35a93988ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yYmrsYP3XYMZr1cGtha3QzmuNB1C7CfyhV"
        ]
      }
    }
  ],
  "extraPayloadSize": 70,
  "extraPayload": "0200ae50010078e5c08b39960887bf95185c381bdb719e60b6925fa12af78a8824fade927387c757acb6bac63da84f9245e20cfd5d830382ac634d434725ca6349ab5db920a3",
  "cbTx": {
    "version": 2,
    "height": 86190,
    "merkleRootMNList": "877392defa24888af72aa15f92b6609e71db1b385c1895bf870896398bc0e578",
    "merkleRootQuorums": "a320b95dab4963ca2547434d63ac8203835dfd0ce245924fa83dc6bab6ac57c7"
  },
  "hex": "03000500010000000000000000000000000000000000000000000000000000000000000000ffffffff2703ae50011a4d696e656420627920416e74506f6f6c2021000b01201da9196f0000000007000000ffffffff02809e4730000000001976a914cbd7bfcc50351180132b2c0698cb90ad74c473c788ac809e4730000000001976a91488a060bc2dfe05780ae4dcb6c98b12436c35a93988ac00000000460200ae50010078e5c08b39960887bf95185c381bdb719e60b6925fa12af78a8824fade927387c757acb6bac63da84f9245e20cfd5d830382ac634d434725ca6349ab5db920a3",
  "blockhash": "00000000007b0fb99e36713cf08012482478ee496e6dcb4007ad2e806306e62b",
  "height": 86190,
  "confirmations": 83233,
  "time": 1556114577,
  "blocktime": 1556114577,
  "instantlock": true,
  "instantlock_internal": false,
  "chainlock": true
}
{% endhighlight %}

*See also*

* [GetSpecialTxes][rpc getspecialtxes]: {{summary_getSpecialTxes}}
* [GetTransaction][rpc gettransaction]: {{summary_getTransaction}}

{% endautocrossref %}
