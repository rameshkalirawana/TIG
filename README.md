Autohor: Hemant Kumar
Automation for Deployment of Telegraf, Influxdb and Grafana

Telegraf Role Definition:

All the varibales for telegraf can be defined in /telegraf/defaults/main.yaml:

Variables List:

telegraf_install_version: stable

# The user and group telegraf should run under (should be set to telegraf unless needed otherwise)
telegraf_runas_user: telegraf
telegraf_runas_group: telegraf
# Configuration Variables
telegraf_tags:
telegraf_aws_tags: false
telegraf_aws_tags_prefix:

telegraf_agent_interval: 10s
telegraf_round_interval: "true"
telegraf_metric_batch_size: "1000"
telegraf_metric_buffer_limit: "10000"
telegraf_collection_jitter: 0s
telegraf_flush_interval: 10s
telegraf_flush_jitter: 0s
telegraf_debug: "false"
telegraf_quiet: "false"
telegraf_hostname:
telegraf_omit_hostname: "false"
telegraf_install_url:
database: "test1"   # list of databases can be used for each telegraf agent to be deployed on different clients
telegraf_influxdb_urls:
  - http://localhost:8086
telegraf_influxdb_database: "{{ database }}"
telegraf_influxdb_precision: s
telegraf_influxdb_retention_policy: autogen
telegraf_influxdb_write_consistency: any
telegraf_influxdb_ssl_ca:
telegraf_influxdb_ssl_cert:
telegraf_influxdb_ssl_key:
telegraf_influxdb_insecure_skip_verify:
telegraf_influxdb_timeout: 5s
telegraf_influxdb_username:
telegraf_influxdb_password:
telegraf_influxdb_user_agent:
telegraf_influxdb_udp_payload:

#All the plugins can be defined here as list that needs to be enabled on telegraf
telegraf_plugins_base: 
- name: mem
  - name: system
  - name: cpu
    options:
      percpu: "true"
      totalcpu: "true"
      fielddrop:
        - "time_*"
  - name: disk
    options:
      mountpoints:
        - "/"

----------------------------------------------------------------------------------------------------------------------
Grafana Role Definition:

Grafana varaibles can be defined in /grafana/defaults/main.yaml.
Variables list:


grafana_version: latest
# Should we use the provisioning capability when possible (provisioning require grafana >= 5.0)
grafana_use_provisioning: true
grafana_instance: "{{ ansible_fqdn | default(ansible_host) | default(inventory_hostname) }}"
grafana_logs_dir: "/var/log/grafana"
grafana_data_dir: "/var/lib/grafana"
grafana_address: "0.0.0.0"
grafana_port: 3000
# External Grafana address. Variable maps to "root_url" in grafana server section
grafana_url: "http://{{ grafana_address }}:{{ grafana_port }}"
grafana_api_url: "{{ grafana_url }}"
grafana_domain: "{{ ansible_fqdn | default(ansible_host) | default('localhost') }}"
# Additional options for grafana "server" section
# This section WILL omit options for: http_addr, http_port, domain, and root_url, as those settings are set by variables listed before
grafana_server:
  protocol: http
  enforce_domain: false
  socket: ""
  cert_key: ""
  cert_file: ""
  enable_gzip: false
  static_root_path: public
  router_logging: false
# Variables correspond to ones in grafana.ini configuration file
# Security
grafana_security:
  admin_user: admin
  admin_password: "admin"
#  secret_key: ""
#  login_remember_days: 7
#  cookie_username: grafana_user
#  cookie_remember_name: grafana_remember
#  disable_gravatar: true
#  data_source_proxy_whitelist:

# Database setup
grafana_database:
  type: sqlite3
#  host: 127.0.0.1:3306
#  name: grafana
#  user: root
#  password: ""
#  url: ""
#  ssl_mode: disable
#  path: grafana.db
#  max_idle_conn: 2
#  max_open_conn: ""
#  log_queries: ""

# User management and registration
grafana_welcome_email_on_sign_up: false
grafana_users:
  allow_sign_up: false
  # allow_org_create: true
  # auto_assign_org: true
  auto_assign_org_role: Viewer
  # login_hint: "email or username"
  default_theme: dark
  # external_manage_link_url: ""
  # external_manage_link_name: ""
  # external_manage_info: ""

# grafana authentication mechanisms
grafana_auth: {}
#  disable_login_form: false
#  disable_signout_menu: false
#  anonymous:
#    org_name: "Main Organization"
#    org_role: Viewer
#  ldap:
#    config_file: "/etc/grafana/ldap.toml"
#    allow_sign_up: false
#  basic: true

grafana_ldap: {}
#  verbose_logging: false
#  servers:
#    host: 127.0.0.1
#    port: 389 # 636 for SSL
#    use_ssl: false
#    start_tls: false
#    ssl_skip_verify: false
#    root_ca_cert: /path/to/certificate.crt
#    bind_dn: "cn=admin,dc=grafana,dc=org"
#    bind_password: grafana
#    search_filter: "(cn=%s)" # "(sAMAccountName=%s)" on AD
#    search_base_dns:
#      - "dc=grafana,dc=org"
#    group_search_filter: "(&(objectClass=posixGroup)(memberUid=%s))"
#    group_search_base_dns:
#      - "ou=groups,dc=grafana,dc=org"
#    attributes:
#      name: givenName
#      surname: sn
#      username: sAMAccountName
#      member_of: memberOf
#      email: mail
#  group_mappings:
#    - name: Main Org.
#      id: 1
#      groups:
#        - group_dn: "cn=admins,ou=groups,dc=grafana,dc=org"
#          org_role: Admin
#        - group_dn: "cn=editors,ou=groups,dc=grafana,dc=org"
#          org_role: Editor
#        - group_dn: "*"
#          org_role: Viewer
#    - name: Alternative Org
#      id: 2
#      groups:
#        - group_dn: "cn=alternative_admins,ou=groups,dc=grafana,dc=org"
#          org_role: Admin

