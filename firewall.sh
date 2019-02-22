#!/bin/sh

TABLE=f3nsub

# get networks
networks=$(curl -s https://sub.f3netze.de/api.php?query=allowed | jq -r '.[].ip')

if [ -z "$networks" ]; then
	echo "ERROR: Got no networks!" >&2
	exit 1
fi

# empty table
ip -6 route flush table "$TABLE"

# insert 'throw' route for every allowed subnet for both directions
for net in $networks; do
	ip -6 route add throw "$net" table "$TABLE"
	ip -6 route add throw default from "$net" table "$TABLE"
done

# prohibit everything else
ip -6 route add prohibit default table "$TABLE"
