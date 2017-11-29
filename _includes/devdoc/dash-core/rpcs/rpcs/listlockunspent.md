{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/listlockunspent.md" %}

##### ListLockUnspent
{% include helpers/subhead-links.md %}

{% assign summary_listLockUnspent="returns a list of temporarily unspendable (locked) outputs." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `listlockunspent` RPC {{summary_listLockUnspent}}

*Parameters: none*

*Result---an array of locked outputs*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing all locked outputs.  May be empty"

- n: "→<br>Output"
  t: "object"
  p: "Optional<br>(1 or more)"
  d: "An object describing a particular locked output"

- n: "→ →<br>`txid`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the transaction containing the locked output, encoded as hex in RPC byte order"

- n: "→ →<br>`vout`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The output index number (vout) of the locked output within the transaction.  Output index `0` is the first output within the transaction"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet listlockunspent
{% endhighlight %}

Result:

{% highlight json %}
[
  {
    "txid": "d3d57ec5e4168b7145e911d019e9713563c1f2db5b2d6885739ea887feca4c87",
    "vout": 0
  }
]
{% endhighlight %}

*See also*

* [LockUnspent][rpc lockunspent]: {{summary_lockUnspent}}

{% endautocrossref %}
