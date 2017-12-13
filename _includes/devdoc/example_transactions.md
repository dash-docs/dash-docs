{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/example_transactions.md" %}
<!-- __ -->

## Transactions
{% include helpers/subhead-links.md %}

### Transaction Tutorial
{% include helpers/subhead-links.md %}

{% autocrossref %}

Creating transactions is something most Dash applications do.
This section describes how to use Dash Core's RPC interface to
create transactions with various attributes.

Your applications may use something besides Dash Core to create
transactions, but in any system, you will need to provide the same kinds
of data to create transactions with the same attributes as those
described below.

In order to use this tutorial, you will need to setup [Dash Core][core executable]
and create a regression test mode environment with 500 DASH in your test
wallet.

{% endautocrossref %}






#### Simple Spending
{% include helpers/subhead-links.md %}

{% autocrossref %}

Dash Core provides several RPCs which handle all the details of
spending, including creating change outputs and paying appropriate fees.
Even advanced users should use these RPCs whenever possible to decrease
the chance that duffs will be lost by mistake.

{% highlight bash %}
> dash-cli -regtest getnewaddress
yLp6ZJueuigiF4s9E1Pv8tEunDPEsjyQfd

> NEW_ADDRESS=yLp6ZJueuigiF4s9E1Pv8tEunDPEsjyQfd
{% endhighlight %}

Get a new Dash address and save it in the shell variable `$NEW_ADDRESS`.

{% highlight bash %}
> dash-cli -regtest sendtoaddress $NEW_ADDRESS 10.00
c7e5ae1240fdd83bb94c94a93816ed2ab7bcb56ec3ff8a9725c5c1e0482684ea
{% endhighlight %}

Send 10 dash to the address using the `sendtoaddress` RPC.  The
returned hex string is the transaction identifier (txid).

The `sendtoaddress` RPC automatically selects an unspent transaction
output (UTXO) from which to spend the duffs. In this case, it
withdrew the duffs from our only available UTXO, the coinbase
transaction for block #1 which matured with the creation of block #101.
To spend a specific UTXO, you could use the `sendfrom` RPC instead.

{% highlight bash %}
> dash-cli -regtest listunspent
[
]
{% endhighlight %}

Use the `listunspent` RPC to display the UTXOs belonging to this wallet.
The list is empty because it defaults to only showing confirmed
UTXOs and we just spent our only confirmed UTXO.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest listunspent 0
{% endhighlight %}
{% highlight json %}
[  
   {  
      "txid":"c7e5ae1240fdd83bb94c94a93816ed2ab7bcb56ec3ff8a9725c5c1e0482684ea",
      "vout":0,
      "address":"yLp6ZJueuigiF4s9E1Pv8tEunDPEsjyQfd",
      "account":"",
      "scriptPubKey":"76a914056b1fe57914236149feb21dcbc6b86f4bdd9f4988ac",
      "amount":10.00000000,
      "confirmations":0,
      "ps_rounds":-2,
      "spendable":true,
      "solvable":true
   },
   {  
      "txid":"c7e5ae1240fdd83bb94c94a93816ed2ab7bcb56ec3ff8a9725c5c1e0482684ea",
      "vout":1,
      "address":"yeP6Tw2uW4nWAFWRytw8TyshErTq59dUkN",
      "scriptPubKey":"76a914c622e98a6ccf34d02620612f58f20a50061cf4b188ac",
      "amount":490.00000000,
      "confirmations":0,
      "ps_rounds":-2,
      "spendable":true,
      "solvable":true
   }
]
{% endhighlight %}
</div>

Re-running the `listunspent` RPC with the argument "0" to also display
unconfirmed transactions shows that we have two UTXOs, both with the
same txid. The first UTXO shown is a change output that `sendtoaddress`
created using a new address from the key pool. The second UTXO shown is
the spend to the address we provided. If we had spent those duffs to
someone else, that second transaction would not be displayed in our
list of UTXOs.

{% highlight bash %}
> dash-cli -regtest generate 1

> unset NEW_ADDRESS
{% endhighlight %}

Create a new block to confirm the transaction above (takes less than a
second) and clear the shell variable.

{% endautocrossref %}

##### Simple Spending Script

<!-- Shell script to run previous example -->
Shell script to run the previous example:
<div markdown="1" class="multicode">
<script src="https://gist.github.com/dash-docs/f40bddfc0844ec0d66d196720dc936f8.js"></script>
</div>



#### Simple Raw Transaction
{% include helpers/subhead-links.md %}

{% autocrossref %}

The raw transaction RPCs allow users to create custom transactions and
delay broadcasting those transactions. However, mistakes made in raw
transactions may not be detected by Dash Core, and a number of raw
transaction users have permanently lost large numbers of duffs, so
please be careful using raw transactions on mainnet.

This subsection covers one of the simplest possible raw transactions.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest listunspent
{% endhighlight %}
{% highlight json %}
[
  {
    "txid": "f84ca4ad33ec7889d3c6ac670152137a3ee1603c4096230a10562976f700d130",
    "vout": 0,
    "address": "yRdk89fwSW1mUBxQo5fCmEfTva7b4wh2H5",
    "account": "",
    "scriptPubKey": "76a9143a4e8960f26c1fa82d937046959b656e4dd7966688ac",
    "amount": 10.00000000,
    "confirmations": 1,
    "ps_rounds": -2,
    "spendable": true,
    "solvable": true
  },
  {
    "txid": "f84ca4ad33ec7889d3c6ac670152137a3ee1603c4096230a10562976f700d130",
    "vout": 1,
    "address": "yavnyFMebbfX4F2VC25P18FW6LS66h2wqJ",
    "scriptPubKey": "76a914a0411dbed3eab4341d5c41496d61b4fa1b22037e88ac",
    "amount": 490.00000000,
    "confirmations": 1,
    "ps_rounds": -2,
    "spendable": true,
    "solvable": true
  },
  {
    "txid": "9036265a8f577421e556cd4f729752d73469953deea759de11efa9ba354936a8",
    "vout": 0,
    "address": "yWtgzKSckhedxtJ8NXhShWGjfBivkvBGgG",
    "scriptPubKey": "21023fff9c9dc9088c0aeba90d75413705091111311d761054de23ac\
                      dd217450869aac",
    "amount": 500.00000000,
    "confirmations": 101,
    "ps_rounds": -2,
    "spendable": true,
    "solvable": true
  }
]

{% endhighlight %}
{% highlight bash %}

> UTXO_TXID=9036265a8f577421e556cd4f729752d73469953deea759de11ef[...]
> UTXO_VOUT=0
{% endhighlight %}
</div>

Re-rerun `listunspent`. We now have three UTXOs: the two transactions we
created before plus the coinbase transaction from block #2. We save the
txid and output index number (vout) of that coinbase UTXO to shell
variables.

{% highlight bash %}
> dash-cli -regtest getnewaddress
yfV9Wirf5RkYHgNDttjpBz8Wdi8BavLHcP

> NEW_ADDRESS=yfV9Wirf5RkYHgNDttjpBz8Wdi8BavLHcP
{% endhighlight %}

Get a new address to use in the raw transaction.

{% highlight bash %}
## Outputs - inputs = transaction fee, so always double-check your math!
> dash-cli -regtest createrawtransaction '''
    [
      {
        "txid": "'$UTXO_TXID'",
        "vout": '$UTXO_VOUT'
      }
    ]
    ''' '''
    {
      "'$NEW_ADDRESS'": 499.9999
    }'''
0100000001a8364935baa9ef11de59a7ee3d956934d75297724fcd56e5217457\
8f5a2636900000000000ffffffff01f04c3ba40b0000001976a914d240140859\
744755d73e5967081c3bedceffc5db88ac00000000

> RAW_TX=0100000001a8364935baa9ef11de59a7ee3d956934d75297724fcd5[...]
{% endhighlight %}

Using two arguments to the `createrawtransaction` RPC, we create a new
raw format transaction. The first argument (a JSON array) references
the txid of the coinbase transaction from block #2 and the index
number (0) of the output from that transaction we want to spend. The
second argument (a JSON object) creates the output with the address
(public key hash) and number of dash we want to transfer.
We save the resulting raw format transaction to a shell variable.

![Warning icon](/img/icons/icon_warning.svg)
 **Warning:** `createrawtransaction` does not automatically create change
outputs, so you can easily accidentally pay a large transaction fee. In
this example, our input had 500.0000 dash and our output
(`$NEW_ADDRESS`) is being paid 499.9999 dash, so the transaction will
include a fee of 0.0001 dash. If we had paid `$NEW_ADDRESS` only 100
dash with no other changes to this transaction, the transaction fee
would be a whopping 400 dash. See the Complex Raw Transaction
subsection below for how to create a transaction with multiple outputs so you
can send the change back to yourself.


<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest decoderawtransaction $RAW_TX
{% endhighlight %}
{% highlight json %}
{
  "txid": "7cbd2245ee5d824c00fc08b3bf2f694ad9a215d38d897fcf2df64a43c59bb97b",
  "size": 85,
  "version": 1,
  "locktime": 0,
  "vin": [
    {
      "txid": "9036265a8f577421e556cd4f729752d73469953deea759de11efa9ba354936a8",
      "vout": 0,
      "scriptSig": {
        "asm": "",
        "hex": ""
      },
      "sequence": 4294967295
    }
  ],
  "vout": [
    {
      "value": 499.99990000,
      "valueSat": 49999990000,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 d240140859744755d73e5967081c3bedceffc5db\
                  OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914d240140859744755d73e5967081c3bedceffc5db88ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yfV9Wirf5RkYHgNDttjpBz8Wdi8BavLHcP"
        ]
      }
    }
  ]
}
{% endhighlight %}
</div>

