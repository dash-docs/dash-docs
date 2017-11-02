{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/estimatesmartpriority.md" %}

##### EstimateSmartPriority
{% include helpers/subhead-links.md %}

{% autocrossref %}

{% assign summary_estimateSmartPriority="estimates the priority that a transaction needs in order to be included within a certain number of blocks as a free high-priority transaction and returns the number of blocks for which the estimate is valid." %}

The `estimatesmartpriority` RPC {{summary_estimateSmartPriority}} This should not to be confused with the `prioritisetransaction` RPC which will remain supported for adding fee deltas to transactions.

{{WARNING}} `estimatesmartpriority` has been [removed from Bitcoin](https://github.com/bitcoin/bitcoin/commit/fe282acd7604b5265762b24e531bdf1ebb1f009b) and will no longer be available in the next major release (planned for Bitcoin Core 0.15.0). While still present in Dash Core, the interface should be considered unstable and may disappear or change. Use the RPC listed in the "See Also" subsection below instead.

Transaction priority is relative to a transaction's byte size.

*Parameter #1---how many blocks the transaction may wait before being included as a free high-priority transaction*

{% itemplate ntpd1 %}
- n: "Blocks"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The maximum number of blocks a transaction should have to wait before it is predicted to be included in a block based purely on its priority"

{% enditemplate %}

*Result---the priority a transaction needs*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "JSON Object containing estimate information"

- n: "→<br>`priority`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The estimated priority the transaction should be in order to be included within the specified number of blocks.  If the node doesn't have enough information to make an estimate, the value `-1` will be returned"

- n: "→<br>`blocks`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Block number where the estimate was found"

{% enditemplate %}

*Examples from Dash Core 0.12.2*

{% highlight bash %}
dash-cli estimatesmartpriority 6
{% endhighlight %}

Result:

{% highlight json %}
{
  "priority": 718158904
  "blocks": 25
}
{% endhighlight %}

Requesting data the node can't calculate yet:

{% highlight bash %}
dash-cli estimatesmartpriority 100
{% endhighlight %}

Result:

{% highlight json %}
{
  "priority": -1,
  "blocks": 100
}
{% endhighlight %}

*See also*

* [EstimatePriority][rpc estimatepriority]: {{summary_estimatePriority}}

{% endautocrossref %}
