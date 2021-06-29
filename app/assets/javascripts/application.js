// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery.jscroll.min.js
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    contentSelector: '.jscroll',
    nextSelector: 'a.next',
    loadingHtml: '読み込み中'
  });
});

$(document).on('turbolinks:load', function(){
  $('.p-top').hide().fadeIn(2000);
});

$(document).on('turbolinks:load', function(){
  $('.p-bottom').hide().fadeIn(6000);
});

$(document).on('turbolinks:load', (function() {
  $('.post-button').on('click', function(event) {
    $(this).toggleClass('active');
    $('.form-page').fadeToggle();
    $('#theTarget').fadeToggle();
    event.preventDefault();
  });
}));

$(document).on('turbolinks:load', (function() {
  $('.tag-button').on('click', function(event) {
    $(this).toggleClass('active');
    $('.tag-lists').fadeToggle();
    event.preventDefault();
  });
}));

$(document).on('turbolinks:load', function () {
  $("#theTarget").skippr({
    transition : 'fade',
    speed : 1000,
    easing : 'easeOutQuart',
    navType : 'block',
    childrenElementType : 'div',
    arrows : true,
    autoPlay : true,
    autoPlayDuration : 4000,
    keyboardOnAlways : true,
    hidePrevious : false
  });
});

// document.addEventListener("turbolinks:load", () => {
//     function scrollToEnd() {
//         const messageDetails = document.getElementById('scroll-inner');
//         messageDetails.scrollTop = messageDetails.scrollHeight;
//     }
//     scrollToEnd();
// });

$(function() {
  $(document).on('click', '.sign_button', function() {
    $('.sign_modal_wrapper').show();
    $('.sign_modal').show();
    if ($(this).hasClass('sign_up_button')) {
      $('.sign_up_modal').show();
    } else {
      $('.sign_in_modal').show();
    }
  });
});

$(document).on('click', '.sign_modal_wrapper, .fa_wrapper, .button', function() {
    $('.sign_modal_wrapper').hide();
    $('.sign_modal').hide();
    $('.sign_modal_content').hide();
});