Use the `decoderawtransaction` RPC to see exactly what the transaction
we just created does.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest signrawtransaction $RAW_TX
{% endhighlight %}
{% highlight json %}
{
  "hex": "0100000001a8364935baa9ef11de59a7ee3d956934d75297724fcd\
          56e52174578f5a2636900000000049483045022100b4e5e9224afa\
          de8686bb22a957d1ec1587a66ee84943761b2d9061d5f751cd7602\
          203c88d4064641a413ce3d0824264d6d87908960487afe9a3a133e\
          7d67a22fd05101ffffffff01f04c3ba40b0000001976a914d24014\
          0859744755d73e5967081c3bedceffc5db88ac00000000",
  "complete": true
}
{% endhighlight %}
{% highlight bash %}

> SIGNED_RAW_TX=0100000001a8364935baa9ef11de59a7ee3d956934d75297[...]
{% endhighlight %}
</div>

Use the `signrawtransaction` RPC to sign the transaction created by
`createrawtransaction` and save the returned "hex" raw format signed
transaction to a shell variable.

Even though the transaction is now complete, the Dash Core node we're
connected to doesn't know anything about the transaction, nor does any
other part of the network. We've created a spend, but we haven't
actually spent anything because we could simply unset the
`$SIGNED_RAW_TX` variable to eliminate the transaction.

{% highlight bash %}
> dash-cli -regtest sendrawtransaction $SIGNED_RAW_TX
fa0f4105b0a2b2706d65581c5e6411d3970253c7f231944fa2f978b4a3d9010d
{% endhighlight %}

Send the signed transaction to the connected node using the
`sendrawtransaction` RPC. After accepting the transaction, the node
would usually then broadcast it to other peers, but we're not currently
connected to other peers because we started in regtest mode.

{% highlight bash %}
> dash-cli -regtest generate 1

> unset UTXO_TXID UTXO_VOUT NEW_ADDRESS RAW_TX SIGNED_RAW_TX
{% endhighlight %}

Generate a block to confirm the transaction and clear our shell
variables.

{% endautocrossref %}





#### Complex Raw Transaction
{% include helpers/subhead-links.md %}

{% autocrossref %}

