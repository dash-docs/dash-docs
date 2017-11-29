{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/listsinceblock.md" %}

##### ListSinceBlock
{% include helpers/subhead-links.md %}

{% assign summary_listSinceBlock="gets all transactions affecting the wallet which have occurred since a particular block, plus the header hash of a block at a particular depth." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `listsinceblock` RPC {{summary_listSinceBlock}}

*Parameter #1---a block header hash*

{% itemplate ntpd1 %}
- n: "Header Hash"
  t: "string (hex)"
  p: "Optional<br>(0 or 1)"
  d: "The hash of a block header encoded as hex in RPC byte order.  All transactions affecting the wallet which are not in that block or any earlier block will be returned, including unconfirmed transactions.  Default is the hash of the genesis block, so all transactions affecting the wallet are returned by default"

{% enditemplate %}

*Parameter #2---the target confirmations for the lastblock field*

{% itemplate ntpd1 %}
- n: "Target Confirmations"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "Sets the lastblock field of the results to the header hash of a block with this many confirmations.  This does not affect which transactions are returned.  Default is `1`, so the hash of the most recent block on the local best block chain is returned"

{% enditemplate %}

*Parameter #3---whether to include watch-only addresses in details and calculations*

{{INCLUDE_INCLUDE_WATCH_ONLY_PARAMETER}}

**Result**

{% assign DEPTH="→ → → " %}
{% include helpers/vars.md %}

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object containing an array of transactions and the lastblock field"

- n: "→<br>`transactions`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array of objects each describing a particular **payment** to or from this wallet.  The objects in this array do not describe an actual transactions, so more than one object in this array may come from the same transaction.  This array may be empty"

- n: "→ →<br>Payment"
  t: "object"
  p: "Optional<br>(0 or more)"
  d: "An payment which did not appear in the specified block or an earlier block"

{{INCLUDE_F_LIST_TRANSACTIONS}}
{{INCLUDE_F_LIST_TRANSACTIONS_F_FULL}}
- n: "→<br>`lastblock`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The header hash of the block with the number of confirmations specified in the *target confirmations* parameter, encoded as hex in RPC byte order"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Get all transactions since a particular block (including watch-only
transactions) and the header hash of the sixth most recent block.

{% highlight bash %}
dash-cli -testnet listsinceblock \
              00000000688633a503f69818a70eac281302e9189b1bb57a76a05c329fcda718 \
              6 true
{% endhighlight %}

Result (edited to show only two payments):

{% highlight json %}
{
  "transactions": [
    {
      "account": "",
      "address": "yfCjqf9F7oNGD1sRqta2rNpCXSQ9dknDf5",
      "category": "send",
      "amount": -0.01000010,
      "vout": 7,
      "fee": 0.05000050,
      "confirmations": 95,
      "instantlock": false,
      "blockhash": "0000000002aa705754c6ab4e15cf2183a1d174e61c080f64eb469c458669144b",
      "blockindex": 1,
      "blocktime": 1511972930,
      "txid": "52e34eec71a4cf95c043b76567f55cec1bc293c444810d454a2d05f2a819b5ed",
      "walletconflicts": [
      ],
      "time": 1511972930,
      "timereceived": 1511974218,
      "bip125-replaceable": "no",
      "abandoned": false
    },
    {
      "account": "",
      "address": "yi2U4Cx2QH33LdNwk2c2oLABWzEZWhYU9k",
      "category": "send",
      "amount": -0.01000010,
      "vout": 8,
      "fee": 0.05000050,
      "confirmations": 95,
      "instantlock": false,
      "blockhash": "0000000002aa705754c6ab4e15cf2183a1d174e61c080f64eb469c458669144b",
      "blockindex": 1,
      "blocktime": 1511972930,
      "txid": "52e34eec71a4cf95c043b76567f55cec1bc293c444810d454a2d05f2a819b5ed",
      "walletconflicts": [
      ],
      "time": 1511972930,
      "timereceived": 1511974218,
      "bip125-replaceable": "no",
      "abandoned": false
    }
  ],
  "lastblock": "000000000dba5583e3fc5c2df06b478e922702f53a1476aac8eb4322f648ccea"
}

{% endhighlight %}

*See also*

* [ListReceivedByAccount][rpc listreceivedbyaccount]: {{summary_listReceivedByAccount}}
* [ListReceivedByAddress][rpc listreceivedbyaddress]: {{summary_listReceivedByAddress}}

{% endautocrossref %}
