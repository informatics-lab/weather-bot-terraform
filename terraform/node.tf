data "template_file" "bootstrap" {
    template            = "${file("./scripts/bootstrap.sh")}"

    vars = {
      docker_compose_file = "${file("./config/docker-compose.yml")}"
      telegraf_config = "${file("./config/telegraf.conf")}"
      bot_secrets = "${file("./config/secrets.json")}"
    }
}

resource "aws_instance" "sol" {
  ami                   = "ami-f9dd458a"
  instance_type         = "t2.micro"
  key_name              = "gateway"
  user_data             = "${data.template_file.bootstrap.rendered}"
  iam_instance_profile  = "${aws_iam_instance_profile.sol.name}"
  security_groups        = ["default", "${aws_security_group.sol.name}"]

  tags = {
    Name = "Sol (weather bot)"
    OfficeHours = "false"
    Project = "chatbot"
    Owner = "jacobtomlinson"
    EndOfLife = "2017-11-04T09:00:00+00:00"
  }

  root_block_device = {
    volume_size = 20
  }
}
