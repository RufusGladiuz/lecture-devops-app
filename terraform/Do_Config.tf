resource "digitalocean_droplet" "web1" {
  image = "ubuntu-18-04-x64"
  name = "DevOpsSoSe2012"
  region = "FRA1"
  size = "2GB"
  private_networking = false
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
    agent = false
  }

provisioner "remote-exec" {
    inline =[

      //Install basics
        "sudo apt-get update",
        "sudo apt install npm -y",

      //TODO: Install nodeJS > 10.0
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
        "sudo sleep 30",
        "sudo wget http://`ip route get 1.2.3.4 | awk '{print $7}'`:8080/jnlpJars/jenkins-cli.jar",
        "sudo echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount(\"devops\", \"admin123\")' | java -jar jenkins-cli.jar -auth admin:`cat /var/lib/jenkins/secrets/initialAdminPassword` -s http://localhost:8080/ groovy =",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin configuration-as-code"
        //"curl -L https://github.com/jenkins-zh/jenkins-cli/releases/latest/download/jcli-linux-amd64.tar.gz|tar xzv",
        //"sudo mv jcli /usr/local/bin/",
        
       //"echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount(\"temp\", \"admin123\")' | java -jar ./jenkins-cli.jar -s \"http://localhost:8080\" -auth admin:`/var/lib/jenkins/secrets/initialAdminPassword` -noKeyAuth groovy = –",
        //Set up python and relevant packages
        //"sudo apt update",
        //"sudo apt install python3.8 -y",
        //"sudo apt update",
        //"apt install python3-pip -y",
        //"python3 -m pip install jenkinsapi",

        //TODO: ADD Docker
        //TODO: ADD Docker Compose
        //TODO: Impliment monitor software of choice

        //TODO: Hand docker user rights to jenkins
        //TODO: Restart jenkins





    ]
}

}