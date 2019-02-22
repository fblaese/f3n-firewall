# F3 Netze Firewall

Mit diesem Tool kann die f3nsub API verwendet werden, um nicht verteilte Netze zu blockieren.


## Verwendung

- Routingtabelle anlegen
	```
	vim /etc/iproute2/rt_tables

	[..]
	200	f3nsub
	```

- Passende rules anlegen, die **vor** den normalen rules für das richtige Routing greifen
	```
	post-up ip -6 rule add from 2a0b:f4c0::/40 pref 500 lookup f3nsub
	pre-down ip -6 rule del from 2a0b:f4c0::/40 pref 500 lookup f3nsub
	post-up ip -6 rule add to 2a0b:f4c0::/40 pref 500 lookup f3nsub
	pre-down ip -6 rule del to 2a0b:f4c0::/40 pref 500 lookup f3nsub
	```

- f3n-firewall klonen
	```
	git clone https://github.com/fblaese/f3n-firewall.git
	```

- Cronjob (als User root) einrichten, der alle 10 Minuten das Firewall Skript aufruft
	```
	*/10 *  * * *  /root/f3n-firewall/firewall.sh
	```
