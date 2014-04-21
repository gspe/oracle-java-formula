{% set p  = salt['pillar.get']('java', {}) %}
{% set g  = salt['grains.get']('java', {}) %}

#{%- set java_home      = salt['grains.get']('java_home', salt['pillar.get']('java_home', '/usr/lib/jvm')) %}

{%- set default_version_name = 'jdk1.8.0_05' %}
{%- set default_prefix       = '/usr/lib/jvm' %}
{%- set default_source_url   = 'http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.tar.gz' %}
{%- set default_dl_opts      = '-b oraclelicense=accept-securebackup-cookie -L' %}

{%- set version_name   = g.get('version_name', p.get('version_name', default_version_name)) %}
{%- set prefix         = g.get('prefix', p.get('prefix', default_prefix)) %}
{%- set source_url     = g.get('source_url', p.get('source_url', default_source_url)) %}
{%- set dl_opts        = g.get('dl_opts', p.get('dl_opts', default_dl_opts)) %}
{%- set java_home      = prefix + '/' + version_name %}

{%- set java = {} %}
{%- do java.update( { 'version_name'   : version_name,
                      'source_url'     : source_url,
                      'dl_opts'        : dl_opts,
                      'prefix'         : prefix,
                      'java_home'      : java_home
                  }) %}
