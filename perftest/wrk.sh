wrk -t1 -c1 -d1m http://localhost:8089/ \
	&& sleep 5 \
	&& wrk -t2 -c2 -d1m http://localhost:8089/ \
	&& sleep 5 \
	&& wrk -t4 -c4 -d1m http://localhost:8089/ \
	&& sleep 5 \
	&& wrk -t4 -c8 -d1m http://localhost:8089/ \
	&& sleep 5 \
	&& wrk -t8 -c8 -d1m http://localhost:8089/ \
	&& sleep 5 \
	&& wrk -t8 -c16 -d1m http://localhost:8089/ \
	&& echo "Testing proxy_pass" \
	&& sleep 5 \
	&& wrk -t1 -c1 -d1m http://localhost:8080/http \
	&& sleep 5 \
	&& wrk -t2 -c2 -d1m http://localhost:8080/http \
	&& sleep 5 \
	&& wrk -t4 -c4 -d1m http://localhost:8080/http \
	&& sleep 5 \
	&& wrk -t4 -c8 -d1m http://localhost:8080/http \
	&& sleep 5 \
	&& wrk -t8 -c8 -d1m http://localhost:8080/http \
	&& sleep 5 \
	&& wrk -t8 -c16 -d1m http://localhost:8080/http \
	&& echo "Testing tnt_upstream_module + lua" \
	&& sleep 5 \
	&& wrk -t1 -c1 -d1m http://localhost:8080/lua \
	&& sleep 5 \
	&& wrk -t2 -c2 -d1m http://localhost:8080/lua \
	&& sleep 5 \
	&& wrk -t4 -c4 -d1m http://localhost:8080/lua \
	&& sleep 5 \
	&& wrk -t4 -c8 -d1m http://localhost:8080/lua \
	&& sleep 5 \
	&& wrk -t8 -c8 -d1m http://localhost:8080/lua \
	&& sleep 5 \
	&& wrk -t8 -c16 -d1m http://localhost:8080/lua \
	&& echo "Testing tnt_upstream_module without lua" \
	&& sleep 5 \
	&& wrk -t1 -c1 -d1m http://localhost:8080/tnt \
	&& sleep 5 \
	&& wrk -t2 -c2 -d1m http://localhost:8080/tnt \
	&& sleep 5 \
	&& wrk -t4 -c4 -d1m http://localhost:8080/tnt \
	&& sleep 5 \
	&& wrk -t4 -c8 -d1m http://localhost:8080/tnt \
	&& sleep 5 \
	&& wrk -t8 -c8 -d1m http://localhost:8080/tnt \
	&& sleep 5 \
	&& wrk -t8 -c16 -d1m http://localhost:8080/tnt
 
