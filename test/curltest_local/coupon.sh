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
