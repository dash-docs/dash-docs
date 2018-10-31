{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/protx.md" %}

<!-- __ -->

##### ProTx
{% include helpers/subhead-links.md %}

{% assign summary_proTx="provides a set of commands to execute ProTx related actions." %}

{% autocrossref %}

*Added in Dash Core 0.13.0*

The `protx` RPC {{summary_proTx}}

{% endautocrossref %}

###### ProTx<!--noref--> Register
<!-- no subhead-links here -->

{% autocrossref %}

The `protx<!--noref--> register` RPC creates a ProRegTx referencing an existing collateral and and sends it to the network.

*Parameter #1---collateral address*

{% itemplate ntpd1 %}
- n: "`collateralHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The collateral transaction hash"
{% enditemplate %}

*Parameter #2---collateral index*

{% itemplate ntpd1 %}
- n: "`collateralIndex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The collateral transaction output index"
{% enditemplate %}

*Parameter #3---IP Address and port*

{% itemplate ntpd1 %}
- n: "`ipAndPort`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "IP and port in the form 'IP:PORT'.<br>Must be unique on the network.<br>Can be set to '0', which will require a ProUpServTx afterwards."
{% enditemplate %}

*Parameter #4---owner key address*

{% itemplate ntpd1 %}
- n: "`ownerKeyAddr`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The owner key used for payee updates and proposal voting. The private key belonging to this address be known in your wallet. The address must be unused and must differ from the `collateralAddress`."
{% enditemplate %}

*Parameter #5---operator public key*

{% itemplate ntpd1 %}
- n: "`operatorPubKey`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: " The operator public key. The private key does not have to be known. It has to match the private key which is later used when operating the masternode."
{% enditemplate %}

*Parameter #6---voting key address*

{% itemplate ntpd1 %}
- n: "`votingKeyAddr`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The voting key address. The private key does not have to be known by your wallet. It has to match the private key which is later used when voting on proposals. If set to '0' or an empty string, `ownerAddr` will be used."
{% enditemplate %}

*Parameter #7---operator reward*

{% itemplate ntpd1 %}
- n: "`operatorReward`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The fraction in % to share with the operator. If non-zero, `ipAndPort` must be zero as well.<br>The value must be between '0.00' and '100.00'."
{% enditemplate %}

*Parameter #8---payout address*

{% itemplate ntpd1 %}
- n: "`payoutAddress`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The Dash address to use for masternode reward payments. Must match `collateralAddress`."
{% enditemplate %}

*Result---provider registration transaction hash*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Provider registration transaction (ProRegTx) hash"
{% enditemplate %}

*Example from Dash Core 0.13.0*

{% highlight bash %}
dash-cli -testnet protx register\
 8b2eab3413abb6e04d17d1defe2b71039ba6b6f72ea1e5dab29bb10e7b745948 1\
 2.3.4.5:2345 yNLuVTXJbjbxgrQX5LSMi7hV19We8hT2d6\
 88d719278eef605d9c19037366910b59bc28d437de4a8db4d76fda6d6985dbdf10404fb9bb5cd0e8c22f4a914a6c5566\
 yNLuVTXJbjbxgrQX5LSMi7hV19We8hT2d6 5 yjJJLkYDUN6X8gWjXbCoKEXoiLeKxxMMRt
{% endhighlight %}

Result:
{% highlight bash %}
61e6d780178d353940c4cb9b3073ac0c50792bbcf0b15c1750d2028b71e34929
{% endhighlight %}

{% endautocrossref %}

###### ProTx<!--noref--> Fund-Register
<!-- no subhead-links here -->

{% autocrossref %}

The `protx<!--noref--> fund_register` RPC creates and funds a ProRegTx with the 1,000 DASH necessary for a masternode and then sends it to the network.

*Parameter #1---collateral address*

{% itemplate ntpd1 %}
- n: "`collateralAddress`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The Dash address to send the collateral to (must be a P2PKH address)"
{% enditemplate %}

*Parameter #2---IP Address and port*

{% itemplate ntpd1 %}
- n: "`ipAndPort`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "IP and port in the form 'IP:PORT'.<br>Must be unique on the network.<br>Can be set to '0', which will require a ProUpServTx afterwards."
{% enditemplate %}

*Parameter #3---owner key address*

{% itemplate ntpd1 %}
- n: "`ownerKeyAddr`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The owner key used for payee updates and proposal voting. The private key belonging to this address be known in your wallet. The address must be unused and must differ from the `collateralAddress`."
{% enditemplate %}

*Parameter #4---operator public key*

{% itemplate ntpd1 %}
- n: "`operatorPubKey`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: " The operator public key. The private key does not have to be known. It has to match the private key which is later used when operating the masternode."
{% enditemplate %}

*Parameter #5---voting key address*

{% itemplate ntpd1 %}
- n: "`votingKeyAddr`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The voting key address. The private key does not have to be known by your wallet. It has to match the private key which is later used when voting on proposals. If set to '0' or an empty string, `ownerAddr` will be used."
{% enditemplate %}

*Parameter #6---operator reward*

{% itemplate ntpd1 %}
- n: "`operatorReward`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The fraction in % to share with the operator. If non-zero, `ipAndPort` must be zero as well.<br>The value must be between '0.00' and '100.00'."
{% enditemplate %}

*Parameter #7---payout address*

{% itemplate ntpd1 %}
- n: "`payoutAddress`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The Dash address to use for masternode reward payments. Must match `collateralAddress`."
{% enditemplate %}

*Result---provider registration transaction hash*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Provider registration transaction (ProRegTx) hash"
{% enditemplate %}

*Example from Dash Core 0.13.0*

{% highlight bash %}
dash-cli -testnet protx fund_register yakx4mMRptKhgfjedNzX5FGQq7kSSBF2e7\
 3.4.5.6:3456 yX2cDS4kcJ4LK4uq9Hd4TG7kURV3sGLZrw\
 0e02146e9c34cfbcb3f3037574a1abb35525e2ca0c3c6901dbf82ac591e30218d1711223b7ca956edf39f3d984d06d51\
 yX2cDS4kcJ4LK4uq9Hd4TG7kURV3sGLZrw 5 yakx4mMRptKhgfjedNzX5FGQq7kSSBF2e7
{% endhighlight %}

Result:
{% highlight bash %}
ba1b3330e16a0876b7a186e7ceb689f03ec646e611e91d7139de021bbf13afdd
{% endhighlight %}

{% endautocrossref %}

###### ProTx<!--noref--> List
<!-- no subhead-links here -->

{% autocrossref %}

The `protx<!--noref--> list` RPC returns a list of provider transactions.

*Example from Dash Core 0.13.0*

{% highlight bash %}
dash-cli -testnet protx list
{% endhighlight %}

Result:
{% highlight json %}
[
  "2b4a07a9b04dc42a0c19b85edb60954a27acaadfe3ee21d0171385778f34e1c2",
  "61e6d780178d353940c4cb9b3073ac0c50792bbcf0b15c1750d2028b71e34929",
  "ca193751f3cbed2aa4f1b33b0acc48c7ed8b9a3679858d69cf23157a4f545176",
  "ba1b3330e16a0876b7a186e7ceb689f03ec646e611e91d7139de021bbf13afdd"
]
{% endhighlight %}

List only ProTx which are active/valid at the given chain height. If height is not
specified, it defaults to the current chain-tip

{% highlight bash %}
dash-cli -testnet protx list valid 700
{% endhighlight %}

Result:
{% highlight json %}
[
  "2b4a07a9b04dc42a0c19b85edb60954a27acaadfe3ee21d0171385778f34e1c2"
]
{% endhighlight %}

{% endautocrossref %}

###### ProTx<!--noref--> Info
<!-- no subhead-links here -->

{% autocrossref %}

The `protx<!--noref--> info` RPC returns detailed information about a deterministic masternode.

*Example from Dash Core 0.13.0*

{% highlight bash %}
dash-cli -testnet protx info\
 2b4a07a9b04dc42a0c19b85edb60954a27acaadfe3ee21d0171385778f34e1c2
{% endhighlight %}

Result:
{% highlight json %}
{
  "proTxHash": "2b4a07a9b04dc42a0c19b85edb60954a27acaadfe3ee21d0171385778f34e1c2",
  "collateralHash": "8d23d08ee6e2e0577550c90afde9bc63745f734605724ba9908e0220c48dec04",
  "collateralIndex": 1,
  "operatorReward": 5,
  "state": {
    "registeredHeight": 683,
    "lastPaidHeight": 785,
    "PoSePenalty": 0,
    "PoSeRevivedHeight": -1,
    "PoSeBanHeight": -1,
    "revocationReason": 0,
    "keyIDOwner": "29705bab955f252f876cbe47958b20feaa2b3e99",
    "pubKeyOperator": "0bfd3d519f16de1669e977c316bd53fc902f83a75b6008dff3a7037ab4d3edaa39eadb13f5d6d1f192673f9ab86f17a2",
    "keyIDVoting": "29705bab955f252f876cbe47958b20feaa2b3e99",
    "addr": "1.2.3.4:1234",
    "payoutAddress": "ybeK49S8ineDqNV698GZdMpdiHaYsZUJ2g"
  },
  "confirmations": 192,
  "wallet": {
    "hasOwnerKey": true,
    "hasOperatorKey": false,
    "hasVotingKey": true,
    "ownsCollateral": true,
    "ownsPayeeScript": true,
    "ownsOperatorRewardScript": false
  }
}
{% endhighlight %}

{% endautocrossref %}

###### ProTx<!--noref--> update_service
<!-- no subhead-links here -->

{% autocrossref %}

The `protx<!--noref--> update_service` RPC creates and sends a ProUpServTx to the network.

*Example from Dash Core 0.13.0*

{% highlight bash %}
dash-cli -testnet protx update_service\
 ba1b3330e16a0876b7a186e7ceb689f03ec646e611e91d7139de021bbf13afdd\
 "4.3.2.1:4321"\
 4da7e1ea30fb9e55c73ad23df0b9d3d34342acb24facf4b19420e1a26ae272d1
{% endhighlight %}

Result:
{% highlight bash %}
5b6cfa1bdd3c8b7e0b9550b9c4e809381f81a410bc7f241d3879dd736fd51270
{% endhighlight %}

{% endautocrossref %}

###### ProTx<!--noref--> Update Registrar
<!-- no subhead-links here -->

{% autocrossref %}

The `protx<!--noref--> update_registrar` RPC creates and sends a ProUpRegTx to the network.

*Example from Dash Core 0.13.0*

{% highlight bash %}
dash-cli -testnet protx update_registrar\
 "ba1b3330e16a0876b7a186e7ceb689f03ec646e611e91d7139de021bbf13afdd"\
 "0e02146e9c34cfbcb3f3037574a1abb35525e2ca0c3c6901dbf82ac591e30218d1711223b7ca956edf39f3d984d06d51"\
 "yX2cDS4kcJ4LK4uq9Hd4TG7kURV3sGLZrw" "yakx4mMRptKhgfjedNzX5FGQq7kSSBF2e7"
{% endhighlight %}

Result:
{% highlight bash %}
702390ef06b10c174841ad7b863df23c166c27815e3be2438e2fee6f87882b91
{% endhighlight %}

{% endautocrossref %}

###### ProTx<!--noref--> Revoke
<!-- no subhead-links here -->

{% autocrossref %}

The `protx<!--noref--> revoke` RPC creates and sends a ProUpRevTx to the network.

*Example from Dash Core 0.13.0*

{% highlight bash %}
dash-cli -testnet protx revoke\
 "ba1b3330e16a0876b7a186e7ceb689f03ec646e611e91d7139de021bbf13afdd"\
 "4da7e1ea30fb9e55c73ad23df0b9d3d34342acb24facf4b19420e1a26ae272d1"
{% endhighlight %}

Result:
{% highlight bash %}
2aad36dd2ab254bee06b0b5dad51e7603691b72058d5806fd94e1d2d19a7c209
{% endhighlight %}

{% endautocrossref %}

###### ProTx<!--noref--> Diff
<!-- no subhead-links here -->

{% autocrossref %}

The `protx<!--noref--> diff` RPC calculates a diff and a proof between two masternode list.

*Example from Dash Core 0.13.0*

{% highlight bash %}
dash-cli -testnet protx diff 600 700
{% endhighlight %}

Result:
{% highlight json %}
{
  "baseBlockHash": "0000a691fd23e6e51368b9204ae9ae67fecdda2fd51ab29fde964e335c84f962",
  "blockHash": "0000b8291620f592a16eea5bbb937c992217d3ff676aa08a5c4e8d4c1d353c61",
  "cbTxMerkleTree": "0100000001351a1d8f0bb20542ce1a83729cdf0048e2deb777e641f7db89b94b0c76544e980101",
  "cbTx": "03000500010000000000000000000000000000000000000000000000000000000000000000ffffffff0502bc020101ffffffff0100743ba40b000000232103ad831efe17ae73c016883085313aaa80365218cc029152edc2886c162048bd0bac00000000260100bc02000043ef07f248e6d6beb10c203a17f434201edba8b85d46699728b7a8e048c339fc",
  "deletedMNs": [
  ],
  "mnList": [
    {
      "proRegTxHash": "2b4a07a9b04dc42a0c19b85edb60954a27acaadfe3ee21d0171385778f34e1c2",
      "service": "1.2.3.4:1234",
      "pubKeyOperator": "0bfd3d519f16de1669e977c316bd53fc902f83a75b6008dff3a7037ab4d3edaa39eadb13f5d6d1f192673f9ab86f17a2",
      "keyIDVoting": "29705bab955f252f876cbe47958b20feaa2b3e99",
      "isValid": true
    }
  ],
  "merkleRootMNList": "fc39c348e0a8b7289769465db8a8db1e2034f4173a200cb1bed6e648f207ef43"
}
{% endhighlight %}

{% endautocrossref %}

{% autocrossref %}

*See also: none*

{% endautocrossref %}
