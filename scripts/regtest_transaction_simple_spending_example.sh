#!/bin/bash
RPCUSER="user"
RPCPWD="pass"
REGTEST_CMD="dash-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPWD"

# SIMPLE SPENDING EXAMPLE
# -----------------------

BLOCKTOGEN=101
printf "\nGenerating %s block(s)...\n" $BLOCKTOGEN
COMMAND="$REGTEST_CMD generate $BLOCKTOGEN"
echo $COMMAND
GENERATED=$($COMMAND)
echo "Generated $BLOCKTOGEN block(s)"

printf "\nChecking balance...\n"
COMMAND="$REGTEST_CMD getbalance"
echo $COMMAND
BALANCE=$($COMMAND)
echo "Balance is: " $BALANCE

printf "\nGetting new address...\n"
COMMAND="$REGTEST_CMD getnewaddress"
echo $COMMAND
NEW_ADDRESS=$($COMMAND)
echo "New address is: " $NEW_ADDRESS

printf "\nSending to address...\n"
COMMAND="$REGTEST_CMD sendtoaddress $NEW_ADDRESS 10.00"
echo $COMMAND
TXID=$($COMMAND)
echo "Transaction ID (TXID) is: " $TXID

printf "\nList unspent...\n"
COMMAND="$REGTEST_CMD listunspent"
echo $COMMAND
UNSPENT=$($COMMAND)
echo "Unspent (excluding unconfirmed): " $UNSPENT

printf "\nList unspent (unconfirmed)...\n"
COMMAND="$REGTEST_CMD listunspent 0"
echo $COMMAND
UNSPENT=$($COMMAND)
echo "Unspent (including unconfirmed): " $UNSPENT


BLOCKTOGEN=1
printf "\nGenerating %s block(s) to confirm...\n" $BLOCKTOGEN
COMMAND="$REGTEST_CMD generate $BLOCKTOGEN"
echo $COMMAND
GENERATED=$($COMMAND)
echo "Generated $BLOCKTOGEN block(s)"

printf "\nList unspent...\n"
COMMAND="$REGTEST_CMD listunspent"
echo $COMMAND
UNSPENT=$($COMMAND)
echo "Unspent (excluding unconfirmed): " $UNSPENT

unset REGTEST_CMD
unset BLOCKTOGEN
unset COMMAND
unset GENERATED
unset BALANCE
unset NEW_ADDRESS
unset TXID
unset UNSPENT
