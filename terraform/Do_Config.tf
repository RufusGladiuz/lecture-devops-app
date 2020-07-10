resource "digitalocean_droplet" "web1" {
  image = "ubuntu-18-04-x64"
  name = "DevOpsSoSe2012"
  region = "FRA1"
  size = "2GB"
  private_networking = true
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
    agent = true
  }

provisioner "remote-exec" {
    inline =[
        "sudo apt-get update",
        "sudo apt install npm -y",

        "sudo apt-get update",
        "sudo apt install nodejs -y",

        "sudo apt-get update",
        "sudo apt install git -y",

        "sudo apt update",
        "sudo apt install nano -y",

        "sudo apt update",
        "sudo apt install openjdk-8-jdk -y",

        //Install Jenkins
        "wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -",
        "sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
        "sudo apt update",
        "sudo apt install jenkins -y",
        "sudo systemctl start jenkins",

        //Setup jenkins pipeline
        "ip route get 1.2.3.4 | awk '{print $7}'"
        "sudo wget http://$(!!):8080/jnlpJars/jenkins-cli.jar"


        //TODO: ADD Docker
        //TODO: ADD Docker Compose
        //TODO: Impliment monitor software of choice
    ]
}

}