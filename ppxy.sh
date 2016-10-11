wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0b2.tgz
sudo apt-get install libssl-dev openssl
tar -xvzf Python-3.6.0b2.tgz 
cd Python-3.6.0b2/
./configure 
make
sudo make install
sudo python3.6 -m pip install pproxy
read -p "Please specify your ss pass: " pass
nohup pproxy -i ss://chacha20:$pass@:1287 &
