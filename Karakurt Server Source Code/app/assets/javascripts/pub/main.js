
(function ($) {
    $(document).on('ready', function () {
        "use strict";
        /**Tooltip**/
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        })

        /**Scroll to top**/
        function scrollToTop() {
            $("html, body").animate({ scrollTop: 0 }, 0);
        }
        /**Menu**/
        $('.menu-icon-mobile').on('click', function () {
            $('body').toggleClass("open-menu-mobile");
        });
        $('.menu-icon').on('click', function () {
            $('body').toggleClass("open-menu");
            setTimeout(scrollToTop, 0);
        });
        $('.menu-res li.menu-item-has-children').on('click', function (event) {
            event.stopPropagation();
            var submenu = $(this).find(" > ul");
            if ($(submenu).is(":visible")) {
                $(submenu).slideUp();
                $(this).removeClass("open-submenu-active");
            }
            else {
                $(submenu).slideDown();
                $(this).addClass("open-submenu-active");
            }
        });

        $('.menu-res li.menu-item-has-children > a').on('click', function () {
          //  return false;
        });


        /** Back To Top**/
        var win = $(window);
        var totop = $('.totop');
        win.on('scroll', function () {
            if ($(this).scrollTop() >= 300) {
                $(totop).addClass("show");
            }
            else {
                $(totop).removeClass("show");
            }
        });
        $(totop).on('click', function () {
            $("html, body").animate({ scrollTop: 0 }, 1500);
        });


        /**Search Box**/
        var menu_inner = $('.menu-main-inner');
        $('.search-icon').on('click', function () {
            if ($(menu_inner).hasClass("show-search")) {
                $(menu_inner).removeClass("show-search");
            }
            else {
                $(menu_inner).addClass("show-search");
                setTimeout(function () { $('.txt-search').focus(); }, 300);
            }
        });

        var mobile_bar = $('.mobile-bar');
        $('.search-icon-mobile').on('click', function () {
            if ($(mobile_bar).hasClass("show-search-mobile")) {
                $(mobile_bar).removeClass("show-search-mobile");
            }
            else {
                $(mobile_bar).addClass("show-search-mobile");
                setTimeout(function () { $('.txt-search').focus(); }, 300);
            }
        });

        /**Match height  item**/
        var grids_item = $('.grids-item');
        if ($(grids_item).length) {
            $(grids_item).matchHeight();
        }

        /**Grid pinterest style**/
        var grid = $('.grid');
        if ($(grid).length) {
            $(grid).isotope({
                itemSelector: '.grid-item',
            });
        }

        /**Gallery fancybox**/
        var fancybox = $('.fancybox');
        if ($(fancybox).length) {
            $(fancybox).fancybox({
                scrolling: true
            });
        }
    });

    /**price range slider**/
    var price_slider = $('#price-slider');
    if ($(price_slider).length) {
        $(price_slider).slider({
            tooltip: 'hide'
        });
        $(price_slider).on("slide", function (slideEvt) {
            $('.budget-min em').html(slideEvt.value[0]);
            $('.budget-max em').html(slideEvt.value[1]);
        });
    }
})(jQuery);
