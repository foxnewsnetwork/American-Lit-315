# No usertoken
#curl http://0.0.0.0:3000/api/v1/product/buy.json  \
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
#curl http://0.0.0.0:3000/api/v1/product/buy.json  \
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
#curl http://0.0.0.0:3000/api/v1/product/buy.json  \
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
#curl http://0.0.0.0:3000/api/v1/product/buy.json  \
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
