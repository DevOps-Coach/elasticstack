# Elastic Stack 实验室

相关文章

- https://martinliu.cn/posts/elasticsearch-3-nodes-cluster-setup/



## 贡献

请帮忙优化这里的配置和脚本。

    es1: Changed password for user apm_system
    es1: PASSWORD apm_system = kjvSS2LVC3E578KY6H2A
    es1: Changed password for user kibana_system
    es1: PASSWORD kibana_system = lNycOQpdNaqT722UV1rs
    es1: Changed password for user kibana
    es1: PASSWORD kibana = lNycOQpdNaqT722UV1rs
    es1: Changed password for user logstash_system
    es1: PASSWORD logstash_system = ORHjG6v3JvNTewtYctU7
    es1: Changed password for user beats_system
    es1: PASSWORD beats_system = EqJ3HKCifNiSZ2gfv8CC
    es1: Changed password for user remote_monitoring_user
    es1: PASSWORD remote_monitoring_user = T8Uq4CDpJeCFG9DBEL23
    es1: Changed password for user elastic
    es1: PASSWORD elastic = VVPbAfv8yWs4BpJeo41y


curl -H "Content-Type: application/json" -XPOST "192.168.50.11:9200/test-data/_bulk?pretty&refresh" --data-binary "@accounts.json"
curl "localhost:9200/_cat/indices?v"