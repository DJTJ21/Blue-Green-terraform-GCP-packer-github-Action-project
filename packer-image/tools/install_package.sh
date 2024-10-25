
cloud-init status -w
# Install docker, docker-compose, and mysql client
sudo apt-get update
sudo apt-get install -y docker.io docker docker-compose
sudo apt install -y mysql-client-core-8.0
gcloud auth configure-docker -q
sudo usermod -aG docker "$USER"
