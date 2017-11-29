{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/listreceivedbyaddress.md" %}

##### ListReceivedByAddress
{% include helpers/subhead-links.md %}

{% assign summary_listReceivedByAddress="lists the total number of dash received by each address." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `listreceivedbyaddress` RPC {{summary_listReceivedByAddress}}

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

*Result---addresses, account names, balances, and minimum confirmations*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing objects each describing a particular address"

- n: "→<br>Address"
  t: "object"
  p: "Optional<br>(0 or more)"
  d: "An object describing an address"

- n: "→ →<br>`involvesWatchonly`"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to `true` if this address is a watch-only address which has received a spendable payment (that is, a payment with at least the specified number of confirmations and which is not an immature coinbase).  Otherwise not returned"

- n: "→ →<br>`address`"
  t: "string (base58)"
  p: "Required<br>(exactly 1)"
  d: "The address being described encoded in base58check"

- n: "→ →<br>`account`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "*Deprecated: will be removed in a later version of Dash Core*<br><br>The account the address belongs to.  May be the default account, an empty string (\"\")"

- n: "→ →<br>`amount`"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The total amount the address has received in dash"

- n: "→ →<br>`confirmations`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The number of confirmations of the latest transaction to the address.  May be `0` for unconfirmed"

- n: "→ →<br>`label`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The account the address belongs to.  May be the default account, an empty string (\"\")"    

- n: "→ →<br>`txids`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array of TXIDs belonging to transactions that pay the address"

- n: "→ → →<br>TXID"
  t: "string"
  p: "Optional<br>(0 or more)"
  d: "The TXID of a transaction paying the address, encoded as hex in RPC byte order"

{% enditemplate %}

*Example from Dash Core 0.12.2*

List addresses with balances confirmed by at least six blocks, including
watch-only addresses (include InstantSend confirmations for locked InstantSend
transactions):

{% highlight bash %}
dash-cli -testnet listreceivedbyaddress 6 true false true
{% endhighlight %}

Result (edit to show only two entries):

{% highlight json %}
[
  {
    "address": "yV3ZTfwyfUmpspncMSitiwzh7EvqSGrqZA",
    "account": "",
    "amount": 1000.00000000,
    "confirmations": 26779,
    "label": "",
    "txids": [
      "0456aaf51a8df21dd47c2a06ede046a5bf7403bcb95d14d1d71b178c189fb933"
    ]
  },
  {
    "involvesWatchonly" : true,
    "address": "yfoR9uM3rcDfUc7AEfUNm5BjVYGFw7uQ9w",
    "account": "Watching",
    "amount": 1877.78476068,
    "confirmations": 26876,
    "label": "Watching",
    "txids": [
      "cd64114c803a2a243cb6ce4eb5c98e60cd2c688be8e900b3b957fe520cf42601",
      "83d3f7f31926908962e336341b1895d5f734f9d7149bdb35f0381cc78019bd83"
    ]
  }
]
{% endhighlight %}

*See also*

* [ListReceivedByAccount][rpc listreceivedbyaccount]: {{summary_listReceivedByAccount}}
* [GetReceivedByAddress][rpc getreceivedbyaddress]: {{summary_getReceivedByAddress}}
* [GetReceivedByAccount][rpc getreceivedbyaccount]: {{summary_getReceivedByAccount}}


{% endautocrossref %}
