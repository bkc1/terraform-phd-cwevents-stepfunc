output "test1-pubaddress"       { value = "${aws_instance.test1.public_ip}"}
output "sfn_arn"                { value = "${aws_sfn_state_machine.stopstartlambda.id}"}
