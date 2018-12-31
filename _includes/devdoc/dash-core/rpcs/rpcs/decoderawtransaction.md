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
000000000000000000000000000000ffffffff4b02953d045e572a5c08fabe6d6d66663734\
36333636333230616162346432366264616530386339366263623534010000000000000010\
00000eaf0000000d2f6e6f64655374726174756d2f0000000002b4e32237010000001976a9\
14cb594917ad4e5849688ec63f29a0f7f3badb5da688acaae32237010000001976a914a3c5\
284d3cd896815ac815f2dd76a3a71cb3d8e688ac00000000260100953d00007b8577a1c051\
bcab40e08c72209f3eddc476d859c8054c57a7287700b2de2db4
{% endhighlight %}

Result:

{% highlight json %}
{
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
  "instantlock": false
}
{% endhighlight %}

*See also*

* [CreateRawTransaction][rpc createrawtransaction]: {{summary_createRawTransaction}}
* [SignRawTransaction][rpc signrawtransaction]: {{summary_signRawTransaction}}
* [SendRawTransaction][rpc sendrawtransaction]: {{summary_sendRawTransaction}}

{% endautocrossref %}
