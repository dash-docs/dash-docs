{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/gobject.md" %}

##### GObject
{% include helpers/subhead-links.md %}

{% assign summary_gObject="provides a set of commands for managing governance objects and displaying information about them." %}

{% autocrossref %}

The `gobject` RPC {{summary_gObject}}

###### GObject Check

The `gobject check` RPC validates governance object data (_proposals only_).

*Parameter #1---object data (hex)*

{% itemplate ntpd1 %}
- n: "`data-hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The data (hex) of a governance proposal object"

{% enditemplate %}

*Result---governance object status*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing status"

- n: "→<br>`Object Status`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Status of the governance object"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject check 5b5b2270726f706f73616c222c7b22656e645f65706f\
6368223a2231353037343534383935222c226e616d65223a227465737470726f706f73616c5f\
2d5f6162636465666768696a6b6c6d6e6f707172737475767778797a30313233343536373839\
31353037323635383233222c227061796d656e745f61646472657373223a2279664e68484c4c\
695936577a5a646a51766137324a64395134313468516578514c68222c227061796d656e745f\
616d6f756e74223a2232222c2273746172745f65706f6368223a223135303732363538323322\
2c2274797065223a312c2275726c223a2268747470733a2f2f7777772e6461736863656e7472\
616c2e6f72672f702f746573745f70726f706f73616c5f31353037323635383233227d5d5d
{% endhighlight %}

Result:
{% highlight json %}
{
  "Object status": "OK"
}
{% endhighlight %}

###### GObject Prepare

The `gobject prepare` RPC prepares a governance object by signing and creating a collateral transaction.

*Parameter #1---parent hash*

{% itemplate ntpd1 %}
- n: "`parent-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the parent object. Usually the root node which has a hash of 0"

{% enditemplate %}

*Parameter #2---revision*

{% itemplate ntpd1 %}
- n: "`revision`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Object revision number"

{% enditemplate %}

*Parameter #3---time*

{% itemplate ntpd1 %}
- n: "`time`"
  t: "int64_t"
  p: "Required<br>(exactly 1)"
  d: "Create time"

{% enditemplate %}

*Parameter #4---data*

{% itemplate ntpd1 %}
- n: "`data`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Object data (JSON object with governance details)"

{% enditemplate %}

*Result---collateral transaction ID*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Transaction ID for the collateral transaction"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
gobject prepare 0 1 1509548445 5b5b2270726f706f73616c222c7b22656e645f65706f6\
368223a313530393638303337392c226e616d65223a22746573742d70726f706f73616c2d646\
173682d646f6373222c227061796d656e745f61646472657373223a2279554b447a353950745\
0577348596b56346537424337416263454c72346a52787371222c227061796d656e745f616d6\
f756e74223a32302c2273746172745f65706f6368223a313530393637363831342c227479706\
5223a312c2275726c223a2268747470733a2f2f646173682d646f63732e746573742f7465737\
4227d5d5d
{% endhighlight %}

Result (Collateral Transaction ID):
{% highlight bash %}
061ec99eb641ffdeaa05a1a724a255103bebc445b15c6c8c028b19c08608496b
{% endhighlight %}


###### GObject Submit

The `gobject submit` RPC submits a governance object to network (objects must first be prepared via `gobject prepare`).

*Parameter #1---parent hash*

{% itemplate ntpd1 %}
- n: "`parent-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the parent object. Usually the root node which has a hash of 0"

{% enditemplate %}

*Parameter #2---revision*

{% itemplate ntpd1 %}
- n: "`revision`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Object revision number"

{% enditemplate %}

*Parameter #3---time*

{% itemplate ntpd1 %}
- n: "`time`"
  t: "int64_t"
  p: "Required<br>(exactly 1)"
  d: "Create time"

{% enditemplate %}

*Parameter #4---data*

{% itemplate ntpd1 %}
- n: "`data`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Object data (JSON object with governance details)"

{% enditemplate %}

*Parameter #5---transaction ID*

{% itemplate ntpd1 %}
- n: "`data`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Collateral transaction ID"

{% enditemplate %}

*Result---governance object hash*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Governance object hash"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
gobject submit 0 1 1509548445 5b5b2270726f706f73616c222c7b22656e645f65706f6\
368223a313530393638303337392c226e616d65223a22746573742d70726f706f73616c2d646\
173682d646f6373222c227061796d656e745f61646472657373223a2279554b447a353950745\
0577348596b56346537424337416263454c72346a52787371222c227061796d656e745f616d6\
f756e74223a32302c2273746172745f65706f6368223a313530393637363831342c227479706\
5223a312c2275726c223a2268747470733a2f2f646173682d646f63732e746573742f7465737\
4227d5d5d 061ec99eb641ffdeaa05a1a724a255103bebc445b15c6c8c028b19c08608496b
{% endhighlight %}

Result (Governance Object Hash):
{% highlight bash %}
75e991c86ed5a50305e315e00c9a95fc74841bd97d58391071edc9ff206a0d3c
{% endhighlight %}

###### GObject Deserialize

The `gobject deserialize` RPC deserializes a governance object from a hex string to JSON.

*Parameter #1---object data (hex)*

{% itemplate ntpd1 %}
- n: "`data-hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The data (hex) of a governance object"

{% enditemplate %}

**Results**

The result output<!--noref--> varies depending on the type of governance object being
deserialized. Examples are shown below for both proposal and trigger object types.

**Result - Proposal**

*Result---governance proposal object deserialized to JSON*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Array of governance objects"

- n: "→<br>Object"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Proposal object"

- n: "→ →<br>`end_epoch`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Governance object info as string"

- n: "→ →<br>`name`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Proposal name"

- n: "→ →<br>`payment_address`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Proposal payment address"

- n: "→ →<br>`payment_amount`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Proposal payment amount"

- n: "→ →<br>`start_epoch`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Proposal start"

- n: "→ →<br>`type`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Object type"

- n: "→ →<br>`url`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Proposal URL"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject deserialize 5b5b2270726f706f73616c222c7b22656e645f6\
5706f6368223a2231353037343534383935222c226e616d65223a227465737470726f706f7361\
6c5f2d5f6162636465666768696a6b6c6d6e6f707172737475767778797a30313233343536373\
83931353037323635383233222c227061796d656e745f61646472657373223a2279664e68484c\
4c695936577a5a646a51766137324a64395134313468516578514c68222c227061796d656e745\
f616d6f756e74223a2232222c2273746172745f65706f6368223a223135303732363538323322\
2c2274797065223a312c2275726c223a2268747470733a2f2f7777772e6461736863656e74726\
16c2e6f72672f702f746573745f70726f706f73616c5f31353037323635383233227d5d5d
{% endhighlight %}

Result:
{% highlight json %}
[
  [
    "proposal",
    {
      "end_epoch":"1507454895",
      "name":"testproposal_-_abcdefghijklmnopqrstuvwxyz01234567891507265823",
      "payment_address":"yfNhHLLiY6WzZdjQva72Jd9Q414hQexQLh",
      "payment_amount":"2",
      "start_epoch":"1507265823",
      "type":1,
      "url":"https://www.dashcentral.org/p/test_proposal_1507265823"
    }
  ]
]
{% endhighlight %}

**Result - Trigger**

*Result---governance trigger object deserialized to JSON*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Array of governance objects"

- n: "→<br>Object"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Trigger object"

- n: "→ →<br>`event_block_height`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Block height to activate trigger"

- n: "→ →<br>`payment_addresses`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Proposal payment address"

- n: "→ →<br>`payment_amounts`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Proposal payment amount"

- n: "→ →<br>`proposal_hashes`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Proposal hashes"

- n: "→ →<br>`type`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Object type"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject deserialize 5b5b2274726967676572222c207b226576656e7\
45f626c6f636b5f686569676874223a2031383435362c20227061796d656e745f616464726573\
736573223a20227952465968665a4a4258567a3861696850365a7166714174374245316256644\
676567c79544c795070554668696768355270787a72695a6362474c5972527836687959455022\
2c20227061796d656e745f616d6f756e7473223a2022322e31323334353637387c322e3030303\
030303030222c202270726f706f73616c5f686173686573223a20223632623161336564633938\
37626432313134636439323263336339376166643039383339353534313862313730316330666\
131353262616662386131313735667c3138376337353166653631336434386139623331316161\
34383833383635666166396234336333623931333433333438326636636632343763313835656\
13037222c202274797065223a20327d5d5d
{% endhighlight %}

Result (wrapped):
{% highlight json %}
[  
  [
    "trigger",
    {  
      "event_block_height":18456,
      "payment_addresses":"yRFYhfZJBXVz8aihP6ZqfqAt7BE1bVdFvV\
        |yTLyPpUFhigh5RpxzriZcbGLYrRx6hyYEP",
      "payment_amounts":"2.12345678|2.00000000",
      "proposal_hashes":"62b1a3edc987bd2114cd922c3c97afd0983955418b1701c0fa\
        152bafb8a1175f|187c751fe613d48a9b311aa4883865faf9b43c3b913433482f6c\
        f247c185ea07",
      "type":2
    }
  ]
]
{% endhighlight %}


###### GObject Count

The `gobject count` RPC returns the count of governance objects and votes.

*Parameters: none*

*Result---count of governance objects and votes*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The count of governance objects and votes"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject count
{% endhighlight %}

Result (wrapped):
{% highlight text %}
Governance Objects: 177 (Proposals: 177, Triggers: 0, Watchdogs: 0/0, \
	Other: 0; Erased: 5), Votes: 9680
{% endhighlight %}


###### GObject Get

The `gobject get` RPC returns a governance object by hash.

*Parameter #1---object hash*

{% itemplate ntpd1 %}
- n: "`governance-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of a governance object"

{% enditemplate %}

*Result---governance object details*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Information about the governance object"

- n: "→<br>`DataHex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Governance object info as hex string"

- n: "→<br>`DataString`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Governance object info as string"

- n: "→<br>`Hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of this governance object"

- n: "→<br>`CollateralHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the collateral payment transaction"

- n: "→<br>`ObjectType`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Object types:<br>`1` - Unknown<br>`2` - Proposal<br>`3` - Trigger<br>`4` - Watchdog"

- n: "→<br>`CreationTime`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Object creation time as Unix epoch time"

- n: "→<br>`FundingResult`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Funding vote details"

- n: "→ →<br>`AbsoluteYesCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Yes` votes minus number of `No` votes"

- n: "→ →<br>`YesCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Yes` votes"

- n: "→ →<br>`NoCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `No` votes"

- n: "→ →<br>`AbstainCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Abstain` votes"

- n: "→<br>`ValidResult`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object validity vote details"

- n: "→ →<br>`AbsoluteYesCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Yes` votes minus number of `No` votes"

- n: "→ →<br>`YesCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Yes` votes"

- n: "→ →<br>`NoCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `No` votes"

- n: "→ →<br>`AbstainCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Abstain` votes"

- n: "→<br>`DeleteResult`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Delete vote details"

- n: "→ →<br>`AbsoluteYesCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Yes` votes minus number of `No` votes"

- n: "→ →<br>`YesCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Yes` votes"

- n: "→ →<br>`NoCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `No` votes"

- n: "→ →<br>`AbstainCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Abstain` votes"

- n: "→<br>`EndorsedResult`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Endorsed vote details"

- n: "→ →<br>`AbsoluteYesCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Yes` votes minus number of `No` votes"

- n: "→ →<br>`YesCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Yes` votes"

- n: "→ →<br>`NoCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `No` votes"

- n: "→ →<br>`AbstainCount`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of `Abstain` votes"

- n: "→<br>`fLocalValidity`"
  t: "boolean"
  p: "Required<br>(exactly 1)"
  d: "Valid by the blockchain"

- n: "→<br>`IsValidReason`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "`fLocalValidity` error result. Empty if no error returned."

- n: "→<br>`fCachedValid`"
  t: "boolean"
  p: "Required<br>(exactly 1)"
  d: "Minimum network support has been reached flagging this object as a valid and understood governance object (e.g, the serialized data is correct format, etc)"

- n: "→<br>`fCachedFunding`"
  t: "boolean"
  p: "Required<br>(exactly 1)"
  d: "Minimum network support has been reached for this object to be funded (doesn't mean it will be for sure though)"

- n: "→<br>`fCachedDelete`"
  t: "boolean"
  p: "Required<br>(exactly 1)"
  d: "Minimum network support has been reached saying this object should be deleted from the system entirely"

- n: "→<br>`fCachedEndorsed`"
  t: "boolean"
  p: "Required<br>(exactly 1)"
  d: "Minimum network support has been reached flagging this object as endorsed"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject get \
	42253a7bec554b97a65d2889e6cb9a1cf308b3d47a778c704bf9cdc1fe1bf6ff
{% endhighlight %}

Result (wrapped):
{% highlight json %}
{
  "DataHex": "5b5b2270726f706f73616c222c7b22656e645f65706f6368223a2231353037343339353130222c226e616d65223a227465737470726f706f73616c5f2d5f6162636465666768696a6b6c6d6e6f707172737475767778797a3031323334353637383931353037323530343338222c227061796d656e745f61646472657373223a22795668577955345933756456784d5234464b3333556741534a41436831436835516a222c227061796d656e745f616d6f756e74223a2232222c2273746172745f65706f6368223a2231353037323530343338222c2274797065223a312c2275726c223a2268747470733a2f2f7777772e6461736863656e7472616c2e6f72672f702f746573745f70726f706f73616c5f31353037323530343338227d5d5d",
  "DataString": "[[\"proposal\",{\"end_epoch\":\"1507439510\",\"name\":\"testproposal_-_abcdefghijklmnopqrstuvwxyz01234567891507250438\",\"payment_address\":\"yVhWyU4Y3udVxMR4FK33UgASJACh1Ch5Qj\",\"payment_amount\":\"2\",\"start_epoch\":\"1507250438\",\"type\":1,\"url\":\"https://www.dashcentral.org/p/test_proposal_1507250438\"}]]",
  "Hash": "42253a7bec554b97a65d2889e6cb9a1cf308b3d47a778c704bf9cdc1fe1bf6ff",
  "CollateralHash": "cb09bd0310c0a67cde9387ad4d8908a7ad9f5d89c5afd58e9332b8bd26a646c7",
  "ObjectType": 1,
  "CreationTime": 1507246694,
  "FundingResult": {
    "AbsoluteYesCount": 0,
    "YesCount": 0,
    "NoCount": 0,
    "AbstainCount": 0
  },
  "ValidResult": {
    "AbsoluteYesCount": 0,
    "YesCount": 0,
    "NoCount": 0,
    "AbstainCount": 0
  },
  "DeleteResult": {
    "AbsoluteYesCount": 31,
    "YesCount": 31,
    "NoCount": 0,
    "AbstainCount": 0
  },
  "EndorsedResult": {
    "AbsoluteYesCount": 0,
    "YesCount": 0,
    "NoCount": 0,
    "AbstainCount": 0
  },
  "fLocalValidity": true,
  "IsValidReason": "",
  "fCachedValid": true,
  "fCachedFunding": false,
  "fCachedDelete": false,
  "fCachedEndorsed": false
}
{% endhighlight %}


###### GObject Getvotes

The `gobject getvotes` RPC gets all votes for a governance object hash (including old votes).

*Parameter #1---object hash*

{% itemplate ntpd1 %}
- n: "`governance-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of a governance object"

{% enditemplate %}

*Result---votes for specified governance*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "The governance object votes"

- n: "→<br>Vote Info"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "Key: vote-hash<br><br>Value: vinMasternode, time, outcome, and signal of the vote"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject getvotes 78941af577f639ac94440e4855a1ed8f\
  696f1506d1c0bed4f4b68f05be26d3ca
{% endhighlight %}

Result (truncated):
{% highlight json %}
{
  "174aaba65982d25a23f437e2a66ec3836146ba7b7ce5b3fe2d5476907f7079d9": "CTxIn(COutPoint(2eab488e3a7b030303de0d18e357ce17a9fc6b8876705d61076bbe923b2e5fc8, 1), scriptSig=):1509354047:YES:DELETE",
  "216cbc42addec1a6b83e1f2b0b3779594bd879f5671dd76a9826cc690c68286d": "CTxIn(COutPoint(b0320c1eff10ccb5e26086017a09e77dacb30fdcafccb3d98db3e5b610b9f1bd, 1), scriptSig=):1509117256:YES:DELETE",
  "aa4dc9d3b9e74e8c1ffc725b737d07f8a32e43c64907e4bea19e64a86135f08a": "CTxIn(COutPoint(af9f5646ace92f76b3a01b0abe08716a0a7ded64074c2d2e712c93174b9013d1, 1), scriptSig=):1508866932:YES:FUNDING",
  "73dd135ea7bece0f2047de75d8ca04f2985daebed9568d28ee58a60a12a2a082": "CTxIn(COutPoint(8e3fee7f668fed7019588be616225c6c4762ee632470878b2dc8eae3f0b3f67d, 1), scriptSig=):1508866932:YES:FUNDING",
  "d13b9c5c28bbc8684a7291961a1023abbbe65b534804d0629fb44166cc1a6148": "CTxIn(COutPoint(08b2dbffd61d927bc12c20f6853513f41fbf7737446632b13c7ca0df8c6da282, 1), scriptSig=):1508866932:YES:FUNDING",
  "8a4283d457d8635b43c6fa6cbf865813a80d965c777e8ba07364eb6468200ae1": "CTxIn(COutPoint(76c40abd280441b75577e99e9e4f253f9281a7deb4feebff83860f9cede7a09b, 1), scriptSig=):1508866932:YES:FUNDING",
  "313e19607813cb0db3b3fb477982b4d3418f13f8511295419df8fe1f7ff6668f": "CTxIn(COutPoint(0fd502f28b9a9a256d9ba29a047c375fe2823b6e76e4853af16e079a709ab72a, 1), scriptSig=):1508866932:YES:FUNDING"
}
{% endhighlight %}


###### GObject Getcurrentvotes

The `gobject getcurrentvotes` RPC gets only current (tallying) votes for a governance object hash (does not include old votes).

*Parameter #1---object hash*

{% itemplate ntpd1 %}
- n: "`governance-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of a governance object"

{% enditemplate %}

*Result---votes for specified governance*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "The governance object votes"

- n: "→<br>Vote Info"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "Key: vote-hash<br><br>Value: vinMasternode, time, outcome, and signal of the vote"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject getcurrentvotes 78941af577f639ac94440e4855a1ed8f\
  696f1506d1c0bed4f4b68f05be26d3ca
{% endhighlight %}

Result (truncated):
{% highlight json %}
{
  "174aaba65982d25a23f437e2a66ec3836146ba7b7ce5b3fe2d5476907f7079d9": "CTxIn(COutPoint(2eab488e3a7b030303de0d18e357ce17a9fc6b8876705d61076bbe923b2e5fc8, 1), scriptSig=):1509354047:YES:DELETE",
  "444d4d871ec35479804f060c733f516908382642ec2dfce6044a59fcadfdcd60": "CTxIn(COutPoint(18e496fe85b61ac9a5fcaec1ef683c7e3fc9bce4a83c883608427ecfb1002fca, 1), scriptSig=):1508866932:YES:FUNDING",
  "d49a472c62e9d8105931829fc50ef6c6ce04a230507646ee0eaa615e863ef3a0": "CTxIn(COutPoint(18e496fe85b61ac9a5fcaec1ef683c7e3fc9bce4a83c883608427ecfb1002fca, 1), scriptSig=):1509117071:YES:DELETE",
  "78442507441d4524d2493b8568d130415c1eb394adb2fe38d6ffeb199115bc5d": "CTxIn(COutPoint(3df7fb192e21c34da99bdd10c34e58ecaf3f3c37d6b2289f0ffedba5050188cc, 1), scriptSig=):1509312524:YES:DELETE",
  "aa4dc9d3b9e74e8c1ffc725b737d07f8a32e43c64907e4bea19e64a86135f08a": "CTxIn(COutPoint(af9f5646ace92f76b3a01b0abe08716a0a7ded64074c2d2e712c93174b9013d1, 1), scriptSig=):1508866932:YES:FUNDING",
}
{% endhighlight %}


###### GObject List

The `gobject list` RPC Lists governance objects (can be filtered by signal and/or object type).

*Parameter #1---signal*

{% itemplate ntpd1 %}
- n: "`signal`"
  t: "string (hex)"
  p: "Optional<br>(exactly 1)"
  d: "Type of governance object signal: <br>• `valid`<br>• `funding`<br>• `delete`<br>• `endorsed`<br>• `all` (_DEFAULT_)"

{% enditemplate %}

*Parameter #2---type*

{% itemplate ntpd1 %}
- n: "`type`"
  t: "string (hex)"
  p: "Optional<br>(exactly 1)"
  d: "Type of governance object signal: <br>• `proposals`<br>• `triggers`<br>• `watchdogs`<br>• `all` (_DEFAULT_)"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject list all proposals
{% endhighlight %}

Result (truncated):
{% highlight json %}
{
  "b370fa1afd61aca9aa879abea3087e29656a670478f281d4196efb4e7e893ffe": {
    "DataHex": "5b5b2270726f706f73616c222c7b22656e645f65706f6368223a2231353037343430303338222c226e616d65223a227465737470726f706f73616c5f2d5f6162636465666768696a6b6c6d6e6f707172737475767778797a3031323334353637383931353037323530393636222c227061796d656e745f61646472657373223a2279544c636f506d4e315963654432534345474d6b6e34395753565a4277626f646e6e222c227061796d656e745f616d6f756e74223a2232222c2273746172745f65706f6368223a2231353037323530393636222c2274797065223a312c2275726c223a2268747470733a2f2f7777772e6461736863656e7472616c2e6f72672f702f746573745f70726f706f73616c5f31353037323530393636227d5d5d",
    "DataString": "[[\"proposal\",{\"end_epoch\":\"1507440038\",\"name\":\"testproposal_-_abcdefghijklmnopqrstuvwxyz01234567891507250966\",\"payment_address\":\"yTLcoPmN1YceD2SCEGMkn49WSVZBwbodnn\",\"payment_amount\":\"2\",\"start_epoch\":\"1507250966\",\"type\":1,\"url\":\"https://www.dashcentral.org/p/test_proposal_1507250966\"}]]",
    "Hash": "b370fa1afd61aca9aa879abea3087e29656a670478f281d4196efb4e7e893ffe",
    "CollateralHash": "a51ea89c14735f8b5df37cd846b3561494cc616d4a741e4ef83b368d45c960ba",
    "ObjectType": 1,
    "CreationTime": 1507250966,
    "AbsoluteYesCount": 0,
    "YesCount": 0,
    "NoCount": 0,
    "AbstainCount": 0,
    "fBlockchainValidity": true,
    "IsValidReason": "",
    "fCachedValid": true,
    "fCachedFunding": false,
    "fCachedDelete": false,
    "fCachedEndorsed": false
  },
  "906ae4dbd285e1025832ac9b3160073ecbfeef094d34cf81b3d797a349c720ff": {
    "DataHex": "5b5b2270726f706f73616c222c7b22656e645f65706f6368223a2231353037343534383935222c226e616d65223a227465737470726f706f73616c5f2d5f6162636465666768696a6b6c6d6e6f707172737475767778797a3031323334353637383931353037323635383233222c227061796d656e745f61646472657373223a2279664e68484c4c695936577a5a646a51766137324a64395134313468516578514c68222c227061796d656e745f616d6f756e74223a2232222c2273746172745f65706f6368223a2231353037323635383233222c2274797065223a312c2275726c223a2268747470733a2f2f7777772e6461736863656e7472616c2e6f72672f702f746573745f70726f706f73616c5f31353037323635383233227d5d5d",
    "DataString": "[[\"proposal\",{\"end_epoch\":\"1507454895\",\"name\":\"testproposal_-_abcdefghijklmnopqrstuvwxyz01234567891507265823\",\"payment_address\":\"yfNhHLLiY6WzZdjQva72Jd9Q414hQexQLh\",\"payment_amount\":\"2\",\"start_epoch\":\"1507265823\",\"type\":1,\"url\":\"https://www.dashcentral.org/p/test_proposal_1507265823\"}]]",
    "Hash": "906ae4dbd285e1025832ac9b3160073ecbfeef094d34cf81b3d797a349c720ff",
    "CollateralHash": "1707470c4372ba048b72945365b4bb71afc8a986e0755c1f1e8a37bba21fde83",
    "ObjectType": 1,
    "CreationTime": 1507265823,
    "AbsoluteYesCount": 0,
    "YesCount": 0,
    "NoCount": 0,
    "AbstainCount": 0,
    "fBlockchainValidity": true,
    "IsValidReason": "",
    "fCachedValid": true,
    "fCachedFunding": false,
    "fCachedDelete": false,
    "fCachedEndorsed": false
  }
}
{% endhighlight %}

###### GObject Diff

The `gobject diff` RPC Lists governance objects differences since last diff.

*Parameter #1---signal*

{% itemplate ntpd1 %}
- n: "`signal`"
  t: "string (hex)"
  p: "Optional<br>(exactly 1)"
  d: "Type of governance object signal: <br>• `valid`<br>• `funding`<br>• `delete`<br>• `endorsed`<br>• `all` (_DEFAULT_)"

{% enditemplate %}

*Parameter #2---type*

{% itemplate ntpd1 %}
- n: "`type`"
  t: "string (hex)"
  p: "Optional<br>(exactly 1)"
  d: "Type of governance object signal: <br>• `proposals`<br>• `triggers`<br>• `watchdogs`<br>• `all` (_DEFAULT_)"

{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject diff all all
{% endhighlight %}

Result:
{% highlight json %}
{
}
{% endhighlight %}


###### GObject Vote-alias

###### GObject Vote-conf

###### GObject Vote-many


*See also:*

* [GetGovernanceInfo][rpc getgovernanceinfo]: {{summary_getGovernanceInfo}}
* [GetSuperblockBudget][rpc getsuperblockbudget]: {{summary_getSuperblockBudget}}

{% endautocrossref %}
