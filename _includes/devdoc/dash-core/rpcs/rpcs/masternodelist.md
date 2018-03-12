{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/masternodelist.md" %}

##### MasternodeList
{% include helpers/subhead-links.md %}

<!-- __ -->

{% assign summary_masternodeList="returns a list of masternodes in different modes." %}

{% autocrossref %}

The `masternodelist` RPC {{summary_masternodeList}}

*Parameter #1---List mode*

{% itemplate ntpd1 %}
- n: "`mode`"
  t: "string"
  p: "Optional (exactly 1);<br>Required to use `filter`"
  d: "The mode to run list in"

{% enditemplate %}

*Mode Options (Default=json)*

Mode | Description
--- | --- | --- |
`activeseconds` | Print number of seconds masternode recognized by the network as enabled (since latest issued \"masternodestart/start-many/start-alias\")
`addr` | Print ip address associated with a masternode (can be additionally filtered, partial match)
`daemon` | Print daemon version of a masternode (can be additionally filtered, exact match)
`full` | Print info in format 'status protocol payee lastseen activeseconds lastpaidtime lastpaidblock IP' (can be additionally filtered, partial match)
`info` | Print info in format 'status protocol payee lastseen activeseconds sentinelversion sentinelstate IP' (can be additionally filtered, partial match)
`json` (Default) | Print info in JSON format (can be additionally filtered, partial match)
`lastpaidblock` | Print the last block height a node was paid on the network
`lastpaidtime` | Print the last time a node was paid on the network
`lastseen` | Print timestamp of when a masternode was last seen on the network
`payee` | Print Dash address associated with a masternode (can be additionally filtered, partial match)
`protocol` | Print protocol of a masternode (can be additionally filtered, exact match)
`pubkey` | Print the masternode (not collateral) public key
`rank` | Print rank of a masternode based on current block
`sentinel` | Print sentinel version of a masternode (can be additionally filtered, exact match)
`status` | Print masternode status: PRE_ENABLED / ENABLED / EXPIRED / SENTINEL_PING_EXPIRED / NEW_START_REQUIRED / UPDATE_REQUIRED / POSE_BAN / OUTPOINT_SPENT (can be additionally filtered, partial match)

*Parameter #2---List filter*

{% itemplate ntpd1 %}
- n: "`filter`"
  t: "string"
  p: "Optional<br>(exactly 1)"
  d: "Filter results. Partial match by outpoint by default in all modes, additional matches in some modes are also available."

{% enditemplate %}

*Result---the masternode list*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object/null"
  p: "Required<br>(exactly 1)"
  d: "Information about the masternode sync status"

- n: "→<br>Masternode Info"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "The requested masternode info. Output varies based on selected `mode` and `filter` parameters"

{% enditemplate %}

*Example from Dash Core 0.12.3*

Get unfiltered Masternode list in default mode

{% highlight bash %}
dash-cli -testnet masternodelist
{% endhighlight %}

Result:
{% highlight json %}
{
  "83ab0eaeffc212fab5aea4a3057fba51dafdfa6da8b29c3f0de62ed9319fea03-0": {
    "address": "203.0.113.1:19999",
    "payee": "yiz8WZ9VY9F7SyGuc8mXj6wrDERs6T47B1",
    "status": "ENABLED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "1.0.2",
    "sentinelstate": "current",
    "lastseen": 1520876844,
    "activeseconds": 3389581,
    "lastpaidtime": 1520868832,
    "lastpaidblock": 89879
  },
  "33a833559acc50b63e0909a550d10af26f41043382a9eed30e5218df5adf5304-1": {
    "address": "203.0.113.2:39999",
    "payee": "yfY21tLcuKtohnkKtwBQXzEKFapwuhb9FE",
    "status": "ENABLED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "1.1.0",
    "sentinelstate": "current",
    "lastseen": 1520876480,
    "activeseconds": 2110895,
    "lastpaidtime": 1520866020,
    "lastpaidblock": 89862
  },
  "54754314335419cc04ef09295ff7765c8062a6123486aed55fd7e9b04f300b13-0": {
    "address": "203.0.113.3:20019",
    "payee": "ycn5RWc4Ruo35FTS8bJwugVyCEkfVcrw9a",
    "status": "NEW_START_REQUIRED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "Unknown",
    "sentinelstate": "expired",
    "lastseen": 1517843286,
    "activeseconds": 0,
    "lastpaidtime": 1520873295,
    "lastpaidblock": 89898
  },
  "a4676419793d232359dfd7240bf1b0635b56f2a16aac4cb57f7e9ba459d50116-1": {
    "address": "203.0.113.4:19999",
    "payee": "ydZHEVgMX67xsi97BhN8KoacN6SCMz6Xho",
    "status": "SENTINEL_PING_EXPIRED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "1.0.2",
    "sentinelstate": "expired",
    "lastseen": 1520876776,
    "activeseconds": 7694877,
    "lastpaidtime": 0,
    "lastpaidblock": 0
  },
  "3d64bd65cb84b935278420de3673cba33470a1e1996c4debfccb5d722254404c-1": {
    "address": "203.0.113.5:19999",
    "payee": "ySkDc9dHns1AFcjJzGqNmkNnErjakcB2Bp",
    "status": "ENABLED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "1.0.2",
    "sentinelstate": "current",
    "lastseen": 1520876576,
    "activeseconds": 10796968,
    "lastpaidtime": 1520876143,
    "lastpaidblock": 89922
  },
  "54355b4b4d26b84821dab6e0e1c0bded7d8fefc72414f22f45515d1732f1c8e6-1": {
    "address": "203.0.113.6:29999",
    "payee": "yPk4NCyqvWjeJbE3tW1wmJ9LV2wgVLiYRT",
    "status": "ENABLED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "1.1.0",
    "sentinelstate": "current",
    "lastseen": 1520876323,
    "activeseconds": 2110746,
    "lastpaidtime": 1520875985,
    "lastpaidblock": 89920
  },
  "c6585f4ba88875eb2edc376b9ae24b74fd8c0ef89288923cf16a8fe2787b7ce8-1": {
    "address": "203.0.113.7:19999",
    "payee": "yP1UHNx26ShYLej56SbHiTiPAUv2QppbUv",
    "status": "SENTINEL_PING_EXPIRED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "1.0.2",
    "sentinelstate": "expired",
    "lastseen": 1520876884,
    "activeseconds": 7694986,
    "lastpaidtime": 0,
    "lastpaidblock": 0
  },
  "b7d45ac3d8c5ddea9ff90d81d92d362e09713a06b2a0089f49c7deb9b2521fef-0": {
    "address": "203.0.113.8:19999",
    "payee": "yN4iFe7a2G6YYoBtUXcoyixCTV3vDzWSrS",
    "status": "NEW_START_REQUIRED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "1.0.2",
    "sentinelstate": "current",
    "lastseen": 1508842770,
    "activeseconds": 416775,
    "lastpaidtime": 0,
    "lastpaidblock": 0
  },
  "5ef4e5c9d09f6fb927b7b815ea2736ddfce468021d49704acfc3bb7939b425ff-1": {
    "address": "203.0.113.9:19999",
    "payee": "yPwTQgY8JDFaDjAgUdHmapG4SmzY6SDbE9",
    "status": "ENABLED",
    "protocol": 70208,
    "daemonversion": "Unknown",
    "sentinelversion": "1.1.0",
    "sentinelstate": "current",
    "lastseen": 1520876862,
    "activeseconds": 2111317,
    "lastpaidtime": 1520872118,
    "lastpaidblock": 89892
  }
}
{% endhighlight %}

Get a filtered Masternode list

{% highlight bash %}
dash-cli -testnet masternodelist full "NEW"
{% endhighlight %}

Result:
{% highlight json %}
{
  "6125fc1da46cd2fdd013b1fbb02144367a95feffd379c08064f38de0e3deb80c-1": "NEW_START_REQUIRED 70208 yh7RGWjZN8yDAAzPpYFUJZAj41jG7G43c8 1507401630        0 1507409411   5874 1.1.1.1:19999",
  "866d66b88afed15ed1a936b680ace1a99e0ca14d0242bc2983c5fdd2c16c1637-1": "NEW_START_REQUIRED 70208 yQHJ4muL7FyhUj1x8iBr2Ws9E4cJ68DKin 1507626190   138962 1507620650   7215 178.62.203.249:19999",
  "7c17695bdccc617410164882bd8b5fb7bf4f5a3dceb0a7476800e161cba1c57f-1": "NEW_START_REQUIRED 70208 yjWGCrz6iJnDsrog5FX6ag3iQUNor9UFj5 1507636178        0          0      0 83.1.99.1:19999",
  "0512f77ebceaf288386e9a050e3c80652c7bfb6e993659ded2dff43eae6904ac-1": "NEW_START_REQUIRED 70208 ydahSbZKWUjBi6jHeWjLgr7navPoZVCgwH 1507646277    32460 1507649163   7397 172.104.45.115:19999",
  "4222505288507e0f1abc32f0323cce1d6c4d22c8e785adb0cf8075b70ae92ddf-1": "NEW_START_REQUIRED 70208 yUznkRL396PewekhtCpUJkfJcxt8fhDyoX 1507646174     9996 1507642757   7355 83.1.99.2:19999",
  "b454dd0efc19657f8d56a750385b90ebfb53dce5182a21238b225d6cbb3307f0-1": "NEW_START_REQUIRED 70208 yYR5dcULfpnbPSixorzMkQ9SGwzPPsXcuC 1507401632        0 1507408648   5868 2.2.2.2:19999"
}
{% endhighlight %}

*See also:*

* [Masternode][rpc masternode]: {{summary_masternode}}
* [MasternodeBroadcast][rpc masternodebroadcast]: {{summary_masternodeBroadcast}}
* [MnSync][rpc mnsync]: {{summary_mnSync}}

{% endautocrossref %}
