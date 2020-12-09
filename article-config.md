# Config Kafka Connection

## Source Connection Config (Producer)
```json
{
  "name": "source-sohead",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "transforms": [
      "key",
      "route"
    ],
    "transforms.key.type": "org.apache.kafka.connect.transforms.ExtractField$Key",
    "transforms.key.field": "id",
    "transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
    "transforms.route.regex": "([^.]+)\\.([^.]+)\\.([^.]+)",
    "transforms.route.replacement": "$1.test_db.$3",
    "database.server.name": "socialhead_shop",
    "database.hostname": "postgres",
    "database.user": "postgres",
    "database.password": "postgres",
    "database.dbname": "test_db",
    "column.include.list": [
      "public.ss_feeds.id",
      "public.ss_feeds.shop_id",
      "public.ss_feeds.user_id",
      "public.ss_feeds.status",
      "public.ss_feeds.social_type"
    ],
    "table.include.list": [
      "public.ss_feeds"
    ],
    "message.key.columns": [
      "public.ss_feeds.id",
      "public.ss_feeds.shop_id"
    ]
  }
}
```

## Sink Connection Config (Consumer)

### `ss_feeds`
```json
{
  "name": "elasticsearch-feeds",
  "config": {
    "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "transforms": [
      "route",
      "unwrap"
    ],
    "topics": "socialhead_shop.test_db.ss_feeds",
    "transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
    "transforms.route.regex": "([^.]+)\\.([^.]+)\\.([^.]+)",
    "transforms.route.replacement": "$3",
    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.drop.tombstones": "false",
    "connection.url": "http://elasticsearch:9200",
    "type.name": "_doc",
    "behavior.on.null.values": "delete"
  }
}
```
