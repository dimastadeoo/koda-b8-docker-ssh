FROM ubuntu:latest

# 1. Install openssh-server dan tools pendukung
RUN apt-get update && apt-get install -y openssh-server sudo 

# 2. Buat user
ARG USERNAME=dimas
ARG PASSWORD=123

RUN useradd -rm -d /home/$USERNAME -s /bin/bash -g root -G sudo -u 1001 $USERNAME && \
    echo "$USERNAME:$PASSWORD" | chpasswd

# 3. Setup SSH directory dan masukkan Public Key (Hardened Security)
RUN mkdir -p /home/$USERNAME/.ssh && chmod 700 /home/$USERNAME/.ssh
COPY id_rsa.pub /home/$USERNAME/.ssh/authorized_keys
RUN chmod 600 /home/$USERNAME/.ssh/authorized_keys && \
    chown -R $USERNAME:root /home/$USERNAME/.ssh

# 4. Konfigurasi SSH Daemon (Ubah port ke 8088 & Matikan Password Auth)
RUN sed -i 's/#Port 22/Port 8088/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Ekspos port 8088 sesuai kebutuhan
EXPOSE 8088

# 5. SSH daemon menjadi entrypoint container
CMD ["/usr/sbin/sshd", "-D"]