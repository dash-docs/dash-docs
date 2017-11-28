{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getreceivedbyaccount.md" %}

##### GetReceivedByAccount
{% include helpers/subhead-links.md %}

{% assign summary_getReceivedByAccount="returns the total amount received by addresses in a particular account from transactions with the specified number of confirmations.  It does not count coinbase transactions." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `getreceivedbyaccount` RPC {{summary_getReceivedByAccount}}

{{WARNING}} `getreceivedbyaccount` will be removed in a later version of Dash
Core.  Use the RPCs listed in the See Also subsection below instead.

*Parameter #1---the account name*

{% itemplate ntpd1 %}
- n: "Account"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The name of the account containing the addresses to get.  For the default account, use an empty string (\"\")"

{% enditemplate %}

*Parameter #2---the minimum number of confirmations*

{{INCLUDE_CONFIRMATIONS_PARAMETER}}

*Parameter #3---whether to add 5 confirmations to transactions locked via InstantSend*

{% itemplate ntpd1 %}
- n: "addlockconf"
  t: "bool"
  p: "Optional<br>(exactly 1)"
  d: "Add the number of InstantSend confirmations to InstantSend locked transactions (default=false)"

{% enditemplate %}

*Result---the number of dash received*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The number of dash received by the account.  May be `0`"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Get the dash received by the "doc test" account with six or more
confirmations:

{% highlight bash %}
dash-cli -testnet getreceivedbyaccount "doc test" 6
{% endhighlight %}

Result:

{% highlight json %}
0.30000000
{% endhighlight %}

*See also*

* [GetReceivedByAddress][rpc getreceivedbyaddress]: {{summary_getReceivedByAddress}}
* [GetAddressesByAccount][rpc getaddressesbyaccount]: {{summary_getAddressesByAccount}}
* [ListAccounts][rpc listaccounts]: {{summary_listAccounts}}

{% endautocrossref %}
