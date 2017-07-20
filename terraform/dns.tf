resource "aws_route53_record" "sol" {
  zone_id = "Z3USS9SVLB2LY1"
  name = "sol.informaticslab.co.uk"
  type = "A"
  ttl = "60"
  records = ["${aws_instance.sol.public_ip}"]
}
