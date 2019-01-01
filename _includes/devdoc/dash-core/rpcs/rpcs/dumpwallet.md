{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/dumpwallet.md" %}

##### DumpWallet
{% include helpers/subhead-links.md %}

{% assign summary_dumpWallet="creates or overwrites a file with all wallet keys in a human-readable format." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.  Requires an unlocked wallet or an unencrypted
wallet.*

The `dumpwallet` RPC {{summary_dumpWallet}}

*Parameter #1---a filename*

{% itemplate ntpd1 %}
- n: "Filename"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The file in which the wallet dump will be placed.  May be prefaced by an absolute file path.  An existing file with that name will be overwritten"

{% enditemplate %}

*Result---information about exported wallet*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An object describing dumped wallet file"

- n: "→<br>`dashcoreversion`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Dash Core build details"

- n: "→<br>`lastblockheight`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Height of the most recent block received"

- n: "→<br>`lastblockhash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the most recent block received"

- n: "→<br>`lastblocktime`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Timestamp of the most recent block received"

- n: "→<br>`keys`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Number of keys dumped"

- n: "→<br>`file`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Name of the file the wallet was dumped to"

- n: "→<br>`warning`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Warning to not share the file due to it containing the private keys"
{% enditemplate %}

*Example from Dash Core 0.13.0*

Create a wallet dump and then print its first 10 lines.

{% highlight bash %}
dash-cli -testnet dumpwallet /tmp/dump.txt
head /tmp/dump.txt
{% endhighlight %}

Results:

{% highlight json %}
{
  "dashcoreversion": "v0.13.0.0",
  "lastblockheight": 250186,
  "lastblockhash": "0000000000a82fb1890de5da4740d0671910a436fe6fc4503a3e553adef073b4",
  "lastblocktime": "2018-10-23T12:50:44Z",
  "keys": 8135,
  "file": "/tmp/dump.txt",
  "warning": "/tmp/dump.txt file contains all private keys from this wallet. Do not share it with anyone!"
}
{% endhighlight %}

Results (the first 10 lines of the file):

{% highlight bash %}
# Wallet dump created by Dash Core v0.13.0.0
# * Created on 2018-10-23T12:55:38Z
# * Best block at time of backup was 250186 (0000000000a82fb1890de5da4740d0671910a436fe6fc4503a3e553adef073b4),
#   mined on 2018-10-23T12:50:44Z

cQZZ4awQvcXXyES3CmUJqSgeTobQm9t9nyUr337kvUtsWsnvvMyw 2017-11-28T18:21:36Z label=test%20label # addr=ycBuREgSskHHkWLxDa9A5WppCki6PfFycL
cTBRPnJoPjEMh67v1zes437v8Po5bFLDWKgEudTJMhVaLs1ZVGJe 2017-11-28T18:21:37Z reserve=1 # addr=yNsWkgPLN1u7p5dfWYnasYdgirU2J3tjUj
cRkkwrFnQUrih3QiT87sNy1AxyfjzqVYSyVYuL3qnJcSiQfE4QJa 2017-11-28T18:21:37Z reserve=1 # addr=yRkHzRbRKn8gBp5826mbaBvxLuBBNDVQg3
cQM7KoqQjHCCTrDhnfBEY1vpW9W65zRvaQeTb41UbFb6WX8Q8UkQ 2017-11-28T18:21:37Z reserve=1 # addr=yVEdefApUYiDLHApvvWCK5afTtJeQada8Y
cTGSKYaQTQabnjNSwCqpjYXiucVujTXiwp9dzmJV9cNAiayAJusi 2017-11-28T18:21:37Z reserve=1 # addr=ybQYgp21ZyZK8JuMLb2CVwG4TaWrXVXD5M
{% endhighlight %}

*See also*

* [BackupWallet][rpc backupwallet]: {{summary_backupWallet}}
* [ImportWallet][rpc importwallet]: {{summary_importWallet}}

{% endautocrossref %}
