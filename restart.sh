sudo docker stop $(sudo docker ps -a -q --filter="ancestor=jsonmapper" --format="{{.ID}}")
sudo docker build . --tag=jsonmapper
sudo docker run -d --rm -p 3003:3003 jsonmapper

