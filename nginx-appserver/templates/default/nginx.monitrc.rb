check process nginx with pidfile /var/run/nginx.pid
  start program = "/etc/init.d/nginx start"
  stop  program = "/etc/init.d/nginx stop"
  if failed host 127.0.0.1 port 8080 then restart
