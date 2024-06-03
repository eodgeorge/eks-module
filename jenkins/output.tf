output "jenkins-contrl-ip" { value = aws_instance.jenkins-controller.private_ip }
output "jenkins-agent-ip" { value = aws_instance.jenkins-agent.private_ip}