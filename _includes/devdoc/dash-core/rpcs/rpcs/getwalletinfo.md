{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getwalletinfo.md" %}

##### GetWalletInfo
{% include helpers/subhead-links.md %}

{% assign summary_getWalletInfo="provides information about the wallet." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `getwalletinfo` RPC {{summary_getWalletInfo}}

*Parameters: none*

*Result---information about the wallet*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object describing the wallet"

- n: "→<br>`walletversion`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The version number of the wallet"

- n: "→<br>`balance`"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The total confirmed balance of the wallet.  The same as returned by the `getbalance` RPC with default parameters"

- n: "→<br>`unconfirmed_balance`"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The total unconfirmed balance of the wallet.  The same as returned by the `getunconfirmedbalance` RPC with default parameters"

- n: "→<br>`immature_balance`"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The total immature balance of the wallet.  This includes mining/masternode rewards that cannot be spent yet"

- n: "→<br>`txcount`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The total number of transactions in the wallet (both spends and receives)"

- n: "→<br>`keypoololdest`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The date as Unix epoch time when the oldest key in the wallet key pool was created; useful for only scanning blocks created since this date for transactions"

- n: "→<br>`keypoolsize`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The number of keys in the wallet keypool"

- n: "→<br>`keypoolsize_hd_internal`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "How many new keys are pre-generated for internal use (used for change outputs, only appears if the wallet is using this feature, otherwise external keys are used)"

- n: "→<br>`keys_left`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The number of unused keys left since the last automatic backup"

- n: "→<br>`unlocked_until`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "Only returned if the wallet was encrypted with the `encryptwallet` RPC. A Unix epoch date when the wallet will be locked, or `0` if the wallet is currently locked"

- n: "→<br>`paytxfee`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The transaction fee configuration, set in DASH/kB"

- n: "→<br>`hdchainid`"
  t: "string (hash)"
  p: "Optional<br>(0 or 1)"
  d: "The ID of the HD chain"

- n: "→<br>`hdaccountcount`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "How many accounts of the HD chain are in this wallet"

- n: "→ →<br>`hdaccountcountindex`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "The index of the account"

- n: "→ →<br>`hdexternalkeyindex`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "Current external child key index"

- n: "→ →<br>`hdinternalkeyindex`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "Current internal child key index"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet getwalletinfo
{% endhighlight %}

Result:

{% highlight json %}
{
  "walletversion": 61000,
  "balance": 3000.00000000,
  "unconfirmed_balance": 10.10000000,
  "immature_balance": 11.25000000,
  "txcount": 267,
  "keypoololdest": 1508428379,
  "keypoolsize": 999,
  "keys_left": 978,
  "unlocked_until": 0,
  "paytxfee": 0.00000000
}
{% endhighlight %}

*See also*

* [ListTransactions][rpc listtransactions]: {{summary_listTransactions}}

{% endautocrossref %}
