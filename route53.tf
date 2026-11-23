
# Public Hosted Zone
resource "aws_route53_zone" "main" {
  name = "bigbytecloud.com"

  tags = {
    Name = "bigbytecloud-public-zone"
  }
}

# Alias A Record - Root Domain
resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "bigbytecloud.com"
  type    = "A"

  alias {
    name                   = aws_lb.huma-lb.dns_name
    zone_id                = aws_lb.huma-lb.zone_id
    evaluate_target_health = true
  }
}

# www.bigbytecloud.com
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.bigbytecloud.com"
  type    = "A"

  alias {
    name                   = aws_lb.huma-lb.dns_name
    zone_id                = aws_lb.huma-lb.zone_id
    evaluate_target_health = true
  }
}

# huma.bigbytecloud.com
resource "aws_route53_record" "huma" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "huma.bigbytecloud.com"
  type    = "A"

  alias {
    name                   = aws_lb.huma-lb.dns_name
    zone_id                = aws_lb.huma-lb.zone_id
    evaluate_target_health = true
  }
}

# Output Nameservers
output "route53_nameservers" {
  value = aws_route53_zone.main.name_servers
}

output "alb_dns_name" {
  value       = aws_lb.huma-lb.dns_name
  description = "Output alb dns name"
}
