{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rest/requests/get_mempool-info.md" %}

##### GET MemPool/Info
{% include helpers/subhead-links.md %}

{% assign summary_restGetMemPool-info="returns information about the node's current transaction memory pool." %}
<!-- __ -->
{% autocrossref %}

The `GET mempool/info` operation {{summary_restGetMemPool-info}}  Supports only `json` as output format.

*Request*

{% highlight text %}
GET /mempool/info.json
{% endhighlight %}

*Parameters: none*

*Result as JSON*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "A object containing information about the memory pool"

- n: "→<br>`size`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The number of transactions currently in the memory pool"

- n: "→<br>`bytes`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The total number of bytes in the transactions in the memory pool"

- n: "→<br>`usage`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.11.0*<br><br>Total memory usage for the mempool in bytes"

- n: "→<br>`maxmempool`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.12.0*<br><br>Maximum memory usage for the mempool in bytes"

- n: "→<br>`mempoolminfee`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "*Added in Bitcoin Core 0.12.0*<br><br>The lowest fee per kilobyte paid by any transaction in the memory pool"

{% enditemplate %}

*Examples from Dash Core 0.12.2*

Get memory pool info in JSON:

{% highlight bash %}
curl http://localhost:19998/rest/mempool/info.json
{% endhighlight %}

Result (whitespaced added):

{% highlight json %}
{  
   "size":1,
   "bytes":1256,
   "usage":3376,
   "maxmempool":300000000,
   "mempoolminfee":0.00000000
}
{% endhighlight %}

*See also*

* [GET MemPool/Contents][rest get mempool-contents]: {{summary_restGetMemPool-contents}}
* [GetMemPoolInfo][rpc getmempoolinfo] RPC: {{summary_getMemPoolInfo}}

{% endautocrossref %}
