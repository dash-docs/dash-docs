{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/gettransaction.md" %}

##### GetTransaction
{% include helpers/subhead-links.md %}

{% assign summary_getTransaction="gets detailed information about an in-wallet transaction." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `gettransaction` RPC {{summary_getTransaction}}

*Parameter #1---a transaction identifier (TXID)*

{% itemplate ntpd1 %}
- n: "TXID"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the transaction to get details about.  The TXID must be encoded as hex in RPC byte order"

{% enditemplate %}

*Parameter #2---whether to include watch-only addresses in details and calculations*

{{INCLUDE_INCLUDE_WATCH_ONLY_PARAMETER}}

*Result---a description of the transaction*

{% assign DEPTH="→ " %}
{% include helpers/vars.md %}

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object describing how the transaction affects the wallet"

- n: "→<br>`amount`"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "A positive number of dash if this transaction increased the total wallet balance; a negative number of dash if this transaction decreased the total wallet balance, or `0` if the transaction had no net effect on wallet balance"

- n: "→<br>`fee`"
  t: "number (dash)"
  p: "Optional<br>(0 or 1)"
  d: "If an outgoing transaction, this is the fee paid by the transaction reported as negative dash"

- n: "→<br>`instantlock`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Current transaction lock state"

{{INCLUDE_F_LIST_TRANSACTIONS_F_FULL}}

- n: "→<br>`DS`"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to 1 if a PrivateSend transaction"

- n: "→<br>`details`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing one object for each input or output in the transaction which affected the wallet"

- n: "→ → <br>`involvesWatchonly`"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to `true` if the input or output involves a watch-only address.  Otherwise not returned"

- n: "→ →<br>`account`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The account which the payment was credited to or debited from.  May be an empty string (\"\") for the default account"

- n: "→ →<br>`address`"
  t: "string (base58)"
  p: "Optional<br>(0 or 1)"
  d: "If an output, the address paid (may be someone else's address not belonging to this wallet).  If an input, the address paid in the previous output.  May be empty if the address is unknown, such as when paying to a non-standard pubkey script"

- n: "→ →<br>`category`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Set to one of the following values:<br>• `send` if sending payment normally<br>• `privatesend` if sending PrivateSent payment<br>• `receive` if this wallet received payment in a regular transaction<br>• `generate` if a matured and spendable coinbase<br>• `immature` if a coinbase that is not spendable yet<br>• `orphan` if a coinbase from a block that's not in the local best block chain"

- n: "→ →<br>`amount`"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "A negative dash amount if sending payment; a positive dash amount if receiving payment (including coinbases)"

- n: "→ →<br>`vout`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "For an output, the output index (vout) for this output in this transaction.  For an input, the output index for the output being spent in its transaction.  Because inputs list the output indexes from previous transactions, more than one entry in the details array may have the same output index"

- n: "→ →<br>`fee`"
  t: "number (dash)"
  p: "Optional<br>(0 or 1)"
  d: "If sending payment, the fee paid as a negative dash value.  May be `0`.  Not returned if receiving payment"

- n: "→ →<br>`abandoned`"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "*Added in Bitcoin Core 0.12.1*<br><br>Indicates if a transaction is was abandoned:<br>• `true` if it was abandoned (inputs are respendable)<br>• `false`  if it was not abandoned<br>Only returned by *send* category payments"

- n: "→<br>`hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The transaction in serialized transaction format"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gettransaction \
  345d5f708b047b145f6a40a4e1e36c76648611cd009bd073e607c8ddf47bb797
{% endhighlight %}

Result:

{% highlight json %}
{
  "amount": 0.00000000,
  "fee": -0.00010000,
  "confirmations": 20,
  "instantlock": false,
  "trusted": true,
  "txid": "345d5f708b047b145f6a40a4e1e36c76648611cd009bd073e607c8ddf47bb797",
  "walletconflicts": [
  ],
  "time": 1511967821,
  "timereceived": 1511967821,
  "bip125-replaceable": "no",
  "DS": "1",
  "details": [
    {
      "account": "",
      "address": "ybTSbNqB7nG4ZVbHyati6GbfFz5w7tDnHf",
      "category": "privatesend",
      "amount": -10.00000000,
      "label": "PS",
      "vout": 0,
      "fee": -0.00010000,
      "abandoned": false
    },
    {
      "account": "PS",
      "address": "ybTSbNqB7nG4ZVbHyati6GbfFz5w7tDnHf",
      "category": "receive",
      "amount": 10.00000000,
      "label": "PS",
      "vout": 0
    }
  ],
  "hex": "010000000156d338508686982770a101c9fd41ce8b2c6ff4eb17dac6b1e7a32dfc5d2ae6e9030000006b4830450221008e8bf68440818d2b2fe8bcc2447d3b455f4e27864dae3f2bc62d2c8d1fdadaad0220390a0810f7f75436a7ebb0bc5c5a5e377b2330e1395f42b5f96d249ac9705ffc012103f4398f7e93dcc64a24191dbae57ef1ccbfcbd867f39a714020e66cf5b10050c4feffffff0100ca9a3b000000001976a914a60d00463c9eed290555e8f719333fc6b21c636088ac89850000"
}

{% endhighlight %}

*See also*

* [GetRawTransaction][rpc getrawtransaction]: {{summary_getRawTransaction}}

{% endautocrossref %}
