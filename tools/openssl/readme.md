# key generation  密钥生成

openssl rand  -hex 16



# 初始化向量生成
openssl rand -hex 16 


# encryption


openssl enc -aes-128-cbc -nosalt -K  59059f0545f7ae36fad3fdfdaceee09a -iv 59059f0545f7ae36fad3fdfdaceee09a -in /Users/hwkf-marlsen-47932/Downloads/sample_2560x1440.mp4 -out /Users/hwkf-marlsen-47932/Downloads/encrypt.mp4


# decryption
openssl enc -d -aes-128-cbc -nosalt  -K  15af2db352a3a1d742a11a67eb4b901785007e4df3a3e380e0895a96406f6181 -iv 59059f0545f7ae36fad3fdfdaceee09a  -in /Users/hwkf-marlsen-47932/Downloads/encrypt.mp4 -out /Users/hwkf-marlsen-47932/Downloads/decrypt.mp4 


