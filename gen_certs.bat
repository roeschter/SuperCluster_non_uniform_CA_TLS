rem @echo off
setlocal enableextensions
set TERM=
c:
cd "C:\cygwin64\bin" 
.\bash --login -i -c "export PATH=/cygdrive/d/synadia/software/samples/C42_SuperCluster_non_uniform_CA_TLS:$PATH;cd /cygdrive/d/synadia/software/samples/C42_SuperCluster_non_uniform_CA_TLS;bash"

############ Cluster in domain "localhost"
# Generate CA key and certificate
openssl genrsa -out ca-A.key 2048
openssl req -x509 -new -nodes -key ca-A.key -subj "/CN=nats-ca-A" -days 3650 -out ca-A.crt

# Generate server key and certificate
openssl genrsa -out nats-A.key 2048
openssl req -new -key nats-A.key -config nats-A.conf -extensions v3_req -out nats-A.csr 
openssl x509 -req -in nats-A.csr -CA ca-A.crt -CAkey ca-A.key -out nats-A.crt -days 365 -extensions v3_req -extfile nats-A.conf

############ Cluster in domain "127.0.0.1"
# Generate CA key and certificate
openssl genrsa -out ca-B.key 2048
openssl req -x509 -new -nodes -key ca-B.key -subj "/CN=nats-ca-B" -days 3650 -out ca-B.crt

# Generate server key and certificate
openssl genrsa -out nats-B.key 2048
openssl req -new -key nats-B.key -config nats-B.conf -extensions v3_req -out nats-B.csr 
openssl x509 -req -in nats-B.csr -CA ca-B.crt -CAkey ca-B.key -out nats-B.crt -days 365 -extensions v3_req -extfile nats-B.conf


###### Merge CAs
rm certs.crt
cat ca-A.crt ca-B.crt > certs.crt