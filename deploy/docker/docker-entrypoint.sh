#!/bin/bash
set -e

if [[ "$1" == "tokenpayd" ]]; then
	mkdir -p "$TOKENPAY_DATA"

	if [[ ! -s "$TOKENPAY_DATA/tokenpay.conf" ]]; then
		cat <<-EOF > "$TOKENPAY_DATA/tokenpay.conf"
		printtoconsole=1
		rpcallowip=*
		txindex=1
		rpcpassword=${TOKENPAY_RPC_PASSWORD:-password}
		rpcuser=${TOKENPAY_RPC_USER:-tokenpay}
		EOF
		chown tokenpay:tokenpay "$TOKENPAY_DATA/tokenpay.conf"
	fi

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R tokenpay "$TOKENPAY_DATA"
	ln -sfn "$TOKENPAY_DATA" /home/tokenpay/.tokenpay
	chown -h tokenpay:tokenpay /home/tokenpay/.tokenpay

	exec gosu tokenpay "$@"
fi

exec "$@"
