{%- from 'oracle-java/settings.sls' import java with context %}

# require a source_url - there is no default download location for a jdk
{%- if java.source_url is defined %}

java-install-dir:
  file.directory:
    - name: {{ java.prefix }}
    - user: root
    - group: root
    - mode: 755

unpack-jdk-tarball:
  cmd.run:
    - name: curl {{ java.dl_opts }} '{{ java.source_url }}' | tar xz
    - cwd: {{ java.prefix }}
    - unless: test -d {{ java.java_home }}
    - require:
      - file: {{ java.prefix }}

java-alternatives:
  alternatives.install:
    - name: java
    - link: /usr/bin/java
    - path: {{ java.java_home }}/bin/java
    - priority: 100

javac-alternatives:
  alternatives.install:
    - name: javac
    - link: /usr/bin/javac
    - path: {{ java.java_home }}/bin/javac
    - priority: 100

javaws-alternatives:
  alternatives.install:
    - name: javaws
    - link: /usr/bin/javaws
    - path: {{ java.java_home }}/bin/javaws
    - priority: 100

java-home:
  file.blockreplace:
    - name: /etc/environment
    - marker_start: "# BLOCK TOP : salt managed zone: oracle-java"
    - marker_end: "# BLOCK END : end of salt managed zone"
    - content: JAVA_HOME="{{ java.java_home }}"
    - append_if_not_found: True
    - show_changes: True

{%- endif %}