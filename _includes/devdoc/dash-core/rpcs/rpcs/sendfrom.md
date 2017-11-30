{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/sendfrom.md" %}

##### SendFrom
{% include helpers/subhead-links.md %}

{% assign summary_sendFrom="spends an amount from a local account to a dash address." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support. Requires an unlocked wallet or an
unencrypted wallet.*

The `sendfrom` RPC {{summary_sendFrom}}

{{WARNING}} `sendfrom` will be removed in a later version of Dash
Core.  Use the RPCs listed in the See Also subsection below instead.

*Parameter #1---from account*

{% itemplate ntpd1 %}
- n: "From Account"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The name of the account from which the dash should be spent.  Use an empty string (\"\") for the default account"

{% enditemplate %}

*Parameter #2---to address*

{% itemplate ntpd1 %}
- n: "To Address"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "A P2PKH or P2SH address to which the dash should be sent"

{% enditemplate %}

*Parameter #3---amount to spend*

{% itemplate ntpd1 %}
- n: "Amount"
  t: "number (dash)"
  p: "Required<br>(exactly 1)"
  d: "The amount to spend in dash.  Dash Core will ensure the account has sufficient dash to pay this amount (but the transaction fee paid is not included in the calculation, so an account can spend a total of its balance plus the transaction fee)"

{% enditemplate %}

*Parameter #4---minimum confirmations*

{{INCLUDE_SPEND_CONFIRMATIONS}}

*Parameter #5---whether to add 5 confirmations to transactions locked via InstantSend*

{{INCLUDE_ADD_LOCK_CONFIRMATIONS_PARAMETER}}

*Parameter #6---a comment*

{% itemplate ntpd1 %}
- n: "Comment"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "A locally-stored (not broadcast) comment assigned to this transaction.  Default is no comment"

{% enditemplate %}

*Parameter #7---a comment about who the payment was sent to*

{% itemplate ntpd1 %}
- n: "Comment To"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "A locally-stored (not broadcast) comment assigned to this transaction.  Meant to be used for describing who the payment was sent to. Default is no comment"

{% enditemplate %}

*Result---a TXID of the sent transaction*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The TXID of the sent transaction, encoded as hex in RPC byte order"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Spend 0.1 dash from the account "test" to the address indicated below
using only UTXOs with at least six confirmations, giving the
transaction the comment "Example spend" and labeling the spender
"Example.com":


{% highlight bash %}
dash-cli -testnet sendfrom "test" \
            yhJays6zGUFKq1KS5V5WLbyk3cwCXyGrKd \
            0.1 \
            6 \
            false \
            "Example spend" \
            "Example.com"
{% endhighlight %}

Result:

{% highlight text %}
cd64b9d55c63bf247f2eca32f978e340622107b607a46c422dabcdc20c0571fe
{% endhighlight %}

*See also*

* [SendToAddress][rpc sendtoaddress]: {{summary_sendToAddress}}
* [SendMany][rpc sendmany]: {{summary_sendMany}}


{% endautocrossref %}
