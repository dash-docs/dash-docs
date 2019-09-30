---
# This file is licensed under the MIT License (MIT) available on
# http://opensource.org/licenses/MIT.

layout: base
lang: en
id: developer-reference
title: "Developer Reference - Dash"
breadcrumbs:
#  - bitcoin
  - dev docs
  - Reference
end_of_page: |
  <script src="/js/jquery/jquery-1.11.2.min.js"></script>
  <script src="/js/jquery/jquery-ui.min.js"></script>
  <script src="/js/devsearch.js"></script>
  <script>updateToc();</script>
---
<link rel="stylesheet" href="/css/jquery-ui.min.css">

<!-- This should be empty, but comment it out just in case: {% include helpers/vars.md %} -->

# Dash Developer Reference

<p class="summary">Find technical details and API documentation.</p>

<div markdown="1" id="toc" class="toc"><div markdown="1">

* Table of contents
{:toc}

<ul class="goback"><li><a href="/en/">Return To Overview</a></li></ul>
<ul class="reportissue"><li><a href="https://github.com/dash-docs/dash-docs/issues/new" onmouseover="updateIssue(event);">Report An Issue</a></li></ul>
<ul class="editsource"><li><a href="https://github.com/dash-docs/dash-docs/tree/master/_includes" onmouseover="updateSource(event);">Edit On GitHub</a></li></ul>

</div></div>
<div markdown="1" class="toccontent">

{% include devdoc/fragment_reviews_needed.md %}

<input id="glossary_term" class="glossary_term" placeholder="Search the glossary, RPCs, and more">

{% include devdoc/ref_intro.md %}

{% include devdoc/ref_block_chain.md %}

{% include devdoc/ref_transactions.md %}

{% include devdoc/ref_wallets.md %}

{% include devdoc/ref_p2p_networking.md %}

{% include devdoc/ref_bips.md %}

{% include devdoc/dash-core/api-intro.md %}

{% include devdoc/dash-core/rpcs/intro.md %}

{% include devdoc/dash-core/rpcs/quick-reference.md %}

#### RPCs
<!-- no subhead-links here -->

{{WARNING}} the block chain and memory pool can include arbitrary data
which several of the commands below will return in hex format. If you
convert this data to another format in an executable context, it could
be used in an exploit. For example, displaying a pubkey script as
ASCII text in a webpage could add arbitrary Javascript to that page and
create a cross-site scripting (XSS) exploit. To avoid problems, please
treat block chain and memory pool data as an arbitrary input from an
untrusted source.

{% include devdoc/dash-core/rpcs/rpcs/abandontransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/abortrescan.md %}

{% include devdoc/dash-core/rpcs/rpcs/addmultisigaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/addnode.md %}

{% include devdoc/dash-core/rpcs/rpcs/backupwallet.md %}

{% include devdoc/dash-core/rpcs/rpcs/bls.md %}

{% include devdoc/dash-core/rpcs/rpcs/clearbanned.md %}

{% include devdoc/dash-core/rpcs/rpcs/createmultisig.md %}

{% include devdoc/dash-core/rpcs/rpcs/createrawtransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/debug.md %}

{% include devdoc/dash-core/rpcs/rpcs/decoderawtransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/decodescript.md %}

{% include devdoc/dash-core/rpcs/rpcs/disconnectnode.md %}

{% include devdoc/dash-core/rpcs/rpcs/dumphdinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/dumpprivkey.md %}

{% include devdoc/dash-core/rpcs/rpcs/dumpwallet.md %}

{% include devdoc/dash-core/rpcs/rpcs/encryptwallet.md %}

{% include devdoc/dash-core/rpcs/rpcs/estimatefee.md %}

{% include devdoc/dash-core/rpcs/rpcs/estimatepriority.md %}

{% include devdoc/dash-core/rpcs/rpcs/estimatesmartfee.md %}

{% include devdoc/dash-core/rpcs/rpcs/estimatesmartpriority.md %}

{% include devdoc/dash-core/rpcs/rpcs/fundrawtransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/generate.md %}

{% include devdoc/dash-core/rpcs/rpcs/generatetoaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaccountaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaccount.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaddednodeinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaddressbalance.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaddressdeltas.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaddressesbyaccount.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaddressmempool.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaddresstxids.md %}

{% include devdoc/dash-core/rpcs/rpcs/getaddressutxos.md %}

{% include devdoc/dash-core/rpcs/rpcs/getbalance.md %}

{% include devdoc/dash-core/rpcs/rpcs/getbestblockhash.md %}

