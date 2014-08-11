{% from "supervisor/map.jinja" import supervisor with context %}

supervisor:
  pkg.installed: 
    - name: {{ supervisor.package }}

/var/log/supervisor: 
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - file_mode: 644
    - makedirs: True

/etc/supervisor/conf.d:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - file_mode: 644
    - makedirs: True

/etc/supervisor/conf.d/processes.ini:
  file.managed:
    - source: salt://supervisor/templates/processes.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja

/etc/supervisord.conf:
  file.managed:
    - source: salt://supervisor/templates/config.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja

supervisor_service: 
  service.running: 
    - name: supervisor
    - enable: True
    - reload: True
    - watch: 
      - file: /etc/supervisord.conf
