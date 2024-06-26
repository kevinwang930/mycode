# key generation

openssl rand  -hex 16


# encryption


openssl enc -aes-128-cbc -nosalt -K  63ccb45a6fb711fd5c5a7492ede6d7c0 -iv 00000000000000000000000000000000 -in /Users/hwkf-marlsen-47932/Downloads/3209828-uhd_3840_2160_25fps.mp4 -out /Users/hwkf-marlsen-47932/Downloads/encrypt.mp4 


# decryption
openssl enc -d -aes-128-cbc -in /Users/hwkf-marlsen-47932/Downloads/encrypt.mp4 -out /Users/hwkf-marlsen-47932/Downloads/decrypt.mp4 -pass file:key.enc