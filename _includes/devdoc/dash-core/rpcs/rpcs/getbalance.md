{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getbalance.md" %}

##### GetBalance
{% include helpers/subhead-links.md %}

{% assign summary_getBalance="gets the balance in decimal dash across all accounts or for a particular account." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `getbalance` RPC {{summary_getBalance}}

*Parameter #1---an account name*

{% itemplate ntpd1 %}
- n: "Account"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "*Deprecated: will be removed in a later version of Bitcoin Core*<br><br>The name of an account to get the balance for.  An empty string (\"\") is the default account.  The string `*` will get the balance for all accounts (this is the default behavior)"

{% enditemplate %}

*Parameter #2---the minimum number of confirmations*

{{INCLUDE_CONFIRMATIONS_PARAMETER}}

*Parameter #3---whether to add 5 confirmations to transactions locked via InstantSend*

{% itemplate ntpd1 %}
- n: "addlockconf"
  t: "bool"
  p: "Optional<br>(exactly 1)"
  d: "Add the number of InstantSend confirmations to InstantSend locked transactions"

{% enditemplate %}

*Parameter #4---whether to include watch-only addresses*

{{INCLUDE_INCLUDE_WATCH_ONLY_PARAMETER}}

*Result---the balance in dash*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The balance of the account (or all accounts) in dash"

{% enditemplate %}

*Examples from Dash Core 0.12.2*

Get the balance for the main ("") account, including transactions with
at least five confirmations and those spent to watch-only addresses in
that account. Do not add the InstantSend confirmations (5) for locked transactions.

{% highlight bash %}
dash-cli -testnet getbalance "" 3 false true
{% endhighlight %}

Result:

{% highlight json %}
0.00000000
{% endhighlight %}

Get the balance for the main ("") account, including transactions with
at least one confirmation and those spent to watch-only addresses in
that account. Add the InstantSend confirmations (5) for locked transactions.

{% highlight bash %}
dash-cli -testnet getbalance "" 3 true true
{% endhighlight %}

Result:

{% highlight json %}
1.00000000
{% endhighlight %}


*See also*

* [ListAccounts][rpc listaccounts]: {{summary_listAccounts}}
* [GetReceivedByAccount][rpc getreceivedbyaccount]: {{summary_getReceivedByAccount}}
* [GetReceivedByAddress][rpc getreceivedbyaddress]: {{summary_getReceivedByAddress}}

{% endautocrossref %}
