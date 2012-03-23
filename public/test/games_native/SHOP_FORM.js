function initTabRight(){
	$("#gamertiser_shop_tab").css("right",'0');
	$("#gamertiser_shop_tab").css("margin-right",'-7px');
}

var horizontal_right = $(document).width()-$("#gamertiser_shop_main").width()-30;
var horizontal_middle =$(document).width()/2+$("#gamertiser_shop_main").width()/2;

var vertical_bottom = $(document).height()-$("#gamertiser_shop_main").height()-20;
var vertical_middle = $(document).height()/2-$("#gamertiser_shop_main").height()/2;

function initShopPosition(vertical, horizontal, shop_width, shop_height){
	var x, y;
	if (horizontal == 'left'){
		x = 0;
	} else if (horizontal == 'middle') {
		x = $(document).width()/2-shop_width/2;
	} else if (horizontal == 'right') {
		x = $(document).width()-shop_width-20;
	}
	if (vertical == 'top'){
		y = 0;
	} else if (vertical == 'middle') {
		y = $(document).height()/2-shop_height/2;
	} else if (vertical == 'bottom') {
		y = $(document).height()-shop_height-20;
	}
	//alert('shop width is ' + shop_width +' '+ shop_height);
	//alert('Page format is '+ $(document).width() +' '+$(document).height());
	//alert('final format is '+ x +' '+y);
	$("#gamertiser_shop_main").css("left",x);
	$("#gamertiser_shop_main").css("top", y);
}

var SHOP_FORM;
if(SHOP_FORM == undefined) {
  SHOP_FORM = {};
}

SHOP_FORM.load = function(token) {

  this.gamertiser_shop_id = 'api/v1/coupon_form';
  this.empty_url = "http://getgamertiser_shop.s3.amazonaws.com/assets/gamertiser_shop/images/transparent.gif";
  this.feedback_url = '';

  this.tab_html = '<a id="gamertiser_shop_tab" onclick="GAMERTISER_DISPLAY_SHOP(\'' + token +'\');" href="#">Feedback</a>';

  this.overlay_html = '<div id="gamertiser_shop_overlay" style="display: none;">' +
			'<div id="gamertiser_shop_main">' +
			'<a id="gamertiser_shop_close" onclick="document.getElementById(\'gamertiser_shop_overlay\').style.display = \'none\';return false" href="#"/></a>' +
			'<div id="overlay_header">' +
				'</div>' +
				'<iframe src="' + this.feedback_url + '" id="gamertiser_shop_iframe" allowTransparency="true" scrolling="no" frameborder="0" class="loading"></iframe>' +
				'</div>' +
				'<div id="gamertiser_shop_screen" onclick="document.getElementById(\'gamertiser_shop_overlay\').style.display = \'none\';return false" style="height: 100%;"/>' +
				'</div>' +
	'</div>';
       
    //put up the tab and over_lay 
    document.write(this.tab_html);
    document.write(this.overlay_html);    
};

SHOP_FORM.show = function() {
  //feedback_url = 'http://gamertiser.com/' + this.gamertiser_shop_id + '?token='+ token +'&'+'coupon_id=' + coupon_id;
  feedback_url = 'http://gamertiser.com/api/v1/product_inventory_display';
  document.getElementById('gamertiser_shop_iframe').setAttribute("src", feedback_url);
  //javascript based
  //document.getElementById('gamertiser_shop_overlay').style.display = "block";
  $('#gamertiser_shop_overlay').show(800 );
  return false;
};

//gamteriser show reward controllers
function gamertiser_tmp_product(token, coupon_id) {
		SHOP_FORM.show(token, coupon_id);
	}

// given type:string, token:string, id:integer
// send in the put request to increment click_through
function gamertiser_product_click_through(type, id, token) {
	var my_url = 'http://gamertiser.com/api/v1/' + type + '?token=' + token + '&' + type + '_id=' + id;

    $.ajax({
		url: my_url,
	    type: 'PUT',
		    data: '',
		    success: gamertiser_tmp_product(token, id)
	});
}
// given data:json, type:string, token:string
// use jquery to append the type of product in the correct tags
function gamertiser_show_reward_product(data, type, token) {
	if (type == 'coupon') {
		var func = "gamertiser_coupon_click_through('"+ type +"','" + data.id+ "' , '"+ token+"')"
		f = $("<a/>").attr("onclick", func).appendTo("#gamertiser_images");
		f.append($("<img/>").attr("src", data.picture_path));
	} else if (type == 'product'){
		var func = "gamertiser_product_click_through('" + type + "','" + data.id+ "' , '"+ token+"')"
		f = $("<a/>").attr("onclick", func).appendTo("#gamertiser_products");
		f.append($("<img/>").attr("src", data.picture_path));
	}
}
function GAMERTISER_SHOW_P(type, token){

	$(document).ready(function(){
        var url = "http://gamertiser.com/api/v1/" + type +".json?token=" + token
        $.getJSON(url + "&callback=?", null,
		function(data){
			gamertiser_show_reward_product(data, type, token);
		});
	});
}

function GAMERTISER_DISPLAY_SHOP(token){
	SHOP_FORM.show();
	//re-get everything
	
//for each item, can display appropriate prompt

}
