{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getbestchainlock.md" %}

<!--__-->

##### GetBestChainLock
{% include helpers/subhead-links.md %}

{% assign summary_getBestChainLock="returns the block hash of the best chainlock." %}

{% autocrossref %}

The `getbestchainlock` RPC {{summary_getBestChainLock}}

Throws an error if there is no known chainlock yet.

*Parameters: none*

*Result*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object/null"
  p: "Required<br>(exactly 1)"
  d: "An object containing the requested block, or JSON `null` if an error occurred"

- n: "→<br>`blockhash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the block encoded as hex in RPC byte order."

- n: "→<br>`height`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The height of this block on its block chain"

- n: "→<br>`known_block`"
  t: "boolean"
  p: "Required<br>(exactly 1)"
  d: "True if the block is known by this node"

{% enditemplate %}

*Example from Dash Core 0.14.1*

{% highlight bash %}
dash-cli -testnet getbestchainlock
{% endhighlight %}

Result:
{% highlight json %}
{
  "blockhash": "000000000036ab34d3005941d4224fc5887526355c98b769e27e5ece05f48860",
  "height": 182106,
  "known_block": true
}
{% endhighlight %}

*See also: none*

{% endautocrossref %}
