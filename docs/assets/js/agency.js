// Agency Theme JavaScript

(function ($) {
  "use strict"; // Start of use strict

  if (!$("#container404").length) {
    // jQuery for page scrolling feature - requires jQuery Easing plugin
    $("a.page-scroll").bind("click", function (event) {
      var $anchor = $(this);
      $("html, body")
        .stop()
        .animate(
          {
            scrollTop: $($anchor.attr("href")).offset().top - 50,
          },
          1250,
          "easeInOutExpo",
        );
      event.preventDefault();
    });

    // Highlight the top nav as scrolling occurs
    $("body").scrollspy({
      target: ".navbar-fixed-top",
      offset: 51,
    });

    // Closes the Responsive Menu on Menu Item Click
    $(".navbar-collapse ul li a").click(function () {
      $(".navbar-toggle:visible").click();
    });
  }

  // Offset for Main Navigation
  $("#mainNav").affix({
    offset: {
      top: 100,
    },
  });

  // Remove padding (bootstrap .fade bugfix)
  $(".portfolio-link").click(function () {
    setTimeout(function () {
      $(".portfolio-modal").css({ padding: "0px" });
    }, 200);
  });

  // If the page is 404 always affix
  if ($("#container404").length) {
    var el = $(".affix-top");
    el.addClass("affix");
    el.removeClass("affix-top");
    console.log("page 404, force affix on navbar");
    $("a").each(function (index, element) {
      $(this).prop("href", "/" + $(element).attr("href"));
    });
  }
})(jQuery); // End of use strict