grafana_session: {}
#  provider: file
#  provider_config: "sessions"

grafana_analytics: {}
#  reporting_enabled: true
#  google_analytics_ua_id: ""

# Set this for mail notifications
grafana_smtp: {}
#  host:
#  user:
#  password:
#  from_address:

# Enable grafana alerting mechanism
grafana_alerting: true

# Internal grafana metrics system
grafana_metrics: {}
#  interval_seconds: 10
#  graphite:
#    address: "localhost:2003"
#    prefix: "prod.grafana.%(instance_name)s"

# Distributed tracing options
grafana_tracing: {}
#  address: "localhost:6831"
#  always_included_tag: "tag1:value1,tag2:value2"
#  sampler_type: const
#  sampler_param: 1

grafana_snapshots: {}
#  external_enabled: true
#  external_snapshot_url: "https://snapshots-origin.raintank.io"
#  external_snapshot_name: "Publish to snapshot.raintank.io"
#  snapshot_remove_expired: true
#  snapshot_TTL_days: 90

# External image store
grafana_image_storage: {}
#  provider: gcs
#  key_file:
#  bucket:
#  path:


#######
# Plugins from https://grafana.com/plugins
grafana_plugins: []
   - raintank-worldping-app
#
#List of Dashboards that user wants to download and not that datasource will automatically be configured in dowloaded json file through /grafana/tasks/dashboards.yaml
# Dashboards from https://grafana.com/dashboards
grafana_dashboards:  
- dashboard_id: '928'
  revision_id: '3'
  datasource: 'Influxdb'
#  - dashboard_id: '1860'
#    revision_id: '4'
#    datasource: 'Prometheus'
#  - dashboard_id: '358'
#    revision_id: '1'
#    datasource: 'Prometheus'

# This is the directory where user can upload his custom dashboards in json format and that dashboarde will be copied to grafana server in /tmp/dashboards/
From there user can upload this json though Grafana UI console and configure everything accordingly
grafana_dashboards_dir: "dashboards"

# Alert notification channels to configure
grafana_alert_notifications: []
#   - name: "Email Alert"
#     type: "email"
#     isDefault: true
#     settings:
#       addresses: "example@example.com"

# Datasources to configure for Grafana (Can be passed as list of many datasources)
grafana_datasources: 
- name: "InfluxDB"
  type: "influxdb"
#    access: "proxy"
  url: "http://localhost:8086"
  database: telegraf
#    basicAuth: true
#    basicAuthUser: "admin"
#    basicAuthPassword: "password"
#    isDefault: true
#    jsonData:
#      tlsAuth: false
#      tlsAuthWithCACert: false
#      tlsSkipVerify: true

# API keys to configure
grafana_api_keys: []
#  - name: "admin"
#    role: "Admin"
#  - name: "viewer"
#    role: "Viewer"
#  - name: "editor"
#    role: "Editor"

# The location where the keys should be stored.
grafana_api_keys_dir: "{{ lookup('env', 'HOME') }}/grafana/keys"
--------------------------------------------------------------------------------------------------------------------

InfluxDB Role Definition:
Variables for Influxdb can be assigned in /influxdb/defaults/main.yaml
Variables list:

influxdb_conf_file: /etc/influxdb/influxdb.conf
influxdb_group: influxdb
influxdb_http_port: 8086
influxdb_ifql_port: 8082
influxdb_rpc_port: 8088
influxdb_udp_port: 8089
influxdb_user: influxdb
influxdb_version: 1.6.3
#List of databases to be configured on Influx server
influx_databases:
- test1
- test2
-----------------------------------------------------------------------------------------------------------------------

Description: 
These roles are modular and can be targeted anywhere on remote system or a group of servers for example in order to deploy grafana refer to the following playbook:
# install-grafana.yml
- name: Installing Grafana on hosted machine
 hosts: grafana 
 become: yes
  roles:
    - grafana
  vars:
    grafana_security:
      admin_user: "admin"
      admin_password: "admin"
    grafana_datasources:
      - name: Influxdb
        type: influxdb
        access: proxy
        url: 'http://localhost:9090'
        basicAuth: true
    grafana_dashboards:
      - dashboard_id: 928
        revision_id: 3
        datasource: influxdb

Note: Please run above playbook with an inventory file as described below:

[grafana]
13.52.0.136 ansible_ssh_user=*** ansible_ssh_private_key_file=/home/hemant/Downloads/test.pem
[telegraf]
*.*.*.*  ansible_ssh_user=*** ansible_ssh_private_key_file=/home/hemant/Downloads/test.pem
[influxdb]
*.*.*.*  ansible_ssh_user=*** ansible_ssh_private_key_file=/home/hemant/Downloads/test.pem

So in order to deploy grafana on 13.52.0.136, run following command :
ansible-playbook grafana.yaml -i hosts_inventory_file

Similarly for configuring different Telegraf agents on different machines for sending data to different databases on Influx server:
#Deploy Telgraf
---
- name: Install Telegraf client 1
  hosts: client_1
  connection: local
  become: yes
  roles:
    - telegraf
  vars:
    database: "test1"
- name: Install Telegraf on Client 2
  hosts: cllient_2
  connection: local
  become: yes
  roles:
   - telegraf
  vars:
   database: "test2"
   
   



