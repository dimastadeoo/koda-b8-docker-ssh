# Membuat server SSH dengan Docker

## ini merupakan halaman yang berisi langkah langkah untuk membuat dan run docker image

1. masuk ke repository yang berisi ssh-key dan Dockerfile

2. selanjutnya build image docker dengan perintah ini, jika belum memiliki docker bisa install lenbih dulu

```sh
docker build . -t <nama_image>
```

3. selanjutnya cek apakah sudah ada image di dalam docker

```sh
docker images
```

4. selanjutnya run docker image yang dibuat tadi, dan pastikan menggunakan jaringan network host, supaya bisa diakses di jaringan komputer

```sh
docker run --network host <nama_image>
```

5. selanjutnya akses ssh di komputer client, disini kita akses port 8088, karena di dockerfile saya mengatur port ssh ke 8088, dan untuk ip host, bisa diisi ip localhost atau ip wifi/LAN yang tersambung di komputer

```sh
ssh -i <lokasi_private_key> -p 8088 username@ip_host
```

jika berhasil maka seharusnya akan otomatis terhubung dengan server docker yang sudah ada ssh server didalamnya, didalam server itu kita bisa melakukan apapun seperti update, install dll