In this example, we'll create a transaction with two inputs and two
outputs.  We'll sign each of the inputs separately, as might happen if
the two inputs belonged to different people who agreed to create a
transaction together (such as a CoinJoin transaction).

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest listunspent
{% endhighlight %}
{% highlight json %}
[
  {
    "txid": "fa0f4105b0a2b2706d65581c5e6411d3970253c7f231944fa2f978b4a3d9010d",
    "vout": 0,
    "address": "yfV9Wirf5RkYHgNDttjpBz8Wdi8BavLHcP",
    "account": "",
    "scriptPubKey": "76a914d240140859744755d73e5967081c3bedceffc5db88ac",
    "amount": 499.99990000,
    "confirmations": 1,
    "ps_rounds": -2,
    "spendable": true,
    "solvable": true
  },
  {
    "txid": "f84ca4ad33ec7889d3c6ac670152137a3ee1603c4096230a10562976f700d130",
    "vout": 0,
    "address": "yRdk89fwSW1mUBxQo5fCmEfTva7b4wh2H5",
    "account": "",
    "scriptPubKey": "76a9143a4e8960f26c1fa82d937046959b656e4dd7966688ac",
    "amount": 10.00000000,
    "confirmations": 2,
    "ps_rounds": -2,
    "spendable": true,
    "solvable": true
  },
  {
    "txid": "f84ca4ad33ec7889d3c6ac670152137a3ee1603c4096230a10562976f700d130",
    "vout": 1,
    "address": "yavnyFMebbfX4F2VC25P18FW6LS66h2wqJ",
    "scriptPubKey": "76a914a0411dbed3eab4341d5c41496d61b4fa1b22037e88ac",
    "amount": 490.00000000,
    "confirmations": 2,
    "ps_rounds": -2,
    "spendable": true,
    "solvable": true
  },
  {
    "txid": "ea6d596da55a137846f8b08bfd414b4667ce456f9e3b3182e6f05810e8613d84",
    "vout": 0,
    "address": "yWtgzKSckhedxtJ8NXhShWGjfBivkvBGgG",
    "scriptPubKey": "21023fff9c9dc9088c0aeba90d75413705091111311d761054de23\
                      acdd217450869aac",
    "amount": 500.00000000,
    "confirmations": 101,
    "ps_rounds": -2,
    "spendable": true,
    "solvable": true
  }
]
{% endhighlight %}
{% highlight bash %}

> UTXO1_TXID=ea6d596da55a137846f8b08bfd414b4667ce456f9e3b3182e6f05810e8613d84
> UTXO1_VOUT=0
> UTXO1_ADDRESS=yWtgzKSckhedxtJ8NXhShWGjfBivkvBGgG

> UTXO2_TXID=f84ca4ad33ec7889d3c6ac670152137a3ee1603c4096230a10562976f700d130
> UTXO2_VOUT=0
> UTXO2_ADDRESS=yRdk89fwSW1mUBxQo5fCmEfTva7b4wh2H5
{% endhighlight %}
</div>

For our two inputs, we select two UTXOs by placing the txid and output
index numbers (vouts) in shell variables.  We also save the addresses
corresponding to the public keys (hashed or unhashed) used in those
transactions. We need the addresses so we can get the corresponding
private keys from our wallet.

{% highlight bash %}
> dash-cli -regtest dumpprivkey $UTXO1_ADDRESS
cNL522MEQUnQxsZJo4ryPH8sPd2uVZaFKjKnZivo9DyVjpAGU7qP

> dash-cli -regtest dumpprivkey $UTXO2_ADDRESS
cPtZ9nagmjQ5bRKMuqoDz8xni6hRPfZ1zp3TSrqH3j3RyUThTYGN

> UTXO1_PRIVATE_KEY=cNL522MEQUnQxsZJo4ryPH8sPd2uVZaFKjKnZivo9DyVjpAGU7qP

> UTXO2_PRIVATE_KEY=cPtZ9nagmjQ5bRKMuqoDz8xni6hRPfZ1zp3TSrqH3j3RyUThTYGN
{% endhighlight %}

Use the `dumpprivkey` RPC to get the private keys corresponding to the
public keys used in the two UTXOs out inputs we will be spending.  We need
the private keys so we can sign each of the inputs separately.

![Warning icon](/img/icons/icon_warning.svg)
 **Warning:** Users should never manually manage private keys on mainnet.
As dangerous as raw transactions are (see warnings above), making a
mistake with a private key can be much worse---as in the case of a HD
wallet [cross-generational key compromise][devguide hardened keys].
**These examples are to help you learn, not for you to emulate on
mainnet.**

{% highlight bash %}
> dash-cli -regtest getnewaddress
yhshGrdbh3rWt9EPaSi7xSGRFMvFdzTZ8n
> dash-cli -regtest getnewaddress
yesLaP5XFTaLZiWAo2zK8mFfUCtV8rRhKw

> NEW_ADDRESS1=yhshGrdbh3rWt9EPaSi7xSGRFMvFdzTZ8n
> NEW_ADDRESS2=yesLaP5XFTaLZiWAo2zK8mFfUCtV8rRhKw
{% endhighlight %}

For our two outputs, get two new addresses.

{% highlight bash %}
## Outputs - inputs = transaction fee, so always double-check your math!
> dash-cli -regtest createrawtransaction '''
    [
      {
        "txid": "'$UTXO1_TXID'",
        "vout": '$UTXO1_VOUT'
      },
      {
        "txid": "'$UTXO2_TXID'",
        "vout": '$UTXO2_VOUT'
      }
    ]
    ''' '''
    {
      "'$NEW_ADDRESS1'": 499.9999,
      "'$NEW_ADDRESS2'": 10
    }'''
0100000002843d61e81058f0e682313b9e6f45ce67464b41fd8bb0f84678135a\
a56d596dea0000000000ffffffff30d100f7762956100a2396403c60e13e7a13\
520167acc6d38978ec33ada44cf80000000000ffffffff02f04c3ba40b000000\
1976a914ec73fe6129b249617bb5f20c8760708055fb6fdb88ac00ca9a3b0000\
00001976a914cb7a56b046479f8c247875d672d3e1aed18c33f488ac00000000

> RAW_TX=0100000002843d61e81058f0e682313b9e6f45ce67464b41fd8bb0f[...]
{% endhighlight %}

Create the raw transaction using `createrawtransaction` much the same as
before, except now we have two inputs and two outputs.


