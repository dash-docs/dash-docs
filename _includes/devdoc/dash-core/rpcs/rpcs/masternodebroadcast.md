{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/masternodebroadcast.md" %}

##### MasternodeBroadcast
{% include helpers/subhead-links.md %}
<!-- __ -->
{% assign summary_masternodeBroadcast="provides a set of commands to create and relay masternode broadcast messages." %}

{% autocrossref %}

The `masternodebroadcast` RPC {{summary_masternodeBroadcast}}

*Parameter #1---masternode broadcast command*

{% itemplate ntpd1 %}
- n: "`command`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The command to use:<br>`create-alias`<br>`create-all`<br>`decode`<br>`relay`"

{% enditemplate %}

{% endautocrossref %}

###### MNB create-alias
<!-- no subhead-links here -->

{% autocrossref %}

The `masternodebroadcast create-alias` RPC creates single remote masternode broadcast message by assigned alias configured in `masternode<!--noref-->.conf`.

*Parameter #2---masternode alias*

{% itemplate ntpd1 %}
- n: "`alias`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The masternode alias for creating the broadcast message"

{% enditemplate %}

*Result---broadcast message*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing result data"

- n: "→<br>`alias`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Alias of the masternode"

- n: "→<br>`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Result of broadcast message create attempt"

- n: "→<br>`hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Masternode broadcast data"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet masternodebroadcast create-alias MN01
{% endhighlight %}

Result:
{% highlight json %}
{
  "alias": "MN01",
  "result": "successful",
  "hex": "010fab7e86a6d7c483b836fe862c8a23f69aebadce7c58c48778a4fa6bd93fc8f60100000000ffffffff00000000000000000000ffff2d20ed4c4e1f210267fae84ef6aa6ab3d877b47932915a9b406566c873ea025986fc7e15a15fd2f24104341ab0d26ae967856213df205bf172418422a847f3a63941d8031234a64a143f5570a6010d2b5e1dff163c91316a65667f0ee1bfb0ff38edd0a695bea75de731411f8a9bf1e7818c7352c8a02bd31a4da1bb8d88e91c8a9c7151afc076b6a68f54c9087a981a780e6279e9d7b73940ee7aad65c28e4846573bffa74518443380dfde4d3c145a00000000401201000fab7e86a6d7c483b836fe862c8a23f69aebadce7c58c48778a4fa6bd93fc8f60100000000ffffffff69fc28f4772eaefd17cd1bab575aac752b5944ee3e7221df204b4d04000000004d3c145a00000000411bef1bdf25a500ae2af4052e8504e2f93ec365d5ed9d42e3c52b84714136060f9766068553c450a4b1c0b3d72740580f097f7e62c098addc55f71f016cfda24d7a0001000100"
}
{% endhighlight %}

{% endautocrossref %}

###### MNB create-all
<!-- no subhead-links here -->

{% autocrossref %}

The `masternodebroadcast create-all` RPC creates remote masternode broadcast messages for all masternodes configured in `masternode<!--noref-->.conf`.

*Result---broadcast message(s)*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing result data"

- n: "→<br>`overall`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Summary of broadcast message creation success/failure"

- n: "→<br>detail"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing status details"

- n: "→ →<br>status"
  t: "object"
  p: "Required<br>(1 or more)"
  d: "Object containing status for each each masternode broadcast message creation attempt"

- n: "→ → →<br>`alias`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Alias of the masternode"

- n: "→ → →<br>`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Result - `successful` or `failed`"

- n: "→ → →<br>`error`"
  t: "string"
  p: "Optional"
  d: "Error message if failed"

- n: "→<br>`hex`"
  t: "string (hex)"
  p: "Optional<br>(exactly 1)"
  d: "Masternode broadcast data (if message(s) created successfully)"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet masternodebroadcast create-all
{% endhighlight %}

Result:
{% highlight json %}
{
  "overall": "Successfully created broadcast messages for 1 masternodes, failed to create 0, total 1",
  "detail": {
    "status": {
      "alias": "MN01",
      "result": "successful"
    }
  },
  "hex": "010fab7e86a6d7c483b836fe862c8a23f69aebadce7c58c48778a4fa6bd93fc8f60100000000ffffffff00000000000000000000ffff2d20ed4c4e1f210267fae84ef6aa6ab3d877b47932915a9b406566c873ea025986fc7e15a15fd2f24104341ab0d26ae967856213df205bf172418422a847f3a63941d8031234a64a143f5570a6010d2b5e1dff163c91316a65667f0ee1bfb0ff38edd0a695bea75de731411f555444bd95d98b8407ff1b8cc595a3d284c30b9bbaca488a949bc53be08ca1021724527f9a15e9307c7391d9ad563dcc9ced6ae621ae7d6fe3e3c3ba81dce795d143145a00000000401201000fab7e86a6d7c483b836fe862c8a23f69aebadce7c58c48778a4fa6bd93fc8f60100000000ffffffff914dff1cc3dfc0729bb1f4e3f070d65d1fa41072da5290a54d472d0400000000d143145a00000000411c628109c911ef330aaa789bd621f8c7975290d196beef3ecdaa1133302daccdaa3df82b1f16d753fef884ce3a3eb28a7b621233c14496a010bb49f247190651100001000100"
}
{% endhighlight %}

{% endautocrossref %}

###### MNB decode
<!-- no subhead-links here -->

{% autocrossref %}

The `masternodebroadcast decode` RPC decodes a masternode broadcast message (deserializes from a hex string to JSON).

*Parameter #2---object data (hex)*

{% itemplate ntpd1 %}
- n: "`data-hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The data (hex) of the masternode broadcast to decode"

{% enditemplate %}

*Result---broadcast message(s)*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing result data"

- n: "→<br>`outpoint`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Masternode outpoint"

- n: "→<br>`addr`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Masternode IP address and port"

- n: "→<br>`pubKeyCollateralAddress`"
  t: "string (hex)"
  p: "Required<br>(1 or more)"
  d: "Masternode collateral public key address"

- n: "→<br>`pubKeyMasternode`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Masternode public key"

- n: "→<br>`vchSig`"
  t: "string (base64)"
  p: "Required<br>(exactly 1)"
  d: "Masternode signature"

- n: "→<br>`sigTime`"
  t: "int64_t"
  p: "Required<br>(exactly 1)"
  d: "Signature time as a Unix epoch"

- n: "→<br>`protocolVersion`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Dash protocol version"

- n: "→<br>`nLastDsq`"
  t: "int64_t"
  p: "Required<br>(exactly 1)"
  d: "Dsq count from the last `dsq` message from this node"

- n: "→<br>lastPing"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Ping object (`mnp` message)"

- n: "→ →<br>`outpoint`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Masternode outpoint"

- n: "→ →<br>`blockHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Block hash from 12 blocks prior to the current tip"

- n: "→ →<br>`sigTime`"
  t: "int64_t"
  p: "Required<br>(exactly 1)"
  d: "Signature time as a Unix epoch"

- n: "→ →<br>`vchSig`"
  t: "string (base64)"
  p: "Required<br>(exactly 1)"
  d: "Masternode signature"

- n: "→<br>`overall`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Summary of broadcast message creation success/failure"

{% enditemplate %}

*Example from Dash Core 0.12.2*
￼{% highlight bash %}
masternodebroadcast decode 010fab7e86a6d7c483b836fe862c8a23f69aebadce7c58c4\
8778a4fa6bd93fc8f60100000000ffffffff00000000000000000000ffff2d20ed4c4e1f2102\
67fae84ef6aa6ab3d877b47932915a9b406566c873ea025986fc7e15a15fd2f24104341ab0d2\
6ae967856213df205bf172418422a847f3a63941d8031234a64a143f5570a6010d2b5e1dff16\
3c91316a65667f0ee1bfb0ff38edd0a695bea75de731411f8a9bf1e7818c7352c8a02bd31a4d\
a1bb8d88e91c8a9c7151afc076b6a68f54c9087a981a780e6279e9d7b73940ee7aad65c28e48\
46573bffa74518443380dfde4d3c145a00000000401201000fab7e86a6d7c483b836fe862c8a\
23f69aebadce7c58c48778a4fa6bd93fc8f60100000000ffffffff69fc28f4772eaefd17cd1b\
ab575aac752b5944ee3e7221df204b4d04000000004d3c145a00000000411bef1bdf25a500ae\
2af4052e8504e2f93ec365d5ed9d42e3c52b84714136060f9766068553c450a4b1c0b3d72740\
580f097f7e62c098addc55f71f016cfda24d7a0001000100
{% endhighlight %}

Result:
{% highlight json %}
{
  "36b753f9c8d328d405b8a909bbf4fd29c0d37aa48eae98fa1289b90e36e002c4": {
    "outpoint": "f6c83fd96bfaa47887c4587cceadeb9af6238a2c86fe36b883c4d7a6867eab0f-1",
    "addr": "45.32.237.76:19999",
    "pubKeyCollateralAddress": "yY6AmGopsZS31wy1JLHR9P6AC6owFaXwuh",
    "pubKeyMasternode": "yj25teTD6yjcNpQC7inq72tDgsivG6xLZM",
    "vchSig": "H4qb8eeBjHNSyKAr0xpNobuNiOkcipxxUa/Adramj1TJCHqYGngOYnnp17c5QO56rWXCjkhGVzv/p0UYRDOA394=",
    "sigTime": 1511275597,
    "protocolVersion": 70208,
    "nLastDsq": 0,
    "lastPing": {
      "outpoint": "f6c83fd96bfaa47887c4587cceadeb9af6238a2c86fe36b883c4d7a6867eab0f-1",
      "blockHash": "00000000044d4b20df21723eee44592b75ac5a57ab1bcd17fdae2e77f428fc69",
      "sigTime": 1511275597,
      "vchSig": "G+8b3yWlAK4q9AUuhQTi+T7DZdXtnULjxSuEcUE2Bg+XZgaFU8RQpLHAs9cnQFgPCX9+YsCYrdxV9x8BbP2iTXo="
    }
  },
  "overall": "Successfully decoded broadcast messages for 1 masternodes, failed to decode 0, total 1"
}
{% endhighlight %}

{% endautocrossref %}

###### MNB relay
<!-- no subhead-links here -->

{% autocrossref %}

The `masternodebroadcast relay` RPC relays a masternode broadcast message to the network.

*Parameter #2---object data (hex)*

{% itemplate ntpd1 %}
- n: "`data-hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The data (hex) of the masternode broadcast to relay"

{% enditemplate %}

*Result---broadcast message(s)*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing result data"

- n: "→<br>Hash"
  t: "string (hex)"
  p: "Required<br>(1 or more)"
  d: "Masternode broadcast hash"

- n: "→ →<br>`outpoint`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Masternode outpoint"

- n: "→ →<br>`addr`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Masternode IP address and port"

- n: "→ →<br>Result"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Result - `successful` or `failed`"

- n: "→ → →<br>`error`"
  t: "string"
  p: "Optional"
  d: "Error message if failed"

- n: "→<br>`overall`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Summary of broadcast message creation success/failure"

{% enditemplate %}

*Example from Dash Core 0.12.2*
￼{% highlight bash %}
masternodebroadcast relay 010fab7e86a6d7c483b836fe862c8a23f69aebadce7c58c4\
8778a4fa6bd93fc8f60100000000ffffffff00000000000000000000ffff2d20ed4c4e1f2102\
67fae84ef6aa6ab3d877b47932915a9b406566c873ea025986fc7e15a15fd2f24104341ab0d2\
6ae967856213df205bf172418422a847f3a63941d8031234a64a143f5570a6010d2b5e1dff16\
3c91316a65667f0ee1bfb0ff38edd0a695bea75de731411f8a9bf1e7818c7352c8a02bd31a4d\
a1bb8d88e91c8a9c7151afc076b6a68f54c9087a981a780e6279e9d7b73940ee7aad65c28e48\
46573bffa74518443380dfde4d3c145a00000000401201000fab7e86a6d7c483b836fe862c8a\
23f69aebadce7c58c48778a4fa6bd93fc8f60100000000ffffffff69fc28f4772eaefd17cd1b\
ab575aac752b5944ee3e7221df204b4d04000000004d3c145a00000000411bef1bdf25a500ae\
2af4052e8504e2f93ec365d5ed9d42e3c52b84714136060f9766068553c450a4b1c0b3d72740\
580f097f7e62c098addc55f71f016cfda24d7a0001000100
{% endhighlight %}

Result:
{% highlight json %}
{
  "36b753f9c8d328d405b8a909bbf4fd29c0d37aa48eae98fa1289b90e36e002c4": {
    "outpoint": "f6c83fd96bfaa47887c4587cceadeb9af6238a2c86fe36b883c4d7a6867eab0f-1",
    "addr": "45.32.237.76:19999",
    "36b753f9c8d328d405b8a909bbf4fd29c0d37aa48eae98fa1289b90e36e002c4": "successful"
  },
  "overall": "Successfully relayed broadcast messages for 1 masternodes, failed to relay 0, total 1"
}
{% endhighlight %}


*See also: none*

{% endautocrossref %}
