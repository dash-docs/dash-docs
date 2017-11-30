{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/sentinelping.md" %}

##### SentinelPing
{% include helpers/subhead-links.md %}
<!-- __ -->
{% assign summary_sentinelPing="sends a Sentinel Ping to the network." %}

{% autocrossref %}

The `sentinelping` RPC {{summary_sentinelPing}}

*Parameter #1---sentinel version*

{% itemplate ntpd1 %}
- n: "Version"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Sentinel version in the form 'x.x.x'"

{% enditemplate %}

*Result---the message signature*

{% itemplate ntpd1 %}
- n: "Result"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Ping result"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet sentinelping
{% endhighlight %}

Result:
{% highlight json %}
true
{% endhighlight %}

*See also: none*

{% endautocrossref %}
