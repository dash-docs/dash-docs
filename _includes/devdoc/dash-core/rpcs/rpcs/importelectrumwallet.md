{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/importelectrumwallet.md" %}

##### ImportElectrumWallet
{% include helpers/subhead-links.md %}

{% assign summary_importElectrumWallet="imports keys from an Electrum wallet export file (.csv or .json)" %}
<!-- __ -->

{% autocrossref %}

The `importelectrumwallet` RPC {{summary_importElectrumWallet}}

*Parameter #1---file name*

{% itemplate ntpd1 %}
- n: "File Name"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The Electrum wallet export file (should be in csv or json format)"

{% enditemplate %}

*Parameter #2---index*

{% itemplate ntpd1 %}
- n: "Index"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "Rescan the wallet for transactions starting from this block index (default: 0)"

{% enditemplate %}

*Result---`null` on success*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "null"
  p: "Required<br>(exactly 1)"
  d: "If the Electrum keys are imported successfully, JSON `null` will be returned"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli importelectrumwallet /tmp/electrum-export.csv
{% endhighlight %}

(Success: no result displayed.)

*See also: none*

{% endautocrossref %}
