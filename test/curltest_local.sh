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

# Coupon Show (Get)
#curl http://0.0.0.0:3001/api/v1/coupon.json -d token=12345

#curl http://0.0.0.0:3001/api/v1/coupon.json -d token=skladjfklajf
#curl http://0.0.0.0:3001/api/v1/coupon.json

# Coupon Increment Click Through (PUT)
# TODO: this does quite work
#curl http://0.0.0.0:3001/api/v1/coupon.json --request PUT --data "token=12345"

# Coupon Redeem (POST)
#curl http://0.0.0.0:3001/api/v1/coupon/redeem.json -d token=12345 -d email=hanqijing@gmail.com -d coupon_id=1

#curl http://0.0.0.0:3001/api/v1/coupon/redeem.json -d token=aefe2fwaf -d email=hanqijing@gmail.com -d coupon_id=0123
#curl http://0.0.0.0:3001/api/v1/coupon/redeem.json -d token=12345 -d email=hanqaefef -d coupon_id=1
#curl http://0.0.0.0:3001/api/v1/coupon/redeem.json

# Product Show (Get)
curl http://0.0.0.0:3001/api/v1/product.json -d token=12345
#curl http://0.0.0.0:3001/api/v1/product.json -d token=12345 -d productid[]=1 -d productid[]=2
#curl http://0.0.0.0:3001/api/v1/product.json -d token=12345 -d productid=1
#curl http://0.0.0.0:3001/api/v1/product.json -d url=www.facebook.com -d token=1
#curl http://0.0.0.0:3001/api/v1/product.json -d productid=1
#curl http://0.0.0.0:3001/api/v1/coupon.json -d token=skladjfklajf

# Product Purchase (Get)
#curl http://0.0.0.0:3001/api/v1/product.json -d token=12345
#curl http://0.0.0.0:3001/api/v1/product/buy.json -d usertoken=12345 -d productid=1 -d user[email]=hanqijing@gmail.com -d user[name]=han -d user[username]=coke12 -d card[number]=4242424242424242 -d card[ccv]=123 -d card[expmon]=02 -d card[expyear]=2015 -d ip=1234567890 -d url=http://google.com 

# No usertoken
#curl http://0.0.0.0:3001/api/v1/product/buy.json  \
#	-d gametoken=12345  \
#	-d productid=1 \
#	-d user[email]=hanqijing@gmail.com \
#	-d user[name]=han \
#	-d user[username]=coke12 \
#	-d card[number]=4242424242424242 \
#	-d card[ccv]=123 \
#	-d card[expmon]=02 \
#	-d card[expyear]=2015 \
#	-d ip=1234567890 \
#	-d url=http://google.com 

# no product id
#curl http://0.0.0.0:3001/api/v1/product/buy.json  \
#	-d gametoken=12345  \
#	-d usertoken=12345  \
#	-d user[email]=hanqijing@gmail.com \
#	-d user[name]=han \
#	-d user[username]=coke12 \
#	-d card[number]=4242424242424242 \
#	-d card[ccv]=123 \
#	-d card[expmon]=02 \
#	-d card[expyear]=2015 \
#	-d ip=1234567890 \
#	-d url=http://google.com 

# no user
#curl http://0.0.0.0:3001/api/v1/product/buy.json  \
#	-d gametoken=12345  \
#	-d usertoken=12345  \
#	-d productid=1 \
#	-d card[number]=4242424242424242 \
#	-d card[ccv]=123 \
#	-d card[expmon]=02 \
#	-d card[expyear]=2015 \
#	-d ip=1234567890 \
#	-d url=http://google.com 

# no card
#curl http://0.0.0.0:3001/api/v1/product/buy.json  \
#	-d gametoken=12345  \
#	-d usertoken=12345  \
#	-d productid=1 \
#	-d user[email]=hanqijing@gmail.com \
#	-d user[name]=han \
#	-d user[username]=coke12 \
#	-d ip=1234567890 \
#	-d url=http://google.com 

# with everything, this should succeed
curl http://0.0.0.0:3001/api/v1/product/buy.json  \
	-d gametoken=12345  \
	-d usertoken=12345  \
	-d productid=1 \
	-d user[email]=hanqijing@gmail.com \
	-d user[name]=han \
	-d user[username]=coke12 \
	-d card[number]=4242424242424242 \
	-d card[ccv]=123 \
	-d card[expmon]=02 \
	-d card[expyear]=2015 \
	-d ip=1234567890 \
	-d url=http://google.com 
