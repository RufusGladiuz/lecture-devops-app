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

        // Give jenkis rights to use docker
        "sudo usermod -aG docker jenkins",
        "sudo systemctl restart jenkins",
        


        

        

        

        
        

            


        


        


        

        

        
        //"sudo java -jar jenkins-cli.jar -auth devops:admin123 -s http://localhost:8080/ install-plugin configuration-as-code"

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