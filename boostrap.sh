#!/bin/bash
#sudo apt-get install ubuntu-gnome-desktop
#sudo apt-get update
#sudo apt-get install ubuntu-desktop

log_file=/tmp/vagrantup.log
exec &> >(tee -a "$log_file")

common_packages=(curl git unzip make gcc build-essential)

install_commom_packages()
{
  sudo apt-get -y install ${common_packages[@]}
}

install_php_packages()
{
  which php > /dev/null
  if [ $? -ne 0 ]; then
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:ondrej/php
    sudo apt-get update

    sudo apt-get -y install php7.1
    php_packages=(libapache2-mod-php php-cli php-cgi php-soap php-xml php-common php-json php-mysql php-mbstring php-mcrypt php-zip php-fpm php-gd)

    sudo apt-get -y install ${php_packages[@]}
    sudo a2enmod proxy_fcgi setenvif
    sudo a2enconf php7.1-fpm
    sudo systemctl restart apache2.service
  else
    echo "PHP packages are already installed!"
  fi
}

install_composer()
{
  install_dir=/home/vagrant/composer
  if [ ! -d "$install_dir" ]; then
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
        >&2 echo 'ERROR: Invalid installer signature'
        rm -rf composer-setup.php
        exit 1
    fi

    mkdir -p $install_dir
    php composer-setup.php --install-dir=$install_dir
    rm -rf composer-setup.php
    echo "alias composer=\"$install_dir/composer.phar\"" >> /home/vagrant/.bashrc
  else
    echo "Composer is already installed!"
  fi

}

install_redis()
{
  which redis-server > /dev/null
  if [ $? -ne 0 ]; then
    redis_file="redis-stable.tar.gz"
    if [ ! -f "$redis_file" ]; then
      wget http://download.redis.io/redis-stable.tar.gz
    fi
    tar xzf $redis_file
    pushd redis-stable
    make distclean
    make
    sudo make install
    popd
    rm -rf redis-stable
  else
    echo "Redis is already installed!"
  fi
}

install_docker()
{
  which docker > /dev/null
  if [ $? -ne 0 ]; then
  sudo apt-get -y remove docker docker-engine docker.io
  sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  sudo apt-get update
  sudo apt-get -y install docker-ce
  sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  else
    echo "Docker is already installed!"
  fi
}

echo "###########################"
echo "Installing common packages..."
echo "###########################"
install_commom_packages
echo "###########################"


echo "###########################"
echo "Installing PHP packages..."
echo "###########################"
install_php_packages
echo "###########################"


echo "###########################"
echo "Installing Composer..."
echo "###########################"
install_composer
echo "###########################"

echo "###########################"
echo "Installing Redis..."
echo "###########################"
install_redis
echo "###########################"

echo "###########################"
echo "Installing Docker..."
echo "###########################"
install_docker
echo "###########################"