{% include devdoc/dash-core/rpcs/rpcs/getbestchainlock.md %}

{% include devdoc/dash-core/rpcs/rpcs/getblock.md %}

{% include devdoc/dash-core/rpcs/rpcs/getblockchaininfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getblockcount.md %}

{% include devdoc/dash-core/rpcs/rpcs/getblockhash.md %}

{% include devdoc/dash-core/rpcs/rpcs/getblockhashes.md %}

{% include devdoc/dash-core/rpcs/rpcs/getblockheader.md %}

{% include devdoc/dash-core/rpcs/rpcs/getblockheaders.md %}

{% include devdoc/dash-core/rpcs/rpcs/getblocktemplate.md %}

{% include devdoc/dash-core/rpcs/rpcs/getchaintips.md %}

{% include devdoc/dash-core/rpcs/rpcs/getchaintxstats.md %}

{% include devdoc/dash-core/rpcs/rpcs/getconnectioncount.md %}

{% include devdoc/dash-core/rpcs/rpcs/getdifficulty.md %}

{% include devdoc/dash-core/rpcs/rpcs/getgenerate.md %}

{% include devdoc/dash-core/rpcs/rpcs/getgovernanceinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/gethashespersec.md %}

{% include devdoc/dash-core/rpcs/rpcs/getinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getmemoryinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getmempoolancestors.md %}

{% include devdoc/dash-core/rpcs/rpcs/getmempooldescendants.md %}

{% include devdoc/dash-core/rpcs/rpcs/getmempoolentry.md %}

{% include devdoc/dash-core/rpcs/rpcs/getmempoolinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getmerkleblocks.md %}

{% include devdoc/dash-core/rpcs/rpcs/getmininginfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getnettotals.md %}

{% include devdoc/dash-core/rpcs/rpcs/getnetworkhashps.md %}

{% include devdoc/dash-core/rpcs/rpcs/getnetworkinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getnewaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/getpeerinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getpoolinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getrawchangeaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/getrawmempool.md %}

{% include devdoc/dash-core/rpcs/rpcs/getrawtransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/getreceivedbyaccount.md %}

{% include devdoc/dash-core/rpcs/rpcs/getreceivedbyaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/getspecialtxes.md %}

{% include devdoc/dash-core/rpcs/rpcs/getspentinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getsuperblockbudget.md %}

{% include devdoc/dash-core/rpcs/rpcs/gettransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/gettxout.md %}

{% include devdoc/dash-core/rpcs/rpcs/gettxoutproof.md %}

{% include devdoc/dash-core/rpcs/rpcs/gettxoutsetinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getunconfirmedbalance.md %}

{% include devdoc/dash-core/rpcs/rpcs/getwalletinfo.md %}

{% include devdoc/dash-core/rpcs/rpcs/getwork.md %}

{% include devdoc/dash-core/rpcs/rpcs/gobject.md %}

{% include devdoc/dash-core/rpcs/rpcs/help.md %}

{% include devdoc/dash-core/rpcs/rpcs/importaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/importelectrumwallet.md %}

{% include devdoc/dash-core/rpcs/rpcs/importmulti.md %}

{% include devdoc/dash-core/rpcs/rpcs/importprivkey.md %}

{% include devdoc/dash-core/rpcs/rpcs/importprunedfunds.md %}

{% include devdoc/dash-core/rpcs/rpcs/importpubkey.md %}

{% include devdoc/dash-core/rpcs/rpcs/importwallet.md %}

{% include devdoc/dash-core/rpcs/rpcs/keepass.md %}

{% include devdoc/dash-core/rpcs/rpcs/keypoolrefill.md %}

{% include devdoc/dash-core/rpcs/rpcs/listaccounts.md %}

{% include devdoc/dash-core/rpcs/rpcs/listaddressbalances.md %}

{% include devdoc/dash-core/rpcs/rpcs/listaddressgroupings.md %}

{% include devdoc/dash-core/rpcs/rpcs/listbanned.md %}

{% include devdoc/dash-core/rpcs/rpcs/listlockunspent.md %}

{% include devdoc/dash-core/rpcs/rpcs/listreceivedbyaccount.md %}

{% include devdoc/dash-core/rpcs/rpcs/listreceivedbyaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/listsinceblock.md %}

{% include devdoc/dash-core/rpcs/rpcs/listtransactions.md %}

{% include devdoc/dash-core/rpcs/rpcs/listunspent.md %}

{% include devdoc/dash-core/rpcs/rpcs/listwallets.md %}

