# *** Latest version of bullseye Debian ***
FROM debian:bullseye

# *** Installing nginx and SSL/TLS ***
RUN apt-get update && apt-get install -y nginx openssl

# *** Generate the private key ***
# This will generate a 2048-bit RSA private key
# and store it in the file /etc/ssl/private/nginx-selfsigned.key.

# We will reference this in the NGINX configuration file.

# [Explanation]

# [openssl genrsa]:
    # Indicates that OpenSSL is being used to generate an RSA private key.
# [-out /etc/ssl/private/nginx-selfsigned.key]:
    # Specifies the location and name of the file where the generated private key will be saved.
    # This path is a common convention for storing private keys on Unix-based systems.

# [2048]:
    # Specifies the bit size of the RSA private key to be generated.
    # In this case, a 2048-bit key is being generated, a commonly accepted standard for adequate security today.

RUN openssl genrsa -out /etc/ssl/private/nginx-selfsigned.key 2048

# *** Generate TLS Certificate ***
# Generate self-signed certificate using private key
# We will reference this in the NGINX configuration file.

# [Explanation]

# [openssl req]:
    # Indicates that OpenSSL is being used to make a request. 
    # In this case, we are generating a self-signed certificate.
# [-x509]: 
    # Specifies that a self-signed certificate will be generated instead of a certificate signing request.

# [-nodes]:
    # Indicates that the private key of the certificate will not be encrypted with a password.
    # This means that the private key will not be password protected and will be accessible without the need to enter a password each time it is used.

# [-days 365]:
    # Sets the validity duration of the certificate in days.

# [-newkey rsa:2048]:
    # Generates a new 2048-bit RSA private key for the certificate.

# [-key /etc/ssl/private/nginx-selfsigned.key]: 
    # Specifies the location and name of the file where the previously generated private key is located.

# [-out /etc/ssl/certs/nginx-selfsigned.crt]: 
    # Specifies the location and name of the file where the self-signed certificate being generated will be saved.

# [-subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=42Paris/CN=mflores.42.fr"]: 
    # This parameter defines the subject of the certificate with information such as:
    # country (C), state (ST), locality (L), organization (O), organizational unit (OU) and common name (CN).

RUN openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -key /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=42Paris/CN=dnieto-c.42.fr"

# Copy config 
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# Lauching nginx daemon
CMD ["nginx", "-g", "daemon off;"]