FROM dapfeffer/apthunter:base

WORKDIR /opt

RUN apt -y update; apt -y upgrade
RUN apt -y install p7zip-full gpg vim python3 python3-pip git

ADD https://github.com/ahmedkhlief/APT-Hunter/archive/refs/heads/main.zip /opt/apt-hunter.zip
RUN 7z x /opt/apt-hunter.zip

WORKDIR /opt/APT-Hunter-main
RUN pip install -r requirements.txt --break-system-packages
RUN ./Get_Latest_Sigma_Rules.sh

ADD start.sh /opt/APT-Hunter-main/start.sh
RUN chmod a+x /opt/APT-Hunter-main/start.sh

ENTRYPOINT /opt/APT-Hunter-main/start.sh
