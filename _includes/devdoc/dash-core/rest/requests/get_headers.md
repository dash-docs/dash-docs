{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rest/requests/get_headers.md" %}

##### GET Headers
{% include helpers/subhead-links.md %}

{% assign summary_restGetHeaders="returns a specified amount of block headers in upward direction." %}
<!-- __ -->
{% autocrossref %}

The `GET headers` operation {{summary_restGetHeaders}}

*Request*

{% highlight text %}
GET /headers/<count>/<hash>.<format>
{% endhighlight %}

*Parameter #1---the amount of block headers to retrieve*

{% itemplate ntpd1 %}
- n: "Amount"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The amount of block headers in upward direction to return (including the start header hash)"

{% enditemplate %}

*Parameter #2---the header hash of the block to retrieve*

{% itemplate ntpd1 %}
- n: "Header Hash"
  t: "path (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the header of the block to get, encoded as hex in RPC byte order"

{% enditemplate %}

*Parameter #3---the output format*

{% itemplate ntpd1 %}
- n: "Format"
  t: "suffix"
  p: "Required<br>(exactly 1)"
  d: "Set to `.json` for decoded block contents in JSON, or `.bin` or `hex` for a serialized block in binary or hex"

{% enditemplate %}

*Response as JSON*

{% itemplate ntpd1 %}
- n: "Result"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing the requested block headers"

- n: "→<br>Block Header"
  t: "object"
  p: "Required<br>(1 or more)"
  d: "An object containing a block header.  The amount of the objects is the same as the amount provided in parameter #1 "

- n: "→→<br>`hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of this block's block header encoded as hex in RPC byte order.  This is the same as the hash provided in parameter #2"

- n: "→→<br>`confirmations`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The number of confirmations the transactions in this block have, starting at 1 when this block is at the tip of the best block chain.  This score will be -1 if the the block is not part of the best block chain"

- n: "→→<br>`height`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The height of this block on its block chain"

- n: "→→<br>`version`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "This block's version number.  See [block version numbers][section block versions]"

- n: "→→<br>`merkleroot`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The merkle root for this block, encoded as hex in RPC byte order"

- n: "→→<br>`time`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The value of the *time* field in the block header, indicating approximately when the block was created"

- n: "→→<br>`mediantime`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.12.0*<br><br>The median time of the 11 blocks before the most recent block on the blockchain.  Used for validating transaction locktime under BIP113"

- n: "→→<br>`nonce`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The nonce which was successful at turning this particular block into one that could be added to the best block chain"

- n: "→→<br>`bits`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The value of the *nBits* field in the block header, indicating the target threshold this block's header had to pass"

- n: "→→<br>`difficulty`"
  t: "number (real)"
  p: "Required<br>(exactly 1)"
  d: "The estimated amount of work done to find this block relative to the estimated amount of work done to find block 0"

- n: "→→<br>`chainwork`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The estimated number of block header hashes miners had to check from the genesis block to this block, encoded as big-endian hex"

- n: "→→<br>`previousblockhash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the header of the previous block, encoded as hex in RPC byte order"

- n: "→→<br>`nextblockhash`"
  t: "string (hex)"
  p: "Optional<br>(0 or 1)"
  d: "The hash of the next block on the best block chain, if known, encoded as hex in RPC byte order"

{% enditemplate %}

*Examples from Dash Core 0.12.2*

Request 2 block headers in hex-encoded serialized block format:

{% highlight bash %}
curl http://localhost:19998/rest/headers/2/0000000000ccbf46cf6b78827ac1019f82598be839bce08bff00d188e75fb451.hex
{% endhighlight %}

Result (wrapped):

{% highlight bash %}
0000002097e8135d73afa52145f6d0b4d0f957030cd598837ddc6750271fb109\
000000008478305a7abf2f7cb21a889fb68d53c3e51685349e18e1b104b5956c\
100bfea2c72d285a84030a1cd0041ed70000002051b45fe788d100ff8be0bc39\
e88b59829f01c17a82786bcf46bfcc000000000004dc24bddd15f790efcd7af3\
8d03f805cc1c74516888ccec8874db2ac8beb043092e285a999f091c5d6ec419
{% endhighlight %}

Get the same block headers in JSON:

{% highlight bash %}
curl http://localhost:19998/rest/headers/2/0000000000ccbf46cf6b78827ac1019f82598be839bce08bff00d188e75fb451.json
{% endhighlight %}

Result (whitespace added):

{% highlight json %}
[  
   {  
      "hash":"0000000000ccbf46cf6b78827ac1019f82598be839bce08bff00d188e75fb451",
      "confirmations":80,
      "height":38010,
      "version":536870912,
      "merkleroot":"a2fe0b106c95b504b1e1189e348516e5c3538db69f881ab27c2fbf7a5a307884",
      "time":1512582599,
      "mediantime":1512582025,
      "nonce":3609068752,
      "bits":"1c0a0384",
      "difficulty":25.56450187425715,
      "chainwork":"00000000000000000000000000000000000000000000000000092fc476457b68",
      "previousblockhash":"0000000009b11f275067dc7d8398d50c0357f9d0b4d0f64521a5af735d13e897",
      "nextblockhash":"0000000000a9baff28a79db2a50e13af8f313138f4568339f58d73eda14a4d51"
   },
   {  
      "hash":"0000000000a9baff28a79db2a50e13af8f313138f4568339f58d73eda14a4d51",
      "confirmations":79,
      "height":38011,
      "version":536870912,
      "merkleroot":"43b0bec82adb7488eccc886851741ccc05f8038df37acdef90f715ddbd24dc04",
      "time":1512582665,
      "mediantime":1512582146,
      "nonce":432303709,
      "bits":"1c099f99",
      "difficulty":26.60134045579303,
      "chainwork":"00000000000000000000000000000000000000000000000000092fdf1051882b",
      "previousblockhash":"0000000000ccbf46cf6b78827ac1019f82598be839bce08bff00d188e75fb451",
      "nextblockhash":"0000000008de9da638149042323fc05ded619a922ff1fac6e66f66fc773bd716"
   }
]
{% endhighlight %}

*See also*

* [GET Block/NoTxDetails][rest get block-notxdetails] {{summary_restGetBlock-noTxDetails}}
* [GetBlock][rpc getblock] RPC: {{summary_getBlock}}
* [GetBlockHash][rpc getblockhash] RPC: {{summary_getBlockHash}}
* [GetBlockHeader][rpc getblockheader] RPC: {{summary_getBlockHeader}}

{% endautocrossref %}
