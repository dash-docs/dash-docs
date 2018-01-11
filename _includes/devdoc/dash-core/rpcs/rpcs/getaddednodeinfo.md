{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getaddednodeinfo.md" %}

##### GetAddedNodeInfo
{% include helpers/subhead-links.md %}

{% assign summary_getAddedNodeInfo="returns information about the given added node, or all added nodes (except onetry nodes). Only nodes which have been manually added using the `addnode` RPC will have their information displayed." %}

{% autocrossref %}

The `getaddednodeinfo` RPC {{summary_getAddedNodeInfo}}

*Parameter #1---whether to display connection information*

{% itemplate ntpd1 %}
- n: "Dummy"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Kept for historical purposes but ignored<br><br>*Removed in Bitcoin Core 0.14.0*"

{% enditemplate %}

*Parameter #2---what node to display information about*

{% itemplate ntpd1 %}
- n: "`node`"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "The node to get information about in the same `<IP address>:<port>` format as the `addnode` RPC.  If this parameter is not provided, information about all added nodes will be returned"

{% enditemplate %}

*Result---a list of added nodes*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing objects describing each added node.  If no added nodes are present, the array will be empty.  Nodes added with `onetry` will not be returned"

- n: "→<br>Added Node<!--noref-->"
  t: "object"
  p: "Optional<br>(0 or more)"
  d: "An object containing details about a single added node"

- n: "→ →<br>`addednode`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "An added node in the same `<IP address>:<port>` format as used in the `addnode` RPC."

- n: "→ →<br>`connected`"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "This will be set to `true` if the node is currently connected and `false` if it is not"

- n: "→ →<br>`addresses`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "This will be an array of addresses<!--noref--> belonging to the added node"

- n: "→ → →<br>Address<!--noref-->"
  t: "object"
  p: "Optional<br>(0 or more)"
  d: "An object describing one of this node's addresses<!--noref-->"

- n: "→ → → →<br>`address`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "An IP address and port number of the node.  If the node was added using a DNS address, this will be the resolved IP address"

- n: "→ → → →<br>`connected`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Whether or not the local node is connected to this addnode using this IP address.  Valid values are:<br>• `false` for not connected<br>• `inbound` if the addnode connected to us<br>• `outbound` if we connected to the addnode"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli getaddednodeinfo true
{% endhighlight %}

Result (real hostname and IP address replaced with [RFC5737][] reserved address):

{% highlight json %}
[
  {
    "addednode": "192.0.2.113:19999",
    "connected": true,
    "addresses": [
      {
        "address": "192.0.2.113:19999",
        "connected": "outbound"
      }
    ]
  }
]
{% endhighlight %}

*See also*

* [AddNode][rpc addnode]: {{summary_addNode}}
* [GetPeerInfo][rpc getpeerinfo]: {{summary_getPeerInfo}}

{% endautocrossref %}
