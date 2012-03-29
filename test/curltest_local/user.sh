# user log in
#curl http://0.0.0.0:3001/api/v1/users -d email=lolcat@lolcat.lolcat -d password=lolcat -d game_token=12345
#curl http://0.0.0.0:3001/api/v1/users -d email=lolcat@lolcat.lolcat -d password=lolcat -d game_token=''
#curl http://0.0.0.0:3001/api/v1/users -d email=lolcat@lolcat.lolcat -d password='' -d game_token=12345
#curl http://0.0.0.0:3001/api/v1/users -d email=lolcat@lolcat.lolcat -d password=lolcat -d game_token=12345

# user create
#curl http://0.0.0.0:3001/api/v1/users/create -d email=jack@gmail.com.com -d password=jack12 -d game_token=12345
#curl http://0.0.0.0:3001/api/v1/users/create -d email=lolcat@lolcat.lolcat -d password=lolcat -d game_token=12345
#curl http://0.0.0.0:3001/api/v1/users/create -d email=lolcat@lolcat.lolcat -d password=lolcat
#curl http://0.0.0.0:3001/api/v1/users/create -d email=lolcat@lolcat.lolcat -d game_token=12345
#curl http://0.0.0.0:3001/api/v1/users/create -d password=lolcat -d game_token=12345

# user updatea
# should allow one to update
# name
# password
# credit card
# shipping address
#curl http://0.0.0.0:3001/api/v1/users/update -d email=jack@gmail.com.com -d password=jack12 -d game_token=12345
#curl http://0.0.0.0:3001/api/v1/users/update -d email=jack@gmail.com.com -d password=jack12 -d game_token=12345
#curl http://0.0.0.0:3001/api/v1/users/update -d email=jack@gmail.com.com -d password=jack12 -d game_token=12345
#curl http://0.0.0.0:3001/api/v1/users/update -d email=jack@gmail.com.com -d password=jack12 -d game_token=12345