<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest signrawtransaction $RAW_TX '[]' '''
    [
      "'$UTXO1_PRIVATE_KEY'"
    ]'''
{% endhighlight %}
{% highlight json %}
{
  "hex": "0100000002843d61e81058f0e682313b9e6f45ce67464b41fd8bb0\
  f84678135aa56d596dea00000000494830450221009f7f356c0cc2d3337b5f\
  76dfc6de9f9be7c8c5ac2074cbeeba4815b90329602002207790f23361480e\
  2a5a2d1fa6e293ccd5cd01279ad301176f091b84d6dd8e8f6501ffffffff30\
  d100f7762956100a2396403c60e13e7a13520167acc6d38978ec33ada44cf8\
  0000000000ffffffff02f04c3ba40b0000001976a914ec73fe6129b249617b\
  b5f20c8760708055fb6fdb88ac00ca9a3b000000001976a914cb7a56b04647\
  9f8c247875d672d3e1aed18c33f488ac00000000",
  "complete": false,
  "errors": [
    {
      "txid": "f84ca4ad33ec7889d3c6ac670152137a3ee1603c4096230a1\
                0562976f700d130",
      "vout": 0,
      "scriptSig": "",
      "sequence": 4294967295,
      "error": "Operation not valid with the current stack size"
    }
  ]
}
{% endhighlight %}
{% highlight bash %}

> PARTLY_SIGNED_RAW_TX=0100000002843d61e81058f0e682313b9e6f45ce6[...]
{% endhighlight %}
</div>

Signing the raw transaction with `signrawtransaction` gets more
complicated as we now have three arguments:

1. The unsigned raw transaction.

2. An empty array. We don't do anything with this argument in this
   operation, but some valid JSON must be provided to get access to the
   later positional arguments.

3. The private key we want to use to sign one of the inputs.

The result is a raw transaction with only one input signed; the fact
that the transaction isn't fully signed is indicated by value of the
`complete` JSON field.  We save the incomplete, partly-signed raw
transaction hex to a shell variable.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest signrawtransaction $PARTLY_SIGNED_RAW_TX '[]' '''
    [
      "'$UTXO2_PRIVATE_KEY'"
    ]'''
{% endhighlight %}
{% highlight json %}
{
  "hex": "0100000002843d61e81058f0e682313b9e6f45ce67464b41fd8bb0\
  f84678135aa56d596dea00000000494830450221009f7f356c0cc2d3337b5f\
  76dfc6de9f9be7c8c5ac2074cbeeba4815b90329602002207790f23361480e\
  2a5a2d1fa6e293ccd5cd01279ad301176f091b84d6dd8e8f6501ffffffff30\
  d100f7762956100a2396403c60e13e7a13520167acc6d38978ec33ada44cf8\
  000000006a47304402207867e88e3fe2c926df29376d77eba81daf9f4a5573\
  44d4f02e9c7dcee96a51e4022076274c2365dc069e7ef797c95c75ab6e01ca\
  3757342f3e6f21a3d9d01086efb7012102ff9005f79aa4c22ac48fa93d9b7f\
  40f321db1c13cd70cf08bdab3e23c8d19620ffffffff02f04c3ba40b000000\
  1976a914ec73fe6129b249617bb5f20c8760708055fb6fdb88ac00ca9a3b00\
  0000001976a914cb7a56b046479f8c247875d672d3e1aed18c33f488ac0000\
  0000",
  "complete": true
}
{% endhighlight %}
</div>

To sign the second input, we repeat the process we used to sign the
first input using the second private key. Now that both inputs are
signed, the `complete` result is *true*.

{% highlight bash %}
> unset PARTLY_SIGNED_RAW_TX RAW_TX NEW_ADDRESS1 [...]
{% endhighlight %}

Clean up the shell variables used. Unlike previous subsections, we're
not going to send this transaction to the connected node with
`sendrawtransaction`. This will allow us to illustrate in the Offline
Signing subsection below how to spend a transaction which is not yet in
the block chain or memory pool.

{% endautocrossref %}





#### Offline Signing
{% include helpers/subhead-links.md %}

{% autocrossref %}

We will now spend the transaction created in the Complex Raw Transaction
subsection above without sending it to the local node first. This is the
same basic process used by wallet programs for offline
signing---which generally means signing a transaction without access
to the current UTXO set.

Offline signing is safe. However, in this example we will also be
spending an output which is not part of the block chain because the
transaction containing it has never been broadcast. That can be unsafe:

![Warning icon](/img/icons/icon_warning.svg)
 **Warning:** Transactions which spend outputs from unconfirmed
transactions are vulnerable to transaction malleability. Be sure to read
about transaction malleability and adopt good practices before spending
unconfirmed transactions on mainnet.

{% highlight bash %}
> OLD_SIGNED_RAW_TX=0100000002843d61e81058f0e682313b9e6f45ce67464b41fd8bb0\
      f84678135aa56d596dea00000000494830450221009f7f356c0cc2d3337b5f76dfc6\
      de9f9be7c8c5ac2074cbeeba4815b90329602002207790f23361480e2a5a2d1fa6e2\
      93ccd5cd01279ad301176f091b84d6dd8e8f6501ffffffff30d100f7762956100a23\
      96403c60e13e7a13520167acc6d38978ec33ada44cf8000000006a47304402207867\
      e88e3fe2c926df29376d77eba81daf9f4a557344d4f02e9c7dcee96a51e402207627\
      4c2365dc069e7ef797c95c75ab6e01ca3757342f3e6f21a3d9d01086efb7012102ff\
      9005f79aa4c22ac48fa93d9b7f40f321db1c13cd70cf08bdab3e23c8d19620ffffff\
      ff02f04c3ba40b0000001976a914ec73fe6129b249617bb5f20c8760708055fb6fdb\
      88ac00ca9a3b000000001976a914cb7a56b046479f8c247875d672d3e1aed18c33f4\
      88ac00000000
{% endhighlight %}

