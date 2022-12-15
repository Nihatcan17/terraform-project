output "rds_endpoint" {
  value = aws_db_instance.nht-db.address
}

output "load-balancer-address" {
  value = aws_lb.nht-alb.dns_name
  
}