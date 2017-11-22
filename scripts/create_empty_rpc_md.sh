#!/bin/bash
#echo "$# parameters"
#echo "$@";

PARAMCOUNT=$#
#echo "$PARAMCOUNT parameters"

if [ "$PARAMCOUNT" == 1 ]; then
	FILENAME=${1,,}.md
	RPCNAME=$1

	echo "{% comment %}" >> $FILENAME
	echo "This file is licensed under the MIT License (MIT) available on" >> $FILENAME
	echo "http://opensource.org/licenses/MIT." >> $FILENAME
	echo "{% endcomment %}" >> $FILENAME
	echo '{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/'$FILENAME'" %}' >> $FILENAME
	echo "" >> $FILENAME

	echo "##### $RPCNAME" >> $FILENAME
	echo "{% include helpers/subhead-links.md %}" >> $FILENAME
	echo "" >> $FILENAME
	echo "{% assign summary_${RPCNAME,}=\"\""" %}" >> $FILENAME
	echo "" >> $FILENAME
	echo "{% autocrossref %}" >> $FILENAME
	echo "" >> $FILENAME
	echo "The \`${RPCNAME,,}\` RPC {{summary_${RPCNAME,}}}" >> $FILENAME
	echo "" >> $FILENAME

	# Parameters
	echo "*Parameter #1---PARAMETER DESCRIPTION*" >> $FILENAME
	echo "" >> $FILENAME

	# Results
	echo "*Result---RESULT DESCRIPTION*" >> $FILENAME
	echo "" >> $FILENAME

	echo "*Example from Dash Core 0.12.2*" >> $FILENAME
	echo "" >> $FILENAME

	# Example
	echo "{% highlight bash %}" >> $FILENAME
	echo "dash-cli -testnet ${RPCNAME,,}" >> $FILENAME
	echo "{% endhighlight %}" >> $FILENAME
	echo "" >> $FILENAME
	
	# Example results
	echo "Result:" >> $FILENAME
	echo "{% highlight json %}" >> $FILENAME
	echo "	*INSERT RESULTS HERE*" >> $FILENAME
	echo "{% endhighlight %}" >> $FILENAME
	echo "" >> $FILENAME

	echo "*See also:*" >> $FILENAME
	echo "" >> $FILENAME

	echo "{% endautocrossref %}" >> $FILENAME

	cat $FILENAME

	echo " "
	echo "Next copy the created file ('$FILENAME') to ../_includes/devdoc/dash-core/rpcs/rpcs"
	echo "Then update _autocrossref.yaml, _config.yaml, _includes/references.md, en/developer-reference.md, and rpcs/quick-reference.md"
else
	echo "Incorrect number of parameters (Should be exactly 1)"
	echo "Usage: create_empty_rpc_md RPCNAME"
	echo "Example: create_empty_rpc_md GetBlock"
fi

#This file is licensed under the MIT License (MIT) available on
#http://opensource.org/licenses/MIT.
#{% endcomment %}
#{% assign filename="_includes/devdoc/dash-core/rpcs/rpcs/getaddressutxos.md" %}#
#
###### GetAddressUtxos
#{% include helpers/subhead-links.md %}
#
#{% autocrossref %}
#
#{% assign summary_getAddressUtxos="" %}
#
#
#{% endautocrossref %}
