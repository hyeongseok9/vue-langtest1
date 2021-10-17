from ubuntu
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /home/hsnam
RUN apt update
RUN apt install -y nginx python3 python3-pip
ADD . .
RUN ls -al
RUN pip3 install -r /home/hsnam/requests.txt
RUN cp nginx-dev.conf /etc/nginx/sites-enabled/default
RUN chmod +x ./run.sh
CMD ["./run.sh"]