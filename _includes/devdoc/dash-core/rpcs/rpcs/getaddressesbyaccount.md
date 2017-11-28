{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getaddressesbyaccount.md" %}

##### GetAddressesByAccount
{% include helpers/subhead-links.md %}

{% assign summary_getAddressesByAccount="returns a list of every address assigned to a particular account." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `getaddressesbyaccount` RPC {{summary_getAddressesByAccount}}

{{WARNING}} `getaddressesbyaccount` will be removed in a later version of Dash
Core.  Use the RPCs listed in the See Also subsection below instead.

*Parameter #1---the account name*

{% itemplate ntpd1 %}
- n: "Account"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The name of the account containing the addresses to get.  To get addresses from the default account, pass an empty string (\"\")"

{% enditemplate %}

*Result---a list of addresses*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing all addresses belonging to the specified account.  If the account has no addresses, the array will be empty"

- n: "Address"
  t: "string (base58)"
  p: "Optional<br>(1 or more)"
  d: "A P2PKH or P2SH address belonging to the account"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Get the addresses assigned to the account "doc test":

{% highlight bash %}
dash-cli -testnet getaddressesbyaccount "doc test"
{% endhighlight %}

Result:

{% highlight json %}
[
  "yMTFRnrfJ4NpnYVeidDNHVwT7uuNsVjevq",
  "yhT2HS1SxvXkMVdAdf6RNtGPfuVFvwZi35"
]
{% endhighlight %}

*See also*

* [GetAccount][rpc getaccount]: {{summary_getAccount}}
* [GetBalance][rpc getbalance]: {{summary_getBalance}}

{% endautocrossref %}
