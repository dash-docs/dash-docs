{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/decoderawtransaction.md" %}
<!--__-->

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

*Example from Dash Core 0.13.0*

Decode a signed one-input, two-output transaction:

{% highlight bash %}
dash-cli decoderawtransaction 02000000015d0b26079696875e9fc3cb480420aae3c8\
b1da628fbb14cc718066df7fe7c5fd010000006a47304402202cfa683981898ad9adb89534\
23a38f7185ed41e163aa195d608fbe5bc3034910022034e2376aaed1c6576c0dad79d626ee\
27f706baaed86dabb105979c3e6f6e1cb9012103d14eb001cf0908f3a2333d171f6236497a\
82318a6a6f649b4d7fd8e5c8922e08feffffff021e3f4b4c000000001976a914b02ae52066\
542b4aec5cf45c7cae3183d7bd322788ac00f90295000000001976a914252c9de3a0ebd5c9\
5886187b24969d4ccdb5576e88ac943d0000
{% endhighlight %}

Result:

{% highlight json %}
{
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
  "instantlock": true
}
{% endhighlight %}

Decode a coinbase special transaction (CbTx):

{% highlight bash %}
dash-cli decoderawtransaction 03000500010000000000000000000000000000000000\
000000000000000000000000000000ffffffff2703ae50011a4d696e656420627920416e74\
506f6f6c2021000b01201da9196f0000000007000000ffffffff02809e4730000000001976\
a914cbd7bfcc50351180132b2c0698cb90ad74c473c788ac809e4730000000001976a91488\
a060bc2dfe05780ae4dcb6c98b12436c35a93988ac00000000460200ae50010078e5c08b39\
960887bf95185c381bdb719e60b6925fa12af78a8824fade927387c757acb6bac63da84f92\
45e20cfd5d830382ac634d434725ca6349ab5db920a3
{% endhighlight %}

Result:

{% highlight json %}
{
  "txid": "25632685ed0d7286901a80961c924c1ddd952e764754dbd8b40d0956413c8b56",
  "size": 229,
  "version": 3,
  "type": 5,
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
      }
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
  "instantlock": false,
  "instantlock_internal": false,  
  "chainlock": false
}
{% endhighlight %}

*See also*

* [CombineRawTransaction][rpc combinerawtransaction]: {{summary_combineRawTransaction}}
* [CreateRawTransaction][rpc createrawtransaction]: {{summary_createRawTransaction}}
* [SignRawTransaction][rpc signrawtransaction]: {{summary_signRawTransaction}}
* [SendRawTransaction][rpc sendrawtransaction]: {{summary_sendRawTransaction}}

{% endautocrossref %}
