version: '3'

services:
  trojan-panel-caddy:
    image: caddy:2.6.2
    container_name: trojan-panel-caddy
    restart: always
    network_mode: host
    volumes:
      - "/tpdata/caddy/config.json:/tpdata/caddy/config.json"
      - "/tpdata/caddy/cert/:/tpdata/caddy/cert/certificates/acme-v02.api.letsencrypt.org-directory/test1.de26-vl6.cfd/"
      - "/tpdata/caddy/srv/:/tpdata/caddy/srv/"
      - "/tpdata/caddy/logs/:/tpdata/caddy/logs/"
    command: caddy run --config /tpdata/caddy/config.json

  trojan-panel-mariadb:
    image: mariadb:10.7.3
    container_name: trojan-panel-mariadb
    restart: always
    network_mode: host
    environment:
      MYSQL_DATABASE: trojan_panel_db
      MYSQL_ROOT_PASSWORD: "Panel1234"
      TZ: Asia/Shanghai
    command: --port=9507

  trojan-panel-redis:
    image: redis:6.2.7
    container_name: trojan-panel-redis
    restart: always
    network_mode: host
    command: redis-server --requirepass Pannel1234 --port 6378

  trojan-panel:
    image: jonssonyan/trojan-panel/2.0.5
    container_name: trojan-panel
    restart: always
    network_mode: host
    volumes:
      - "/tpdata/caddy/srv/:/tpdata/trojan-panel/webfile/"
      - "/tpdata/trojan-panel/logs/:/tpdata/trojan-panel/logs/"
      - "/tpdata/trojan-panel/config/:/tpdata/trojan-panel/config/"
      - "/etc/localtime:/etc/localtime"
    environment:
      - "mariadb_ip=37.114.53.91"
      - "mariadb_port=9507"
      - "mariadb_user=root"
      - "mariadb_pas=$Panel1234"
      - "redis_host=37.114.53.91"
      - "redis_port=6378"
      - "redis_pass=Panel1234"
      - "server_port=8081"

  trojan-panel-ui:
    image: jonssonyan/trojan-panel-ui/2.0.4
    container_name: trojan-panel-ui
    restart: always
    network_mode: host
    volumes:
      - "/tpdata/nginx/default.conf:/etc/nginx/conf.d/default.conf"
      - "/tpdata/caddy/cert/:/tpdata/caddy/cert/"

  trojan-panel-core:
    image: jonssonyan/trojan-panel/2.0.5
    container_name: trojan-panel-core
    restart: always
    network_mode: host
    volumes:
      - "/tpdata/trojan-panel-core/bin/xray/config:/tpdata/trojan-panel-core/bin/xray/config"
      - "/tpdata/trojan-panel-core/bin/trojango/config:/tpdata/trojan-panel-core/bin/trojango/config"
      - "/tpdata/trojan-panel-core/bin/hysteria/config:/tpdata/trojan-panel-core/bin/hysteria/config"
      - "/tpdata/trojan-panel-core/bin/naiveproxy/config:/tpdata/trojan-panel-core/bin/naiveproxy/config"
      - "/tpdata/trojan-panel-core/logs/:/tpdata/trojan-panel-core/logs/"
      - "/tpdata/trojan-panel-core/config/:/tpdata/trojan-panel-core/config/"
      - "/tpdata/caddy/cert/:/tpdata/caddy/cert/"
      - "/tpdata/caddy/srv/:/tpdata/caddy/srv/"
      - "/etc/localtime:/etc/localtime"
    environment:
      - "mariadb_ip=37.114.53.91"
      - "mariadb_port=9507"
      - "mariadb_user=root"
      - "mariadb_pas=Panel1234"
      - "database=trojan_panel_db"
      - "account-table=account"
      - "redis_host=37.114.53.91"
      - "redis_port=6378"
      - "redis_pass=Panel1234"
      - "crt_path=/tpdata/caddy/cert/test1.de26-vl6.cfd.crt"
      - "key_path=/tpdata/caddy/cert/test1.de26-vl6.cfd.key"
      - "grpc_port=8100"
      - "server_port=8082"
	  
   trojan-panel-caddy-2:
    image: caddy:2.6.2
    container_name: trojan-panel-caddy-2
    restart: always
    network_mode: host
    volumes:
      - "/tpdata/caddy/config.json:/tpdata/caddy/config.json"
      - "/tpdata/caddy/cert/:/tpdata/caddy/cert/certificates/acme-v02.api.letsencrypt.org-directory/test2.de26-vl6.cfd/"
      - "/tpdata/caddy/srv/:/tpdata/caddy/srv/"
      - "/tpdata/caddy/logs/:/tpdata/caddy/logs/"
    command: caddy run --config /tpdata/caddy/config.json

  trojan-panel-mariadb-2:
    image: mariadb:10.7.3
    container_name: trojan-panel-mariadb-2
    restart: always
    network_mode: host
    environment:
      MYSQL_DATABASE: trojan_panel_db
      MYSQL_ROOT_PASSWORD: "Panel1234"
      TZ: Asia/Shanghai
    command: --port=9507

  trojan-panel-redis-2:
    image: redis:6.2.7
    container_name: trojan-panel-redis-2
    restart: always
    network_mode: host
    command: redis-server --requirepass Pannel1234 --port 6378

  trojan-panel-2:
    image: jonssonyan/trojan-panel/2.0.5
    container_name: trojan-panel-2
    restart: always
    network_mode: host
    volumes:
      - "/tpdata/caddy/srv/:/tpdata/trojan-panel/webfile/"
      - "/tpdata/trojan-panel/logs/:/tpdata/trojan-panel/logs/"
      - "/tpdata/trojan-panel/config/:/tpdata/trojan-panel/config/"
      - "/etc/localtime:/etc/localtime"
    environment:
      - "mariadb_ip=37.114.53.96"
      - "mariadb_port=9507"
      - "mariadb_user=root"
      - "mariadb_pas=$Panel1234"
      - "redis_host=37.114.53.96"
      - "redis_port=6378"
      - "redis_pass=Panel1234"
      - "server_port=8081"

  trojan-panel-ui-2:
    image: jonssonyan/trojan-panel-ui/2.0.4
    container_name: trojan-panel-ui-2
    restart: always
    network_mode: host
    volumes:
      - "/tpdata/nginx/default.conf:/etc/nginx/conf.d/default.conf"
      - "/tpdata/caddy/cert/:/tpdata/caddy/cert/"

  trojan-panel-core-2:
    image: jonssonyan/trojan-panel/2.0.5
    container_name: trojan-panel-core-2
    restart: always
    network_mode: host
    volumes:
      - "/tpdata/trojan-panel-core/bin/xray/config:/tpdata/trojan-panel-core/bin/xray/config"
      - "/tpdata/trojan-panel-core/bin/trojango/config:/tpdata/trojan-panel-core/bin/trojango/config"
      - "/tpdata/trojan-panel-core/bin/hysteria/config:/tpdata/trojan-panel-core/bin/hysteria/config"
      - "/tpdata/trojan-panel-core/bin/naiveproxy/config:/tpdata/trojan-panel-core/bin/naiveproxy/config"
      - "/tpdata/trojan-panel-core/logs/:/tpdata/trojan-panel-core/logs/"
      - "/tpdata/trojan-panel-core/config/:/tpdata/trojan-panel-core/config/"
      - "/tpdata/caddy/cert/:/tpdata/caddy/cert/"
      - "/tpdata/caddy/srv/:/tpdata/caddy/srv/"
      - "/etc/localtime:/etc/localtime"
    environment:
      - "mariadb_ip=37.114.53.96"
      - "mariadb_port=9507"
      - "mariadb_user=root"
      - "mariadb_pas=Panel1234"
      - "database=trojan_panel_db"
      - "account-table=account"
      - "redis_host=37.114.53.96"
      - "redis_port=6378"
      - "redis_pass=Panel1234"
      - "crt_path=/tpdata/caddy/cert/test2.de26-vl6.cfd.crt"
      - "key_path=/tpdata/caddy/cert/test2.de26-vl6.cfd.key"
      - "grpc_port=8100"
      - "server_port=8082"