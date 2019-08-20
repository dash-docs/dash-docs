{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/gobject.md" %}

<!--__-->

##### GObject
{% include helpers/subhead-links.md %}

{% assign summary_gObject="provides a set of commands for managing governance objects and displaying information about them." %}

{% autocrossref %}

The `gobject` RPC {{summary_gObject}}

{% endautocrossref %}

###### GObject Check
<!-- no subhead-links here -->

{% autocrossref %}

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
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing status"

- n: "→<br>`Object Status`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Status of the governance object"

{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet gobject check 7b22656e645f65706f6368223a3135363034353730\
35352c226e616d65223a2274657374222c227061796d656e745f61646472657373223a22796\
4354b4d52457333474c4d65366d544a597233597248316a75774e777246436642222c227061\
796d656e745f616d6f756e74223a352c2273746172745f65706f6368223a313536303435333\
439302c2274797065223a312c2275726c223a22687474703a2f2f746573742e636f6d227d
{% endhighlight %}

Result:
{% highlight json %}
{
  "Object status": "OK"
}
{% endhighlight %}

{% endautocrossref %}

###### GObject Prepare
<!-- no subhead-links here -->

{% autocrossref %}

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
  d: "Create time (Unix epoch time)"

{% enditemplate %}

*Parameter #4---data*

{% itemplate ntpd1 %}
- n: "`data-hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "**Updated in Dash Core 0.14.0 to require all new proposals to use JSON serialization.**<br><br>Object data (JSON object with governance details). Additional details regarding this are provided in an example below."

{% enditemplate %}

*Parameter #5---use-IS*

{% itemplate ntpd1 %}
- n: "`use-IS`"
  t: "boolean"
  p: "Optional<br>(0 or 1)"
  d: "*Deprecated and ignored since Dash Core 0.14.1*"

{% enditemplate %}

*Parameter #6---outputHash*

{% itemplate ntpd1 %}
- n: "`outputHash`"
  t: "string (hex)"
  p: "Optional<br>(0 or 1)"
  d: "*Added in Dash Core 0.13.0*<br><br>The single output to submit the proposal fee from"

{% enditemplate %}

*Parameter #7---outputIndex*

{% itemplate ntpd1 %}
- n: "`outputIndex`"
  t: "numeric"
  p: "Optional<br>(0 or 1)"
  d: "*Added in Dash Core 0.13.0*<br><br>The output index (required if the `outputHash` parameter is provided)"

{% enditemplate %}


*Result---collateral transaction ID*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Transaction ID for the collateral transaction"

{% enditemplate %}

**Details of the `data-hex` field:**

The `data-hex` field is comprised of a JSON object as described in [GObject
Deserialize](#gobject-deserialize) which is serialized to hex.

An example of a proposal JSON object is shown here:

{% highlight json %}
{
  "end_epoch": 1560457055,
  "name": "test",
  "payment_address": "yd5KMREs3GLMe6mTJYr3YrH1juwNwrFCfB",
  "payment_amount": 5,
  "start_epoch": 1560453490,
  "type": 1,
  "url": "http://test.com"
}
{% endhighlight %}

To serialize the object, first remove all spaces from the JSON object as shown below:

{% highlight json %}
{"end_epoch":1560457055,"name":"test","payment_address":"yd5KMREs3GLMe6mTJYr3YrH1juwNwrFCfB","payment_amount":5,"start_epoch":1560453490,"type":1,"url":"http://test.com"}
{% endhighlight %}

Then convert the string to its hex equivalent as shown below. This is what will
be used for the `data-hex` field of the `gobject prepare` command:

{% highlight bash %}
7b22656e645f65706f6368223a313536303435373035352c226e616d65223a2274657374222c\
227061796d656e745f61646472657373223a227964354b4d52457333474c4d65366d544a5972\
33597248316a75774e777246436642222c227061796d656e745f616d6f756e74223a352c2273\
746172745f65706f6368223a313536303435333439302c2274797065223a312c2275726c223a\
22687474703a2f2f746573742e636f6d227d
{% endhighlight %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
gobject prepare 0 1 1560449223 7b22656e645f65706f6368223a3135363034353730353\
52c226e616d65223a2274657374222c227061796d656e745f61646472657373223a227964354\
b4d52457333474c4d65366d544a597233597248316a75774e777246436642222c227061796d6\
56e745f616d6f756e74223a352c2273746172745f65706f6368223a313536303435333439302\
c2274797065223a312c2275726c223a22687474703a2f2f746573742e636f6d227d
{% endhighlight %}

Result (Collateral Transaction ID):
{% highlight bash %}
3fd758e7a5761bb07b2850b8ba432ef42c1ea80f0921d2eab0682697dda78262
{% endhighlight %}

{% endautocrossref %}

###### GObject Submit
<!-- no subhead-links here -->

{% autocrossref %}

The `gobject submit` RPC submits a governance object to network (objects must
first be prepared via `gobject prepare`).

Note: Parameters 1-4 should be the same values as the ones used for `gobject
prepare`.

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
- n: "`data-hex`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "**Updated in Dash Core 0.14.0 to require all new proposals to use JSON serialization.**<br><br>Object data (JSON object with governance details). See [GObject Prepare](#gobject-prepare) for additional details about this field."

{% enditemplate %}

*Parameter #5---fee transaction ID*

{% itemplate ntpd1 %}
- n: "`data`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Fee transaction ID - required for all objects except triggers"

{% enditemplate %}

*Result---governance object hash*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Governance object hash"

{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet gobject submit 0 1 1560449223 7b22656e645f65706f6368223a3\
13536303435373035352c226e616d65223a2274657374222c227061796d656e745f61646472\
657373223a227964354b4d52457333474c4d65366d544a597233597248316a75774e7772464\
36642222c227061796d656e745f616d6f756e74223a352c2273746172745f65706f6368223a\
313536303435333439302c2274797065223a312c2275726c223a22687474703a2f2f7465737\
42e636f6d227d \
3fd758e7a5761bb07b2850b8ba432ef42c1ea80f0921d2eab0682697dda78262
{% endhighlight %}

Result (Governance Object Hash):
{% highlight bash %}
e353b2ab5f7e7cb24b95e00e153ec2a6339249672f18b8e8e144aa711678710d
{% endhighlight %}

{% endautocrossref %}

###### GObject Deserialize
<!-- no subhead-links here -->

{% autocrossref %}

The `gobject deserialize` RPC deserializes a governance object from a hex string to JSON.

*Parameter #1---object data (hex)*

{% itemplate ntpd1 %}
- n: "`hex_data`"
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
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Array of governance objects"

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

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet gobject deserialize 7b22656e645f65706f6368223a313536303435\
373035352c226e616d65223a2274657374222c227061796d656e745f61646472657373223a22\
7964354b4d52457333474c4d65366d544a597233597248316a75774e777246436642222c2270\
61796d656e745f616d6f756e74223a352c2273746172745f65706f6368223a31353630343533\
3439302c2274797065223a312c2275726c223a22687474703a2f2f746573742e636f6d227d
{% endhighlight %}

Result:
{% highlight json %}
{
  "end_epoch": 1560457055,
  "name": "test",
  "payment_address": "yd5KMREs3GLMe6mTJYr3YrH1juwNwrFCfB",
  "payment_amount": 5,
  "start_epoch": 1560453490,
  "type": 1,
  "url": "http://test.com"
}
{% endhighlight %}

<!-- __ -->

**Result - Trigger**

*Result---governance trigger object deserialized to JSON*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Array of governance objects"

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

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet gobject deserialize 7b226576656e745f626c6f636b5f68656967687\
4223a203131393539322c20227061796d656e745f616464726573736573223a20227954686d6e\
75565a316765516e79776f456147627079333362695435473573587a62222c20227061796d656\
e745f616d6f756e7473223a2022312e3335393631393331222c202270726f706f73616c5f6861\
73686573223a20223836333966636464653131626432373032373663396330333564366435346\
3653962393138323465366466373532636164376464646331616532663734386435222c202274\
797065223a20327d
{% endhighlight %}

Result (wrapped):
{% highlight json %}
{
  "event_block_height": 119592,
  "payment_addresses": "yThmnuVZ1geQnywoEaGbpy33biT5G5sXzb",
  "payment_amounts": "1.35961931",
  "proposal_hashes": "8639fcdde11bd270276c9c035d6d54ce9b91824e6df752cad7dddc1ae2f748d5",
  "type": 2
}
{% endhighlight %}

{% endautocrossref %}

###### GObject Count
<!-- no subhead-links here -->

{% autocrossref %}

The `gobject count` RPC returns the count of governance objects and votes.

*Parameter #1---mode*

{% itemplate ntpd1 %}
- n: "`mode`"
  t: "string"
  p: "Optional<br>(exactly 1)"
  d: "Result return format:<br>`json` (default)<br>`all` - Default before Dash Core 0.12.3 (for backwards compatibility)"

{% enditemplate %}


**Command Mode - `json`**

*Result---count of governance objects and votes*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Information about the governance object"

- n: "→<br>`objects_total`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Total object count"

- n: "→<br>`proposals`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Proposal count"

- n: "→<br>`triggers`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Trigger count"

- n: "→<br>`other`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Non-proposal/trigger count"

- n: "→<br>`erased`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Erased count"

- n: "→<br>`votes`"
  t: "int"
  p: "Required<br>(exactly 1)"
  d: "Vote count"

{% enditemplate %}

*Example from Dash Core 0.14.0 (mode: `json`/default)*

{% highlight bash %}
dash-cli -testnet gobject count
{% endhighlight %}

Result (wrapped):
{% highlight json %}
{
  "objects_total": 3,
  "proposals": 3,
  "triggers": 0,
  "other": 0,
  "erased": 4,
  "votes": 18
}
{% endhighlight %}


**Command Mode - `all`**

*Result---count of governance objects and votes*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "The count of governance objects and votes"

{% enditemplate %}

*Example from Dash Core 0.14.0 (mode: `all`)*

{% highlight bash %}
dash-cli -testnet gobject count all
{% endhighlight %}

Result (wrapped):
{% highlight text %}
Governance Objects: 177 (Proposals: 177, Triggers: 0, Other: 0; Erased: 5), \
Votes: 9680
{% endhighlight %}

{% endautocrossref %}

###### GObject Get
<!-- no subhead-links here -->

{% autocrossref %}

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
- n: "Result"
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
  d: "Object types:<br>`1` - Unknown<br>`2` - Proposal<br>`3` - Trigger"

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

{% endautocrossref %}

###### GObject Getvotes
<!-- no subhead-links here -->

{% autocrossref %}

<!-- __ -->

{{WARNING}} **_Removed in Dash Core 0.14.0._**

{% endautocrossref %}

###### GObject Getcurrentvotes
<!-- no subhead-links here -->

{% autocrossref %}

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
- n: "Result"
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
  "174aaba65982d25a23f437e2a66ec3836146ba7b7ce5b3fe2d5476907f7079d9": "2eab488e3a7b030303de0d18e357ce17a9fc6b8876705d61076bbe923b2e5fc8-1:1509354047:YES:DELETE",
  "444d4d871ec35479804f060c733f516908382642ec2dfce6044a59fcadfdcd60": "18e496fe85b61ac9a5fcaec1ef683c7e3fc9bce4a83c883608427ecfb1002fca-1:1508866932:YES:FUNDING",
  "d49a472c62e9d8105931829fc50ef6c6ce04a230507646ee0eaa615e863ef3a0": "18e496fe85b61ac9a5fcaec1ef683c7e3fc9bce4a83c883608427ecfb1002fca-1:1509117071:YES:DELETE",
  "78442507441d4524d2493b8568d130415c1eb394adb2fe38d6ffeb199115bc5d": "3df7fb192e21c34da99bdd10c34e58ecaf3f3c37d6b2289f0ffedba5050188cc-1:1509312524:YES:DELETE",
  "aa4dc9d3b9e74e8c1ffc725b737d07f8a32e43c64907e4bea19e64a86135f08a": "af9f5646ace92f76b3a01b0abe08716a0a7ded64074c2d2e712c93174b9013d1-1:1508866932:YES:FUNDING",
}
{% endhighlight %}

{% endautocrossref %}

###### GObject List
<!-- no subhead-links here -->

{% autocrossref %}

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
  d: "Type of governance object signal: <br>• `proposals`<br>• `triggers`<br>• `all` (_DEFAULT_)"

{% enditemplate %}

*Result---governance objects*

{{INCLUDE_GOVERNANCE_OBJECT}}

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

{% endautocrossref %}

###### GObject Diff
<!-- no subhead-links here -->

{% autocrossref %}

<!-- __ -->

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
  d: "Type of governance object signal: <br>• `proposals`<br>• `triggers`<br>• `all` (_DEFAULT_)"

{% enditemplate %}

*Result---governance objects*

{{INCLUDE_GOVERNANCE_OBJECT}}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject diff all all
{% endhighlight %}

Result (truncated):
{% highlight json %}
{
  "17c2bd32005c5168a52f9b5caa74d875ee8a6867a6109f36923887ef6c36b301": {
    "DataHex": "5b5b2270726f706f73616c222c7b22656e645f65706f6368223a2231353037343533353731222c226e616d65223a227465737470726f706f73616c5f2d5f6162636465666768696a6b6c6d6e6f707172737475767778797a3031323334353637383931353037323634343939222c227061796d656e745f61646472657373223a2279697355653636445352487048504233514245426764574746637068435933626234222c227061796d656e745f616d6f756e74223a2232222c2273746172745f65706f6368223a2231353037323634343939222c2274797065223a312c2275726c223a2268747470733a2f2f7777772e6461736863656e7472616c2e6f72672f702f746573745f70726f706f73616c5f31353037323634343939227d5d5d",
    "DataString": "[[\"proposal\",{\"end_epoch\":\"1507453571\",\"name\":\"testproposal\",\"payment_address\":\"yisUe66DSRHpHPB3QBEBgdWGFcphCY3bb4\",\"payment_amount\":\"2\",\"start_epoch\":\"1507264499\",\"type\":1,\"url\":\"https://www.dashcentral.org/p/test_proposal_1507264499\"}]]",
    "Hash": "17c2bd32005c5168a52f9b5caa74d875ee8a6867a6109f36923887ef6c36b301",
    "CollateralHash": "a25c44b57931afd74530ce39741f91456446a8fd794d2f1c58c42d6f492647ad",
    "ObjectType": 1,
    "CreationTime": 1507264499,
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

{% endautocrossref %}

###### GObject Vote-alias
<!-- no subhead-links here -->

{% autocrossref %}

The `gobject vote-alias` RPC votes on a governance object by masternode alias (using masternode<!--noref-->.conf setup).

*Parameter #1---governance hash*

{% itemplate ntpd1 %}
- n: "`governance-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the governance object"

{% enditemplate %}

*Parameter #2---vote signal*

{% itemplate ntpd1 %}
- n: "`signal`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote signal: `funding`, `valid`, or `delete`"

{% enditemplate %}

*Parameter #3---vote outcome*

{% itemplate ntpd1 %}
- n: "`outcome`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote outcome: `yes`, `no`, or `abstain`"

{% enditemplate %}

*Parameter #4---masternode alias*

{% itemplate ntpd1 %}
- n: "`alias`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Alias of voting masternode"

{% enditemplate %}

*Result---votes for specified governance*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "The governance object votes"

- n: "→<br>`overall`"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "Reports number of vote successes/failures"

- n: "→<br>`detail`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Vote details"

- n: "→ →<br>Masternode Alias"
  t: "object"
  p: "Required<br>(1 or more)"
  d: "Name of the masternode alias"

- n: "→ → →<br>`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote result"
{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject vote-alias \
0bf97bce78b3b642c36d4ca8e9265f8f66de8774c220221f57739c1956413e2b \
funding yes MN01
{% endhighlight %}

Result:
{% highlight json %}
{
  "overall": "Voted successfully 1 time(s) and failed 0 time(s).",
  "detail": {
    "MN01": {
      "result": "success"
    }
  }
}
{% endhighlight %}

{% endautocrossref %}

###### GObject Vote-conf
<!-- no subhead-links here -->

{% autocrossref %}

The `gobject vote-conf` RPC votes on a governance object by masternode configured in dash.conf.

*Parameter #1---governance hash*

{% itemplate ntpd1 %}
- n: "`governance-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the governance object"

{% enditemplate %}

*Parameter #2---vote signal*

{% itemplate ntpd1 %}
- n: "`signal`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote signal: `funding`, `valid`, or `delete`"

{% enditemplate %}

*Parameter #3---vote outcome*

{% itemplate ntpd1 %}
- n: "`outcome`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote outcome: `yes`, `no`, or `abstain`"

{% enditemplate %}

*Result---votes for specified governance*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "The governance object votes"

- n: "→<br>`overall`"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "Reports number of vote successes/failures"

- n: "→<br>`detail`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Vote details"

- n: "→ →<br>`dash.conf`"
  t: "object"
  p: "Required<br>(1 or more)"
  d: ""

- n: "→ → →<br>`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote result"
{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject vote-conf \
0bf97bce78b3b642c36d4ca8e9265f8f66de8774c220221f57739c1956413e2b funding yes
{% endhighlight %}

{% highlight json %}
{
  "overall": "Voted successfully 1 time(s) and failed 0 time(s).",
  "detail": {
    "dash.conf": {
      "result": "success"
    }
  }
}
{% endhighlight %}

{% endautocrossref %}

###### GObject Vote-many
<!-- no subhead-links here -->

{% autocrossref %}

The `gobject vote-many` RPC votes on a governance object by all masternodes (using masternode<!--noref-->.conf setup).

*Parameter #1---governance hash*

{% itemplate ntpd1 %}
- n: "`governance-hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the governance object"

{% enditemplate %}

*Parameter #2---vote signal*

{% itemplate ntpd1 %}
- n: "`signal`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote signal: `funding`, `valid`, or `delete`"

{% enditemplate %}

*Parameter #3---vote outcome*

{% itemplate ntpd1 %}
- n: "`outcome`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote outcome: `yes`, `no`, or `abstain`"

{% enditemplate %}

*Parameter #4---masternode alias*

{% itemplate ntpd1 %}
- n: "`alias`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Alias of voting masternode"

{% enditemplate %}

*Result---votes for specified governance*

{% itemplate ntpd1 %}
- n: "Result"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "The governance object votes"

- n: "→<br>`overall`"
  t: "string"
  p: "Required<br>(1 or more)"
  d: "Reports number of vote successes/failures"

- n: "→<br>`detail`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Vote details"

- n: "→ →<br>Masternode Alias"
  t: "object"
  p: "Required<br>(1 or more)"
  d: "Name of the masternode alias"

- n: "→ → →<br>`result`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Vote result"
{% enditemplate %}

*Example from Dash Core 0.12.2*

{% highlight bash %}
dash-cli -testnet gobject vote-many \
0bf97bce78b3b642c36d4ca8e9265f8f66de8774c220221f57739c1956413e2b funding yes
{% endhighlight %}

{% highlight json %}
{
  "overall": "Voted successfully 1 time(s) and failed 0 time(s).",
  "detail": {
    "MN01": {
      "result": "success"
    }
  }
}
{% endhighlight %}

*See also:*

* [GetGovernanceInfo][rpc getgovernanceinfo]: {{summary_getGovernanceInfo}}
* [GetSuperblockBudget][rpc getsuperblockbudget]: {{summary_getSuperblockBudget}}

{% endautocrossref %}
