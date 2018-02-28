// Post Show PAge  https://bonze.tw/jquery-%E5%8F%96%E5%BE%97-dom-%E5%85%83%E7%B4%A0%E5%BA%A7%E6%A8%99-offset-%E8%88%87-position/
$(document).ready(function(){
  var headerHeight = $('header').outerHeight();
  var doctorHeight = $('.container-doctor').outerHeight();
  var postHeight = $('.container-post').outerHeight();
  var contentHeight = $('.section__content').outerHeight();
  var footerHeight = $('footer').outerHeight();
  var wrapperHeight = $('#wrapper__sidebar--posts').outerHeight();
  var scrollStart = headerHeight + doctorHeight;
  var bodyHeight = $('body').height();
  var sidebarHeight = $('#sidebar--posts').height();
  var scrollStop = (headerHeight + doctorHeight + postHeight - sidebarHeight) - 200;
  $(window).on('resize scroll',function(){
    var windowHeight = $(window).height();
    var sidebarOuterHeight = $('#sidebar--posts').outerHeight();
    var noScroll = (sidebarOuterHeight+40);
    var scrollPosition = $(window).scrollTop();
    var newTop = (scrollPosition + headerHeight);
    if (scrollPosition >= doctorHeight) {
      //$('#wrapper__sidebar--posts > #sidebar--posts').addClass('showed');
      $('#wrapper__sidebar--posts > #sidebar--posts').css('top',newTop);
    }
    else {
      //$('#wrapper__sidebar--posts > #sidebar--posts').removeClass('showed');
      $('#wrapper__sidebar--posts > #sidebar--posts').css('top',scrollStart);
    }
    if (scrollPosition >= scrollStop){
      //$('#wrapper__sidebar--posts > #sidebar--posts').addClass('bottom-locked');
      $('#wrapper__sidebar--posts > #sidebar--posts').css('top', scrollStop + 65);
    }
    else {
      $('#wrapper__sidebar--posts > #sidebar--posts').removeClass('bottom-locked');
      console.log(scrollStop);
    }
    if (noScroll > windowHeight) {
      $('#wrapper__sidebar--posts > #sidebar--posts').addClass('top-locked');
    }
    else {
      $('#wrapper__sidebar--posts > #sidebar--posts').removeClass('top-locked');
    }
  });
});

// Doctor Show PAge 
$(document).ready(function(){
  var headerHeight = $('header').outerHeight();
  var doctorHeight = $('.container-doctor').outerHeight();
  var footerHeight = $('footer').outerHeight();
  var wrapperHeight = $('#wrapper__sidebar--doctors').outerHeight();
  var scrollStart = doctorHeight + headerHeight;
  var bodyHeight = $('body').height();
  var sidebarHeight = $('#sidebar--doctors').height();
  var scrollStop = (doctorHeight - sidebarHeight) + 40;
  $(window).on('resize scroll',function(){
    var windowHeight = $(window).height();
    var sidebarOuterHeight = $('#sidebar--doctors').outerHeight();
    var noScroll = (sidebarOuterHeight+40);
    var scrollPosition = $(window).scrollTop();
    var newTop = (scrollPosition + headerHeight);
    if (scrollPosition >= doctorHeight) {
      $('#wrapper__sidebar--doctors > #sidebar--doctors').css('top',newTop);
    }
    else {
      $('#wrapper__sidebar--doctors > #sidebar--doctors').css('top',scrollStart);
    }
    if (scrollPosition >= scrollStop){
      $('#sidebar--doctors').addClass('bottom-locked');
    }
    else {
      $('#sidebar--doctors').removeClass('bottom-locked');
    }
    if (noScroll > windowHeight) {
      $('#sidebar--doctors').addClass('top-locked');
    }
    else {
      $('#sidebar--doctors').removeClass('top-locked');
    }
  });
});

