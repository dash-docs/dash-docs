{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/keepass.md" %}

##### KeePass
{% include helpers/subhead-links.md %}

{% assign summary_keepass="provides commands for configuring and managing KeePass authentication" %}

<!-- __ -->

{% autocrossref %}

The `keepass` RPC {{summary_keepass}}

*Parameter #1---Command mode*

{% itemplate ntpd1 %}
- n: "`mode`"
  t: "string"
  p: "Required (exactly 1)"
  d: "The command mode to use:<br>`genkey`,<br>`init`,<br>`setpassphrase`"

{% enditemplate %}

*Command Options*

Mode | Description
--- | --- | --- |
`genkey` | Generates a base64 encoded 256 bit AES key that can be used for the communication with KeePassHttp. This is only necessary for manual configuration.
`init` | Sets up the association between Dash Core and KeePass by generating an AES key and sending an association message to KeePassHttp. This will trigger KeePass to ask for an Id for the association. Returns the association and the base64 encoded string for the AES key.
`setpassphrase` | Updates the passphrase in KeePassHttp to a new value. This should match the passphrase you intend to use for the wallet. Please note that the standard RPC commands walletpassphrasechange and the wallet encryption from the QT GUI already send the updates to KeePassHttp, so this is only necessary for manual manipulation of the password.


**Command Mode - `genkey`**

*Result---the new key*

{% itemplate ntpd1 %}
- n: "Result"
  t: "string (base64)"
  p: "Required (exactly 1)"
  d: "The new key"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Manually generate a key

{% highlight bash %}
dash-cli -testnet keepass genkey
{% endhighlight %}

Result:
{% highlight bash %}
Generated Key: dNjo+J8Jb30txbJiKq4s9H6vEgWq/whb1w9bb2cTOFo=
{% endhighlight %}  


**Command Mode - `init`**

*Result---initialization response*

{% itemplate ntpd1 %}
- n: "Result"
  t: "string"
  p: "Required (exactly 1)"
  d: "The success/error status"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Automatically initialize

{% highlight bash %}
dash-cli -testnet keepass init
{% endhighlight %}

Result (wrapped):
{% highlight bash %}
Association successful. Id: testwalletassociation - \
Key: MSb+JLygqz7ZH40SyJ1QR62i00IXoa3tmT85MGGI2K0=
{% endhighlight %}  


**Command Mode - `setpassphrase`**

*Parameter #2---Passphrase*

{% itemplate ntpd1 %}
- n: "Passphrase"
  t: "string"
  p: "Required (exactly 1)"
  d: "The passphrase to set"

{% enditemplate %}

*Result---status*

{% itemplate ntpd1 %}
- n: "Result"
  t: "string"
  p: "Required (exactly 1)"
  d: "The success/error status"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Set KeePass passphrase

{% highlight bash %}
dash-cli -testnet keepass setpassphrase 1BWi20Xyk76uWumxJQy4
{% endhighlight %}

Result:
{% highlight bash %}
setlogin: Updated credentials.
{% endhighlight %}  

*See also: none*

{% endautocrossref %}
