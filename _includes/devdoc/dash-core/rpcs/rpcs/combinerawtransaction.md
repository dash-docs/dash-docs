{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/combinerawtransaction.md" %}

<!--__-->

##### CombineRawTransaction
{% include helpers/subhead-links.md %}

{% assign summary_combineRawTransaction="combine multiple partially signed transactions into one transaction." %}

{% autocrossref %}

The `combinerawtransaction` RPC {{summary_combineRawTransaction}}

The combined transaction may be another partially signed transaction or a
fully signed transaction.

*Parameter #1---txs*

{% itemplate ntpd1 %}
- n: "txs"
  t: "string"
  p: "Required"
  d: "A json array of hex strings of partially signed transactions"

{% enditemplate %}

*Result---hex-encoded raw transaction with signature(s)*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string"
  p: "Required<br>(Exactly 1)"
  d: "The resulting raw transaction in serialized transaction format encoded as hex."

{% enditemplate %}

*Example from Dash Core 0.14.1*

The following example shows a fully signed two input transaction being assembled
by combining two partially signed transactions. The first hex-encoded string is
the transaction with only the first input signed. The second hex-encoded string is
the transaction with only the second input signed.

{% highlight bash %}
dash-cli combinerawtransaction '[
 "0200000002fdb27b4f2b80a5fd3b96602618a6ccf7bdde504bf90989610b19ed6ecd769520010000006b483045022100f8770316327966fb1972338d14db8d38048455da8b62f6350b117c797cea459e02206c63c103cf53ce1d24a313b3e6853913fa14febafd733e683b6eb46a7beec0fa012103c67d86944315838aea7ec80d390b5d09b91b62483370d4979da5ccf7a7df77a9ffffffff0d052e9b13c53bb342d772767732ffe4fa9f1c150629d3fa79655267baa7c86a0100000000ffffffff0200ca9a3b000000001976a9144139b147b5cef5fef5bcdb02fcdf55e426f74dbb88ac00daf89a000000001976a91465f53f2095c99ce152ff3bc8a8f027d8a77cbdcb88ac00000000",
 "0200000002fdb27b4f2b80a5fd3b96602618a6ccf7bdde504bf90989610b19ed6ecd7695200100000000ffffffff0d052e9b13c53bb342d772767732ffe4fa9f1c150629d3fa79655267baa7c86a010000006b4830450221008c3abc11ea84cc98cf674afc5b6d3d078d672768d289f2ab976ea4b2a49129fc022008470458b1b179800e7f5348196d510d2f147e69fe836c94135fc5c620312acd012102912ba98d6641f79864d04d41523167f5db267e45d1633e9243a0be7efb675719ffffffff0200ca9a3b000000001976a9144139b147b5cef5fef5bcdb02fcdf55e426f74dbb88ac00daf89a000000001976a91465f53f2095c99ce152ff3bc8a8f027d8a77cbdcb88ac00000000"
]'
{% endhighlight %}

Result:
{% highlight bash %}
0200000002fdb27b4f2b80a5fd3b96602618a6ccf7bdde504bf90989610b19ed6ecd7695\
20010000006b483045022100f8770316327966fb1972338d14db8d38048455da8b62f635\
0b117c797cea459e02206c63c103cf53ce1d24a313b3e6853913fa14febafd733e683b6e\
b46a7beec0fa012103c67d86944315838aea7ec80d390b5d09b91b62483370d4979da5cc\
f7a7df77a9ffffffff0d052e9b13c53bb342d772767732ffe4fa9f1c150629d3fa796552\
67baa7c86a010000006b4830450221008c3abc11ea84cc98cf674afc5b6d3d078d672768\
d289f2ab976ea4b2a49129fc022008470458b1b179800e7f5348196d510d2f147e69fe83\
6c94135fc5c620312acd012102912ba98d6641f79864d04d41523167f5db267e45d1633e\
9243a0be7efb675719ffffffff0200ca9a3b000000001976a9144139b147b5cef5fef5bc\
db02fcdf55e426f74dbb88ac00daf89a000000001976a91465f53f2095c99ce152ff3bc8\
a8f027d8a77cbdcb88ac00000000
{% endhighlight %}

*See also:*

* [CreateRawTransaction][rpc createrawtransaction]: {{summary_createRawTransaction}}
* [DecodeRawTransaction][rpc decoderawtransaction]: {{summary_decodeRawTransaction}}
* [SignRawTransaction][rpc signrawtransaction]: {{summary_signRawTransaction}}
* [SendRawTransaction][rpc sendrawtransaction]: {{summary_sendRawTransaction}}
* [Serialized Transaction Format][raw transaction format]

{% endautocrossref %}
