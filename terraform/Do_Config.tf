resource "digitalocean_droplet" "web2" {
  image = "ubuntu-18-04-x64"
  name = "DevOpsSoSe20202"
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

  provisioner "file" {
    source      = "./githubrepo.txt"
    destination = "./githubrepo.txt"
  }

provisioner "remote-exec" {

    inline =[
      //Install webserver
      "sudo apt-get update",
      "sudo apt install nginx",

      //Install basics
        "sudo apt-get update",
        "sudo apt install npm -y",
               
        "sudo curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh",
        "sudo bash nodesource_setup.sh",
        "sudo apt install nodejs -y",


        "sudo apt-get update",
        "sudo apt install git -y",

        "sudo apt update",
        "sudo apt install nano -y",

        "sudo apt update",
        "sudo apt install openjdk-8-jdk -y",

        //Install Docker
        "sudo apt-get update",
        "sudo apt install apt-transport-https ca-certificates curl software-properties-common -y",
        "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
        "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable\"",
        "sudo apt-get update",
        "sudo apt-cache policy docker-ce",
        "sudo apt install docker-ce -y",

        //Install Docker Compose
        "sudo curl -L \"https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
        "sudo chmod +x /usr/local/bin/docker-compose",

        //Install Jenkins
        "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
        "sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
        "sudo apt update",
        "sudo apt install jenkins -y",
        "sudo systemctl start jenkins",

        //Wait for jenkins to initilise
        "sudo sleep 30",

        //Get Jenkis JDK
        "sudo wget http://`ip route get 1.2.3.4 | awk '{print $7}'`:8080/jnlpJars/jenkins-cli.jar",

        //Create jenkins user
        "sudo echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount(\"devops\", \"admin123\")' | java -jar jenkins-cli.jar -auth admin:`cat /var/lib/jenkins/secrets/initialAdminPassword` -s http://localhost:8080/ groovy =",

        // Installing jenkins basic plugins
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin cloudbees-folder",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin timestamper",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin workflow-aggregator",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin antisamy-markup-formatter",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin build-timeout",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin credentials-binding",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin ws-cleanup",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin ant",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin gradle",      
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin github-branch-source",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin pipeline-github-lib",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin pipeline-stage-view",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin git",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin subversion",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin ssh-slaves",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin matrix-auth",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin pam-auth",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin ldap",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin email-ext",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin mailer",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin configuration-as-code",
        "sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin configuration-as-code-support",


        


        //Setup Job
        //"sudo git clone https://github.com/Oni22/lecture-devops-app.git",
        //"sudo mkdir /var/lib/jenkins/jobs/devops",

        //"sudo cp -r lecture-devops-app/jenkins/config.xml /var/lib/jenkins/jobs/devops",
        //"sudo rm -R lecture-devops-app",

        // Give jenkis rights to use docker
        "sudo usermod -aG docker jenkins",
        "sudo systemctl restart jenkins",

        //TODO: Setup Webhook

        //TODO: Setup Pipeline

        //Monitoring
        "sudo apt-get install monit -y",
        "monit",
        "echo 'set httpd port 2812 \n use address' $(ip route get 1.2.3.4 | awk '{print $7}') '\n allow 0.0.0.0/0.0.0.0 \n allow admin:monit' >> /etc/monit/monitrc",
        "monit reload",

        //TODO: HTTPS
        "sudo apt-get update",
       "sudo apt-get install software-properties-common",
        "sudo add-apt-repository universe",
        "sudo add-apt-repository ppa:certbot/certbot",
       "sudo apt-get update",
       "sudo apt-get install certbot python3-certbot-apache",
       "sudo certbot --apache",



    ]
}

}