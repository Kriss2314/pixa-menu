var entity = undefined;
var close = true;
$(document).ready(function(){
  // Mouse Controls
  audioClick 		= new Audio('https://www.zapsplat.com/wp-content/uploads/2015/sound-effects-18146/zapsplat_multimedia_click_001_19367.mp3');
  audio 				= new Audio('http://freesound.org/data/previews/166/166186_3034894-lq.mp3');
  audioClick.volume	 = 0.1;
  audio.volume	 = 0.3;





  // Listen for NUI Events
  window.addEventListener('message', function(event){
    
   
 
    if(event.data.type == 'open'){
      $(".crosshair").addClass('fadeIn');
      $(".crosshair").addClass('active');
      $(".menu").empty();
      var options = event.data.options;

        entity = event.data.entity;
 
      close = event.data.closeMenu;
      for (var i=0; i < options.length; i++) {
        if (options[i].drawing == undefined || options[i].drawing == true) {
        $(".menu").append(`
        <li><p class="${options[i].event}" data-event="${options[i].event}" href=""><i class="${options[i].icon}"></i> ${options[i].label}</p></li>
        `);
        }
      }
      $(".menu").addClass('fadeIn');
  
    } else if (event.data.type == 'close') {
      $(".crosshair").removeClass('fadeIn').removeClass('active');
      $(".menu").empty();
      $(".menu").removeClass('fadeIn');
      $.post('http://pixa_menu/disablenuifocus', JSON.stringify({
        nuifocus: false
      }));
    }


  });





  $(document.body).on('mouseenter', '.menu li p' ,function(e){
    audio.play();
});


  $(document.body).on('click', '.menu li p' ,function(e){
    var event = $(this).data('event');
    var open = $(this).data('leaveOpen');
    e.preventDefault();
    audioClick.play();
    //console.log(close);
    if (close) {
      $(".crosshair").removeClass('fadeIn').removeClass('active');
      $(".menu").empty();
      $(".menu").removeClass('fadeIn');
      $.post('http://pixa_menu/disablenuifocus', JSON.stringify({
        nuifocus: false
      }));
    }
      $.post('http://pixa_menu/useEvent', JSON.stringify({
        event: event,
        entity: entity
      }));
});


    // Click Crosshair
    $('.crosshair').on('click', function(e){
      e.preventDefault();
      $(".crosshair").removeClass('fadeIn').removeClass('active');
      $(".menu").empty();
      $(".menu").removeClass('fadeIn');
      $.post('http://pixa_menu/disablenuifocus', JSON.stringify({
        nuifocus: false
      }));
    });

   

    $(document).keypress(function(e){
      if(e.which == 101){ // if "E" is pressed
        $(".crosshair").removeClass('fadeIn').removeClass('active');
        $(".menu").removeClass('fadeIn');
        $(".menu").empty();
        $.post('http://pixa_menu/disablenuifocus', JSON.stringify({
          nuifocus: false
        }));
      }
    });


  

});
