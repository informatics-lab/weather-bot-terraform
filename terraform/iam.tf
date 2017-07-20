data template_file "policy" {
  template = "${file("terraform/templates/logs.tpl")}"
}

data template_file "assume_role" {
  template = "${file("terraform/templates/assume_role.tpl")}"
}

resource "aws_iam_role" "sol" {
  name = "sol"
  assume_role_policy = "${data.template_file.assume_role.rendered}"
}

resource "aws_iam_role_policy" "sol" {
  name = "sol"
  role = "${aws_iam_role.sol.id}"
  policy = "${data.template_file.policy.rendered}"
}

resource "aws_iam_instance_profile" "sol" {
  name = "sol"
  role = "${aws_iam_role.sol.name}"
}
