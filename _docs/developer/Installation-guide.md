---
layout: default
category: Developer
order: 3
---

This guide explains how an installation of the core components of MakerLab can
be accomplished. In many cases, each repository's `README` contains similar (or
even more complete) information. Regarding this, the `setup` repo contains many
markdown files and other files which are used in a setup (hence its name).

## Updates

```bash
sudo apt-get update
sudo apt-get -y upgrade
```

## Python

This installation handles system-wide packages used by DML's core. The
`requirements.txt` is from the `setup` repo.

```bash
sudo apt-get install -y python3 python3-pip
sudo pip3 install -r requirements.txt
```

## uWSGI

Setup
```bash
sudo mkdir -p /etc/uwsgi/vassals
```

Start at boot
```bash
# Edit /etc/rc.local and add
/usr/local/bin/uwsgi --emperor /etc/uwsgi/vassals --uid www-data --gid www-data --daemonize /var/log/uwsgi-emperor.log
# before the line "exit 0".
```

This will make both `uwsgi`'s emperor start at boot, as well as load and keep
the vassals deployed running continuously. Even in case of failure they are
restarted.

## Docker

```bash
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
```

```bash
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"
```

```bash
sudo apt-get update
sudo apt-get -y install docker-ce
```

```bash
sudo service docker start
sudo usermod -aG docker $USER
sudo systemctl enable docker
```

### Docker Compose

The link below was used in the last deploy issued at the time of this writing.
Newer versions may exist.

```bash
sudo su -
curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
logout
```

## Postgres

```bash
sudo apt-get install -y postgresql-client

POSTGRES_PASSWORD=**** \
    docker run --restart=always --name dml-postgres -p 127.0.0.1:5432:5432 \
    -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" -d postgres

psql -h 127.0.0.1 -p 5432 -U postgres postgres < initial.db
```

The `initial.db` file referenced comes from the `setup` repo. It contains a
based structure necessary to make the wiki function properly.

Although probably obvious, `POSTGRES_PASSWORD` should be replaced with the
password desired.

The command will start a docker container running Postgres, open only locally
(i.e. `localhost`) and that will auto-spawn and restart at boot and in case of
failure.

## Node.js

The url below was up-to-date when written. May be outdated by now.

```bash
sudo su root
curl -sL https://deb.nodesource.com/setup_7.x | bash -
apt-get install -y nodejs
logout
```

## Services

```bash
mkdir $HOME/dml
```

This is the directory where the core's and other services' repos live.

### Solr

```bash
cd $HOME/dml
git clone git@gitlab.com:makerlab/solr-engine.git
cd solr-engine
virtualenv --python=python3 venv
source venv/bin/activate
pip install -r requirements.txt
```

```bash
./setup.sh
```

The script above will handle the creation of necessary directories, setting
permissions and launching a docker container running Solr (with sensible
settings to be used alongside the wiki).

#### uWSGI

```bash
sudo ln -s `pwd`/solr_uwsgi.ini /etc/uwsgi/vassals/
```

By linking Solr's `uwsgi` configuration to file in the vassals directory, the
`uwsgi` emperor will look after Solr's proxy server process.

### Wiki

```bash
cd $HOME/dml
git clone git@gitlab.com:makerlab/dml-django-wiki.git
cd dml-django-wiki
virtualenv --python=python3 venv
source venv/bin/activate
pip install -r requirements.txt
```

#### Gentelella

```bash
sudo npm install -g bower
bower install
```

#### Dependencies

This section is fuzzy and might bring headcases (though nothing seriously
concerning).

Simply, different dependencies might be needed. It shouldn't be too difficult
to track, but as platforms change, so do the dependencies. Maybe a docker
container for the wiki might be generated at a later time.

```bash
cd $HOME/dml/dml-django-wiki
sudo apt-get install -y gettext
cd dml
python manage.py compilemessages
```

#### Static files

```bash
cd $HOME/dml/dml-django-wiki
sudo mkdir -p '/var/www/makerlab/'
sudo cp -a 'dml/media' '/var/www/makerlab/'
sudo chown -R www-data:www-data /var/www/makerlab/
cd dml
sudo -u www-data -E env PATH=$PATH PYTHONPATH=$PYTHONPATH python manage.py collectstatic
```

#### Nginx

```bash
sudo apt-get install -y nginx
cd $HOME/dml/dml-django-wiki
sudo ln -s `pwd`/wiki_nginx.conf /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo /etc/init.d/nginx restart
```

Notice that we link the wiki's nginx config file to a nginx directory. This way
we can keep the file locally without, though changes reflect upstream.

#### uWSGI

```bash
cd $HOME/dml/dml-django-wiki
sudo ln -s `pwd`/wiki_uwsgi.ini /etc/uwsgi/vassals/
```

Same model as with Solr.

Keep the `uwsgi` config file locally but link it with the vassals directory.
This was the emperor will look after the wiki's process.

### SSL

Create a self-signed key and certificate pair
```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
```

Create a strong Diffie-Hellman group
```bash
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

Create the `self-signed.conf` snippet
```bash
cat << EOT | sudo tee /etc/nginx/snippets/self-signed.conf > /dev/null
ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
EOT
```

Create the `ssl-params.conf` snippet
```bash
cat << EOT | sudo tee /etc/nginx/snippets/ssl-params.conf > /dev/null
# from https://cipherli.st/
# and https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
ssl_ecdh_curve secp384r1;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
#add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
add_header Strict-Transport-Security "max-age=63072000; includeSubdomains";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;

ssl_dhparam /etc/ssl/certs/dhparam.pem;
EOT
```

### Servant

```bash
cd $HOME/dml
git clone git@gitlab.com:makerlab/dml-servant.git
cd dml-servant
nohup env HUBOT_SLACK_TOKEN=XXXX bin/hubot --adapter slack &
```

This will keep the servant's process running detached in the background,
without preventing it from being killed.


## Mail configuration

We used `exim`. Its configuration follows.

To start the configuration wizard issue
```bash
$ dpkg-reconfigure exim4-config
```

The options with which `exim` was configured follow (the numbers refer to the
screens where they were selected).

1. internet site; mail is sent and received directly using SMTP
2. deti-makerlab.ua.pt
3. 127.0.0.1 ; ::1
4. deti-makerlab.ua.pt; deti-makerlab; localhost
5. Relay options
    1. empty
    2. empty
6. no
7. mbox format in /var/mail/
8. no
