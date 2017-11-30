{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/settxfee.md" %}

##### SetTxFee
{% include helpers/subhead-links.md %}

{% assign summary_setTxFee="sets the transaction fee per kilobyte paid by transactions created by this wallet." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `settxfee` RPC {{summary_setTxFee}}

*Parameter #1---the transaction fee amount per kilobyte*

{% itemplate ntpd1 %}
- n: "Transaction Fee Per Kilobyte"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The transaction fee to pay, in dash, for each kilobyte of transaction data.  Be careful setting the fee too low---your transactions may not be relayed or included in blocks"

{% enditemplate %}

*Result: `true` on success*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "bool (true)"
  p: "Required<br>(exactly 1)"
  d: "Set to `true` if the fee was successfully set"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Set the transaction fee per kilobyte to 10,000 duffs.

{% highlight bash %}
dash-cli -testnet settxfee 0.00010000
{% endhighlight %}

Result:

{% highlight json %}
true
{% endhighlight %}

*See also*

* [GetWalletInfo][rpc getwalletinfo]: {{summary_getWalletInfo}}
* [GetNetworkInfo][rpc getnetworkinfo]: {{summary_getNetworkInfo}}

{% endautocrossref %}
