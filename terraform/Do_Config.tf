resource "digitalocean_droplet" "web1" {
  image = "ubuntu-18-04-x64"
  name = "DevOpsSoSe2012"
  region = "FRA1"
  size = "512mb"
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
  }

provisioner "remote-exec" {
    inline =[
        "sudo apt-get update",
        "sudo apt install npm",
        "sudo apt-get update",
        "sudo apt install nodejs",
        "sudo apt-get update",
        "sudo apt install git",

    ]
}

}