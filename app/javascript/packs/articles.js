$(document).ready(function() {
  if ($('#paginate-infinite-scroll').length) {
    $(window).scroll(function() {
      var url = $('#paginate-infinite-scroll .pagination .page-item .page-link:last').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('#paginate-infinite-scroll').text("Please Wait...");
        return $.getScript(url);
      }
    });
    return $(window).scroll();
  }
});
