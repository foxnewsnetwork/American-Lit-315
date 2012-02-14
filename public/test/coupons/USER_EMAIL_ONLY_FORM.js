
var USER_EMAIL_ONLY_FORM;
if(USER_EMAIL_ONLY_FORM == undefined) {
  USER_EMAIL_ONLY_FORM = {};
}

USER_EMAIL_ONLY_FORM.load = function() {
  this.barometer_id = 'api/v1/user_email_form';
  this.empty_url = "http://getbarometer.s3.amazonaws.com/assets/barometer/images/transparent.gif";
  this.feedback_url = '';

  this.tab_html = '<a id="barometer_tab" onclickY_FROM.show();" href="#">Feedback</a>';

  this.overlay_html = '<div id="barometer_overlay" style="display: none;">' +
			'<div id="barometer_main" style="top: 130.95px;">' +
			'<a id="barometer_close" onclick="document.getElementById(\'barometer_overlay\').style.display = \'none\';return false" href="#"/></a>' +
			'<div id="overlay_header">' +
				'</div>' +
				'<iframe src="' + this.feedback_url + '" id="barometer_iframe" allowTransparency="true" scrolling="no" frameborder="0" class="loading"></iframe>' +
				'</div>' +
				'<div id="barometer_screen" onclick="document.getElementById(\'barometer_overlay\').style.display = \'none\';return false" style="height: 100%;"/>' +
				'</div>' +
	'</div>';
       
       
    document.write(this.tab_html);
    document.write(this.overlay_html);    
};

USER_EMAIL_ONLY_FORM.show = function(token, coupon_id) {
  feedback_url = 'http://0.0.0.0:3000/' + this.barometer_id + '?token='+ token +'&'+'coupon_id=' + coupon_id;
  document.getElementById('barometer_iframe').setAttribute("src", feedback_url);
  document.getElementById('barometer_overlay').style.display = "block";
  return false;
};
