{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/importaddress.md" %}

##### ImportAddress
{% include helpers/subhead-links.md %}

{% assign summary_importAddress="adds an address or pubkey script to the wallet without the associated private key, allowing you to watch for transactions affecting that address or pubkey script without being able to spend any of its outputs." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `importaddress` RPC {{summary_importAddress}}

*Parameter #1---the address or pubkey script to watch*

{% itemplate ntpd1 %}
- n: "Address or Script"
  t: "string (base58 or hex)"
  p: "Required<br>(exactly 1)"
  d: "Either a P2PKH or P2SH address encoded in base58check, or a pubkey script encoded as hex"

{% enditemplate %}

*Parameter #2---The account into which to place the address or pubkey script*

{% itemplate ntpd1 %}
- n: "Label"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "An optional label.  Default is an empty string(\"\")"

{% enditemplate %}

*Parameter #3---whether to rescan the block chain*

{% itemplate ntpd1 %}
- n: "Rescan"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to `true` (the default) to rescan the entire local block database for transactions affecting any address or pubkey script in the wallet (including transaction affecting the newly-added address or pubkey script).  Set to `false` to not rescan the block database (rescanning can be performed at any time by restarting Dash Core with the `-rescan` command-line argument).  Rescanning may take several minutes."

{% enditemplate %}

*Parameter #4---whether to rescan the block chain*

{% itemplate ntpd1 %}
- n: "P2SH"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Add the P2SH version of the script as well"

{% enditemplate %}

*Result---`null` on success*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "null"
  p: "Required<br>(exactly 1)"
  d: "If the address or pubkey script is added to the wallet (or is already part of the wallet), JSON `null` will be returned"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Add an address, rescanning the local block database for any transactions
matching it.

{% highlight bash %}
dash-cli -testnet importaddress \
  yg89Yt5Tjzs9nRpX3wJCuvr7KuQvgkvmeC "watch-only test" true
{% endhighlight %}

Result:

(No output<!--noref-->; success.)

Show that the address has been added:

{% highlight bash %}
dash-cli -testnet getaccount yg89Yt5Tjzs9nRpX3wJCuvr7KuQvgkvmeC
{% endhighlight %}

Result:

{% highlight text %}
watch-only test
{% endhighlight %}

*See also*

* [ImportPrivKey][rpc importprivkey]: {{summary_importPrivKey}}
* [ListReceivedByAddress][rpc listreceivedbyaddress]: {{summary_listReceivedByAddress}}

{% endautocrossref %}
