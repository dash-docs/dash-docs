{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/createmultisig.md" %}

##### CreateMultiSig
{% include helpers/subhead-links.md %}

{% assign summary_createMultiSig="creates a P2SH multi-signature address." %}

{% autocrossref %}

The `createmultisig` RPC {{summary_createMultiSig}}

*Parameter #1---the number of signatures required*

{% itemplate ntpd1 %}
- n: "Required"
  t: "number (int)"
  p: "Required<br>(exactly 1)"
  d: "The minimum (*m*) number of signatures required to spend this m-of-n multisig script"

{% enditemplate %}

*Parameter #2---the full public keys, or addresses for known public keys*

{% itemplate ntpd1 %}
- n: "Keys Or Addresses"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array of strings with each string being a public key or address"

- n: "→<br>Key Or Address"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "A public key against which signatures will be checked.  If wallet support is enabled, this may be a P2PKH address belonging to the wallet---the corresponding public key will be substituted.  There must be at least as many keys as specified by the Required parameter, and there may be more keys"

{% enditemplate %}

*Result---P2SH address and hex-encoded redeem script*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object describing the multisig address"

- n: "→<br>`address`"
  t: "string (base58)"
  p: "Required<br>(exactly 1)"
  d: "The P2SH address for this multisig redeem script"

- n: "→<br>`redeemScript`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The multisig redeem script encoded as hex"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Creating a 2-of-3 P2SH multisig address by mixing two P2PKH addresses and
one full public key:

{% highlight bash %}
dash-cli -testnet createmultisig 2 '''
  [
    "yNpezfFDfoikDuT1f4iK75AiLp2YLPsGAb",
    "0311f97539724e0de38fb1ff79f5148e5202459d06ed07193ab18c730274fd0d88",
    "yVJj7TB3ZhMcSP2wo65ZFNqy23BQH9tT87"
  ]
'''
{% endhighlight %}

Result:

{%highlight json %}
{
  "address": "8uJLxDxk2gEMbidF5vT8XLS2UCgQmVcroW",
  "redeemScript": "522102eacba539d92eb88d4e73bb32749d79f53f6e8d7947ac40a71bd4b26c13b6ec29210311f97539724e0de38fb1ff79f5148e5202459d06ed07193ab18c730274fd0d882103251f25a5c0291446d801ba6df122f67a7dd06c60a9b332b7b29cc94f3b8f57d053ae"
}
{% endhighlight %}

*See also*

* [AddMultiSigAddress][rpc addmultisigaddress]: {{summary_addMultiSigAddress}}
* [DecodeScript][rpc decodescript]: {{summary_decodeScript}}
* [Pay-To-Script-Hash (P2SH)][/en/glossary/p2sh-address]

{% endautocrossref %}
