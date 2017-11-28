{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getaccountaddress.md" %}

##### GetAccountAddress
{% include helpers/subhead-links.md %}

{% autocrossref %}

<!-- __ -->

{% assign summary_getAccountAddress="returns the current Dash address for receiving payments to this account. If the account doesn't exist, it creates both the account and a new address for receiving payment.  Once a payment has been received to an address, future calls to this RPC for the same account will return a different address." %}

*Requires wallet support.*

The `getaccountaddress` RPC {{summary_getAccountAddress}}

{{WARNING}} `getaccountaddress` will be removed in a later version of Dash
Core.  Use the RPCs listed in the See Also subsection below instead.

*Parameter #1---an account name*

{% itemplate ntpd1 %}
- n: "Account"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The name of an account.  Use an empty string (\"\") for the default account.  If the account doesn't exist, it will be created"

{% enditemplate %}

*Result---a Dash address*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (base58)"
  p: "Required<br>(exactly 1)"
  d: "An address, belonging to the account specified, which has not yet received any payments"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Get an address for the default account:

{% highlight bash %}
dash-cli -testnet getaccountaddress ""
{% endhighlight %}

Result:

{% highlight text %}
yNUQ6RzTpNj5GP5ebdRcusJ7K9JJKx6VvV
{% endhighlight %}

*See also*

* [GetNewAddress][rpc getnewaddress]: {{summary_getNewAddress}}
* [GetRawChangeAddress][rpc getrawchangeaddress]: {{summary_getRawChangeAddress}}
* [GetAddressesByAccount][rpc getaddressesbyaccount]: {{summary_getAddressesByAccount}}

{% endautocrossref %}
