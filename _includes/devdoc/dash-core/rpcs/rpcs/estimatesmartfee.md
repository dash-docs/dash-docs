{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/estimatesmartfee.md" %}

<!--__-->

##### EstimateSmartFee
{% include helpers/subhead-links.md %}

{% assign summary_estimateSmartFee="estimates the transaction fee per kilobyte that needs to be paid for a transaction to begin confirmation within a certain number of blocks and returns the number of blocks for which the estimate is valid." %}

{% autocrossref %}

The `estimatesmartfee` RPC {{summary_estimateSmartFee}}

*Parameter #1---how many confirmations the transaction may wait before being included*

{% itemplate ntpd1 %}
- n: "conf_target"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "Confirmation target in blocks (1 - 1008)"

{% enditemplate %}

*Parameter #2---estimate mode*

{% itemplate ntpd1 %}
- n: "estimate_mode"
  t: "string"
  p: "Optional<br>Default=<br>`CONSERVATIVE`"
  d: "The fee estimate mode. Whether to return a more conservative estimate which also satisfies a longer history. A conservative estimate potentially returns a higher feerate and is more likely to be sufficient for the desired target, but is not as responsive to short term drops in the prevailing fee market.  Must be one of:<br>`UNSET` (defaults to `CONSERVATIVE`)<br>`ECONOMICAL`<br>`CONSERVATIVE`"

{% enditemplate %}

*Result---the fee the transaction needs to pay per kilobyte*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "JSON Object containing estimate information"

- n: "→<br>`feerate`"
  t: "number (Dash)"
  p: "Optional<br>(0 or 1)"
  d: "The estimated fee the transaction should pay in order to be included within the specified number of blocks.  If the node doesn't have enough information to make an estimate, this field will not be returned"

- n: "→<br>`error`"
  t: "JSON array (strings)"
  p: "Optional<br>(0 or 1)"
  d: "Errors encountered during processing"

- n: "→<br>`blocks`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Block number where the estimate was found"
{% enditemplate %}

*Examples from Dash Core 0.14.1*

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
dash-cli estimatesmartfee 2
{% endhighlight %}

Result:

{% highlight json %}
{
  "errors": [
    "Insufficient data or no feerate found"
  ],
  "blocks": 2
}
{% endhighlight %}

*See also*

* [SetTxFee][rpc settxfee]: {{summary_setTxFee}}

{% endautocrossref %}
