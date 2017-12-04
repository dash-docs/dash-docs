{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/masternode.md" %}

##### Masternode
{% include helpers/subhead-links.md %}

{% assign summary_masternode="provides a set of commands for managing masternodes and displaying information about them." %}

<!-- __ -->

{% autocrossref %}

The `masternode` RPC {{summary_masternode}}

###### Masternode Count

The `masternode count` RPC prints the number of all known masternodes.


###### Masternode Current

The `masternode current` RPC prints info on current masternode winner to be paid the next block (calculated locally).


###### Masternode Debug

The `masternode debug` RPC prints masternode status.


###### Masternode Genkey

The `masternode check` RPC generates a new masternodeprivkey.


###### Masternode Outputs

The `masternode check` RPC prints masternode compatible outputs.


###### Masternode Start

The `masternode check` RPC starts a local hot masternode configure in dash.conf.


###### Masternode Start-alias

The `masternode check` starts a single remote masternode by assigned alias configured in masternode.conf.


###### Masternode Start-mode (all,  missing, disabled)

The `masternode check` RPC starts remote masternodes configured in masternode.conf (<mode>: 'all', 'missing', 'disabled').


###### Masternode Status

The `masternode check` RPC prints masternode status information.


###### Masternode List

The `masternode check` prints a list of all known masternodes (see the `masternodelist` RPC for more info).


###### Masternode List-conf

The `masternode check` RPC prints masternode.conf in JSON format.


###### Masternode Winner

The `masternode check` RPC prints info on the next masternode winner to vote for.


###### Masternode Winners

The `masternode check` RPC prints the list of masternode winners.



{% highlight bash %}
dash-cli -testnet masternode
{% endhighlight %}

Result:
{% highlight json %}
	*INSERT RESULTS HERE*
{% endhighlight %}

*See also:*

{% endautocrossref %}
