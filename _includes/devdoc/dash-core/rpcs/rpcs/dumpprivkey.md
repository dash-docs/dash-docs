{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/dumpprivkey.md" %}

##### DumpPrivKey
{% include helpers/subhead-links.md %}

{% assign summary_dumpPrivKey="returns the wallet-import-format (WIP) private key corresponding to an address. (But does not remove it from the wallet.)" %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support. Requires an unlocked wallet or an
unencrypted wallet.*

The `dumpprivkey` RPC {{summary_dumpPrivKey}}

*Parameter #1---the address corresponding to the private key to get*

{% itemplate ntpd1 %}
- n: "P2PKH Address"
  t: "string (base58)"
  p: "Required<br>(exactly 1)"
  d: "The P2PKH address corresponding to the private key you want returned.  Must be the address corresponding to a private key in this wallet"

{% enditemplate %}

*Result---the private key*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (base58)"
  p: "Required<br>(exactly 1)"
  d: "The private key encoded as base58check using wallet import format"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet dumpprivkey ycBuREgSskHHkWLxDa9A5WppCki6PfFycL
{% endhighlight %}

Result:

{% highlight text %}
cQZZ4awQvcXXyES3CmUJqSgeTobQm9t9nyUr337kvUtsWsnvvMyw
{% endhighlight %}

*See also*

* [ImportPrivKey][rpc importprivkey]: {{summary_importPrivKey}}
* [DumpWallet][rpc dumpwallet]: {{summary_dumpWallet}}

{% endautocrossref %}
