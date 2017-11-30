{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/importpubkey.md" %}

##### ImportPubKey
{% include helpers/subhead-links.md %}

{% assign summary_importPubKey="imports a public key (in hex) that can be watched as if it were in your wallet but cannot be used to spend" %}

<!-- __ -->

{% autocrossref %}

The `importpubkey` RPC {{summary_importPubKey}}

*Parameter #1---the public key to import*

{% itemplate ntpd1 %}
- n: "Private Key"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The public key to import"

{% enditemplate %}

*Parameter #2---the account into which the key should be placed*

{% itemplate ntpd1 %}
- n: "Label"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "The label the key should be assigned"

{% enditemplate %}

*Parameter #3---whether to rescan the block chain*

{% itemplate ntpd1 %}
- n: "Rescan"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Set to `true` (the default) to rescan the entire local block database for transactions affecting any address or pubkey script in the wallet.  Set to `false` to not rescan the block database (rescanning can be performed at any time by restarting Dash Core with the `-rescan` command-line argument).  Rescanning may take several minutes.  Notes: if the address for this key is already in the wallet, the block database will not be rescanned even if this parameter is set"

{% enditemplate %}

*Result---`null` on success*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "null"
  p: "Required<br>(exactly 1)"
  d: "If the public key is added to the wallet (or is already part of the wallet), JSON `null` will be returned"

{% enditemplate %}

*Example from Dash Core 0.12.2*


Import the public key for the address, giving it a label and scanning the
entire block chain:

{% highlight bash %}
dash-cli -testnet importpubkey \
    0210c1349657c1253d3d64d1b31d3500b09335bf12b8df061666e216f550a43249 \
    "test label" \
    true
{% endhighlight %}

(Success: no result displayed.)

*See also:*

* [ImportAddress][rpc importaddress]: {{summary_importAddress}}
* [ImportPrivKey][rpc importprivkey]: {{summary_importPrivKey}}
* [ImportWallet][rpc importwallet]: {{summary_importWallet}}

{% endautocrossref %}
