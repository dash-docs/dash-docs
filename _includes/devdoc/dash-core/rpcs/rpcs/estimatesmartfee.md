{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/estimatesmartfee.md" %}

##### EstimateSmartFee
{% include helpers/subhead-links.md %}

{% assign summary_estimateSmartFee="estimates the transaction fee per kilobyte that needs to be paid for a transaction to begin confirmation within a certain number of blocks and returns the number of blocks for which the estimate is valid." %}

{% autocrossref %}

The `estimatesmartfee` RPC {{summary_estimateSmartFee}}

*Parameter #1---how many blocks the transaction may wait before being included*

{% itemplate ntpd1 %}
- n: "Blocks"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The maximum number of blocks a transaction should have to wait before it is predicted to be included in a block. Has to be between 1 and 25 blocks"

{% enditemplate %}

*Result---the fee the transaction needs to pay per kilobyte*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "JSON Object containing estimate information"

- n: "→<br>`feerate`"
  t: "number (Dash)"
  p: "Required<br>(exactly 1)"
  d: "The estimated fee the transaction should pay in order to be included within the specified number of blocks.  If the node doesn't have enough information to make an estimate, the value `-1` will be returned"

- n: "→<br>`blocks`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Block number where the estimate was found"
{% enditemplate %}

*Examples from Dash Core 0.12.2*

{% highlight bash %}
dash-cli estimatesmartfee 6
{% endhighlight %}

Result:

{% highlight json %}
{
  "feerate": 0.00044345,
  "blocks": 6
}
{% endhighlight %}

Requesting data the node can't calculate (out of range):

{% highlight bash %}
dash-cli estimatesmartfee 100
{% endhighlight %}

Result:

{% highlight json %}
{
  "feerate": -1,
  "blocks": 100
}
{% endhighlight %}

*See also*

* [SetTxFee][rpc settxfee]: {{summary_setTxFee}}

{% endautocrossref %}
