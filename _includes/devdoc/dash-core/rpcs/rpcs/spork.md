{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/spork.md" %}

##### Spork {#spork-rpc}
{% include helpers/subhead-links.md %}

<!-- __ -->

{% assign summary_spork-rpc="reads or updates spork settings on the network." %}

{% autocrossref %}

The `spork` RPC {{summary_spork-rpc}}

To display the status of sporks, use the `show` or `active` syntax.

*Parameter #1---Command mode*

{% itemplate ntpd1 %}
- n: "`mode`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The command mode to use:<br>`show` - Display spork values<br>`active` - Display spork activation status"

{% enditemplate %}

**Command Mode - `show`**

*Result---spork values*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing status"

- n: "→<br>`Spork<!--noref--> Value`"
  t: "int64_t"
  p: "Required<br>(1 or more)"
  d: "Spork value (epoch datetime to enable/disable)"

{% enditemplate %}

*Example from Dash Core 0.14.1*

{% highlight bash %}
dash-cli -testnet spork show
{% endhighlight %}

Result:
{% highlight json %}
{
  "SPORK_2_INSTANTSEND_ENABLED": 0,
  "SPORK_3_INSTANTSEND_BLOCK_FILTERING": 0,
  "SPORK_6_NEW_SIGS": 4000000000,
  "SPORK_9_SUPERBLOCKS_ENABLED": 0,
  "SPORK_15_DETERMINISTIC_MNS_ENABLED": 1047200,
  "SPORK_16_INSTANTSEND_AUTOLOCKS": 0,
  "SPORK_17_QUORUM_DKG_ENABLED": 0,
  "SPORK_19_CHAINLOCKS_ENABLED": 0,
  "SPORK_20_INSTANTSEND_LLMQ_BASED": 0
}
{% endhighlight %}

**Command Mode - `active`**

*Result---spork active status*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing status"

- n: "→<br>`Spork<!--noref--> Activation Status`"
  t: "bool"
  p: "Required<br>(1 or more)"
  d: "Spork activation status"

{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet spork active
{% endhighlight %}

Result:
{% highlight json %}
{
  "SPORK_2_INSTANTSEND_ENABLED": true,
  "SPORK_3_INSTANTSEND_BLOCK_FILTERING": true,
  "SPORK_6_NEW_SIGS": false,
  "SPORK_9_SUPERBLOCKS_ENABLED": true,
  "SPORK_15_DETERMINISTIC_MNS_ENABLED": true,
  "SPORK_16_INSTANTSEND_AUTOLOCKS": true,
  "SPORK_17_QUORUM_DKG_ENABLED": true,
  "SPORK_19_CHAINLOCKS_ENABLED": true,
  "SPORK_20_INSTANTSEND_LLMQ_BASED": true
}
{% endhighlight %}


To update the state of a spork activation, use the `<name> [value]` syntax.

**Command Mode - `update`**

*Parameter #1---Spork name*

{% itemplate ntpd1 %}
- n: "`name`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The name of the spork to update"

{% enditemplate %}

*Parameter #2---Spork value*

{% itemplate ntpd1 %}
- n: "`value`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "The value to assign the spork"

{% enditemplate %}

*Result---spork update status*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Update status (`success` or `failure`)"
{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet spork SPORK_2_INSTANTSEND_ENABLED 0
{% endhighlight %}

Result:
{% highlight bash %}
failure
{% endhighlight %}

*See also: none*

{% endautocrossref %}
