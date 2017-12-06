{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rest/requests/get_block.md" %}

##### GET Block
{% include helpers/subhead-links.md %}
<!-- __ -->
{% assign summary_restGetBlock="gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block." %}

{% autocrossref %}

The `GET block` operation {{summary_restGetBlock}}

*Request*

{% highlight text %}
GET /block/<hash>.<format>
{% endhighlight %}

*Parameter #1---the header hash of the block to retrieve*

{% itemplate ntpd1 %}
- n: "Header Hash"
  t: "path (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the header of the block to get, encoded as hex in RPC byte order"

{% enditemplate %}

*Parameter #2---the output format*

{% itemplate ntpd1 %}
- n: "Format"
  t: "suffix"
  p: "Required<br>(exactly 1)"
  d: "Set to `.json` for decoded block contents in JSON, or `.bin` or `hex` for a serialized block in binary or hex"

{% enditemplate %}

*Response as JSON*

{% assign DEPTH="→ →" %}
{% include helpers/vars.md %}

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object containing the requested block"

- n: "→<br>`hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of this block's block header encoded as hex in RPC byte order.  This is the same as the hash provided in parameter #1"

- n: "→<br>`confirmations`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The number of confirmations the transactions in this block have, starting at 1 when this block is at the tip of the best block chain.  This score will be -1 if the the block is not part of the best block chain"

- n: "→<br>`size`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The size of this block in serialized block format, counted in bytes"

- n: "→<br>`height`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The height of this block on its block chain"

- n: "→<br>`version`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "This block's version number.  See [block version numbers][section block versions]"

- n: "→<br>`merkleroot`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The merkle root for this block, encoded as hex in RPC byte order"

- n: "→<br>`tx`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing all transactions in this block.  The transactions appear in the array in the same order they appear in the serialized block"

- n: "→ →<br>Transaction"
  t: "object"
  p: "Required<br>(1 or more)"
  d: "An object describing a particular transaction within this block"

{{INCLUDE_DECODE_RAW_TRANSACTION}}
- n: "→<br>`time`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The value of the *time* field in the block header, indicating approximately when the block was created"

- n: "→<br>`mediantime`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.12.0*<br><br>The median time of the 11 blocks before the most recent block on the blockchain.  Used for validating transaction locktime under BIP113"

- n: "→<br>`nonce`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The nonce which was successful at turning this particular block into one that could be added to the best block chain"

- n: "→<br>`bits`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The value of the *nBits* field in the block header, indicating the target threshold this block's header had to pass"

- n: "→<br>`difficulty`"
  t: "number (real)"
  p: "Required<br>(exactly 1)"
  d: "The estimated amount of work done to find this block relative to the estimated amount of work done to find block 0"

- n: "→<br>`chainwork`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The estimated number of block header hashes miners had to check from the genesis block to this block, encoded as big-endian hex"

- n: "→<br>`previousblockhash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the header of the previous block, encoded as hex in RPC byte order"

- n: "→<br>`nextblockhash`"
  t: "string (hex)"
  p: "Optional<br>(0 or 1)"
  d: "The hash of the next block on the best block chain, if known, encoded as hex in RPC byte order"

{% enditemplate %}

<!--
  Segwit related fields not in Dash
- n: "→<br>`strippedsize`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.13.0*<br><br>The size of this block in serialized block format excluding witness data, counted in bytes"


- n: "→<br>`weight`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.13.0*<br><br>The block weight as defined in BIP 141"

- n: "→<br>`versionHex`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.13.0*<br><br>This block's version number formatted in hexadecimal.  See [BIP9 assignments]"
-->

*Examples from Dash Core 0.12.2*

Request a block in hex-encoded serialized block format:

{% highlight bash %}
curl http://localhost:19998/rest/block/0000000000ccbf46cf6b78827ac1019f82598be839bce08bff00d188e75fb451.hex
{% endhighlight %}

Result (wrapped):

{% highlight bash %}
0000002097e8135d73afa52145f6d0b4d0f957030cd598837ddc6750271fb109\
000000008478305a7abf2f7cb21a889fb68d53c3e51685349e18e1b104b5956c\
100bfea2c72d285a84030a1cd0041ed701010000000100000000000000000000\
00000000000000000000000000000000000000000000ffffffff13037a94000e\
2f5032506f6f6c2d74444153482fffffffff06a1f9ef04000000001976a91414\
e3832cd7192ffb358a31d842636c4db8dfb1ac88ac6c357f3c000000001976a9\
149262f2289e1f021dca954d8cf07a7ad72c2cc24d88ac31f49e010000000019\
76a914d93f7ffa324b77d361e89a3c9c8df46ccdb4b39288ac40230e43000000\
001976a914c4541983721b26ada79770bf22de4885e19f566188ac0200000000\
0000004341047559d13c3f81b1fadbd8dd03e4b5a1c73b05e2b980e00d467aa9\
440b29c7de23664dde6428d75cafed22ae4f0d302e26c5c5a5dd4d3e1b796d72\
81bdc9430f35ac00000000000000002a6a28c855abe6461b1003ea36feb88a3b\
d50c5696e5784d11f8cd5e892978685de1d6000000000100000000000000
{% endhighlight %}

Get the same block in JSON:

{% highlight bash %}
curl http://localhost:19998/rest/block/0000000000ccbf46cf6b78827ac1019f82598be839bce08bff00d188e75fb451.json
{% endhighlight %}

Result (whitespaced added):

{% highlight json %}
{  
   "hash":"0000000000ccbf46cf6b78827ac1019f82598be839bce08bff00d188e75fb451",
   "confirmations":20,
   "size":414,
   "height":38010,
   "version":536870912,
   "merkleroot":"a2fe0b106c95b504b1e1189e348516e5c3538db69f881ab27c2fbf7a5a307884",
   "tx":[  
      {  
         "txid":"a2fe0b106c95b504b1e1189e348516e5c3538db69f881ab27c2fbf7a5a307884",
         "size":333,
         "version":1,
         "locktime":0,
         "vin":[  
            {  
               "coinbase":"037a94000e2f5032506f6f6c2d74444153482f",
               "sequence":4294967295
            }
         ],
         "vout":[  
            {  
               "value":0.82835873,
               "valueSat":82835873,
               "n":0,
               "scriptPubKey":{  
                  "asm":"OP_DUP OP_HASH160 14e3832cd7192ffb358a31d842636c4db8dfb1ac OP_EQUALVERIFY OP_CHECKSIG",
                  "hex":"76a91414e3832cd7192ffb358a31d842636c4db8dfb1ac88ac",
                  "reqSigs":1,
                  "type":"pubkeyhash",
                  "addresses":[  
                     "yNDtusuhm6otr3eeGh3SqdpNczV4aZSx1b"
                  ]
               }
            },
            {  
               "value":10.14969708,
               "valueSat":1014969708,
               "n":1,
               "scriptPubKey":{  
                  "asm":"OP_DUP OP_HASH160 9262f2289e1f021dca954d8cf07a7ad72c2cc24d OP_EQUALVERIFY OP_CHECKSIG",
                  "hex":"76a9149262f2289e1f021dca954d8cf07a7ad72c2cc24d88ac",
                  "reqSigs":1,
                  "type":"pubkeyhash",
                  "addresses":[  
                     "yZfU36R8dhdnFaK3AwfnubrLXAG2G1WiVn"
                  ]
               }
            },
            {  
               "value":0.27194417,
               "valueSat":27194417,
               "n":2,
               "scriptPubKey":{  
                  "asm":"OP_DUP OP_HASH160 d93f7ffa324b77d361e89a3c9c8df46ccdb4b392 OP_EQUALVERIFY OP_CHECKSIG",
                  "hex":"76a914d93f7ffa324b77d361e89a3c9c8df46ccdb4b39288ac",
                  "reqSigs":1,
                  "type":"pubkeyhash",
                  "addresses":[  
                     "yg89Yt5Tjzs9nRpX3wJCuvr7KuQvgkvmeC"
                  ]
               }
            },
            {  
               "value":11.25000000,
               "valueSat":1125000000,
               "n":3,
               "scriptPubKey":{  
                  "asm":"OP_DUP OP_HASH160 c4541983721b26ada79770bf22de4885e19f5661 OP_EQUALVERIFY OP_CHECKSIG",
                  "hex":"76a914c4541983721b26ada79770bf22de4885e19f566188ac",
                  "reqSigs":1,
                  "type":"pubkeyhash",
                  "addresses":[  
                     "yeDY39aiqbBHbJft5F6rokR23EaZca6UTU"
                  ]
               }
            },
            {  
               "value":0.00000002,
               "valueSat":2,
               "n":4,
               "scriptPubKey":{  
                  "asm":"047559d13c3f81b1fadbd8dd03e4b5a1c73b05e2b980e00d467aa9440b29c7de23664dde6428d75cafed22ae4f0d302e26c5c5a5dd4d3e1b796d7281bdc9430f35 OP_CHECKSIG",
                  "hex":"41047559d13c3f81b1fadbd8dd03e4b5a1c73b05e2b980e00d467aa9440b29c7de23664dde6428d75cafed22ae4f0d302e26c5c5a5dd4d3e1b796d7281bdc9430f35ac",
                  "reqSigs":1,
                  "type":"pubkey",
                  "addresses":[  
                     "yb21342iADyqAotjwcn4imqjvAcdYhnzeH"
                  ]
               }
            },
            {  
               "value":0.00000000,
               "valueSat":0,
               "n":5,
               "scriptPubKey":{  
                  "asm":"OP_RETURN c855abe6461b1003ea36feb88a3bd50c5696e5784d11f8cd5e892978685de1d60000000001000000",
                  "hex":"6a28c855abe6461b1003ea36feb88a3bd50c5696e5784d11f8cd5e892978685de1d60000000001000000",
                  "type":"nulldata"
               }
            }
         ]
      }
   ],
   "time":1512582599,
   "mediantime":1512582025,
   "nonce":3609068752,
   "bits":"1c0a0384",
   "difficulty":25.56450187425715,
   "chainwork":"00000000000000000000000000000000000000000000000000092fc476457b68",
   "previousblockhash":"0000000009b11f275067dc7d8398d50c0357f9d0b4d0f64521a5af735d13e897",
   "nextblockhash":"0000000000a9baff28a79db2a50e13af8f313138f4568339f58d73eda14a4d51"
}
{% endhighlight %}

*See also*

* [GET Block/NoTxDetails][rest get block-notxdetails] {{summary_restGetBlock-noTxDetails}}
* [GetBestBlockHash][rpc getbestblockhash] RPC: {{summary_getBestBlockHash}}
* [GetBlock][rpc getblock] RPC: {{summary_getBlock}}
* [GetBlockHash][rpc getblockhash] RPC: {{summary_getBlockHash}}

{% endautocrossref %}
