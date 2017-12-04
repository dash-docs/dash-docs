{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/dumphdinfo.md" %}

##### DumpHDInfo
{% include helpers/subhead-links.md %}

{% assign summary_dumpHDInfo="returns an object containing sensitive private info about this HD wallet" %}

<!-- __ -->

{% autocrossref %}

The `dumphdinfo` RPC {{summary_dumpHDInfo}}

*Parameters: none*

*Result---HD wallet information*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object containing sensitive private info about this HD wallet."

- n: "→ <br>`hdseed`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The BIP-32 HD seed (in hex)"

- n: "→ <br>`mnemonic`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The BIP-39 mnemonic for this HD wallet (English words)"

- n: "→ <br>`mnemonicpassphrase`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The BIP-39 mnemonic passphrase for this HD wallet (may be empty)"

{% enditemplate %}


*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet dumphdinfo
{% endhighlight %}

Result (truncated for security reasons):
{% highlight json %}
{
  "hdseed": "20c63c3fb298ebd52de3 ...",
  "mnemonic": "cost circle shiver ...",
  "mnemonicpassphrase": ""
}
{% endhighlight %}

*See also: none*

{% endautocrossref %}
