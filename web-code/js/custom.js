$(document).ready(function(){  
     //-------- To add the active class for how it work section ----------//
     var url = document.URL;
	 var id = url.substring(url.lastIndexOf('#') + 1);     
 	  if(id=='stasherWork')
	  {
	 	 $('.topNavigation li').removeClass('active');
	     $('#stasherTop').parent('li').addClass('active');
	  }
	  
	 $('#stasherTop').click(function(){  
	 $('html, body').animate( { scrollTop:$('#stasherWork').position().top }, 'slow');
	 $('.topNavigation li').removeClass('active');
	 $('#stasherTop').parent('li').addClass('active');
     return false;
});

$(window).scroll(function() {    
    var scroll = $(window).scrollTop();

    if (scroll >= 850) {
        $(".howWorks").addClass("active");
		$(".home").removeClass("active");
    } else {
        $(".howWorks").removeClass("active");
		$(".home").addClass("active");
    }
});
$( document ).ready(function() {

 $("#submitcontactform").click(function(){
		var email = $("#email").val();
		var fullname = $("#fullname").val();
		var ajaxurl = "subscribe.php";
		var data = {
			email:email, fullname:fullname  };
    		jQuery.post(ajaxurl, data, function(response) {
			$("#msgdiv").val('');
			$("#msgdiv").html(response);
   	});
   
});
});

//var s = $(".stasherWork");	
//var pos = s.position();	
var nav = $(".navigation");
$(window).scroll(function() {
	var windowpos = $(window).scrollTop();
		if (windowpos >= '150') {
			nav.addClass("stick");			
		} else {
			nav.removeClass("stick");				
		}
});

});

$(window).load(function(){
  $('.flexslider').flexslider({
	animation: "slide",
	start: function(slider){
	  $('body').removeClass('loading');
	}
  });
});
  



  