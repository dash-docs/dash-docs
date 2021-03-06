---
# This file is licensed under the MIT License (MIT) available on
# http://opensource.org/licenses/MIT.

layout: base
lang: en
id: developer-guide
title: "Developer Guide - Dash"
breadcrumbs:
#  - bitcoin
  - dev docs
  - Guide
end_of_page: |
  <script src="/js/jquery/jquery-1.11.2.min.js"></script>
  <script src="/js/jquery/jquery-ui.min.js"></script>
  <script src="/js/devsearch.js"></script>
  <script>updateToc();</script>
redirect_to: "https://dashcore.readme.io/docs/core-guide-introduction"
---
<link rel="stylesheet" href="/css/jquery-ui.min.css">

<h2 style="text-align:center"><img src="/img/icons/icon_warning.svg"></img> Important Note: This documentation site has been deprecated and has not been updated since Dash Core 0.15.0. You will be redirected to the new site at <a href="https://dashcore.readme.io">https://dashcore.readme.io</a> momentarily. <img src="/img/icons/icon_warning.svg"></img></h2><!-- no subhead-links here -->

# Dash Developer Guide

<p class="summary">Find detailed information about the Dash protocol and related specifications.</p>

<div markdown="1" id="toc" class="toc"><div markdown="1">

* Table of contents
{:toc}

<ul class="goback"><li><a href="/en/">Return To Overview</a></li></ul>
<ul class="reportissue"><li><a href="https://github.com/dash-docs/dash-docs/issues/new" onmouseover="updateIssue(event);">Report An Issue</a></li></ul>
<ul class="editsource"><li><a href="https://github.com/dash-docs/dash-docs/tree/master/_includes" onmouseover="updateSource(event);">Edit On GitHub</a></li></ul>

</div></div>

<div markdown="1" class="toccontent">

<!-- includes should be separated by an empty line to prevent a
paragraph at the end of one file from breaking the heading at the start
of the following file. -->

{% include devdoc/fragment_reviews_needed.md %}

<input id="glossary_term" class="glossary_term" placeholder="Search the glossary, RPCs, and more">

{% include devdoc/guide_intro.md %}

{% include devdoc/guide_block_chain.md %}

{% include devdoc/guide_transactions.md %}

{% include devdoc/guide_contracts.md %}

{% include devdoc/guide_wallets.md %}

{% include devdoc/guide_operating_modes.md %}

{% include devdoc/guide_p2p_network.md %}

{% include devdoc/guide_dash_features.md %}

{% include devdoc/guide_mining.md %}

<!-- Services like Blockcyper are more likely to be used by most than building a ground-up payment system
{% comment %}
  include devdoc/guide_payment_processing.md
{% endcomment %}
-->

{% include references.md %}
{{site.glossary_links}}

</div>
