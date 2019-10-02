{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getblockstats.md" %}
<!--__-->

##### GetBlockStats
{% include helpers/subhead-links.md %}

{% assign summary_getBlockStats="computes per block statistics for a given window." %}

{% autocrossref %}

The `getblockstats` RPC {{summary_getBlockStats}}

All amounts are in duffs.

It won't work for some heights with pruning. It won't work without `-txindex` for
`utxo_size_inc`, `*fee` or `*feerate` stats.

*Parameter #1---hash_or_height*

{% itemplate ntpd1 %}
- n: "hash_or_height"
  t: "string or numeric"
  p: "Required<br>(exactly 1)"
  d: "The block hash or height of the target block"

{% enditemplate %}

*Parameter #2---stats*

{% itemplate ntpd1 %}
- n: "stats"
  t: "array"
  p: "optional"
  d: "Values to plot, by default all values (see result below)"

{% enditemplate %}

*Result---a JSON object containing the requested statistics*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object/null"
  p: "Required<br>(exactly 1)"
  d: "An object containing stats for the requested block, or JSON `null` if an error occurred"

- n: "→<br>`avgfee`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Average fee in the block"

- n: "→<br>`avgfeerate`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Average feerate (in duffs per byte)"

- n: "→<br>`avgtxsize`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Average transaction size"

- n: "→<br>`blockhash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The block hash (to check for potential reorgs)"

- n: "→<br>`height`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The height of the block"

- n: "→<br>`ins`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The number of inputs (excluding coinbase)"

- n: "→<br>`maxfee`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Maximum fee in the block"

- n: "→<br>`maxfeerate`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Maximum feerate (in duffs per byte)"

- n: "→<br>`maxtxsize`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Maximum transaction size"

- n: "→<br>`medianfee`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Truncated median fee in the block"

- n: "→<br>`medianfeerate`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Truncated median feerate (in duffs per byte)"

- n: "→<br>`mediantime`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The block median time past"

- n: "→<br>`mediantxsize`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Truncated median transaction size"

- n: "→<br>`minfee`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Minimum fee in the block"

- n: "→<br>`minfeerate`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Minimum feerate (in duffs per byte)"

- n: "→<br>`mintxsize`"
  t: "numeric"
  p: "Required<br>(exactly 1)"

- n: "→<br>`outs`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The number of outputs"

- n: "→<br>`subsidy`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The block subsidy"

- n: "→<br>`time`"
  t: "number (real)"
  p: "Required<br>(exactly 1)"
  d: "The block time"

- n: "→<br>`total_out`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Total amount in all outputs (excluding coinbase and thus reward [i.e. subsidy + totalfee])"

- n: "→<br>`total_size`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "Total size of all non-coinbase transactions"

- n: "→<br>`totalfee`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The fee total"

- n: "→<br>`txs`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The number of transactions (excluding coinbase)"

- n: "→<br>`utxo_increase`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The increase/decrease in the number of unspent outputs"

- n: "→<br>`utxo_size_inc`"
  t: "numeric"
  p: "Required<br>(exactly 1)"
  d: "The increase/decrease in size for the utxo index (not discounting op_return and similar)"
{% enditemplate %}

*Example from Dash Core 0.14.1*

{% highlight bash %}
dash-cli getblockstats 1000 '["blockhash","subsidy", "txs"]'
{% endhighlight %}

Result:
{% highlight json %}
{
  "blockhash": "000004e906762c8c70583418d46915b4271fa83c29d5b88544d05e09e3f3621d",
  "subsidy": 50000000000,
  "txs": 1
}
{% endhighlight %}

*See also: none*

{% endautocrossref %}
