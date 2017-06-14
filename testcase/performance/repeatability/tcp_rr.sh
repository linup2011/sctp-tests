Name="sctp repeatability - tcp-rr" # Case Name, demand
Topo="netns_cs" # Optional
source ./librpt.sh

do_setup()
{
	rpt_env_init
        st_s_run netserver
}

do_clean()
{
	st_s_run pkill netserver
}

do_test()
{
	LOG_DIR="rpt-tcp-rr"

	st_log INFO "Test case 1: RR TCP"
	LOG_PREFIX="rr-tcp"
	NETEM=""
	NETPERF_PARAMS="$NETPERF_BASE -t TCP_RR \
			-H ${st_s_ip4[0]} -L ${st_c_ip4[0]} \
			-- -m 1024"
	rpt_test

	st_log INFO "Test case 3: RR TCP IPv6"
	LOG_PREFIX="rr-tcp-ipv6"
	NETEM=""
	NETPERF_PARAMS="$NETPERF_BASE -t TCP_RR -6 \
			-H ${st_s_ip6[0]} -L ${st_c_ip6[0]} \
			-- -6 -m 1024"
	rpt_test

	st_log INFO "Test case 1: RR 20ms TCP"
	LOG_PREFIX="rr-20ms-tcp"
	NETEM="delay 20ms"
	NETPERF_PARAMS="$NETPERF_BASE -t TCP_RR \
			-H ${st_s_ip4[0]} -L ${st_c_ip4[0]} \
			-- -m 1024"
	rpt_test

	st_log INFO "Test case 3: RR 20ms TCP IPv6"
	LOG_PREFIX="rr-20ms-tcp-ipv6"
	NETEM="delay 20ms"
	NETPERF_PARAMS="$NETPERF_BASE -t TCP_RR -6 \
			-H ${st_s_ip6[0]} -L ${st_c_ip6[0]} \
			-- -6 -m 1024"
	rpt_test
}