Put the previously signed (but not sent) transaction into a shell
variable.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest decoderawtransaction $OLD_SIGNED_RAW_TX
{% endhighlight %}
{% highlight json %}
{
  "txid": "5efd61cf24c9644d79646627c4d1e192e9b2a760a5c720db8f4a9f76cb781077",
  "size": 339,
  "version": 1,
  "locktime": 0,
  "vin": [
    {
      "txid": "ea6d596da55a137846f8b08bfd414b4667ce456f9e3b3182e6f05810e86\
                13d84",
      "vout": 0,
      "scriptSig": {
        "asm": "30450221009f7f356c0cc2d3337b5f76dfc6de9f9be7c8c5ac2074cbee\
                ba4815b90329602002207790f23361480e2a5a2d1fa6e293ccd5cd0127\
                9ad301176f091b84d6dd8e8f65[ALL]",
        "hex": "4830450221009f7f356c0cc2d3337b5f76dfc6de9f9be7c8c5ac2074cb\
                eeba4815b90329602002207790f23361480e2a5a2d1fa6e293ccd5cd01\
                279ad301176f091b84d6dd8e8f6501"
      },
      "sequence": 4294967295
    },
    {
      "txid": "f84ca4ad33ec7889d3c6ac670152137a3ee1603c4096230a10562976f70\
                0d130",
      "vout": 0,
      "scriptSig": {
        "asm": "304402207867e88e3fe2c926df29376d77eba81daf9f4a557344d4f02e\
                9c7dcee96a51e4022076274c2365dc069e7ef797c95c75ab6e01ca3757\
                342f3e6f21a3d9d01086efb7[ALL] 02ff9005f79aa4c22ac48fa93d9b\
                7f40f321db1c13cd70cf08bdab3e23c8d19620",
        "hex": "47304402207867e88e3fe2c926df29376d77eba81daf9f4a557344d4f0\
                2e9c7dcee96a51e4022076274c2365dc069e7ef797c95c75ab6e01ca37\
                57342f3e6f21a3d9d01086efb7012102ff9005f79aa4c22ac48fa93d9b\
                7f40f321db1c13cd70cf08bdab3e23c8d19620"
      },
      "sequence": 4294967295
    }
  ],
  "vout": [
    {
      "value": 499.99990000,
      "valueSat": 49999990000,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 ec73fe6129b249617bb5f20c8760708055fb6fdb\
                OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914ec73fe6129b249617bb5f20c8760708055fb6fdb88ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yhshGrdbh3rWt9EPaSi7xSGRFMvFdzTZ8n"
        ]
      }
    },
    {
      "value": 10.00000000,
      "valueSat": 1000000000,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 cb7a56b046479f8c247875d672d3e1aed18c33f4\
                OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914cb7a56b046479f8c247875d672d3e1aed18c33f488ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yesLaP5XFTaLZiWAo2zK8mFfUCtV8rRhKw"
        ]
      }
    }
  ]
}
{% endhighlight %}
{% highlight bash %}

> UTXO_TXID=5efd61cf24c9644d79646627c4d1e192e9b2a760a5c720db8f4a9f76cb781077
> UTXO_VOUT=1
> UTXO_OUTPUT_SCRIPT=76a914cb7a56b046479f8c247875d672d3e1aed18c33f488ac
{% endhighlight %}
</div>


Decode the signed raw transaction so we can get its txid. Also, choose a
specific one of its UTXOs to spend and save that UTXO's output index number
(vout) and hex pubkey script (scriptPubKey) into shell variables.

{% highlight bash %}
> dash-cli -regtest getnewaddress
yfijhy7gYY34J2U77xFKdMwfA8k5mVnSRa

> NEW_ADDRESS=yfijhy7gYY34J2U77xFKdMwfA8k5mVnSRa
{% endhighlight %}

Get a new address to spend the duffs to.

{% highlight bash %}
## Outputs - inputs = transaction fee, so always double-check your math!
> dash-cli -regtest createrawtransaction '''
    [
      {
        "txid": "'$UTXO_TXID'",
        "vout": '$UTXO_VOUT'
      }
    ]
    ''' '''
    {
      "'$NEW_ADDRESS'": 9.9999
    }'''
0100000001771078cb769f4a8fdb20c7a560a7b2e992e1d1c4276664794d64c9\
24cf61fd5e0100000000ffffffff01f0a29a3b000000001976a914d4d2078580\
a9eea0ca9368d1c99c097279b8081f88ac00000000

> RAW_TX=0100000001771078cb769f4a8fdb20c7a560a7b2e992e1d1c427666[...]
{% endhighlight %}

Create the raw transaction the same way we've done in the previous
subsections.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest signrawtransaction $RAW_TX
{% endhighlight %}
{% highlight json %}
{
  "hex": "0100000001771078cb769f4a8fdb20c7a560a7b2e992e1d1c4276664794d64c9\
          24cf61fd5e0100000000ffffffff01f0a29a3b000000001976a914d4d2078580\
          a9eea0ca9368d1c99c097279b8081f88ac00000000",
  "complete": false,
  "errors": [
    {
      "txid": "5efd61cf24c9644d79646627c4d1e192e9b2a760a5c720db8f4a9f76cb7\
                81077",
      "vout": 1,
      "scriptSig": "",
      "sequence": 4294967295,
      "error": "Input not found or already spent"
    }
  ]
}
{% endhighlight %}
</div>

Attempt to sign the raw transaction without any special arguments, the
way we successfully signed the the raw transaction in the Simple Raw
Transaction subsection. If you've read the [Transaction section][transaction] of
the guide, you may know why the call fails and leaves the raw
transaction hex unchanged.

![Old Transaction Data Required To Be Signed](/img/dev/en-signing-output-to-spend.svg)

As illustrated above, the data that gets signed includes the txid and
vout from the previous transaction.  That information is included in the
`createrawtransaction` raw transaction.  But the data that gets signed
also includes the pubkey script from the previous transaction, even
though it doesn't appear in either the unsigned or signed transaction.

In the other raw transaction subsections above, the previous output was
part of the UTXO set known to the wallet, so the wallet was able to use
the txid and output index number to find the previous pubkey script and
insert it automatically.

