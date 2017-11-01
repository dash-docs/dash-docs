{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/decodescript.md" %}

##### DecodeScript
{% include helpers/subhead-links.md %}

{% assign summary_decodeScript="decodes a hex-encoded P2SH redeem script." %}

{% autocrossref %}

The `decodescript` RPC {{summary_decodeScript}}

*Parameter #1---a hex-encoded redeem script*

{% itemplate ntpd1 %}
- n: "Redeem Script"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The redeem script to decode as a hex-encoded serialized script"

{% enditemplate %}

*Result---the decoded script*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object describing the decoded script, or JSON `null` if the script could not be decoded"

- n: "→<br>`asm`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The redeem script in decoded form with non-data-pushing opcodes listed.  May be empty"

- n: "→<br>`reqSigs`"
  t: "number (int)"
  p: "Optional<br>(0 or 1)"
  d: "The number of signatures required; this is always `1` for P2PK or P2PKH within P2SH.  It may be greater than 1 for P2SH multisig.  This value will not be returned for `nonstandard` script types (see the `type` key above)"

- n: "→<br>`type`"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "The type of script.  This will be one of the following:<br>• `pubkey` for a P2PK script inside P2SH<br>• `pubkeyhash` for a P2PKH script inside P2SH<br>• `multisig` for a multisig script inside P2SH<br>• `nonstandard` for unknown scripts"

- n: "→<br>`addresses`"
  t: "array"
  p: "Optional<br>(0 or 1)"
  d: "A P2PKH addresses used in this script, or the computed P2PKH addresses of any pubkeys in this script.  This array will not be returned for `nonstandard` script types"

- n: "→ →<br>Address"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "A P2PKH address"

- n: "→<br>`p2sh`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The P2SH address of this redeem script"

{% enditemplate %}

*Example from Dash Core 0.12.2*

A 2-of-3 P2SH multisig pubkey script:

{% highlight bash %}
dash-cli -testnet decodescript 522102eacba539d92eb88d4e73bb32\
749d79f53f6e8d7947ac40a71bd4b26c13b6ec29210311f97539724e0de38fb1\
ff79f5148e5202459d06ed07193ab18c730274fd0d882103251f25a5c0291446\
d801ba6df122f67a7dd06c60a9b332b7b29cc94f3b8f57d053ae
{% endhighlight %}

Result:

{% highlight json %}
{
  "asm": "2 02eacba539d92eb88d4e73bb32749d79f53f6e8d7947ac40a71bd4b26c13b6ec29 0311f97539724e0de38fb1ff79f5148e5202459d06ed07193ab18c730274fd0d88 03251f25a5c0291446d801ba6df122f67a7dd06c60a9b332b7b29cc94f3b8f57d0 3 OP_CHECKMULTISIG",
  "reqSigs": 2,
  "type": "multisig",
  "addresses": [
    "yNpezfFDfoikDuT1f4iK75AiLp2YLPsGAb",
    "yWAk1cDVvsRdPYjnzcFkySJux75yaCE7xz",
    "yVJj7TB3ZhMcSP2wo65ZFNqy23BQH9tT87"
  ],
  "p2sh": "8uJLxDxk2gEMbidF5vT8XLS2UCgQmVcroW"
}
{% endhighlight %}

*See also*

* [CreateMultiSig][rpc createmultisig]: {{summary_createMultiSig}}
* [Pay-To-Script-Hash (P2SH)][/en/glossary/p2sh-address]

{% endautocrossref %}
