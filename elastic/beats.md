# Beats

* [Beats Platform Reference](https://www.elastic.co/guide/en/beats/libbeat/master/index.html)
* [Beats overview](https://www.elastic.co/guide/en/beats/libbeat/master/beats-reference.html)

* [Community Beats](https://www.elastic.co/guide/en/beats/libbeat/current/community-beats.html)
* [Beats Developer Guide](https://www.elastic.co/guide/en/beats/devguide/7.5/index.html)

* [Metrics Monitoring Guide](https://www.elastic.co/guide/en/metrics/guide/7.5/index.html)
* [Logs Monitoring Guide](https://www.elastic.co/guide/en/logs/guide/7.5/index.html)

* [Getting started with the Elastic Stack](https://www.elastic.co/guide/en/elastic-stack-get-started/6.8/index.html)

* [Logstash Reference](https://www.elastic.co/guide/en/logstash/master/index.html)

* [Filebeat vs. Logstash — The Evolution of a Log Shipper](https://logz.io/blog/filebeat-vs-logstash/)

## Filebeat

### input + harvester

[How Filebeat works](https://www.elastic.co/guide/en/beats/filebeat/6.8/how-filebeat-works.html)

harvester 的职责是读取单个文件的内容

input 负责管理 `harvester` 并发现所有可以读取的资源

```
filebeat.inputs:
- type: log
  paths:
    - /var/log/*.log
    - /var/path2/*.log
```
