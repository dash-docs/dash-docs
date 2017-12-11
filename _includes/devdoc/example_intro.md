{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/example_intro.md" %}

{% autocrossref %}
<!-- __ -->

The following guide aims to provide examples to help you start
building Dash-based applications. To make the best use of this document,
you may want to install the current version of Dash Core, either from
[source][core git] or from a [pre-compiled executable][core executable].

Once installed, you'll have access to three programs: `dashd`,
`dash-qt`, and `dash-cli`.

* `dash-qt` provides a combination full Dash peer and wallet
  frontend. From the Help menu, you can access a console where you can
  enter the RPC commands used throughout this document.

* `dashd` is more useful for programming: it provides a full peer
  which you can interact with through RPCs to port 9998 (or 19998
  for testnet / 18332 for regtest).

* `dash-cli` allows you to send RPC commands to `dashd` from the
  command line.  For example, `dash-cli help`

All three programs get settings from `dash.conf` in the `DashCore`
application directory:

* Windows: `%APPDATA%\DashCore\`

* OSX: `$HOME/Library/Application Support/DashCore/`

* Linux: `$HOME/.dashcore/`

To use `dashd` and `dash-cli`, you will need to add a RPC password
to your `dash.conf` file. Both programs will read from the same file
if both run on the same system as the same user, so any long random
password will work:

~~~
rpcpassword=change_this_to_a_long_random_password
~~~~

You should also make the `dash.conf` file only readable to its
owner.  On Linux, Mac OSX, and other Unix-like systems, this can be
accomplished by running the following command in the Dash Core application
directory:

~~~
chmod 0600 dash.conf
~~~

For development, it's safer and cheaper to use Dash's test network (testnet)
or regression test mode (regtest) described below.

Questions about Dash use are best sent to the [Dash forum][forum
tech support] and [Discord channels][Discord channels]. Errors or suggestions related to
documentation on dash-docs.github.io can be [submitted as an issue][docs issue].

In the following documentation, some strings have been shortened or wrapped: "[...]"
indicates extra data was removed, and lines ending in a single backslash "\\"
are continued below. If you hover your mouse over a paragraph, cross-reference
links will be shown in blue.  If you hover over a cross-reference link, a brief
definition of the term will be displayed in a tooltip.

{% endautocrossref %}
