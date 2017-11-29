{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/lockunspent.md" %}

##### LockUnspent
{% include helpers/subhead-links.md %}

{% assign summary_lockUnspent="temporarily locks or unlocks specified transaction outputs. A locked transaction output will not be chosen by automatic coin selection when spending dash. Locks are stored in memory only, so nodes start with zero locked outputs and the locked output list is always cleared when a node stops or fails." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `lockunspent` RPC {{summary_lockUnspent}}

*Parameter #1---whether to lock or unlock the outputs*

{% itemplate ntpd1 %}
- n: "Unlock"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Set to `false` to lock the outputs specified in the following parameter.  Set to `true` to unlock the outputs specified.  If this is the only argument specified and it is set to `true`, all outputs will be unlocked; if it is the only argument and is set to `false`, there will be no change"

{% enditemplate %}

*Parameter #2---the outputs to lock or unlock*

{% itemplate ntpd1 %}
- n: "Outputs"
  t: "array"
  p: "Optional<br>(0 or 1)"
  d: "An array of outputs to lock or unlock"

- n: "→<br>Output"
  t: "object"
  p: "Required<br>(1 or more)"
  d: "An object describing a particular output"

- n: "→ →<br>`txid`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the transaction containing the output to lock or unlock, encoded as hex in internal byte order"

- n: "→ →<br>`vout`"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The output index number (vout) of the output to lock or unlock.  The first output in a transaction has an index of `0`"

{% enditemplate %}

*Result---`true` if successful*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Set to `true` if the outputs were successfully locked or unlocked.  If the outputs were already locked or unlocked, it will also return `true`"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Lock two outputs:

{% highlight bash %}
dash-cli -testnet lockunspent false '''
  [
    {
      "txid": "d3d57ec5e4168b7145e911d019e9713563c1f2db5b2d6885739ea887feca4c87",
      "vout": 0
    },
    {
      "txid": "607897611b2f7c5b23297b2a352a8d6f4383f8d0782585f93220082d361f8db9",
      "vout": 1
    }
  ]
'''
{% endhighlight %}

Result:

{% highlight json %}
true
{% endhighlight %}

Verify the outputs have been locked:

{% highlight bash %}
dash-cli -testnet listlockunspent
{% endhighlight %}

Result

{% highlight json %}
[
  {
    "txid": "d3d57ec5e4168b7145e911d019e9713563c1f2db5b2d6885739ea887feca4c87",
    "vout": 0
  },
  {
    "txid": "607897611b2f7c5b23297b2a352a8d6f4383f8d0782585f93220082d361f8db9",
    "vout": 1
  }
]
{% endhighlight %}

Unlock one of the above outputs:

{% highlight bash %}
dash-cli -testnet lockunspent true '''
[
  {
    "txid": "607897611b2f7c5b23297b2a352a8d6f4383f8d0782585f93220082d361f8db9",
    "vout": 1
  }
]
'''
{% endhighlight %}

Result:

{% highlight json %}
true
{% endhighlight %}

Verify the output has been unlocked:

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

* [ListLockUnspent][rpc listlockunspent]: {{summary_listLockUnspent}}
* [ListUnspent][rpc listunspent]: {{summary_listUnspent}}

{% endautocrossref %}
