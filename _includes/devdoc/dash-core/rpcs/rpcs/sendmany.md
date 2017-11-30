{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/sendmany.md" %}

##### SendMany
{% include helpers/subhead-links.md %}

{% assign summary_sendMany="creates and broadcasts a transaction which sends outputs to multiple addresses." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support. Requires an unlocked wallet or an
unencrypted wallet.*

The `sendmany` RPC {{summary_sendMany}}

*Parameter #1---from account*

{% itemplate ntpd1 %}
- n: "From Account"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "*Deprecated: will be removed in a later version of Dash Core*<br><br>The name of the account from which the dash should be spent.  Use an empty string (\"\") for the default account. Dash Core will ensure the account has sufficient dash to pay the total amount in the *outputs* field described below (but the transaction fee paid is not included in the calculation, so an account can spend a total of its balance plus the transaction fee)"

{% enditemplate %}

*Parameter #2---the addresses and amounts to pay*

{% itemplate ntpd1 %}
- n: "Outputs"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object containing key/value pairs corresponding to the addresses and amounts to pay"

- n: "→<br>Address/Amount"
  t: "string (base58) : number (dash)"
  p: "Required<br>(1 or more)"
  d: "A key/value pair with a base58check-encoded string containing the P2PKH or P2SH address to pay as the key, and an amount of dash to pay as the value"

{% enditemplate %}

*Parameter #3---minimum confirmations*

{{INCLUDE_SPEND_CONFIRMATIONS}}

*Parameter #4--whether to add 5 confirmations to transactions locked via InstantSend*
{{INCLUDE_ADD_LOCK_CONFIRMATIONS_PARAMETER}}

*Parameter #5---a comment*

{% itemplate ntpd1 %}
- n: "Comment"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "A locally-stored (not broadcast) comment assigned to this transaction.  Default is no comment"

{% enditemplate %}

*Parameter #6---automatic fee subtraction*

{% itemplate ntpd1 %}
- n: "Subtract Fee From Amount"
  t: "array"
  p: "Optional<br>(0 or 1)"
  d: "An array of addresses.  The fee will be equally divided by as many addresses as are entries in this array and subtracted from each address.  If this array is empty or not provided, the fee will be paid by the sender"

- n: "→<br>Address"
  t: "string (base58)"
  p: "Optional (0 or more)"
  d: "An address previously listed as one of the recipients."
{% enditemplate %}

*Parameter #7---use InstantSend*

{% itemplate ntpd1 %}
- n: "Use InstantSend"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "If set to `true`, send this transaction as InstantSend (default: false)."

{% enditemplate %}

*Parameter #8---use PrivateSend*

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

From the account *test1*, send 0.1 dash to the first address and 0.2
dash to the second address, with a comment of "Example Transaction".

{% highlight bash %}
dash-cli -testnet sendmany \
  "test1" \
  '''
    {
      "ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv": 0.1,
      "yhQrX8CZTTfSjKmaq5h7DgSShyEsumCRBi": 0.2
    } ''' \
  6       \
  false   \
  "Example Transaction"
{% endhighlight %}

Result:

{% highlight text %}
a7c0194a005a220b9bfeb5fdd12d5b90979c10f53de4f8a48a1495aa198a6b95
{% endhighlight %}

*Example from Dash Core 0.12.2 (InstantSend)*

From the account *test1*, send 0.1 dash to the first address and 0.2
dash to the second address using InstantSend, with a comment of "Example Transaction".

{% highlight bash %}
dash-cli -testnet sendmany \
  "test1" \
  '''
    {
      "ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv": 0.1,
      "yhQrX8CZTTfSjKmaq5h7DgSShyEsumCRBi": 0.2
    } ''' \
  6       \
  false   \
  "Example Transaction"
  '''
    [""]
  '''     \
  true
{% endhighlight %}

Result:

{% highlight text %}
3a5bbaa1a7aa3a8af45e8f1adf79528f99efc61052b0616d41b33fb8fb7af347
{% endhighlight %}

*Example from Dash Core 0.12.2 (PrivateSend)*

From the account *test1*, send 0.1 dash to the first address and 0.2
dash to the second address using PrivateSend, with a comment of "Example Transaction".

{% highlight bash %}
dash-cli -testnet sendmany \
  "test1" \
  '''
    {
      "ySutkc49Khpz1HQN8AfWNitVBLwqtyaxvv": 0.1,
      "yhQrX8CZTTfSjKmaq5h7DgSShyEsumCRBi": 0.2
    } ''' \
  6       \
  false   \
  "Example Transaction"
  '''
    [""]
  '''    \
  false  \
  true
{% endhighlight %}

Result:

{% highlight text %}
43337c8e4f3b21bedad7765fa851a6e855e4bb04f60d6b3e4c091ed21ffc5753
{% endhighlight %}

*See also*

* [SendFrom][rpc sendfrom]: {{summary_sendFrom}}
* [SendToAddress][rpc sendtoaddress]: {{summary_sendToAddress}}
* [Move][rpc move]: {{summary_move}}

{% endautocrossref %}
