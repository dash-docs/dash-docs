{% comment %}
This file is licensed under the MIT License (MIT) available on
http://opensource.org/licenses/MIT.
{% endcomment %}
{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/quorum.md" %}

##### Quorum
{% include helpers/subhead-links.md %}

<!--__-->

{% assign summary_quorum="provides a set of commands for quorums (LLMQs)." %}

{% autocrossref %}

*Added in Dash Core 0.14.0*

The `quorum` RPC {{summary_quorum}}

{% endautocrossref %}

###### Quorum<!--noref--> List
<!-- no subhead-links here -->

{% autocrossref %}

The `quorum<!--noref--> list` RPC displays a list of on-chain quorums.

*Parameter #1---quorum count*

{% itemplate ntpd1 %}
- n: "`count`"
  t: "number"
  p: "Optional<br>(0 or 1)"
  d: "Number of quorums to list. Will list active quorums if `count` is not specified."
{% enditemplate %}

*Result---a list of quorums*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Quorum list"

- n: "→<br>Quorum"
  t: "array"
  p: "Required<br>(1 or more)"
  d: "Array of quorum details"

- n: "→ →<br>Quorum Hash"
  t: "string (hex)"
  p: "Optional<br>(0 or more)"
  d: "A quorum hash"
{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet quorum list
{% endhighlight %}

Result:
{% highlight json %}
{
  "llmq_50_60": [
    "00000000023cc6dde69bed898c83fe2328ef38b1ea9da14a599efa14caef0b7d",
    "000000002b968fb3b2fc2ff18d6e89611e366b4d38a6d0437e99bd7c37f2fd83",
    "000000000301054c038b07b5b51493d5efc3f078e3aede6eb603c47943d1cc78",
    "000000000e901278c00c896754a06f8d45d0268c6aff6e72ffb3007d07c10e73",
    "000000001bc592f2a8676203835bc6ad442abeadb9c22b8d6a2999db07354b01",
    "000000000896c37ef8a32318ee871589394f1578473b8825275b610690e47db0",
    "00000000133b192b2319a0716ad18e5788981fff51856f61205af5d6a634ba41",
    "0000000004946f3f9f82a298985f73080d62627d51f6f4ba77f3cd8c6788b3d0",
    "0000000005cb014d3df9bac0ba379f1d5b8b75f0e6d7c408d43ac1db330ec641",
    "0000000006c1653c7ee747f140dd7daa1da23a541e67a0fc0dc88db3482ec4d5"
  ],
  "llmq_400_60": [
    "0000000007697fd69a799bfa26576a177e817bc0e45b9fcfbf48b362b05aeff2"
  ],
  "llmq_400_85": [
  ]
}
{% endhighlight %}

{% endautocrossref %}

###### Quorum<!--noref--> Info
<!-- no subhead-links here -->

{% autocrossref %}

The `quorum<!--noref--> info` RPC returns information about a specific quorum.

*Parameter #1---LLMQ Type*

{% itemplate ntpd1 %}
- n: "`llmqType`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "[Type of quorums](https://github.com/dashpay/dips/blob/master/dip-0006.md#current-llmq<!--noref-->-types) to list:<br>`1` - LLMQ_50_60<br>`2` - LLMQ_400_60<br>`3` - LLMQ_400_85"
{% enditemplate %}

*Parameter #2---quorum hash*

{% itemplate ntpd1 %}
- n: "`quorumHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The block hash of the quorum"
{% enditemplate %}

*Parameter #3---secret key share*

{% itemplate ntpd1 %}
- n: "`includeSkShare`"
  t: "bool"
  p: "Optional<br>(0 or 1)"
  d: "Include the secret key share (default: `false`)"
{% enditemplate %}

*Result---information about a quorum*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Quorum list"

- n: "→<br>`height`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Block height of the quorum"

- n: "→<br>`quorumHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the quorum"

- n: "→<br>`minedBlock`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the block that established the quorum"

- n: "→<br>`members`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array containing quorum member details"

- n: "→ →<br>Member"
  t: "object"
  p: "Required<br>(1 or more)"
  d: "An object describing a particular member"

- n: "→ → →<br>`proTxHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The masternode's Provider Registration transaction hash"

- n: "→ → →<br>`valid`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Indicates if the member is valid"

- n: "→ → →<br>`pubKeyShare`"
  t: "string"
  p: "Optional<br>(0 or 1)"
  d: "Member public key share"

- n: "→<br>`quorumPublicKey`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "Quorum public key"

- n: "→<br>`secretKeyShare`"
  t: "string"
  p: "Optional<br>(exactly 1)"
  d: "Quorum secret key share"
{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet quorum info 1 \
  0000000003284177404622ea79491cb19855254627751cfbbb0035a62d17ab6a true
{% endhighlight %}

Result (truncated):
{% highlight json %}
{
  "height": 76728,
  "quorumHash": "0000000003284177404622ea79491cb19855254627751cfbbb0035a62d17ab6a",
  "minedBlock": "0000000009d8c183650d12e9ff952967ecfde58404e80db1bf5a7d1a31ccd4ee",
  "members": [
    {
      "proTxHash": "5eccc0b9a1a2b8a9c3511cae98a664c377e8493c35cdd120e0d71f0b6b0f62c5",
      "valid": true,
      "pubKeyShare": "04a4ae5cb7f598d1bcc6fa49162fe8c19f6ad763ce3959f5afdc3c00e19d8261af37729ae8a707860ecdea067029d3e9"
    },
    {
      "proTxHash": "1e17ddf8748ed5e6696255da61922bd3985fd15a33fcb2d051cf84242e89f121",
      "valid": true,
      "pubKeyShare": "8239b67aff5368e710a8ebe5f1f3e9087e8f9c52ed165293779f40b0e764a20972f2ade9367f41cd4f64a3516ad8c90c"
    },
    {
      "proTxHash": "f1eb4ac02ab1acbace0a01328e204c4fd7dec5e53a72cccac7729c5802dbeaf4",
      "valid": true,
      "pubKeyShare": "969655b04484de85b3f1ecce5a9745ec7fd0a34533e13fcf285e15ed034578a604e0e2af98cd12cf89d1cfcc167c978d"
    },
    {
      "proTxHash": "a288f5de676eb63dee13a618d39bd6b07ad73e9ae40148202fc5b5f32e1b0bfb",
      "valid": true,
      "pubKeyShare": "047bee41fdce58f8d87ba6820c784f2a096d85d1ceec62520013c7c3ef9de9203b82eadc910b197a906be2cd5fd21c53"
    },
    {
      "proTxHash": "57795a35a3a127e817704b6b8ce64ac7f6afc49f0d0172c1e4125987c31dd1d7",
      "valid": true,
      "pubKeyShare": "168b9cb406bc44348b5de18c9017817f4e1b15c304ab8d365ba3828712ab1f64c1e4715715d61a96c5923fbe8c470788"
    },
    {
      "proTxHash": "04d06d16b3eca2f104ef9749d0c1c17d183eb1b4fe3a16808fd70464f03bcd63",
      "valid": true,
      "pubKeyShare": "93a85894c04dbc06e9a598126aa8ba9983427a089710c4ff37b9b9f12980780e988f89192b5feaa25f907b8db9efb930"
    }
  ],
  "quorumPublicKey": "18772a3ca86f47795f4e9fa40babe89c7be6bc15bb4e4c8a137715a814a4118516a63b89c5c415b9dfe956f2d6a4fde3",
  "secretKeyShare": "3da0d8f532309660f7f44aa0ed42c1569773b39c70f5771ce5604be77e50759e"
}
{% endhighlight %}

{% endautocrossref %}


###### Quorum<!--noref--> DKGStatus
<!-- no subhead-links here -->

{% autocrossref %}

The `quorum<!--noref--> list` RPC displays the status of the current DKG process.

*Parameter #1---detail level*

{% itemplate ntpd1 %}
- n: "`detail_level`"
  t: "number"
  p: "Optional<br>(0 or 1)"
  d: "Detail level of output (default: 0)<!--noref-->:<br>`0` - Only show counts (_default_)<br>`1` - Show member indexes<br>`2` - Show member's ProTxHashes<br><br>_Note: Works only when Spork 17 is enabled and only displays details related to the node running the command._"
{% enditemplate %}

*Result (if detail level was 0 or omitted)---JSON DKG details*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array of objects each containing a provider transaction, or JSON `null` if an error occurred"

- n: "→<br>`proTxHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the initial provider registration transaction as hex in RPC byte order"

- n: "→<br>`time`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The Unix epoch time"

- n: "→<br>`timeStr`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The UTC time as a string"

- n: "→<br>`session`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing DKG Session information"

- n: "→ →<br>LLMQ Type"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object"

- n: "→ → →<br>`llmqType`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "[Type of quorum](https://github.com/dashpay/dips/blob/master/dip-0006.md#current-llmq<!--noref-->-types):<br>`1` - LLMQ_50_60<br>`2` - LLMQ_400_60<br>`3` - LLMQ_400_85"

- n: "→ → →<br>`quorumHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The block hash of the quorum"

- n: "→ → →<br>`quorumHeight`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The block height of the quorum"

- n: "→ → →<br>`phase`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The active DKG phase<br>`1` - Initialized<br>`2` - Contributing<br>`3` - Complaining<br>`4` - Justifying<br>`5` - Committing<br>`6` - Finalizing"

- n: "→ → →<br>`sentContributions`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "True when contributions have been sent"

- n: "→ → →<br>`sentComplaint`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "True when complaints have been sent"

- n: "→ → →<br>`sentJustification`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "True when justifications have been sent"

- n: "→ → →<br>`sentPrematureCommitment`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "True when premature commitments have been sent"

- n: "→ → →<br>`aborted`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "True if the DKG session has been aborted"

- n: "→ → →<br>`badMembers`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of bad members"

- n: "→ → →<br>`weComplain`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of complaints sent"

- n: "→ → →<br>`receivedContributions`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of contributions received"

- n: "→ → →<br>`receivedComplaints`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of complaints received"

- n: "→ → →<br>`receivedJustifications`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of justifications received"

- n: "→ → →<br>`receivedPrematureCommitments`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Number of premature commitments received"

- n: "→<br>`minableCommitments`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "Object containing minable commitments"
{% enditemplate %}

*Result (if detail level was 1)---JSON DKG details including member index*

Note: detail level 1 includes all level 0 fields and expands the following fields.

{% itemplate ntpd1 %}
- n: "→ → →<br>`badMembers`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "Array containing the member index for each bad member"

- n: "→ → →<br>`weComplain`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "Array containing the member index for each complaint sent"

- n: "→ → →<br>`receivedContributions`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "Array containing the member index for each contribution received"

- n: "→ → →<br>`receivedComplaints`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "Array containing the member index for each complaint received"

- n: "→ → →<br>`receivedJustifications`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "Array containing the member index for each justification received"

- n: "→ → →<br>`receivedPrematureCommitments`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "Array containing the member index for each commitment received"
{% enditemplate %}

*Result (if detail level was 2)---JSON DKG details including member index and ProTx hash*

Note: detail level 2 includes all level 0 fields, adds the `allMembers` field, and expands several fields.

{% itemplate ntpd1 %}
- n: "→ → →<br>`badMembers`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "An array of objects with each object containing the member index and ProTx hash for a bad member"

- n: "→ → → →<br>Member"
  t: "object"
  p: "Required<br>(0 or more)"
  d: "An object describing quorum member details"

- n: "→ → → → →<br>`memberIndex`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The quorum member's index"

- n: "→ → → → →<br>`proTxHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the quorum member's provider registration transaction as hex in RPC byte order"

- n: "→ → →<br>`weComplain`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An array of objects with each object containing the member index and ProTx hash for a member being complained about"

- n: "→ → → →<br>Member"
  t: "object"
  p: "Required<br>(0 or more)"
  d: "An object describing quorum member details"

- n: "→ → → → →<br>`memberIndex`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The quorum member's index"

- n: "→ → → → →<br>`proTxHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the quorum member's provider registration transaction as hex in RPC byte order"

- n: "→ → →<br>`receivedContributions`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An array of objects with each object containing the member index and ProTx hash for a member a contribution was received from"

- n: "→ → → →<br>Member"
  t: "object"
  p: "Required<br>(0 or more)"
  d: "An object describing quorum member details"

- n: "→ → → → →<br>`memberIndex`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The quorum member's index"

- n: "→ → → → →<br>`proTxHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the quorum member's provider registration transaction as hex in RPC byte order"

- n: "→ → →<br>`receivedComplaints`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An array of objects with each object containing the member index and ProTx hash for a member a complaint was received from"

- n: "→ → → →<br>Member"
  t: "object"
  p: "Required<br>(0 or more)"
  d: "An object describing quorum member details"

- n: "→ → → → →<br>`memberIndex`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The quorum member's index"

- n: "→ → → → →<br>`proTxHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the quorum member's provider registration transaction as hex in RPC byte order"

- n: "→ → →<br>`receivedJustifications`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An array of objects with each object containing the member index and ProTx hash for a member a justification was received from"

- n: "→ → → →<br>Member"
  t: "object"
  p: "Required<br>(0 or more)"
  d: "An object describing quorum member details"

- n: "→ → → → →<br>`memberIndex`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The quorum member's index"

- n: "→ → → → →<br>`proTxHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the quorum member's provider registration transaction as hex in RPC byte order"

- n: "→ → →<br>`receivedPrematureCommitments`"
  t: "object"
  p: "Required<br>(exactly 1)"
  d: "An array of objects with each object containing the member index and ProTx hash for a member a premature commitment was received from"

- n: "→ → → →<br>Member"
  t: "object"
  p: "Required<br>(0 or more)"
  d: "An object describing quorum member details"

- n: "→ → → → →<br>`memberIndex`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "The quorum member's index"

- n: "→ → → → →<br>`proTxHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the quorum member's provider registration transaction as hex in RPC byte order"

- n: "→ → →<br>`allMembers`"
  t: "array"
  p: "Required<br>(exactly 1)"
  d: "Array containing the provider registration transaction hash for all quorum members"
{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet quorum dkgstatus
{% endhighlight %}

Result:
{% highlight json %}
{
  "proTxHash": "04d06d16b3eca2f104ef9749d0c1c17d183eb1b4fe3a16808fd70464f03bcd63",
  "time": 1555172494,
  "timeStr": "2019-04-13 16:21:34",
  "session": {
    "llmq_50_60": {
      "llmqType": 1,
      "quorumHash": "000000000122768294b19a5f6750094f6e9caa135c0826372d0538d4ceb910bc",
      "quorumHeight": 79368,
      "phase": 6,
      "sentContributions": true,
      "sentComplaint": true,
      "sentJustification": false,
      "sentPrematureCommitment": true,
      "aborted": false,
      "badMembers": 2,
      "weComplain": 0,
      "receivedContributions": 48,
      "receivedComplaints": 44,
      "receivedJustifications": 0,
      "receivedPrematureCommitments": 44
    }
  },
  "minableCommitments": {
    "llmq_50_60": {
      "version": 1,
      "llmqType": 1,
      "quorumHash": "000000000122768294b19a5f6750094f6e9caa135c0826372d0538d4ceb910bc",
      "signersCount": 0,
      "validMembersCount": 0,
      "quorumPublicKey": "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    }
  }
}
{% endhighlight %}

{% endautocrossref %}

*Example from Dash Core 0.14.0 (detail_level: 1)*

{% highlight bash %}
dash-cli -testnet quorum dkgstatus 1
{% endhighlight %}

Result:
{% highlight json %}
{
  "proTxHash": "04d06d16b3eca2f104ef9749d0c1c17d183eb1b4fe3a16808fd70464f03bcd63",
  "time": 1555172494,
  "timeStr": "2019-04-13 16:21:34",
  "session": {
    "llmq_50_60": {
      "llmqType": 1,
      "quorumHash": "000000000122768294b19a5f6750094f6e9caa135c0826372d0538d4ceb910bc",
      "quorumHeight": 79368,
      "phase": 6,
      "sentContributions": true,
      "sentComplaint": true,
      "sentJustification": false,
      "sentPrematureCommitment": true,
      "aborted": false,
      "badMembers": [
        35,
        42
      ],
      "weComplain": [
      ],
      "receivedContributions": [
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        36,
        37,
        38,
        39,
        40,
        41,
        43,
        44,
        45,
        46,
        47,
        48,
        49
      ],
      "receivedComplaints": [
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        33,
        34,
        36,
        37,
        38,
        39,
        40,
        41,
        43,
        44,
        45,
        46,
        47,
        48,
        49
      ],
      "receivedJustifications": [
      ],
      "receivedPrematureCommitments": [
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        33,
        34,
        36,
        37,
        38,
        39,
        40,
        41,
        43,
        44,
        45,
        46,
        47,
        48,
        49
      ]
    }
  },
  "minableCommitments": {
    "llmq_50_60": {
      "version": 1,
      "llmqType": 1,
      "quorumHash": "000000000122768294b19a5f6750094f6e9caa135c0826372d0538d4ceb910bc",
      "signersCount": 0,
      "validMembersCount": 0,
      "quorumPublicKey": "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    }
  }
}
{% endhighlight %}

*Example from Dash Core 0.14.0 (detail_level: 2)*

{% highlight bash %}
dash-cli -testnet quorum dkgstatus 2
{% endhighlight %}

Result:
{% highlight json %}
{
  "proTxHash": "04d06d16b3eca2f104ef9749d0c1c17d183eb1b4fe3a16808fd70464f03bcd63",
  "time": 1555172494,
  "timeStr": "2019-04-13 16:21:34",
  "session": {
    "llmq_50_60": {
      "llmqType": 1,
      "quorumHash": "000000000122768294b19a5f6750094f6e9caa135c0826372d0538d4ceb910bc",
      "quorumHeight": 79368,
      "phase": 6,
      "sentContributions": true,
      "sentComplaint": true,
      "sentJustification": false,
      "sentPrematureCommitment": true,
      "aborted": false,
      "badMembers": [
        {
          "memberIndex": 35,
          "proTxHash": "c24aea30305d539887223fd923df775644b1d86db0aac8c654026e823b549cd7"
        },
        {
          "memberIndex": 42,
          "proTxHash": "f0567069d4f2a2e536e46173a097b318daf03edef989f6875ca06f5c4d49abc9"
        }
      ],
      "weComplain": [
      ],
      "receivedContributions": [
        {
          "memberIndex": 0,
          "proTxHash": "a6670caf2842a4ae5cb4bb78b3c10343456922b500693f6da043af541d58d9cb"
        },
        {
          "memberIndex": 1,
          "proTxHash": "77c0615fb5eb946f7f731a44eb36dc37ee77bf959e7205937d88186cacfbdc7e"
        },
        {
          "memberIndex": 2,
          "proTxHash": "8070c631ce9ac8850d2e95d4ed7be70171ead22ccd7f4bc9c3aee0a227f323c9"
        },
        {
          "memberIndex": 3,
          "proTxHash": "596be0851532a66037744afa694e4de6485f326f4638e704db93cc726866cda3"
        },
        {
          "memberIndex": 4,
          "proTxHash": "51c11d287dfa85aef3eebb5420834c8e443e01d15c0b0a8e397d67e2e51aa239"
        },
        {
          "memberIndex": 5,
          "proTxHash": "9f4f9f83ecbcd5739d7f1479ee14b508f2414d044a717acba0960566c4e6091d"
        },
        {
          "memberIndex": 6,
          "proTxHash": "21c0923badd20f953360c586edfcbb1a830be83206e30b3f65765f7794f2a640"
        },
        {
          "memberIndex": 7,
          "proTxHash": "cc36055f36345b85a2b8176e79feff0ff822c490691c7f8e8d3348b4b1a1d8ac"
        },
        {
          "memberIndex": 8,
          "proTxHash": "4636ed7acbacbc76aba60aa7a1011688fe9ad5fd701d0bf8fc42a502ea3e6543"
        },
        {
          "memberIndex": 9,
          "proTxHash": "32e5ad5cf9a06eb13e0f65cb7ecde1a93ef24995d07355fac2ff05ebd5b9ddbf"
        },
        {
          "memberIndex": 10,
          "proTxHash": "0022afbe93054ca11ce9b67892661af4558597bacff0ab82bff05a2b4a89ca2d"
        },
        {
          "memberIndex": 11,
          "proTxHash": "2523dc6e034911b9004862e87b4d23a32ed6198aec177915df7893f51cd645bd"
        },
        {
          "memberIndex": 12,
          "proTxHash": "abe5d16432915b201cf6f11299a1abd62e5f69a2c4e8717694d1e42d96dbd580"
        },
        {
          "memberIndex": 13,
          "proTxHash": "f443dd87ec7981e8630ae957f295d9d226d4bd3895f59dbd80b30137a92b3735"
        },
        {
          "memberIndex": 14,
          "proTxHash": "6a5be5c068a0be432b7db0772b25094a59ce1f433dd2df0d410511ac641c3768"
        },
        {
          "memberIndex": 15,
          "proTxHash": "84435c41688c8021a25a644e6b94c9f5159aff5658ee2e12f5cea5c714c21aa3"
        },
        {
          "memberIndex": 16,
          "proTxHash": "2db238aa40837319ca13e27aae4333d1248475546be6cfad985a3785c0ac9bd6"
        },
        {
          "memberIndex": 17,
          "proTxHash": "cefb7c69f75d9fbba21f648c6205bebf9b16325956404c70af03144c1135c7d7"
        },
        {
          "memberIndex": 18,
          "proTxHash": "cc7041c869c7c1c0bae7c137f0cda708ad492bc89c4b8f7a40a353d90335febf"
        },
        {
          "memberIndex": 19,
          "proTxHash": "24e642275f5d5f17f67db502d905153cfd83ffbd3d49c90196ec01200917fb31"
        },
        {
          "memberIndex": 20,
          "proTxHash": "bc5c77926b0ccfcb742123a1edf2c27147888f694701df399982a862309921c8"
        },
        {
          "memberIndex": 21,
          "proTxHash": "04d06d16b3eca2f104ef9749d0c1c17d183eb1b4fe3a16808fd70464f03bcd63"
        },
        {
          "memberIndex": 22,
          "proTxHash": "11eabc1e72394af02bbe86815975d054816fe69006fdc64c6d7a06b585e5c311"
        },
        {
          "memberIndex": 23,
          "proTxHash": "71cf5017c4c5f69db5c17a8cfb4c28ffc14ad1715dba2a83f0c30e534291f828"
        },
        {
          "memberIndex": 24,
          "proTxHash": "d567ac9cc7437848210365a0225271ec26a6a6c7d852544a6e9cbd40756075b3"
        },
        {
          "memberIndex": 25,
          "proTxHash": "16ef804605595f67a0e078f7ffbdd93ac55bcd22d9094cb8b61ef527c48f4c44"
        },
        {
          "memberIndex": 26,
          "proTxHash": "f51b426420ac4c518ad07c2bb03e434389337b4e2977d39233114d5e8ef21f69"
        },
        {
          "memberIndex": 27,
          "proTxHash": "2460848868c210d23c68460050f83f47a7ad00db2c47ad6f223a9b1eb04c8d54"
        },
        {
          "memberIndex": 28,
          "proTxHash": "49d94e4c584929320cfe159faf4f6e398f1b2d1fdaa413c01345ce23870d2ca9"
        },
        {
          "memberIndex": 29,
          "proTxHash": "e8b039ce3f1016b7caf781d1b0efbc11191860ec3b131fc49591402a260ba638"
        },
        {
          "memberIndex": 30,
          "proTxHash": "5ab82a5348b5d4c126b0c172665d364352be37c96ce442e710d4a844a6f80bf9"
        },
        {
          "memberIndex": 31,
          "proTxHash": "05b83104eea971582c803ded305109ecb734b582da93b8e301c6f00d6be6c496"
        },
        {
          "memberIndex": 32,
          "proTxHash": "c98c6303af03f7f3b2673ceece962134088e5dcc3c69a0977069c6201b26dc9b"
        },
        {
          "memberIndex": 33,
          "proTxHash": "f933d592d677f3409274646ddea2ffaaca77dfd4ceab7c54037a04e05fc7ee8b"
        },
        {
          "memberIndex": 34,
          "proTxHash": "5d40e68f65e7263d91e114b644ff7f8c9c376db63550d5ef9bc4228870c4f053"
        },
        {
          "memberIndex": 36,
          "proTxHash": "a36edfac56f7f1b0f58aa793115fbd53d792315857033fb32a862507a3f060ff"
        },
        {
          "memberIndex": 37,
          "proTxHash": "c9d43a69bd9effdaed579edc901c5d848711481047c9cc76bad8232d8f329dcd"
        },
        {
          "memberIndex": 38,
          "proTxHash": "d82152084615c73d79f3eb8b0ec6a61e6d0f94c4cdcf26f773f0e42b72176f6f"
        },
        {
          "memberIndex": 39,
          "proTxHash": "869f7f2054a6ed4241967afb74c3b1a07701d2772b368eb0bbfd2e3365adf6f3"
        },
        {
          "memberIndex": 40,
          "proTxHash": "5f1a70a350d21f673d93fae45a50c0362947366e46c96bade51b7933f0cada3e"
        },
        {
          "memberIndex": 41,
          "proTxHash": "024608d03beb6a6065f14a29a837c68ae449ac1e17056819366ca0b72b6dd81f"
        },
        {
          "memberIndex": 43,
          "proTxHash": "254bcd3b28d696ce9d468cd521e6be3f7eb01da32d8bf9fdf34868baaf09d9e7"
        },
        {
          "memberIndex": 44,
          "proTxHash": "0ae626ed4ee06c1f042b2eaa9669302a2e60a0df8137843b39de53f2c3e265aa"
        },
        {
          "memberIndex": 45,
          "proTxHash": "cfa6f7b58c78f827c15e8f1b6a5a2a3a92140101719006d8226a363e2c0c8e5c"
        },
        {
          "memberIndex": 46,
          "proTxHash": "03811a53a20289799f56227f576915492d2cede48522cd1b3f67c6c89cdacf83"
        },
        {
          "memberIndex": 47,
          "proTxHash": "f989866b2fadb674a1ca63746ff8bb97232d6843c95f9e805b8bc2a5ae8e768d"
        },
        {
          "memberIndex": 48,
          "proTxHash": "9de76b8291d00026ab0af86306023c7b90f8e9229dc04916fe1335bf5e11f15d"
        },
        {
          "memberIndex": 49,
          "proTxHash": "e441bbb2f056d471ae9fad83b4dd0fa691a0574eb4a373a0e59d6108614ee07e"
        }
      ],
      "receivedComplaints": [
        {
          "memberIndex": 0,
          "proTxHash": "a6670caf2842a4ae5cb4bb78b3c10343456922b500693f6da043af541d58d9cb"
        },
        {
          "memberIndex": 1,
          "proTxHash": "77c0615fb5eb946f7f731a44eb36dc37ee77bf959e7205937d88186cacfbdc7e"
        },
        {
          "memberIndex": 2,
          "proTxHash": "8070c631ce9ac8850d2e95d4ed7be70171ead22ccd7f4bc9c3aee0a227f323c9"
        },
        {
          "memberIndex": 3,
          "proTxHash": "596be0851532a66037744afa694e4de6485f326f4638e704db93cc726866cda3"
        },
        {
          "memberIndex": 4,
          "proTxHash": "51c11d287dfa85aef3eebb5420834c8e443e01d15c0b0a8e397d67e2e51aa239"
        },
        {
          "memberIndex": 5,
          "proTxHash": "9f4f9f83ecbcd5739d7f1479ee14b508f2414d044a717acba0960566c4e6091d"
        },
        {
          "memberIndex": 6,
          "proTxHash": "21c0923badd20f953360c586edfcbb1a830be83206e30b3f65765f7794f2a640"
        },
        {
          "memberIndex": 7,
          "proTxHash": "cc36055f36345b85a2b8176e79feff0ff822c490691c7f8e8d3348b4b1a1d8ac"
        },
        {
          "memberIndex": 8,
          "proTxHash": "4636ed7acbacbc76aba60aa7a1011688fe9ad5fd701d0bf8fc42a502ea3e6543"
        },
        {
          "memberIndex": 9,
          "proTxHash": "32e5ad5cf9a06eb13e0f65cb7ecde1a93ef24995d07355fac2ff05ebd5b9ddbf"
        },
        {
          "memberIndex": 10,
          "proTxHash": "0022afbe93054ca11ce9b67892661af4558597bacff0ab82bff05a2b4a89ca2d"
        },
        {
          "memberIndex": 11,
          "proTxHash": "2523dc6e034911b9004862e87b4d23a32ed6198aec177915df7893f51cd645bd"
        },
        {
          "memberIndex": 12,
          "proTxHash": "abe5d16432915b201cf6f11299a1abd62e5f69a2c4e8717694d1e42d96dbd580"
        },
        {
          "memberIndex": 14,
          "proTxHash": "6a5be5c068a0be432b7db0772b25094a59ce1f433dd2df0d410511ac641c3768"
        },
        {
          "memberIndex": 15,
          "proTxHash": "84435c41688c8021a25a644e6b94c9f5159aff5658ee2e12f5cea5c714c21aa3"
        },
        {
          "memberIndex": 16,
          "proTxHash": "2db238aa40837319ca13e27aae4333d1248475546be6cfad985a3785c0ac9bd6"
        },
        {
          "memberIndex": 17,
          "proTxHash": "cefb7c69f75d9fbba21f648c6205bebf9b16325956404c70af03144c1135c7d7"
        },
        {
          "memberIndex": 18,
          "proTxHash": "cc7041c869c7c1c0bae7c137f0cda708ad492bc89c4b8f7a40a353d90335febf"
        },
        {
          "memberIndex": 19,
          "proTxHash": "24e642275f5d5f17f67db502d905153cfd83ffbd3d49c90196ec01200917fb31"
        },
        {
          "memberIndex": 20,
          "proTxHash": "bc5c77926b0ccfcb742123a1edf2c27147888f694701df399982a862309921c8"
        },
        {
          "memberIndex": 21,
          "proTxHash": "04d06d16b3eca2f104ef9749d0c1c17d183eb1b4fe3a16808fd70464f03bcd63"
        },
        {
          "memberIndex": 24,
          "proTxHash": "d567ac9cc7437848210365a0225271ec26a6a6c7d852544a6e9cbd40756075b3"
        },
        {
          "memberIndex": 25,
          "proTxHash": "16ef804605595f67a0e078f7ffbdd93ac55bcd22d9094cb8b61ef527c48f4c44"
        },
        {
          "memberIndex": 26,
          "proTxHash": "f51b426420ac4c518ad07c2bb03e434389337b4e2977d39233114d5e8ef21f69"
        },
        {
          "memberIndex": 27,
          "proTxHash": "2460848868c210d23c68460050f83f47a7ad00db2c47ad6f223a9b1eb04c8d54"
        },
        {
          "memberIndex": 28,
          "proTxHash": "49d94e4c584929320cfe159faf4f6e398f1b2d1fdaa413c01345ce23870d2ca9"
        },
        {
          "memberIndex": 29,
          "proTxHash": "e8b039ce3f1016b7caf781d1b0efbc11191860ec3b131fc49591402a260ba638"
        },
        {
          "memberIndex": 30,
          "proTxHash": "5ab82a5348b5d4c126b0c172665d364352be37c96ce442e710d4a844a6f80bf9"
        },
        {
          "memberIndex": 31,
          "proTxHash": "05b83104eea971582c803ded305109ecb734b582da93b8e301c6f00d6be6c496"
        },
        {
          "memberIndex": 33,
          "proTxHash": "f933d592d677f3409274646ddea2ffaaca77dfd4ceab7c54037a04e05fc7ee8b"
        },
        {
          "memberIndex": 34,
          "proTxHash": "5d40e68f65e7263d91e114b644ff7f8c9c376db63550d5ef9bc4228870c4f053"
        },
        {
          "memberIndex": 36,
          "proTxHash": "a36edfac56f7f1b0f58aa793115fbd53d792315857033fb32a862507a3f060ff"
        },
        {
          "memberIndex": 37,
          "proTxHash": "c9d43a69bd9effdaed579edc901c5d848711481047c9cc76bad8232d8f329dcd"
        },
        {
          "memberIndex": 38,
          "proTxHash": "d82152084615c73d79f3eb8b0ec6a61e6d0f94c4cdcf26f773f0e42b72176f6f"
        },
        {
          "memberIndex": 39,
          "proTxHash": "869f7f2054a6ed4241967afb74c3b1a07701d2772b368eb0bbfd2e3365adf6f3"
        },
        {
          "memberIndex": 40,
          "proTxHash": "5f1a70a350d21f673d93fae45a50c0362947366e46c96bade51b7933f0cada3e"
        },
        {
          "memberIndex": 41,
          "proTxHash": "024608d03beb6a6065f14a29a837c68ae449ac1e17056819366ca0b72b6dd81f"
        },
        {
          "memberIndex": 43,
          "proTxHash": "254bcd3b28d696ce9d468cd521e6be3f7eb01da32d8bf9fdf34868baaf09d9e7"
        },
        {
          "memberIndex": 44,
          "proTxHash": "0ae626ed4ee06c1f042b2eaa9669302a2e60a0df8137843b39de53f2c3e265aa"
        },
        {
          "memberIndex": 45,
          "proTxHash": "cfa6f7b58c78f827c15e8f1b6a5a2a3a92140101719006d8226a363e2c0c8e5c"
        },
        {
          "memberIndex": 46,
          "proTxHash": "03811a53a20289799f56227f576915492d2cede48522cd1b3f67c6c89cdacf83"
        },
        {
          "memberIndex": 47,
          "proTxHash": "f989866b2fadb674a1ca63746ff8bb97232d6843c95f9e805b8bc2a5ae8e768d"
        },
        {
          "memberIndex": 48,
          "proTxHash": "9de76b8291d00026ab0af86306023c7b90f8e9229dc04916fe1335bf5e11f15d"
        },
        {
          "memberIndex": 49,
          "proTxHash": "e441bbb2f056d471ae9fad83b4dd0fa691a0574eb4a373a0e59d6108614ee07e"
        }
      ],
      "receivedJustifications": [
      ],
      "receivedPrematureCommitments": [
        {
          "memberIndex": 0,
          "proTxHash": "a6670caf2842a4ae5cb4bb78b3c10343456922b500693f6da043af541d58d9cb"
        },
        {
          "memberIndex": 1,
          "proTxHash": "77c0615fb5eb946f7f731a44eb36dc37ee77bf959e7205937d88186cacfbdc7e"
        },
        {
          "memberIndex": 2,
          "proTxHash": "8070c631ce9ac8850d2e95d4ed7be70171ead22ccd7f4bc9c3aee0a227f323c9"
        },
        {
          "memberIndex": 3,
          "proTxHash": "596be0851532a66037744afa694e4de6485f326f4638e704db93cc726866cda3"
        },
        {
          "memberIndex": 4,
          "proTxHash": "51c11d287dfa85aef3eebb5420834c8e443e01d15c0b0a8e397d67e2e51aa239"
        },
        {
          "memberIndex": 5,
          "proTxHash": "9f4f9f83ecbcd5739d7f1479ee14b508f2414d044a717acba0960566c4e6091d"
        },
        {
          "memberIndex": 6,
          "proTxHash": "21c0923badd20f953360c586edfcbb1a830be83206e30b3f65765f7794f2a640"
        },
        {
          "memberIndex": 7,
          "proTxHash": "cc36055f36345b85a2b8176e79feff0ff822c490691c7f8e8d3348b4b1a1d8ac"
        },
        {
          "memberIndex": 8,
          "proTxHash": "4636ed7acbacbc76aba60aa7a1011688fe9ad5fd701d0bf8fc42a502ea3e6543"
        },
        {
          "memberIndex": 9,
          "proTxHash": "32e5ad5cf9a06eb13e0f65cb7ecde1a93ef24995d07355fac2ff05ebd5b9ddbf"
        },
        {
          "memberIndex": 10,
          "proTxHash": "0022afbe93054ca11ce9b67892661af4558597bacff0ab82bff05a2b4a89ca2d"
        },
        {
          "memberIndex": 11,
          "proTxHash": "2523dc6e034911b9004862e87b4d23a32ed6198aec177915df7893f51cd645bd"
        },
        {
          "memberIndex": 12,
          "proTxHash": "abe5d16432915b201cf6f11299a1abd62e5f69a2c4e8717694d1e42d96dbd580"
        },
        {
          "memberIndex": 14,
          "proTxHash": "6a5be5c068a0be432b7db0772b25094a59ce1f433dd2df0d410511ac641c3768"
        },
        {
          "memberIndex": 15,
          "proTxHash": "84435c41688c8021a25a644e6b94c9f5159aff5658ee2e12f5cea5c714c21aa3"
        },
        {
          "memberIndex": 16,
          "proTxHash": "2db238aa40837319ca13e27aae4333d1248475546be6cfad985a3785c0ac9bd6"
        },
        {
          "memberIndex": 17,
          "proTxHash": "cefb7c69f75d9fbba21f648c6205bebf9b16325956404c70af03144c1135c7d7"
        },
        {
          "memberIndex": 18,
          "proTxHash": "cc7041c869c7c1c0bae7c137f0cda708ad492bc89c4b8f7a40a353d90335febf"
        },
        {
          "memberIndex": 19,
          "proTxHash": "24e642275f5d5f17f67db502d905153cfd83ffbd3d49c90196ec01200917fb31"
        },
        {
          "memberIndex": 20,
          "proTxHash": "bc5c77926b0ccfcb742123a1edf2c27147888f694701df399982a862309921c8"
        },
        {
          "memberIndex": 21,
          "proTxHash": "04d06d16b3eca2f104ef9749d0c1c17d183eb1b4fe3a16808fd70464f03bcd63"
        },
        {
          "memberIndex": 24,
          "proTxHash": "d567ac9cc7437848210365a0225271ec26a6a6c7d852544a6e9cbd40756075b3"
        },
        {
          "memberIndex": 25,
          "proTxHash": "16ef804605595f67a0e078f7ffbdd93ac55bcd22d9094cb8b61ef527c48f4c44"
        },
        {
          "memberIndex": 26,
          "proTxHash": "f51b426420ac4c518ad07c2bb03e434389337b4e2977d39233114d5e8ef21f69"
        },
        {
          "memberIndex": 27,
          "proTxHash": "2460848868c210d23c68460050f83f47a7ad00db2c47ad6f223a9b1eb04c8d54"
        },
        {
          "memberIndex": 28,
          "proTxHash": "49d94e4c584929320cfe159faf4f6e398f1b2d1fdaa413c01345ce23870d2ca9"
        },
        {
          "memberIndex": 29,
          "proTxHash": "e8b039ce3f1016b7caf781d1b0efbc11191860ec3b131fc49591402a260ba638"
        },
        {
          "memberIndex": 30,
          "proTxHash": "5ab82a5348b5d4c126b0c172665d364352be37c96ce442e710d4a844a6f80bf9"
        },
        {
          "memberIndex": 31,
          "proTxHash": "05b83104eea971582c803ded305109ecb734b582da93b8e301c6f00d6be6c496"
        },
        {
          "memberIndex": 33,
          "proTxHash": "f933d592d677f3409274646ddea2ffaaca77dfd4ceab7c54037a04e05fc7ee8b"
        },
        {
          "memberIndex": 34,
          "proTxHash": "5d40e68f65e7263d91e114b644ff7f8c9c376db63550d5ef9bc4228870c4f053"
        },
        {
          "memberIndex": 36,
          "proTxHash": "a36edfac56f7f1b0f58aa793115fbd53d792315857033fb32a862507a3f060ff"
        },
        {
          "memberIndex": 37,
          "proTxHash": "c9d43a69bd9effdaed579edc901c5d848711481047c9cc76bad8232d8f329dcd"
        },
        {
          "memberIndex": 38,
          "proTxHash": "d82152084615c73d79f3eb8b0ec6a61e6d0f94c4cdcf26f773f0e42b72176f6f"
        },
        {
          "memberIndex": 39,
          "proTxHash": "869f7f2054a6ed4241967afb74c3b1a07701d2772b368eb0bbfd2e3365adf6f3"
        },
        {
          "memberIndex": 40,
          "proTxHash": "5f1a70a350d21f673d93fae45a50c0362947366e46c96bade51b7933f0cada3e"
        },
        {
          "memberIndex": 41,
          "proTxHash": "024608d03beb6a6065f14a29a837c68ae449ac1e17056819366ca0b72b6dd81f"
        },
        {
          "memberIndex": 43,
          "proTxHash": "254bcd3b28d696ce9d468cd521e6be3f7eb01da32d8bf9fdf34868baaf09d9e7"
        },
        {
          "memberIndex": 44,
          "proTxHash": "0ae626ed4ee06c1f042b2eaa9669302a2e60a0df8137843b39de53f2c3e265aa"
        },
        {
          "memberIndex": 45,
          "proTxHash": "cfa6f7b58c78f827c15e8f1b6a5a2a3a92140101719006d8226a363e2c0c8e5c"
        },
        {
          "memberIndex": 46,
          "proTxHash": "03811a53a20289799f56227f576915492d2cede48522cd1b3f67c6c89cdacf83"
        },
        {
          "memberIndex": 47,
          "proTxHash": "f989866b2fadb674a1ca63746ff8bb97232d6843c95f9e805b8bc2a5ae8e768d"
        },
        {
          "memberIndex": 48,
          "proTxHash": "9de76b8291d00026ab0af86306023c7b90f8e9229dc04916fe1335bf5e11f15d"
        },
        {
          "memberIndex": 49,
          "proTxHash": "e441bbb2f056d471ae9fad83b4dd0fa691a0574eb4a373a0e59d6108614ee07e"
        }
      ],
      "allMembers": [
        "a6670caf2842a4ae5cb4bb78b3c10343456922b500693f6da043af541d58d9cb",
        "77c0615fb5eb946f7f731a44eb36dc37ee77bf959e7205937d88186cacfbdc7e",
        "8070c631ce9ac8850d2e95d4ed7be70171ead22ccd7f4bc9c3aee0a227f323c9",
        "596be0851532a66037744afa694e4de6485f326f4638e704db93cc726866cda3",
        "51c11d287dfa85aef3eebb5420834c8e443e01d15c0b0a8e397d67e2e51aa239",
        "9f4f9f83ecbcd5739d7f1479ee14b508f2414d044a717acba0960566c4e6091d",
        "21c0923badd20f953360c586edfcbb1a830be83206e30b3f65765f7794f2a640",
        "cc36055f36345b85a2b8176e79feff0ff822c490691c7f8e8d3348b4b1a1d8ac",
        "4636ed7acbacbc76aba60aa7a1011688fe9ad5fd701d0bf8fc42a502ea3e6543",
        "32e5ad5cf9a06eb13e0f65cb7ecde1a93ef24995d07355fac2ff05ebd5b9ddbf",
        "0022afbe93054ca11ce9b67892661af4558597bacff0ab82bff05a2b4a89ca2d",
        "2523dc6e034911b9004862e87b4d23a32ed6198aec177915df7893f51cd645bd",
        "abe5d16432915b201cf6f11299a1abd62e5f69a2c4e8717694d1e42d96dbd580",
        "f443dd87ec7981e8630ae957f295d9d226d4bd3895f59dbd80b30137a92b3735",
        "6a5be5c068a0be432b7db0772b25094a59ce1f433dd2df0d410511ac641c3768",
        "84435c41688c8021a25a644e6b94c9f5159aff5658ee2e12f5cea5c714c21aa3",
        "2db238aa40837319ca13e27aae4333d1248475546be6cfad985a3785c0ac9bd6",
        "cefb7c69f75d9fbba21f648c6205bebf9b16325956404c70af03144c1135c7d7",
        "cc7041c869c7c1c0bae7c137f0cda708ad492bc89c4b8f7a40a353d90335febf",
        "24e642275f5d5f17f67db502d905153cfd83ffbd3d49c90196ec01200917fb31",
        "bc5c77926b0ccfcb742123a1edf2c27147888f694701df399982a862309921c8",
        "04d06d16b3eca2f104ef9749d0c1c17d183eb1b4fe3a16808fd70464f03bcd63",
        "11eabc1e72394af02bbe86815975d054816fe69006fdc64c6d7a06b585e5c311",
        "71cf5017c4c5f69db5c17a8cfb4c28ffc14ad1715dba2a83f0c30e534291f828",
        "d567ac9cc7437848210365a0225271ec26a6a6c7d852544a6e9cbd40756075b3",
        "16ef804605595f67a0e078f7ffbdd93ac55bcd22d9094cb8b61ef527c48f4c44",
        "f51b426420ac4c518ad07c2bb03e434389337b4e2977d39233114d5e8ef21f69",
        "2460848868c210d23c68460050f83f47a7ad00db2c47ad6f223a9b1eb04c8d54",
        "49d94e4c584929320cfe159faf4f6e398f1b2d1fdaa413c01345ce23870d2ca9",
        "e8b039ce3f1016b7caf781d1b0efbc11191860ec3b131fc49591402a260ba638",
        "5ab82a5348b5d4c126b0c172665d364352be37c96ce442e710d4a844a6f80bf9",
        "05b83104eea971582c803ded305109ecb734b582da93b8e301c6f00d6be6c496",
        "c98c6303af03f7f3b2673ceece962134088e5dcc3c69a0977069c6201b26dc9b",
        "f933d592d677f3409274646ddea2ffaaca77dfd4ceab7c54037a04e05fc7ee8b",
        "5d40e68f65e7263d91e114b644ff7f8c9c376db63550d5ef9bc4228870c4f053",
        "c24aea30305d539887223fd923df775644b1d86db0aac8c654026e823b549cd7",
        "a36edfac56f7f1b0f58aa793115fbd53d792315857033fb32a862507a3f060ff",
        "c9d43a69bd9effdaed579edc901c5d848711481047c9cc76bad8232d8f329dcd",
        "d82152084615c73d79f3eb8b0ec6a61e6d0f94c4cdcf26f773f0e42b72176f6f",
        "869f7f2054a6ed4241967afb74c3b1a07701d2772b368eb0bbfd2e3365adf6f3",
        "5f1a70a350d21f673d93fae45a50c0362947366e46c96bade51b7933f0cada3e",
        "024608d03beb6a6065f14a29a837c68ae449ac1e17056819366ca0b72b6dd81f",
        "f0567069d4f2a2e536e46173a097b318daf03edef989f6875ca06f5c4d49abc9",
        "254bcd3b28d696ce9d468cd521e6be3f7eb01da32d8bf9fdf34868baaf09d9e7",
        "0ae626ed4ee06c1f042b2eaa9669302a2e60a0df8137843b39de53f2c3e265aa",
        "cfa6f7b58c78f827c15e8f1b6a5a2a3a92140101719006d8226a363e2c0c8e5c",
        "03811a53a20289799f56227f576915492d2cede48522cd1b3f67c6c89cdacf83",
        "f989866b2fadb674a1ca63746ff8bb97232d6843c95f9e805b8bc2a5ae8e768d",
        "9de76b8291d00026ab0af86306023c7b90f8e9229dc04916fe1335bf5e11f15d",
        "e441bbb2f056d471ae9fad83b4dd0fa691a0574eb4a373a0e59d6108614ee07e"
      ]
    }
  },
  "minableCommitments": {
    "llmq_50_60": {
      "version": 1,
      "llmqType": 1,
      "quorumHash": "000000000122768294b19a5f6750094f6e9caa135c0826372d0538d4ceb910bc",
      "signersCount": 0,
      "validMembersCount": 0,
      "quorumPublicKey": "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    }
  }
}
{% endhighlight %}

###### Quorum<!--noref--> Sign
<!-- no subhead-links here -->

{% autocrossref %}

The `quorum<!--noref--> sign` RPC requests threshold-signing for a message.

![Warning icon](/img/icons/icon_warning.svg) Note: Used for RegTest testing only.

*Parameter #1---LLMQ Type*

{% itemplate ntpd1 %}
- n: "`llmqType`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "[Type of quorum](https://github.com/dashpay/dips/blob/master/dip-0006.md#current-llmq<!--noref-->-types):<br>`1` - LLMQ_50_60<br>`2` - LLMQ_400_60<br>`3` - LLMQ_400_85"
{% enditemplate %}

*Parameter #2---id*

{% itemplate ntpd1 %}
- n: "`id`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Signing request ID"
{% enditemplate %}

*Parameter #3---message hash*

{% itemplate ntpd1 %}
- n: "`msgHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the message to be signed"
{% enditemplate %}

*Result---status*

{% itemplate ntpd1 %}
- n: "result"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "True or false depending on success"

{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet quorum sign 1 \
  "abcd1234abcd1234abcd1234abcd1234abcd1234abcd1234abcd1234abcd1234" \
  "51c11d287dfa85aef3eebb5420834c8e443e01d15c0b0a8e397d67e2e51aa239"
{% endhighlight %}

Result:
{% highlight json %}
false
{% endhighlight %}

{% endautocrossref %}

###### Quorum<!--noref--> GetRecSig
<!-- no subhead-links here -->

{% autocrossref %}

The `quorum<!--noref--> getrecsig` RPC checks gets the recovered signature for a previous threshold-signing message request.

*Parameter #1---LLMQ Type*

{% itemplate ntpd1 %}
- n: "`llmqType`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "[Type of quorum](https://github.com/dashpay/dips/blob/master/dip-0006.md#current-llmq<!--noref-->-types):<br>`1` - LLMQ_50_60<br>`2` - LLMQ_400_60<br>`3` - LLMQ_400_85"
{% enditemplate %}

*Parameter #2---id*

{% itemplate ntpd1 %}
- n: "`id`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Signing request ID"
{% enditemplate %}

*Parameter #3---message hash*

{% itemplate ntpd1 %}
- n: "`msgHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the message to be signed"
{% enditemplate %}

*Result---recovered signature*

{% itemplate ntpd1 %}
- n: "result"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Recovered signature details"

- n: "→<br>`llmqType`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "[Type of quorum](https://github.com/dashpay/dips/blob/master/dip-0006.md#current-llmq<!--noref-->-types):<br>`1` - LLMQ_50_60<br>`2` - LLMQ_400_60<br>`3` - LLMQ_400_85"

- n: "→<br>`quorumHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The block hash of the quorum"  

- n: "→<br>`id`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The signing session ID"

- n: "→<br>`msgHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The message hash"

- n: "→<br>`sig`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The recovered signature"

- n: "→<br>`hash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the recovered signature"
{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet quorum getrecsig 1 \
  "e980ebf295b42f24b03321ffb255818753b2b211e8c46b61c0b6fde91242d12f" \
  "907087d4720850e639b7b5cc41d7a6d020e5a50debb3bc3974f0cb3d7d378ea4"
{% endhighlight %}

Result:
{% highlight json %}
{
  "llmqType": 1,
  "quorumHash": "00000000008344da08e4d262773ea545472fbf625f78b3ebfe5fc067c33b1d22",
  "id": "e980ebf295b42f24b03321ffb255818753b2b211e8c46b61c0b6fde91242d12f",
  "msgHash": "907087d4720850e639b7b5cc41d7a6d020e5a50debb3bc3974f0cb3d7d378ea4",
  "sig": "1365171c408d686af2ca8f5fae91cdf9cf0b5eec60b0b161b9288a1c68e2cd68f225495a787415c924c5953a6282d131178aa6baf4c2673d19549fc627740cf71d295f8a38b9970525a7f248d54a548e16da285b5c1f3ec0740ad40edbcc8615",
  "hash": "d9b7f7904746fbb3eeaeec36fadc79b351f6a854cd22ee9e607592aee972fcb2"
}
{% endhighlight %}

{% endautocrossref %}

###### Quorum<!--noref--> HasRecSig
<!-- no subhead-links here -->

{% autocrossref %}

The `quorum<!--noref--> hasrecsig` RPC checks for a recovered signature for a previous threshold-signing message request.

![Warning icon](/img/icons/icon_warning.svg) Note: Used for RegTest testing only.

*Parameter #1---LLMQ Type*

{% itemplate ntpd1 %}
- n: "`llmqType`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "[Type of quorum](https://github.com/dashpay/dips/blob/master/dip-0006.md#current-llmq<!--noref-->-types):<br>`1` - LLMQ_50_60<br>`2` - LLMQ_400_60<br>`3` - LLMQ_400_85"
{% enditemplate %}

*Parameter #2---id*

{% itemplate ntpd1 %}
- n: "`id`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Signing request ID"
{% enditemplate %}

*Parameter #3---message hash*

{% itemplate ntpd1 %}
- n: "`msgHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the message to be signed"
{% enditemplate %}

*Result---status*

{% itemplate ntpd1 %}
- n: "result"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "True or false depending on success"

{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet quorum hasrecsig 1 \
  "e980ebf295b42f24b03321ffb255818753b2b211e8c46b61c0b6fde91242d12f" \
  "907087d4720850e639b7b5cc41d7a6d020e5a50debb3bc3974f0cb3d7d378ea4"
{% endhighlight %}

Result:
{% highlight json %}
true
{% endhighlight %}

{% endautocrossref %}

###### Quorum<!--noref--> IsConflicting
<!-- no subhead-links here -->

{% autocrossref %}

The `quorum<!--noref--> isconflicting` RPC checks if there is a conflict for a threshold-signing message request.

![Warning icon](/img/icons/icon_warning.svg) Note: Used for RegTest testing only.

*Parameter #1---LLMQ Type*

{% itemplate ntpd1 %}
- n: "`llmqType`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "[Type of quorum](https://github.com/dashpay/dips/blob/master/dip-0006.md#current-llmq<!--noref-->-types):<br>`1` - LLMQ_50_60<br>`2` - LLMQ_400_60<br>`3` - LLMQ_400_85"
{% enditemplate %}

*Parameter #2---id*

{% itemplate ntpd1 %}
- n: "`id`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Signing request ID"
{% enditemplate %}

*Parameter #3---message hash*

{% itemplate ntpd1 %}
- n: "`msgHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Hash of the message to be signed"
{% enditemplate %}

*Result---status*

{% itemplate ntpd1 %}
- n: "result"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "True or false depending on success"

{% enditemplate %}

*Example from Dash Core 0.14.0*

{% highlight bash %}
dash-cli -testnet quorum isconflicting 1 \
  "e980ebf295b42f24b03321ffb255818753b2b211e8c46b61c0b6fde91242d12f" \
  "907087d4720850e639b7b5cc41d7a6d020e5a50debb3bc3974f0cb3d7d378ea4"
{% endhighlight %}

Result:
{% highlight json %}
false
{% endhighlight %}

{% endautocrossref %}


###### Quorum<!--noref--> MemberOf
<!-- no subhead-links here -->

{% autocrossref %}

The `quorum` RPC checks which quorums the given masternode is a member of.

*Parameter #1---proTxHash*

{% itemplate ntpd1 %}
- n: "proTxHash"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "ProTxHash of the masternode."
{% enditemplate %}

*Parameter #2---scanQuorumsCount*

{% itemplate ntpd1 %}
- n: "scanQuorumsCount"
  t: "number"
  p: "Optional"
  d: "Number of quorums to scan for. If not specified, the active quorum count for each specific quorum type is used."
{% enditemplate %}

*Result---list of quorums the masternode is a member of*

{% itemplate ntpd1 %}
- n: "`result`"
  t: "Array of objects"
  p: "Required<br>(exactly 1)"
  d: "Array containing info for quorum's the masternode belongs to"

- n: "→<br>Quorum"
  t: "object"
  p: "Required<br>(0 or more)"
  d: "An object describing quorum details"

- n: "→ →<br>`height`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Block height of the quorum"

- n: "→ →<br>`type`"
  t: "string"
  p: "Required<br>(exactly 1)"
  d: "[Type of quorum](https://github.com/dashpay/dips/blob/master/dip-0006.md#current-llmq<!--noref-->-types)"

- n: "→ →<br>`quorumHash`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the quorum"

- n: "→ →<br>`minedBlock`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "The hash of the block that established the quorum"

- n: "→ →<br>`quorumPublicKey`"
  t: "string (hex)"
  p: "Required<br>(exactly 1)"
  d: "Quorum public key"

- n: "→ →<br>`isValidMember`"
  t: "bool"
  p: "Required<br>(exactly 1)"
  d: "Indicates if the member is valid"

- n: "→ →<br>`memberIndex`"
  t: "number"
  p: "Required<br>(exactly 1)"
  d: "Index of the member within the quorum"
{% enditemplate %}

*Example from Dash Core 0.14.1*

{% highlight bash %}
dash-cli -testnet quorum memberof 1 \
  39c07d2c9c6d0ead56f52726b63c15e295cb5c3ecf7fe1fefcfb23b2e3cfed1f 1
{% endhighlight %}

Result:
{% highlight json %}
[
  {
    "height": 72000,
    "type": "llmq_400_60",
    "quorumHash": "0000000007697fd69a799bfa26576a177e817bc0e45b9fcfbf48b362b05aeff2",
    "minedBlock": "00000000014d910dca80944b52aa3f522d5604254043b8354d641912aace4343",
    "quorumPublicKey": "03a3fbbe99d80a9be8fc59fd4fe43dfbeba9119b688e97493664716cdf15ae47fad70fea7cb93f20fba10d689f9e3c02",
    "isValidMember": true,
    "memberIndex": 80
  }
]
{% endhighlight %}

*See also: none*

{% endautocrossref %}
