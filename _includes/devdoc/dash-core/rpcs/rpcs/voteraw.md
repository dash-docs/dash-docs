{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/voteraw.md" %}

##### VoteRaw
{% include helpers/subhead-links.md %}

{% assign summary_voteRaw="compiles and relays a governance vote with provided external signature instead of signing vote internally" %}

<!-- __ -->

{% autocrossref %}

The `voteraw` RPC {{summary_voteRaw}}


*Parameter #1---masternode transaction hash*

{% itemplate ntpd1 %}
- n: "`masternode-tx-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the masternode collateral transaction"

{% enditemplate %}

*Parameter #2---vote signal*

{% itemplate ntpd1 %}
- n: "`masternode-tx-index`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Index of the masternode collateral transaction"

{% enditemplate %}

*Parameter #3---governance hash*

{% itemplate ntpd1 %}
- n: "`governance-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the governance object"

{% enditemplate %}

*Parameter #4---vote signal*

{% itemplate ntpd1 %}
- n: "`signal`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote signal: `funding`, `valid`, or `delete`"

{% enditemplate %}

*Parameter #5---vote outcome*

{% itemplate ntpd1 %}
- n: "`outcome`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote outcome: `yes`, `no`, or `abstain`"

{% enditemplate %}

*Parameter #6---time*

{% itemplate ntpd1 %}
- n: "`time`"
  t: "int64_t"
  p: "Required<br>(exactly 1)"
  d: "Create time"

{% enditemplate %}

*Parameter #7---vote signature*

{% itemplate ntpd1 %}
- n: "`vote-sig`"
  t: "string (base64)"
  p: "Required<br>(exactly 1)"
  d: "The vote signature created by external application (i.e. [Dash Masternode Tool][] or [dashmnb][]).<br><br>Must match the Dash Core ([governance vote signature format][])."

{% enditemplate %}


*Result---votes for specified governance*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "The vote result"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet voteraw \
f6c83fd96bfaa47887c4587cceadeb9af6238a2c86fe36b883c4d7a6867eab0f 1 \
65a358fefaace40fc07053350be23e519178519290f963dab8ba92f6f85f98c3 \
funding yes 1512507255 \
H1jXKZQp1TZWBPW11E665OwmGBYV1038FohEr0au7zp+O5BCKmVDP/3rGq38ZMy3KOpwnBu6ehd6jlas79hsRBY=
{% endhighlight %}

Result:
{% highlight bash %}
Voted successfully
{% endhighlight %}

*See also:*

* [GObject][rpc gobject]: {{summary_gObject}}

{% endautocrossref %}
