{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/instantsendtoaddress.md" %}

##### InstantSendToAddress
{% include helpers/subhead-links.md %}

{% assign summary_instantSendToAddress="InstantSend an amount to a given address." %}

<!-- __ -->

{% autocrossref %}

The `instantsendtoaddress` RPC {{summary_instantSendToAddress}}

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

*Result---a TXID of the sent transaction*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the sent transaction, encoded as hex in RPC byte order"

{% enditemplate %}

*Example from Dash Core 0.12.2*

InstantSend 0.1 dash to the address below with the comment "instantsendtoadress
example" and the comment-to "Nemo From Example.com":

{% highlight bash %}
dash-cli -testnet instantsendtoaddress ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv \
  1.0 "instantsendtoadress example" "Nemo From Example.com"
{% endhighlight %}

Result:

{% highlight text %}
70e2029d363f0110fe8a0aa2ba7bd771a579453135568b2aa559b2cb30f875aa
{% endhighlight %}

*See also:*

* [SendFrom][rpc sendfrom]: {{summary_sendFrom}}
* [SendMany][rpc sendmany]: {{summary_sendMany}}
* [SendToAddress][rpc sendtoaddress]: {{summary_sendToAddress}}
* [Move][rpc move]: {{summary_move}}

{% endautocrossref %}
