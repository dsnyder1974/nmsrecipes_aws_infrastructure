output "redis_endpoint" {
  value = aws_elasticache_cluster.nms_redis.cache_nodes[0].address
}
