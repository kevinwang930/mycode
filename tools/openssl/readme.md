# key generation  密钥生成

openssl rand  -hex 16



# 初始化向量生成
openssl rand -hex 16 


# encryption

openssl enc -aes-128-cbc -nosalt -K  21dfd0452ec3de6ea4c2ea0e768a6cc4 -iv de58f7f4c72b015d88f83a5ba9877890 -in /Users/hwkf-marlsen-47932/Downloads/sample_2560x1440.mp4 -out /Users/hwkf-marlsen-47932/Downloads/encrypt.mp4


# decryption
openssl enc -d -aes-128-cbc -nosalt  -K  aff42baa5e3b846e339f091ea96e77c3 -iv 00000000000000000000000000000000  -in /Users/hwkf-marlsen-47932/Downloads/encrypt.mp4 -out /Users/hwkf-marlsen-47932/Downloads/decrypt.mp4 


