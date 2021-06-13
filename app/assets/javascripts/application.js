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
    // 無限に追加する要素は、どこに入れる？
    contentSelector: '.jscroll',
    // // 次のページにいくためのリンクの場所は？ ＞aタグの指定
    nextSelector: 'a.next',
    // 読み込み中の表示はどうする？
    loadingHtml: '読み込み中'
  });
});

// $(document).on('turbolinks:load', function(){
//   $('.image-top').hide().fadeIn(2800);
// });

$(document).on('turbolinks:load', function(){
  $('.p-top').hide().fadeIn(2000);
});

$(document).on('turbolinks:load', function(){
  $('.p-bottom').hide().fadeIn(6000);
});

// $(document).on('turbolinks:load', function() {
//     $(this).click(function(){
//         $('.form-page').toggleClass("active");
//     });
// });

$(document).on('turbolinks:load', (function() {
  $('.post-button').on('click', function(event) {
    $(this).toggleClass('active');
    $('.form-page').fadeToggle();
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
    // スライドショーの変化 ("fade" or "slide")
    transition : 'fade',
    // 変化に係る時間(ミリ秒)
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : 'block',
    // 子要素の種類('div' or 'img')
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : true,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 4000,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : true,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
    hidePrevious : false
  });
});