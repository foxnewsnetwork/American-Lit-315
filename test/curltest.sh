# user log in
#curl http://0.0.0.0:3000/api/v1/users -d email=lolcat@lolcat.lolcat -d password=lolcat -d game_token=12345
#curl http://0.0.0.0:3000/api/v1/users -d email=lolcat@lolcat.lolcat -d password=lolcat -d game_token=''
#curl http://0.0.0.0:3000/api/v1/users -d email=lolcat@lolcat.lolcat -d password='' -d game_token=12345
#curl http://0.0.0.0:3000/api/v1/users -d email=lolcat@lolcat.lolcat -d password=lolcat -d game_token=12345

# user create
curl http://0.0.0.0:3000/api/v1/users/create -d email=chicken@chicken.chicken -d password=chicken -d game_token=12345
curl http://0.0.0.0:3000/api/v1/users/create -d email=lolcat@lolcat.lolcat -d password=lolcat -d game_token=12345
curl http://0.0.0.0:3000/api/v1/users/create -d email=lolcat@lolcat.lolcat -d password=lolcat
curl http://0.0.0.0:3000/api/v1/users/create -d email=lolcat@lolcat.lolcat -d game_token=12345
curl http://0.0.0.0:3000/api/v1/users/create -d password=lolcat -d game_token=12345
