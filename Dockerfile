FROM ubuntu:latest

# Install openssh-server dan tools pendukung
RUN apt-get update && apt-get install -y openssh-server

# buat user dan password
RUN useradd -m -s /bin/bash dimas && \
    echo "dimas:123" | chpasswd

# Setup SSH directory dan masukkan Public Key (Hardened Security)
RUN mkdir -p /home/dimas/.ssh && chmod 700 /home/dimas/.ssh
COPY id_ed25519.pub /home/dimas/.ssh/authorized_keys
RUN chmod 600 /home/dimas/.ssh/authorized_keys && \
    chown -R dimas:root /home/dimas/.ssh

# Konfigurasi SSH Daemon (Ubah port ke 8088 & Matikan Password Auth)
RUN sed -i 's/#Port 22/Port 8088/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config 

# SSH daemon menjadi entrypoint container
CMD ["/usr/sbin/sshd", "-D"]