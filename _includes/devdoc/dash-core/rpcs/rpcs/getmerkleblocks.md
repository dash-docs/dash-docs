{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getmerkleblocks.md" %}
<!--__-->

##### GetMerkleBlocks
{% include helpers/subhead-links.md %}

{% assign summary_getMerkleBlocks="returns an array of hex-encoded merkleblocks for <count> blocks<!--noref--> starting from <hash> which match <filter>." %}

{% autocrossref %}

*Added in Dash Core 0.14.1*

The `getmerkleblocks` RPC {{summary_getMerkleBlocks}}

*Parameter #1---filter*

{% itemplate ntpd1 %}
- n: "filter"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The hex encoded bloom filter"

{% enditemplate %}

*Parameter #2---hash*

{% itemplate ntpd1 %}
- n: "hash"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The block hash"

{% enditemplate %}

*Parameter #3---count*

{% itemplate ntpd1 %}
- n: "count"
  t: "number (int)"
  p: "Optional<br>Default/max=2000"
  d: ""

{% enditemplate %}

*Result---the list of merkleblocks*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array of merkleblocks"

- n: "→<br>Merkle Block"
  t: "string (hex)"
  p: "Optional<br>(1 or more)"
  d: "A serialized, hex-encoded merkleblock"
{% enditemplate %}

*Example from Dash Core 0.14.1*

{% highlight bash %}
dash-cli getmerkleblocks \
	"2303028005802040100040000008008400048141010000f8400420800080025004000004130000000000000001" \
	"00000000007e1432d2af52e8463278bf556b55cf5049262f25634557e2e91202"
	2000
{% endhighlight %}

Result (truncated):
{% highlight json %}
[
  "000000202c...aefc440107",
  "0000002058...9a17830103"
]
{% endhighlight %}

*See also: none*

{% endautocrossref %}
