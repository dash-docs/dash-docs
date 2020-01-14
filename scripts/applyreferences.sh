#!/usr/bin/env bash

# first pattern changes [aaaa][] to [aaaa][aaaa]

perl -pe "s/\[([^\]]+)\]\[\]/[\1][\1]/g;" \
-pe "s~\]\[data-pushing opcode\]~](https://en.bitcoin.it/wiki/Script#Constants)~g;" \
-pe "s~\]\[bitcoinpdf\]~](https://bitcoin.org/en/bitcoin-paper)~g;" \
-pe "s~\]\[choose your wallet\]~](https://www.dash.org/wallets/)~g;" \
-pe "s~\]\[communities\]~](https://www.dash.org/community/)~g;" \
-pe "s~\]\[core executable\]~](https://www.dash.org/wallets/#wallets)~g;" \
-pe "s~\]\[dev communities\]~](https://www.dash.org/community/)~g;" \
-pe "s~\]\[BIP9\]~](https://github.com/bitcoin/bips/blob/master/bip-0009.mediawiki)~g;" \
-pe "s~\]\[BIP9 assignments\]~](https://github.com/bitcoin/bips/blob/master/bip-0009/assignments.mediawiki)~g;" \
-pe "s~\]\[BIP14\]~](https://github.com/bitcoin/bips/blob/master/bip-0014.mediawiki)~g;" \
-pe "s~\]\[BIP16\]~](https://github.com/bitcoin/bips/blob/master/bip-0016.mediawiki)~g;" \
-pe "s~\]\[BIP21\]~](https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki)~g;" \
-pe "s~\]\[BIP22\]~](https://github.com/bitcoin/bips/blob/master/bip-0022.mediawiki)~g;" \
-pe "s~\]\[BIP23\]~](https://github.com/bitcoin/bips/blob/master/bip-0023.mediawiki)~g;" \
-pe "s~\]\[BIP30\]~](https://github.com/bitcoin/bips/blob/master/bip-0030.mediawiki)~g;" \
-pe "s~\]\[BIP31\]~](https://github.com/bitcoin/bips/blob/master/bip-0031.mediawiki)~g;" \
-pe "s~\]\[BIP32\]~](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki)~g;" \
-pe "s~\]\[BIP34\]~](https://github.com/bitcoin/bips/blob/master/bip-0034.mediawiki)~g;" \
-pe "s~\]\[BIP35\]~](https://github.com/bitcoin/bips/blob/master/bip-0035.mediawiki)~g;" \
-pe "s~\]\[BIP37\]~](https://github.com/bitcoin/bips/blob/master/bip-0037.mediawiki)~g;" \
-pe "s~\]\[BIP39\]~](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki)~g;" \
-pe "s~\]\[BIP50\]~](https://github.com/bitcoin/bips/blob/master/bip-0050.mediawiki)~g;" \
-pe "s~\]\[BIP61\]~](https://github.com/bitcoin/bips/blob/master/bip-0061.mediawiki)~g;" \
-pe "s~\]\[BIP62\]~](https://github.com/bitcoin/bips/blob/master/bip-0062.mediawiki)~g;" \
-pe "s~\]\[BIP65\]~](https://github.com/bitcoin/bips/blob/master/bip-0065.mediawiki)~g;" \
-pe "s~\]\[BIP66\]~](https://github.com/bitcoin/bips/blob/master/bip-0066.mediawiki)~g;" \
-pe "s~\]\[BIP68\]~](https://github.com/bitcoin/bips/blob/master/bip-0068.mediawiki)~g;" \
-pe "s~\]\[BIP70\]~](https://github.com/bitcoin/bips/blob/master/bip-0070.mediawiki)~g;" \
-pe "s~\]\[BIP71\]~](https://github.com/bitcoin/bips/blob/master/bip-0071.mediawiki)~g;" \
-pe "s~\]\[BIP72\]~](https://github.com/bitcoin/bips/blob/master/bip-0072.mediawiki)~g;" \
-pe "s~\]\[BIP90\]~](https://github.com/bitcoin/bips/blob/master/bip-0090.mediawiki)~g;" \
-pe "s~\]\[BIP111\]~](https://github.com/bitcoin/bips/blob/master/bip-0111.mediawiki)~g;" \
-pe "s~\]\[BIP112\]~](https://github.com/bitcoin/bips/blob/master/bip-0112.mediawiki)~g;" \
-pe "s~\]\[BIP113\]~](https://github.com/bitcoin/bips/blob/master/bip-0113.mediawiki)~g;" \
-pe "s~\]\[BIP125\]~](https://github.com/bitcoin/bips/blob/master/bip-0125.mediawiki)~g;" \
-pe "s~\]\[BIP130\]~](https://github.com/bitcoin/bips/blob/master/bip-0130.mediawiki)~g;" \
-pe "s~\]\[BIP133\]~](https://github.com/bitcoin/bips/blob/master/bip-0133.mediawiki)~g;" \
-pe "s~\]\[BIP141\]~](https://github.com/bitcoin/bips/blob/master/bip-0141.mediawiki)~g;" \
-pe "s~\]\[BIP147\]~](https://github.com/bitcoin/bips/blob/master/bip-0147.mediawiki)~g;" \
-pe "s~\]\[BIP151\]~](https://github.com/bitcoin/bips/blob/master/bip-0151.mediawiki)~g;" \
-pe "s~\]\[BIP152\]~](https://github.com/bitcoin/bips/blob/master/bip-0152.mediawiki)~g;" \
-pe "s~\]\[CVE-2012-2459\]~](https://en.bitcoin.it/wiki/CVEs#CVE-2012-2459)~g;" \
-pe "s~\]\[RFC5737\]~](http://tools.ietf.org/html/rfc5737)~g;" \
-pe "s~\]\[secp256k1\]~](http://www.secg.org/sec2-v2.pdf)~g;" \
-pe "s~\]\[DIP1\]~](https://github.com/dashpay/dips/blob/master/dip-0001.md)~g;" \
-pe "s~\]\[DIP2\]~](https://github.com/dashpay/dips/blob/master/dip-0002.md)~g;" \
-pe "s~\]\[DIP3\]~](https://github.com/dashpay/dips/blob/master/dip-0003.md)~g;" \
-pe "s~\]\[DIP4\]~](https://github.com/dashpay/dips/blob/master/dip-0004.md)~g;" \
-pe "s~\]\[DIP5\]~](https://github.com/dashpay/dips/blob/master/dip-0005.md)~g;" \
-pe "s~\]\[DIP6\]~](https://github.com/dashpay/dips/blob/master/dip-0006.md)~g;" \
-pe "s~\]\[DIP7\]~](https://github.com/dashpay/dips/blob/master/dip-0007.md)~g;" \
-pe "s~\]\[DIP8\]~](https://github.com/dashpay/dips/blob/master/dip-0008.md)~g;" \
-pe "s~\]\[#bitcoin\]~](https://webchat.freenode.net/?channels=bitcoin&uio=d4)~g;" \
-pe "s~\]\[#bitcoin-dev\]~](https://webchat.freenode.net/?channels=bitcoin-dev&uio=d4)~g;" \
-pe "s~\]\[#bitcoin-mining\]~](https://webchat.freenode.net/?channels=bitcoin-mining&uio=d4)~g;" \
-pe "s~\]\[#bitcoin-wiki\]~](https://webchat.freenode.net/?channels=bitcoin-wiki&uio=d4)~g;" \
-pe "s~\]\[0bin\]~](http://0bin.net/)~g;" \
-pe "s~\]\[bcc automated testing\]~](https://github.com/dashpay/dash/blob/master/README.md#automated-testing)~g;" \
-pe "s~\]\[bcc configuration\]~](https://en.bitcoin.it/wiki/Running_Bitcoin)~g;" \
-pe "s~\]\[bcc data directory\]~](https://en.bitcoin.it/wiki/Data_directory)~g;" \
-pe "s~\]\[bcc issues\]~](https://github.com/dashpay/dash/issues)~g;" \
-pe "s~\]\[bcc new issue\]~](https://github.com/dashpay/dash/issues/new)~g;" \
-pe "s~\]\[bcc pulls\]~](https://github.com/dashpay/dash/pulls)~g;" \
-pe "s~\]\[bcc tor\]~](https://en.bitcoin.it/wiki/Tor)~g;" \
-pe "s~\]\[bcc tor hs\]~](https://en.bitcoin.it/wiki/Tor#Hidden_services)~g;" \
-pe "s~\]\[core github tag\]~](https://github.com/bitcoin-dot-org/bitcoin.org/labels/Core)~g;" \
-pe "s~\]\[BFGMiner\]~](https://github.com/luke-jr/bfgminer)~g;" \
-pe "s~\]\[Bitcoin beginners\]~](http://www.reddit.com/r/bitcoinbeginners)~g;" \
-pe "s~\]\[Bitcoin Core\]~](https://bitcoin.org/en/download)~g;" \
-pe "s~\]\[Bitcoin Core 0.1.6\]~](https://github.com/bitcoin/bitcoin/commit/cc0b4c3b62367a2aebe5fc1f4d0ed4b97e9c2ac9)~g;" \
-pe "s~\]\[Bitcoin Core 0.2.9\]~](https://github.com/bitcoin/bitcoin/commit/42605ce8bcc9bd01b86491c74fee14de77960868)~g;" \
-pe "s~\]\[Bitcoin Core 0.3.11\]~](https://github.com/bitcoin/bitcoin/commit/343328c6b8db85e58a1feea85f0d10e62967fa19)~g;" \
-pe "s~\]\[Bitcoin Core 0.3.15\]~](https://github.com/bitcoin/bitcoin/commit/c891967b6fcab2e8dc4ce0c787312b36c07efa4d)~g;" \
-pe "s~\]\[Bitcoin Core 0.3.18\]~](https://github.com/bitcoin/bitcoin/commit/82201801336f64ee77851b9eaab9383ee4e442f0)~g;" \
-pe "s~\]\[Bitcoin Core build unix\]~](https://github.com/dashpay/dash/blob/master/doc/build-unix.md)~g;" \
-pe "s~\]\[Bitcoin Core docs directory\]~](https://github.com/dashpay/dash/tree/master/doc)~g;" \
-pe "s~\]\[bitcoin core fee drop commit\]~](https://github.com/bitcoin/bitcoin/commit/6a4c196dd64da2fd33dc7ae77a8cdd3e4cf0eff1)~g;" \
-pe "s~\]\[Bitcoin Core issue #2381\]~](https://github.com/bitcoin/bitcoin/issues/2381)~g;" \
-pe "s~\]\[Bitcoin Core master\]~](https://github.com/dashpay/dash)~g;" \
-pe "s~\]\[Bitcoin Core pull #4468\]~](https://github.com/bitcoin/bitcoin/pull/4468)~g;" \
-pe "s~\]\[Bitcoin core transifex\]~](https://www.transifex.com/projects/p/bitcoin/)~g;" \
-pe "s~\]\[Bitcoin reddit\]~](http://www.reddit.com/r/dashpay)~g;" \
-pe "s~\]\[Bitcoin reddit new\]~](http://www.reddit.com/r/dashpay/new)~g;" \
-pe "s~\]\[Bitcoin stackexchange\]~](http://bitcoin.stackexchange.com)~g;" \
-pe "s~\]\[Bitcoin stackexchange tag bitcoin-qt\]~](http://bitcoin.stackexchange.com/questions/tagged/bitcoin-qt)~g;" \
-pe "s~\]\[BitcoinJ\]~](http://bitcoinj.github.io)~g;" \
-pe "s~\]\[BitcoinJ documentation about pending transaction safety\]~](https://bitcoinj.github.io/security-model#pending-transactions)~g;" \
-pe "s~\]\[bitcoinj micropayment tutorial\]~](https://bitcoinj.github.io/working-with-micropayments)~g;" \
-pe "s~\]\[block170\]~](https://www.biteasy.com/block/00000000d1145790a8694403d4063f323d499e655c83426834d4ce2f8dd4a2ee)~g;" \
-pe "s~\]\[casascius address utility\]~](https://github.com/casascius/Bitcoin-Address-Utility)~g;" \
-pe "s~\]\[core base58.h\]~](https://github.com/dashpay/dash/blob/master/src/base58.h)~g;" \
-pe "s~\]\[core chainparams.cpp\]~](https://github.com/dashpay/dash/blob/master/src/chainparams.cpp)~g;" \
-pe "s~\]\[core git\]~](https://github.com/dashpay/dash/)~g;" \
-pe "s~\]\[core paymentrequest.proto\]~](https://github.com/dashpay/dash/blob/master/src/qt/paymentrequest.proto)~g;" \
-pe "s~\]\[core script.h\]~](https://github.com/dashpay/dash/blob/master/src/script/script.h)~g;" \
-pe "s~\]\[creative commons attribution 3.0 license\]~](https://creativecommons.org/licenses/by/3.0/)~g;" \
-pe "s~\]\[Dash Masternode Tool\]~](https://github.com/Bertrand256/dash-masternode-tool)~g;" \
-pe "s~\]\[Dash Seeder\]~](https://github.com/nightlydash/dash-seeder/tree/master)~g;" \
-pe "s~\]\[DashJ\]~](https://github.com/HashEngineering/dashj)~g;" \
-pe "s~\]\[dashmnb\]~](https://github.com/chaeplin/dashmnb)~g;" \
-pe "s~\]\[DER\]~](https://en.wikipedia.org/wiki/X.690#DER_encoding)~g;" \
-pe "s~\]\[dig command\]~](https://en.wikipedia.org/wiki/Dig_%28Unix_command%29)~g;" \
-pe "s~\]\[Discord channels\]~](http://www.dashchat.org)~g;" \
-pe "s~\]\[DNS A records\]~](http://tools.ietf.org/html/rfc1035#section-3.2.2)~g;" \
-pe "s~\]\[DNS Seed Policy\]~](https://github.com/dashpay/dash/blob/master/doc/dnsseed-policy.md)~g;" \
-pe "s~\]\[docs issue\]~](https://github.com/dash-docs/dash-docs/issues)~g;" \
-pe "s~\]\[ECDSA\]~](https://en.wikipedia.org/wiki/Elliptic_Curve_DSA)~g;" \
-pe "s~\]\[edit bandwidth sharing guide\]~](https://github.com/bitcoin-dot-org/bitcoin.org/edit/master/en/full-node.md)~g;" \
-pe "s~\]\[Electrum server\]~](https://github.com/spesmilo/electrum-server)~g;" \
-pe "s~\]\[Eloipool\]~](https://github.com/luke-jr/eloipool)~g;" \
-pe "s~\]\[errors in docs\]~](https://github.com/dash-docs/dash-docs/issues?q=is%3Aissue+label%3A%22Dev+Docs%22)~g;" \
-pe "s~\]\[fake satoshi transaction\]~](https://www.reddit.com/r/Bitcoin/comments/3fv42j/blockchaininfo_spoofed_transactions_problem_aug_4/)~g;" \
-pe "s~\]\[forum tech support\]~](https://www.dash.org/forum/categories/dash-support.61/)~g;" \
-pe "s~\]\[ghash betcoin double spend\]~](https://bitcointalk.org/index.php?topic=321630.msg3445371)~g;" \
-pe "s~\]\[gitian sigs\]~](https://github.com/bitcoin/gitian.sigs)~g;" \
-pe "s~\]\[high-speed block relay network\]~](https://www.mail-archive.com/bitcoin-development@lists.sourceforge.net/msg03189.html)~g;" \
-pe "s~\]\[HMAC-SHA512\]~](https://en.wikipedia.org/wiki/HMAC)~g;" \
-pe "s~\]\[HTTP basic authentication\]~](https://en.wikipedia.org/wiki/Basic_access_authentication)~g;" \
-pe "s~\]\[HTTP longpoll\]~](https://en.wikipedia.org/wiki/Push_technology#Long_polling)~g;" \
-pe "s~\]\[information theoretic security\]~](https://en.wikipedia.org/wiki/Information_theoretic_security)~g;" \
-pe "s~\]\[inherit bitcoins\]~](http://bitcoin.stackexchange.com/q/38692/21052)~g;" \
-pe "s~\]\[IP-to-IP payment protocol\]~](https://en.bitcoin.it/wiki/IP_Transactions)~g;" \
-pe "s~\]\[IPv4-mapped IPv6 addresses\]~](http://en.wikipedia.org/wiki/IPv6#IPv4-mapped_IPv6_addresses)~g;" \
-pe "s~\]\[irc channels\]~](https://en.bitcoin.it/wiki/IRC_channels)~g;" \
-pe "s~\]\[JSON-RPC version 1.0\]~](http://json-rpc.org/wiki/specification)~g;" \
-pe "s~\]\[JSON-RPC request batching\]~](http://www.jsonrpc.org/specification#batch)~g;" \
-pe "s~\]\[july 2015 chain forks\]~](https://en.bitcoin.it/wiki/July_2015_chain_forks)~g;" \
-pe "s~\]\[libblkmaker\]~](https://github.com/bitcoin/libblkmaker)~g;" \
-pe "s~\]\[localhost\]~](https://en.wikipedia.org/wiki/Localhost)~g;" \
-pe "s~\]\[lying consistently is hard\]~](https://groups.google.com/forum/#!msg/bitcoinj/Ys13qkTwcNg/9qxnhwnkeoIJ)~g;" \
-pe "s~\]\[makeseeds script\]~](https://github.com/dashpay/dash/tree/master/contrib/seeds)~g;" \
-pe "s~\]\[mozilla's bug reporting documentation\]~](https://developer.mozilla.org/en-US/docs/Mozilla/QA/Bug_writing_guidelines#Writing_precise_steps_to_reproduce)~g;" \
-pe "s~\]\[murmur3\]~](https://en.wikipedia.org/wiki/MurmurHash)~g;" \
-pe "s~\]\[man-in-the-middle\]~](https://en.wikipedia.org/wiki/Man-in-the-middle_attack)~g;" \
-pe "s~\]\[MIME\]~](https://en.wikipedia.org/wiki/Internet_media_type)~g;" \
-pe "s~\]\[MIT license\]~](http://opensource.org/licenses/MIT)~g;" \
-pe "s~\]\[mozrootstore\]~](https://www.mozilla.org/en-US/about/governance/policies/security-group/certs/)~g;" \
-pe "s~\]\[native irc client\]~](https://en.wikipedia.org/wiki/List_of_IRC_clients)~g;" \
-pe "s~\]\[netcat\]~](https://en.wikipedia.org/wiki/Netcat)~g;" \
-pe "s~\]\[nop opcodes\]~](https://en.bitcoin.it/wiki/Script#Reserved_words)~g;" \
-pe "s~\]\[offline transactions\]~](http://bitcoin.stackexchange.com/a/34122/21052)~g;" \
-pe "s~\]\[open a pull request\]~](https://github.com/dash-docs/dash-docs#working-with-github)~g;" \
-pe "s~\]\[open an issue\]~](https://github.com/dash-docs/dash-docs/issues/new)~g;" \
-pe "s~\]\[Payment Request Generator\]~](https://github.com/gavinandresen/paymentrequest/blob/master/php/demo_website/createpaymentrequest.php)~g;" \
-pe "s~\]\[Piotr Piasecki's testnet faucet\]~](https://tpfaucet.appspot.com/)~g;" \
-pe "s~\]\[prime symbol\]~](https://en.wikipedia.org/wiki/Prime_%28symbol%29)~g;" \
-pe "s~\]\[protobuf\]~](https://developers.google.com/protocol-buffers/)~g;" \
-pe "s~\]\[python-bitcoinlib\]~](https://github.com/petertodd/python-bitcoinlib)~g;" \
-pe "s~\]\[python-blkmaker\]~](https://gitorious.org/bitcoin/python-blkmaker)~g;" \
-pe "s~\]\[Satoshi Nakamoto\]~](https://en.bitcoin.it/wiki/Satoshi_Nakamoto)~g;" \
-pe "s~\]\[setup tor\]~](https://www.torproject.org/)~g;" \
-pe "s~\]\[SHA256\]~](https://en.wikipedia.org/wiki/SHA-2)~g;" \
-pe "s~\]\[Stratum mining protocol\]~](http://mining.bitcoin.cz/stratum-mining)~g;" \
-pe "s~\]\[study of SPV privacy over tor\]~](http://arxiv.org/abs/1410.6079)~g;" \
-pe "s~\]\[superblock example\]~](https://chainz.cryptoid.info/dash/block.dws?731104.htm)~g;" \
-pe "s~\]\[Testnet Faucet - Dash.org\]~](https://test.faucet.dash.org/)~g;" \
-pe "s~\]\[Testnet Faucet - Masternode.io\]~](http://test.faucet.masternode.io/)~g;" \
-pe "s~\]\[Testnet Faucet - Dashninja.pl\]~](https://test.faucet.dashninja.pl/)~g;" \
-pe "s~\]\[Testnet Faucet - Crowdnode.io\]~](http://faucet.test.dash.crowdnode.io/)~g;" \
-pe "s~\]\[Tor\]~](https://en.wikipedia.org/wiki/Tor_%28anonymity_network%29)~g;" \
-pe "s~\]\[transifex\]~](https://www.transifex.com/projects/p/bitcoinorg/)~g;" \
-pe "s~\]\[unix epoch time\]~](https://en.wikipedia.org/wiki/Unix_time)~g;" \
-pe "s~\]\[URI encoded\]~](https://tools.ietf.org/html/rfc3986)~g;" \
-pe "s~\]\[wiki bitcoin core compatible devices arm\]~](https://en.bitcoin.it/wiki/Bitcoin_Core_compatible_devices#ARM-based_Chipsets)~g;" \
-pe "s~\]\[wiki bitcoin core documentation\]~](https://en.bitcoin.it/wiki/Category:Bitcoin_Core_documentation)~g;" \
-pe "s~\]\[wiki create account\]~](https://en.bitcoin.it/w/index.php?title=Special:UserLogin&type=signup)~g;" \
-pe "s~\]\[wiki enable editing\]~](https://en.bitcoin.it/wiki/Bitcoin_Wiki:Editing_privileges)~g;" \
-pe "s~\]\[wiki getblocktemplate\]~](https://en.bitcoin.it/wiki/Getblocktemplate)~g;" \
-pe "s~\]\[wiki proper money handling\]~](https://en.bitcoin.it/wiki/Proper_Money_Handling_%28JSON-RPC%29)~g;" \
-pe "s~\]\[wiki template bitcoin core documentation\]~](https://en.bitcoin.it/wiki/Template:Bitcoin_Core_documentation)~g;" \
-pe "s~\]\[wiki script\]~](https://en.bitcoin.it/wiki/Script)~g;" \
-pe "s~\]\[x509\]~](https://en.wikipedia.org/wiki/X.509)~g;" \
-pe "s~\]\[core bloom.cpp hash\]~](https://github.com/dashpay/dash/blob/333e1eaeea80344e5a28db6efbce2691c85e2b25/src/bloom.cpp#L58)~g;" \
-pe "s~\]\[MAX_SIZE\]~](https://github.com/dashpay/dash/blob/c31ba8ba4c07e72620bd71753f2103ca103bb1c2/src/serialize.h#L26)~g;" \
-pe "s~\]\[privatesend denominations\]~](https://github.com/dashpay/dash/blob/753b1e486b2757b1dba59998ee477e7ceff04f2d/src/privatesend.cpp#L149-L171)~g;" \
-pe "s~\]\[rpcprotocol.h\]~](https://github.com/dashpay/dash/blob/3e0eee4c84f40b3cf277e8d03e004249d03c081d/src/rpcprotocol.h)~g;" \
-pe "s~\]\[spork.h\]~](https://github.com/dashpay/dash/blob/a4f5ba38b65384fb9243ce78c111feceb377e1a9/src/spork.h#L20)~g;" \
-pe "s~\]\[spork pubkey\]~](https://github.com/dashpay/dash/blob/eaf90b77177efbaf9cbed46e822f0d794f1a0ee5/src/chainparams.cpp#L158)~g;" \
-pe "s~\]\[masternode payments pubkey\]~](https://github.com/dashpay/dash/blob/eaf90b77177efbaf9cbed46e822f0d794f1a0ee5/src/chainparams.cpp#L159)~g;" \
-pe "s~\]\[block subsidy\]~](https://github.com/dashpay/dash/blob/9ed9474a9eb007bba70278ce19df68e84aeeb712/src/main.cpp#L1741)~g;" \
-pe "s~\]\[governance vote signature format\]~](https://github.com/dashpay/dash/blob/48d63ab296f5613c727306ea39524f51d157a04c/src/governance-vote.cpp#L240-#L241)~g;" \