{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/backupwallet.md" %}

##### BackupWallet
{% include helpers/subhead-links.md %}

{% assign summary_backupWallet="safely copies `wallet.dat`<!--noref--> to the specified file, which can be a directory or a path with filename." %}

<!-- __ -->

{% autocrossref %}

*Requires wallet support.*

The `backupwallet` RPC {{summary_backupWallet}}

*Parameter #1---destination directory or filename*

{% itemplate ntpd1 %}
- n: "Destination"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "A filename or directory name.  If a filename, it will be created or overwritten.  If a directory name, the file `wallet.dat`<!--noref--> will be created or overwritten within that directory"

{% enditemplate %}

*Result---`null` or error*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "null"
  p: "Required<br>(exactly 1)"
  d: "Always `null` whether success or failure.  The JSON-RPC error and message fields will be set if a failure occurred"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet backupwallet /tmp/backup.dat
{% endhighlight %}

*See also*

* [DumpWallet][rpc dumpwallet]: {{summary_dumpWallet}}
* [ImportWallet][rpc importwallet]: {{summary_importWallet}}

{% endautocrossref %}
