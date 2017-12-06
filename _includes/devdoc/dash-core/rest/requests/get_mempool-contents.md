{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rest/requests/get_mempool-contents.md" %}

##### GET MemPool/Contents
{% include helpers/subhead-links.md %}

{% assign summary_restGetMemPool-contents="returns all transaction in the memory pool with detailed information." %}
<!-- __ -->
{% autocrossref %}

The `GET mempool/contents` operation {{summary_restGetMemPool-contents}}  Supports only `json` as output format.

*Request*

{% highlight text %}
GET /mempool/contents.json
{% endhighlight %}

*Parameters: none*

*Result as JSON*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "A object containing transactions currently in the memory pool.  May be empty"

- n: "→<br>TXID"
  t: "string : object"
  p: "Optional<br>(0 or more)"
  d: "The TXID of a transaction in the memory pool, encoded as hex in RPC byte order"

- n: "→ →<br>`size`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The size of the serialized transaction in bytes"

- n: "→ →<br>`fee`"
  t: "number (bitcoins)"
  p: "Required<br>(exactly 1)"
  d: "The transaction fee paid by the transaction in decimal bitcoins"

- n: "→ →<br>`modifiedfee`"
  t: "number (bitcoins)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.12.0*<br><br>The transaction fee with fee deltas used for mining priority in decimal bitcoins"

- n: "→ →<br>`time`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The time the transaction entered the memory pool, Unix epoch time format"

- n: "→ →<br>`height`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The block height when the transaction entered the memory pool"

- n: "→ →<br>`startingpriority`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The priority of the transaction when it first entered the memory pool"

- n: "→ →<br>`currentpriority`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The current priority of the transaction"

- n: "→ →<br>`descendantcount`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.12.0*<br><br>The number of in-mempool descendant transactions (including this one)"

- n: "→ →<br>`descendantsize`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.12.0*<br><br>The size of in-mempool descendants (including this one)"

- n: "→ →<br>`descendantfees`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.12.0*<br><br>The modified fees (see `modifiedfee` above) of in-mempool descendants (including this one)"

- n: "→ →<br>`depends`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array holding TXIDs of unconfirmed transactions this transaction depends upon (parent transactions).  Those transactions must be part of a block before this transaction can be added to a block, although all transactions may be included in the same block.  The array may be empty"

- n: "→ → →<br>Depends TXID"
  t: "string"
  p: "Optional (0 or more)"
  d: "The TXIDs of any unconfirmed transactions this transaction depends upon, encoded as hex in RPC byte order"

{% enditemplate %}

<!-- Not present in Dash
- n: "→ →<br>`ancestorcount`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.13.0*<br><br>The number of in-mempool ancestor transactions (including this one)"

- n: "→ →<br>`ancestorsize`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.13.0*<br><br>The size of in-mempool ancestors (including this one)"

- n: "→ →<br>`ancestorfees`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.13.0*<br><br>The modified fees (see `modifiedfee` above) of in-mempool ancestors (including this one)"
-->

*Examples from Dash Core 0.12.2*

Get all transactions in the memory pool in JSON:

{% highlight bash %}
curl http://localhost:19998/rest/mempool/contents.json
{% endhighlight %}

Result (whitespaced added):

{% highlight json %}
{  
   "b06edec446fbcc0fc04a6e2774a843823f5238c2e15de40e61767a44f6788d32":{  
      "size":225,
      "fee":0.00010000,
      "modifiedfee":0.00010000,
      "time":1512596309,
      "height":38094,
      "startingpriority":1934576927.410256,
      "currentpriority":1934576927.410256,
      "descendantcount":1,
      "descendantsize":225,
      "descendantfees":10000,
      "depends":[  

      ]
   }
}
{% endhighlight %}

*See also*

* [GET MemPool/Info][rest get mempool-info]: {{summary_restGetMemPool-info}}
* [GetMemPoolInfo][rpc getmempoolinfo] RPC: {{summary_getMemPoolInfo}}
* [GetRawMemPool][rpc getrawmempool] RPC: {{summary_getRawMemPool}}

{% endautocrossref %}
