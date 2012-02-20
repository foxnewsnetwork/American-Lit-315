module TmpUsersHelper
  def time_left
    expire = @coupon_stat.updated_at + 1.days
    @time_left = (((Time.parse(DateTime.now.to_s) - Time.parse(expire.to_s))/1.hour)).abs
    return @time_left.floor
  end
end
