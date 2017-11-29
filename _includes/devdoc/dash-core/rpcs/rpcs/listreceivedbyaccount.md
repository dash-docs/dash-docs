{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/listreceivedbyaccount.md" %}

##### ListReceivedByAccount
{% include helpers/subhead-links.md %}

{% assign summary_listReceivedByAccount="lists the total number of dash received by each account." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `listreceivedbyaccount` RPC {{summary_listReceivedByAccount}}

{{WARNING}} `listreceivedbyaccount` will be removed in a later version of Dash
Core.  Use the RPCs listed in the See Also subsection below instead.

*Parameter #1---the minimum number of confirmations a transaction must have to be counted*

{{INCLUDE_CONFIRMATIONS_PARAMETER}}

*Parameter #2---whether to add 5 confirmations to transactions locked via InstantSend*

{% itemplate ntpd1 %}
- n: "addlockconf"
  t: "bool"
  p: "Optional<br>(exactly 1)"
  d: "Add the number of InstantSend confirmations to InstantSend locked transactions"

{% enditemplate %}

*Parameter #3---whether to include empty accounts*

{% itemplate ntpd1 %}
- n: "Include Empty"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to `true` to display accounts which have never received a payment.  Set to `false` (the default) to only include accounts which have received a payment.  Any account which has received a payment will be displayed even if its current balance is `0`"

{% enditemplate %}

*Parameter #4---whether to include watch-only addresses in results*

{{INCLUDE_INCLUDE_WATCH_ONLY_PARAMETER}}

*Result---account names, balances, and minimum confirmations*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing objects each describing an account.  At the very least, the default account (\"\") will be included"

- n: "→<br>Account"
  t: "object"
  p: "Required<br>(1 or more)"
  d: "An object describing an account"

- n: "→ →<br>`involvesWatchonly`"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to `true` if the balance of this account includes a watch-only address which has received a spendable payment (that is, a payment with at least the specified number of confirmations and which is not an immature coinbase).  Otherwise not returned"

- n: "→ →<br>`account`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The name of the account"

- n: "→ →<br>`amount`<!--noref-->"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The total amount received by this account in dash"

- n: "→ →<br>`confirmations`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The number of confirmations received by the last transaction received by this account.  May be `0`"

- n: "→ →<br>`label`"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "A comment for the address/transaction"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Get the balances for all non-empty accounts, including only transactions
which have been confirmed at least six times (include InstantSend confirmations
for locked InstantSend transactions):

{% highlight bash %}
dash-cli -testnet listreceivedbyaccount 6 true false true
{% endhighlight %}

Result (edited to only show the first two results):

{% highlight json %}
[
    {
        "account" : "",
        "amount" : 0.19960000,
        "confirmations" : 53601
    },
    {
        "account" : "doc test",
        "amount" : 0.30000000,
        "confirmations" : 8991
    }
]
{% endhighlight %}

*See also*

* [ListReceivedByAddress][rpc listreceivedbyaddress]: {{summary_listReceivedByAddress}}
* [GetReceivedByAccount][rpc getreceivedbyaccount]: {{summary_getReceivedByAccount}}
* [GetReceivedByAddress][rpc getreceivedbyaddress]: {{summary_getReceivedByAddress}}


{% endautocrossref %}