{% include devdoc/dash-core/rpcs/rpcs/lockunspent.md %}

{% include devdoc/dash-core/rpcs/rpcs/logging.md %}

{% include devdoc/dash-core/rpcs/rpcs/masternode.md %}

{% include devdoc/dash-core/rpcs/rpcs/masternodebroadcast.md %}

{% include devdoc/dash-core/rpcs/rpcs/masternodelist.md %}

{% include devdoc/dash-core/rpcs/rpcs/mnsync.md %}

{% include devdoc/dash-core/rpcs/rpcs/move.md %}

{% include devdoc/dash-core/rpcs/rpcs/ping.md %}

{% include devdoc/dash-core/rpcs/rpcs/protx.md %}

{% include devdoc/dash-core/rpcs/rpcs/preciousblock.md %}

{% include devdoc/dash-core/rpcs/rpcs/privatesend.md %}

{% include devdoc/dash-core/rpcs/rpcs/prioritisetransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/pruneblockchain.md %}

{% include devdoc/dash-core/rpcs/rpcs/quorum.md %}

{% include devdoc/dash-core/rpcs/rpcs/removeprunedfunds.md %}

{% include devdoc/dash-core/rpcs/rpcs/sendfrom.md %}

{% include devdoc/dash-core/rpcs/rpcs/sendmany.md %}

{% include devdoc/dash-core/rpcs/rpcs/sendrawtransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/sendtoaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/setaccount.md %}

{% include devdoc/dash-core/rpcs/rpcs/setban.md %}

{% include devdoc/dash-core/rpcs/rpcs/setgenerate.md %}

{% include devdoc/dash-core/rpcs/rpcs/setnetworkactive.md %}

{% include devdoc/dash-core/rpcs/rpcs/setprivatesendamount.md %}

{% include devdoc/dash-core/rpcs/rpcs/setprivatesendrounds.md %}

{% include devdoc/dash-core/rpcs/rpcs/settxfee.md %}

{% include devdoc/dash-core/rpcs/rpcs/signmessage.md %}

{% include devdoc/dash-core/rpcs/rpcs/signmessagewithprivkey.md %}

{% include devdoc/dash-core/rpcs/rpcs/signrawtransaction.md %}

{% include devdoc/dash-core/rpcs/rpcs/sentinelping.md %}

{% include devdoc/dash-core/rpcs/rpcs/spork.md %}

{% include devdoc/dash-core/rpcs/rpcs/stop.md %}

{% include devdoc/dash-core/rpcs/rpcs/submitblock.md %}

{% include devdoc/dash-core/rpcs/rpcs/uptime.md %}

{% include devdoc/dash-core/rpcs/rpcs/validateaddress.md %}

{% include devdoc/dash-core/rpcs/rpcs/verifychain.md %}

{% include devdoc/dash-core/rpcs/rpcs/verifymessage.md %}

{% include devdoc/dash-core/rpcs/rpcs/verifytxoutproof.md %}

{% include devdoc/dash-core/rpcs/rpcs/voteraw.md %}

{% include devdoc/dash-core/rpcs/rpcs/walletlock.md %}

{% include devdoc/dash-core/rpcs/rpcs/walletpassphrase.md %}

{% include devdoc/dash-core/rpcs/rpcs/walletpassphrasechange.md %}

{% include devdoc/dash-core/rest/intro.md %}

{% include devdoc/dash-core/rest/quick-reference.md %}

#### Requests
<!-- no subhead-links here -->

{{WARNING}} the block chain and memory pool can include arbitrary data
which several of the commands below will return in hex format. If you
convert this data to another format in an executable context, it could
be used in an exploit. For example, displaying a pubkey script as
ASCII text in a webpage could add arbitrary Javascript to that page and
create a cross-site scripting (XSS) exploit. To avoid problems, please
treat block chain and memory pool data as an arbitrary input from an
untrusted source.

{% include devdoc/dash-core/rest/requests/get_block.md %}

{% include devdoc/dash-core/rest/requests/get_block-notxdetails.md %}

{% include devdoc/dash-core/rest/requests/get_chaininfo.md %}

{% include devdoc/dash-core/rest/requests/get_getutxos.md %}

{% include devdoc/dash-core/rest/requests/get_headers.md %}

{% include devdoc/dash-core/rest/requests/get_mempool-contents.md %}

{% include devdoc/dash-core/rest/requests/get_mempool-info.md %}

{% include devdoc/dash-core/rest/requests/get_tx.md %}

{% include references.md %}
{{site.glossary_links}}

</div>
