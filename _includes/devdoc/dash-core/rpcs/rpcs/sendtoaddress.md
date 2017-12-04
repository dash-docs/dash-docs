{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/sendtoaddress.md" %}

##### SendToAddress
{% include helpers/subhead-links.md %}

{% assign summary_sendToAddress="spends an amount to a given address." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support. Requires an unlocked wallet or an
unencrypted wallet.*

The `sendtoaddress` RPC {{summary_sendToAddress}}

*Parameter #1---to address*

{% itemplate ntpd1 %}
- n: "To Address"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "A P2PKH or P2SH address to which the dash should be sent"

{% enditemplate %}

*Parameter #2---amount to spend*

{% itemplate ntpd1 %}
- n: "Amount"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The amount to spent in dash"

{% enditemplate %}

*Parameter #3---a comment*

{% itemplate ntpd1 %}
- n: "Comment"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "A locally-stored (not broadcast) comment assigned to this transaction.  Default is no comment"

{% enditemplate %}

*Parameter #4---a comment about who the payment was sent to*

{% itemplate ntpd1 %}
- n: "Comment To"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "A locally-stored (not broadcast) comment assigned to this transaction.  Meant to be used for describing who the payment was sent to. Default is no comment"

{% enditemplate %}

*Parameter #5---automatic fee subtraction*

{% itemplate ntpd1 %}
- n: "Subtract Fee From Amount"
  t: "boolean"
  p: "Optional<br>(0 or 1)"
  d: "The fee will be deducted from the amount being sent. The recipient will receive less dash than you enter in the amount field. Default is `false`"

{% enditemplate %}

*Parameter #6---use InstantSend*

{% itemplate ntpd1 %}
- n: "Use InstantSend"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "If set to `true`, send this transaction as InstantSend (default: false)."

{% enditemplate %}

*Parameter #7---use PrivateSend*

{% itemplate ntpd1 %}
- n: "Use PrivateSend"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "If set to `true`, use anonymized funds only (default: false)."

{% enditemplate %}

*Result---a TXID of the sent transaction*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the sent transaction, encoded as hex in RPC byte order"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Spend 0.1 dash to the address below with the comment "sendtoadress
example" and the comment-to "Nemo From Example.com":

{% highlight bash %}
dash-cli -testnet sendtoaddress ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv \
  1.0 "sendtoaddress example" "Nemo From Example.com"
{% endhighlight %}

Result:

{% highlight text %}
70e2029d363f0110fe8a0aa2ba7bd771a579453135568b2aa559b2cb30f875aa
{% endhighlight %}

*Example from Dash Core 0.12.2 (InstantSend)*

Spend 0.1 dash via InstantSend to the address below with the comment "sendtoadress
example" and the comment-to "Nemo From Example.com":

{% highlight bash %}
dash-cli -testnet sendtoaddress ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv \
  1.0 "sendtoaddress example" "Nemo From Example.com" false true
{% endhighlight %}

Result:

{% highlight text %}
af002b9c931b5efb5b2852df3d65efd48c3b9ac2ba0ef8a4cf97b894f3ff08c2
{% endhighlight %}

*Example from Dash Core 0.12.2 (PrivateSend)*

Spend 0.1 dash via PrivateSend to the address below with the comment "sendtoadress
example" and the comment-to "Nemo From Example.com":

{% highlight bash %}
dash-cli -testnet sendtoaddress ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv \
  1.0 "sendtoaddress example" "Nemo From Example.com" false false true
{% endhighlight %}

Result:

{% highlight text %}
949833bc49e0643f63e2afed1704ccccf005a93067a4e46165b06ace42544694
{% endhighlight %}

*Example from Dash Core 0.12.2 (InstantSend + PrivateSend)*

Spend 0.1 dash via InstantSend and PrivateSend to the address below with the
comment "sendtoadressexample" and the comment-to "Nemo From Example.com":

{% highlight bash %}
dash-cli -testnet sendtoaddress ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv \
  1.008 "sendtoaddress example" "Nemo From Example.com" false true true
{% endhighlight %}

Result:

{% highlight text %}
ba4bbe29fa06b67d6f3f3a73e381627e66abe22e217ce329aefad41ea72c3922
{% endhighlight %}

*See also*

* [InstantSendToAddress][rpc instantsendtoaddress]: {{summary_instantSendToAddress}}
* [SendFrom][rpc sendfrom]: {{summary_sendFrom}}
* [SendMany][rpc sendmany]: {{summary_sendMany}}
* [Move][rpc move]: {{summary_move}}

{% endautocrossref %}
