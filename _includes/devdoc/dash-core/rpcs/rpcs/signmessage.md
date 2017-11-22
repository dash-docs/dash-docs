{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/signmessage.md" %}

##### SignMessage
{% include helpers/subhead-links.md %}
<!-- __ -->
{% assign summary_signMessage="signs a message with the private key of an address." %}

{% autocrossref %}

*Requires wallet support. Requires an unlocked wallet or an
unencrypted wallet.*

The `signmessage` RPC {{summary_signMessage}}

*Parameter #1---the address corresponding to the private key to sign with*

{% itemplate ntpd1 %}
- n: "Address"
  t: "string (base58)"
  p: "Required<br>(exactly 1)"
  d: "A P2PKH address whose private key belongs to this wallet"

{% enditemplate %}

*Parameter #2---the message to sign*

{% itemplate ntpd1 %}
- n: "Message"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The message to sign"

{% enditemplate %}

*Result---the message signature*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (base64)"
  p: "Required<br>(exactly 1)"
  d: "The signature of the message, encoded in base64."

{% enditemplate %}

*Example from Dash Core 0.12.2*

Sign a the message "Hello, World!" using the following address:

{% highlight bash %}
dash-cli -testnet signmessage yNpezfFDfoikDuT1f4iK75AiLp2YLPsGAb "Hello, World!"
{% endhighlight %}

Result:

{% highlight text %}
H4XULzfHCf16In2ECk9Ta9QxQPq639zQto2JA3OLlo3JbUdrClvJ89+A1z+Z9POd6l8LJhn1jGpQYF8mX4jkQvE=
{% endhighlight %}

*See also*

* [VerifyMessage][rpc verifymessage]: {{summary_verifyMessage}}

{% endautocrossref %}