In this case, you're spending an output which is unknown to the wallet,
so it can't automatically insert the previous pubkey script.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest signrawtransaction $RAW_TX '''
    [
      {
        "txid": "'$UTXO_TXID'",
        "vout": '$UTXO_VOUT',
        "scriptPubKey": "'$UTXO_OUTPUT_SCRIPT'"
      }
    ]'''
{% endhighlight %}
{% highlight json %}
{
  "hex": "0100000001771078cb769f4a8fdb20c7a560a7b2e992e1d1c4276664794d64c9\
          24cf61fd5e010000006a47304402204ee3aae064dccedb511a84fcade3f35f2d\
          95119283e2e9f23659d91ce799cb6d02203a4cecbd7c154de8394b9505814f1e\
          c842e890980e7c4c20ed182f09a71d65f3012103b0b12fb25b6382b0680ce4b0\
          379bc201c4cbb391d3c0e171181f24c9a5df1468ffffffff01f0a29a3b000000\
          001976a914d4d2078580a9eea0ca9368d1c99c097279b8081f88ac00000000",
  "complete": true
}
{% endhighlight %}
{% highlight bash %}

> SIGNED_RAW_TX=0100000001771078cb769f4a8fdb20c7a560a7b2e992e1d1[...]
{% endhighlight %}
</div>

Successfully sign the transaction by providing the previous pubkey
script and other required input data.

This specific operation is typically what offline signing wallets do.
The online wallet creates the raw transaction and gets the previous
pubkey scripts for all the inputs. The user brings this information to
the offline wallet. After displaying the transaction details to the
user, the offline wallet signs the transaction as we did above. The
user takes the signed transaction back to the online wallet, which
broadcasts it.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest sendrawtransaction $SIGNED_RAW_TX
{% endhighlight %}
{% highlight bash %}
error code: -25
error message:
Missing inputs

error: {"code":-22,"message":"TX rejected"}
{% endhighlight %}
</div>

Attempt to broadcast the second transaction before we've broadcast the
first transaction.  The node rejects this attempt because the second
transaction spends an output which is not a UTXO the node knows about.

{% highlight bash %}
> dash-cli -regtest sendrawtransaction $OLD_SIGNED_RAW_TX
5efd61cf24c9644d79646627c4d1e192e9b2a760a5c720db8f4a9f76cb781077
> dash-cli -regtest sendrawtransaction $SIGNED_RAW_TX
f89deefb927fbd03c5acab194de2ba8f98ab160b9c4b3f57bde63073c4b5f060
{% endhighlight %}

Broadcast the first transaction, which succeeds, and then broadcast the
second transaction---which also now succeeds because the node now sees
the UTXO.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest getrawmempool
{% endhighlight %}
{% highlight json %}
[
  "f89deefb927fbd03c5acab194de2ba8f98ab160b9c4b3f57bde63073c4b5f060",
  "5efd61cf24c9644d79646627c4d1e192e9b2a760a5c720db8f4a9f76cb781077"
]
{% endhighlight %}
</div>

We have once again not generated an additional block, so the transactions
above have not yet become part of the regtest block chain.  However, they
are part of the local node's memory pool.

{% highlight bash %}
> unset OLD_SIGNED_RAW_TX SIGNED_RAW_TX RAW_TX [...]
{% endhighlight %}

Remove old shell variables.

{% endautocrossref %}






#### P2SH Multisig
{% include helpers/subhead-links.md %}

{% autocrossref %}

In this subsection, we will create a P2SH multisig address, spend
duffs to it, and then spend those duffs from it to another
address.

Creating a multisig address is easy. Multisig outputs have two
parameters, the *minimum* number of signatures required (*m*) and the
*number* of public keys to use to validate those signatures. This is
called m-of-n, and in this case we'll be using 2-of-3.

{% highlight bash %}
    > dash-cli -regtest getnewaddress
    yYtWtpW7akCc2a5En8NsXeTGENyYbNgv9q
    > dash-cli -regtest getnewaddress
    yarm2x9eDFd9dKCycyPigwwj1vfJcYFxsH
    > dash-cli -regtest getnewaddress
    yLknHbtnjJRVWQr78aTfCPfNB42jfNkDWK

    > NEW_ADDRESS1=yYtWtpW7akCc2a5En8NsXeTGENyYbNgv9q
    > NEW_ADDRESS2=yarm2x9eDFd9dKCycyPigwwj1vfJcYFxsH
    > NEW_ADDRESS3=yLknHbtnjJRVWQr78aTfCPfNB42jfNkDWK
{% endhighlight %}

Generate three new P2PKH addresses. P2PKH addresses cannot be used with
the multisig redeem script created below. (Hashing each public key is
unnecessary anyway---all the public keys are protected by a hash when
the redeem script is hashed.) However, Dash Core uses addresses as a
way to reference the underlying full (unhashed) public keys it knows
about, so we get the three new addresses above in order to use their
public keys.

Recall from the Guide that the hashed public keys used in addresses
obfuscate the full public key, so you cannot give an address to another
person or device as part of creating a typical multisig output or P2SH multisig
redeem script. You must give them a full public key.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest validateaddress $NEW_ADDRESS3
{% endhighlight %}
{% highlight json %}
{
  "isvalid": true,
  "address": "yLknHbtnjJRVWQr78aTfCPfNB42jfNkDWK",
  "scriptPubKey": "76a91404caa000366b99780f8e606ccc818883ca7f48f888ac",
  "ismine": true,
  "iswatchonly": false,
  "isscript": false,
  "pubkey": "038007ef6fd812d73da054271b68a42dae06672cff2a30b2814935537e593\
              0ebf6",
  "iscompressed": true,
  "account": ""
}

{% endhighlight %}
{% highlight bash %}

> NEW_ADDRESS3_PUBLIC_KEY=038007ef6fd812d73da054271b68a42dae0667[...]
{% endhighlight %}
</div>

Use the `validateaddress` RPC to display the full (unhashed) public key
for one of the addresses.  This is the information which will
actually be included in the multisig redeem script.  This is also the
information you would give another person or device as part of creating
a multisig output or P2SH multisig redeem script.

We save the address returned to a shell variable.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest createmultisig 2 '''
    [
      "'$NEW_ADDRESS1'",
      "'$NEW_ADDRESS2'",
      "'$NEW_ADDRESS3_PUBLIC_KEY'"
    ]'''
{% endhighlight %}
{% highlight json %}
{
  "address": "8meEZF54K7GxhHhdLCCeNwFQjHENv4CK86",
  "redeemScript": "522103fa8866cccae3c975a72884443a351801a0ea9721cbe721558\
                  6ddd6fab5f39f262103b2259f42a241f4870e794521594f2af7aadf0\
                  e4c580a43582e58630e4618634621038007ef6fd812d73da054271b6\
                  8a42dae06672cff2a30b2814935537e5930ebf653ae"
}
{% endhighlight %}
{% highlight bash %}

> P2SH_ADDRESS=8meEZF54K7GxhHhdLCCeNwFQjHENv4CK86
> P2SH_REDEEM_SCRIPT=522103fa8866cccae3c975a72884443a351801a0ea9[...]
{% endhighlight %}
</div>

Use the `createmultisig` RPC with two arguments, the number (*n*) of
signatures required and a list of addresses or public keys.  Because
P2PKH addresses can't be used in the multisig redeem script created by this
RPC, the only addresses which can be provided are those belonging to a
public key in the wallet.  In this case, we provide two addresses and
one public key---all of which will be converted to public keys in the
redeem script.

The P2SH address is returned along with the redeem script which must be
provided when we spend duffs sent to the P2SH address.

![Warning icon](/img/icons/icon_warning.svg)
 **Warning:** You must not lose the redeem script, especially if you
don't have a record of which public keys you used to create the P2SH
multisig address. You need the redeem script to spend any dash sent
to the P2SH address. If you lose the redeem script, you can recreate it
by running the same command above, with the public keys listed in the
same order. However, if you lose both the redeem script and even one of
the public keys, you will never be able to spend duffs sent to that
P2SH address.

Neither the address nor the redeem script are stored in the wallet when
you use `createmultisig`. To store them in the wallet, use the
`addmultisigaddress` RPC instead.  If you add an address to the wallet,
you should also make a new backup.

{% highlight bash %}
> dash-cli -regtest sendtoaddress $P2SH_ADDRESS 10.00
ddb2a2eb2402a9ae61d7db93a9a48c0747859d899e704b10f5b72145779f9c52

> UTXO_TXID=ddb2a2eb2402a9ae61d7db93a9a48c0747859d899e704b10f5b7[...]
{% endhighlight %}

Paying the P2SH multisig address with Dash Core is as simple as
paying a more common P2PKH address. Here we use the same command (but
different variable) we used in the Simple Spending subsection. As
before, this command automatically selects an UTXO, creates a change
output to a new one of our P2PKH addresses if necessary, and pays a
transaction fee if necessary.

We save that txid to a shell variable as the txid of the UTXO we plan to spend next.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest getrawtransaction $UTXO_TXID 1
{% endhighlight %}
{% highlight json %}
{
  "hex": "010000000130d100f7762956100a2396403c60e13e7a13520167acc6d38978ec\
          33ada44cf8010000006b48304502210084effe3132550e6ba43a7f4cc54ad30d\
          001c0dbc3ea66d638e5f3d6039a28c2b022044c8cd89cf455b8650fe259306eb\
          2a30b0112969717e469a722bca0263e0975d01210324c2226564b19f0948306b\
          b7160a735c28001bbd046cd46059df9f8434f41254feffffff0200ca9a3b0000\
          000017a9144f334f26e350c8903c92ff25b733670902cfad5a8700e0052d0b00\
          00001976a91479165c2155b8fec5c702ec7f251d0982f27b402988ac67000000",
  "txid": "ddb2a2eb2402a9ae61d7db93a9a48c0747859d899e704b10f5b72145779f9c52",
  "size": 224,
  "version": 1,
  "locktime": 103,
  "vin": [
    {
      "txid": "f84ca4ad33ec7889d3c6ac670152137a3ee1603c4096230a10562976f70\
                0d130",
      "vout": 1,
      "scriptSig": {
        "asm": "304502210084effe3132550e6ba43a7f4cc54ad30d001c0dbc3ea66d63\
                8e5f3d6039a28c2b022044c8cd89cf455b8650fe259306eb2a30b01129\
                69717e469a722bca0263e0975d[ALL] 0324c2226564b19f0948306bb7\
                160a735c28001bbd046cd46059df9f8434f41254",
        "hex": "48304502210084effe3132550e6ba43a7f4cc54ad30d001c0dbc3ea66d\
                638e5f3d6039a28c2b022044c8cd89cf455b8650fe259306eb2a30b011\
                2969717e469a722bca0263e0975d01210324c2226564b19f0948306bb7\
                160a735c28001bbd046cd46059df9f8434f41254"
      },
      "sequence": 4294967294
    }
  ],
  "vout": [
    {
      "value": 10.00000000,
      "valueSat": 1000000000,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_HASH160 4f334f26e350c8903c92ff25b733670902cfad5a OP_EQUAL",
        "hex": "a9144f334f26e350c8903c92ff25b733670902cfad5a87",
        "reqSigs": 1,
        "type": "scripthash",
        "addresses": [
          "8meEZF54K7GxhHhdLCCeNwFQjHENv4CK86"
        ]
      }
    },
    {
      "value": 480.00000000,
      "valueSat": 48000000000,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 79165c2155b8fec5c702ec7f251d0982f27b4029\
                OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a91479165c2155b8fec5c702ec7f251d0982f27b402988ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yXMhQ1L5q3PcnJgEhyAFztQPPRaEr8Mh8s"
        ]
      }
    }
  ]
}
{% endhighlight %}
{% highlight bash %}

> UTXO_VOUT=0
> UTXO_OUTPUT_SCRIPT=a9144f334f26e350c8903c92ff25b733670902cfad5a87
{% endhighlight %}
</div>

We use the `getrawtransaction` RPC with the optional second argument
(*true*) to get the decoded transaction we just created with
`sendtoaddress`. We choose one of the outputs to be our UTXO and get
its output index number (vout) and pubkey script (scriptPubKey).

{% highlight bash %}
> dash-cli -regtest getnewaddress
yZSxAakpoWGG3vcsvpk9qNtsYREhump4Cr

> NEW_ADDRESS4=yZSxAakpoWGG3vcsvpk9qNtsYREhump4Cr
{% endhighlight %}

We generate a new P2PKH address to use in the output we're about to
create.

{% highlight bash %}
## Outputs - inputs = transaction fee, so always double-check your math!
> dash-cli -regtest createrawtransaction '''
    [
      {
        "txid": "'$UTXO_TXID'",
        "vout": '$UTXO_VOUT'
      }
   ]
   ''' '''
   {
     "'$NEW_ADDRESS4'": 9.998
   }'''

0100000001529c9f774521b7f5104b709e899d8547078ca4a993dbd761aea902\
24eba2b2dd0000000000ffffffff01c0bc973b000000001976a914900504f96c\
55d6ebe1c33581ba9430ca05b12a1488ac00000000

010000000175e1769813db8418fea17576694af1ff31cb2b512b7333e6eb42f0\
30d0d778720000000000ffffffff01c0bc973b000000001976a914b6f64f5bf3\
e38f25ead28817df7929c06fe847ee88ac00000000

> RAW_TX=0100000001529c9f774521b7f5104b709e899d8547078ca4a993dbd[...]
{% endhighlight %}

We generate the raw transaction the same way we did in the Simple Raw
Transaction subsection.

{% highlight bash %}
> dash-cli -regtest dumpprivkey $NEW_ADDRESS1
cThhxbQUtBDzHZbZrW6XAR4XkXfaQf4Abo7BQaTK2zVp7sVrHdmv
> dash-cli -regtest dumpprivkey $NEW_ADDRESS3
cUbYymPeHhRszTn64Xg7dzYKez8YC83M39ZTPJDiBDu8dRD3EjzF

> NEW_ADDRESS1_PRIVATE_KEY=cThhxbQUtBDzHZbZrW6XAR4XkXfaQf4Abo7BQ[...]
> NEW_ADDRESS3_PRIVATE_KEY=cUbYymPeHhRszTn64Xg7dzYKez8YC83M39ZTP[...]
{% endhighlight %}

We get the private keys for two of the public keys we used to create the
transaction, the same way we got private keys in the Complex Raw
Transaction subsection. Recall that we created a 2-of-3 multisig pubkey script,
so signatures from two private keys are needed.

![Warning icon](/img/icons/icon_warning.svg)
 **Reminder:** Users should never manually manage private keys on
mainnet. See the warning in the [complex raw transaction section][devex
complex raw transaction].

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest signrawtransaction $RAW_TX '''
    [
      {
        "txid": "'$UTXO_TXID'",
        "vout": '$UTXO_VOUT',
        "scriptPubKey": "'$UTXO_OUTPUT_SCRIPT'",
        "redeemScript": "'$P2SH_REDEEM_SCRIPT'"
      }
    ]
    ''' '''
    [
      "'$NEW_ADDRESS1_PRIVATE_KEY'"
    ]'''
{% endhighlight %}
{% highlight json %}
{
  "hex": "0100000001529c9f774521b7f5104b709e899d8547078ca4a993dbd761aea902\
          24eba2b2dd00000000b40047304402201cc50eac6d2db04dabd8ccd68b3116c0\
          a8d37e7e41335e0d0ab441a5aa08cdcd02204011d184dca2489758c05e01556f\
          f2ff9c48c39ff434fdfb1d9e0284fbde7701014c69522103fa8866cccae3c975\
          a72884443a351801a0ea9721cbe7215586ddd6fab5f39f262103b2259f42a241\
          f4870e794521594f2af7aadf0e4c580a43582e58630e4618634621038007ef6f\
          d812d73da054271b68a42dae06672cff2a30b2814935537e5930ebf653aeffff\
          ffff01c0bc973b000000001976a914900504f96c55d6ebe1c33581ba9430ca05\
          b12a1488ac00000000",
  "complete": false,
  "errors": [
    {
      "txid": "ddb2a2eb2402a9ae61d7db93a9a48c0747859d899e704b10f5b72145779\
                f9c52",
      "vout": 0,
      "scriptSig": "0047304402201cc50eac6d2db04dabd8ccd68b3116c0a8d37e7e41\
                    335e0d0ab441a5aa08cdcd02204011d184dca2489758c05e01556f\
                    f2ff9c48c39ff434fdfb1d9e0284fbde7701014c69522103fa8866\
                    cccae3c975a72884443a351801a0ea9721cbe7215586ddd6fab5f3\
                    9f262103b2259f42a241f4870e794521594f2af7aadf0e4c580a43\
                    582e58630e4618634621038007ef6fd812d73da054271b68a42dae\
                    06672cff2a30b2814935537e5930ebf653ae",
      "sequence": 4294967295,
      "error": "Operation not valid with the current stack size"
    }
  ]
}
{% endhighlight %}
{% highlight bash %}

> PARTLY_SIGNED_RAW_TX=010000000175e1769813db8418fea17576694af1f[...]
{% endhighlight %}
</div>

We make the first signature. The input argument (JSON object) takes the
additional redeem script parameter so that it can append the redeem script
to the signature script after the two signatures.

<div markdown="1" class="multicode">
{% highlight bash %}
> dash-cli -regtest signrawtransaction $PARTLY_SIGNED_RAW_TX '''
    [
      {
        "txid": "'$UTXO_TXID'",
        "vout": '$UTXO_VOUT',
        "scriptPubKey": "'$UTXO_OUTPUT_SCRIPT'",
        "redeemScript": "'$P2SH_REDEEM_SCRIPT'"
      }
    ]
    ''' '''
    [
      "'$NEW_ADDRESS3_PRIVATE_KEY'"
    ]'''
{% endhighlight %}
{% highlight json %}
{
  "hex": "0100000001529c9f774521b7f5104b709e899d8547078ca4a993dbd761aea902\
          24eba2b2dd00000000fdfd000047304402201cc50eac6d2db04dabd8ccd68b31\
          16c0a8d37e7e41335e0d0ab441a5aa08cdcd02204011d184dca2489758c05e01\
          556ff2ff9c48c39ff434fdfb1d9e0284fbde770101483045022100e0e1f95f1a\
          b85814ee0920d5bd28c6831086e838af4bec344fd8654a0b58525f022075989f\
          d3a677e1522aa85d45c41720aec9e7c127acadb6c14338c3b1a768ab28014c69\
          522103fa8866cccae3c975a72884443a351801a0ea9721cbe7215586ddd6fab5\
          f39f262103b2259f42a241f4870e794521594f2af7aadf0e4c580a43582e5863\
          0e4618634621038007ef6fd812d73da054271b68a42dae06672cff2a30b28149\
          35537e5930ebf653aeffffffff01c0bc973b000000001976a914900504f96c55\
          d6ebe1c33581ba9430ca05b12a1488ac00000000",
  "complete": true
}
{% endhighlight %}
{% highlight bash %}

> SIGNED_RAW_TX=0100000001529c9f774521b7f5104b709e899d8547078ca4[...]
{% endhighlight %}
</div>

The `signrawtransaction` call used here is nearly identical to the one
used above.  The only difference is the private key used.  Now that the
two required signatures have been provided, the transaction is marked as
complete.

{% highlight bash %}
> dash-cli -regtest sendrawtransaction $SIGNED_RAW_TX
483061b32894aacf6c4050291252a480c2a4c869eb85bd45082fb87d6b175ae8
{% endhighlight %}

We send the transaction spending the P2SH multisig output to the local
node, which accepts it.

{% endautocrossref %}
