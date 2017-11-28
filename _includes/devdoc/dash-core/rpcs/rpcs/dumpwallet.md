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

*Result---`null` or error*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "null"
  p: "Required<br>(exactly 1)"
  d: "Always `null` whether success or failure.  The JSON-RPC error and message fields will be set if a failure occurred"

{% enditemplate %}

*Example from Dash Core 0.12.2*

Create a wallet dump and then print its first 10 lines.

{% highlight bash %}
dash-cli -testnet dumpwallet /tmp/dump.txt
head /tmp/dump.txt
{% endhighlight %}

Results (only showing the first 10 lines):

{% highlight bash %}
# Wallet dump created by Dash Core v0.12.2.1 (2017-11-11 10:02:45 +0300)
# * Created on 2017-11-28T19:52:46Z
# * Best block at time of backup was 33750 (0000000005d5d1651f3b52d7a7158e350261519c52a28527c6053a8f5989a5a4),
#   mined on 2017-11-28T19:48:05Z

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
