/*! functions.js | Huro | Css ninja 2020-2021 */
"use strict"; //Set environment variable (Used for development and demo)

/* 
    Possible values:
    1. development
    2. customization
*/

var env = 'development'; //Theme colors to be used from JS

var themeColors = {
  primary: '#000',
  primaryMedium: '#d4b3ff',
  primaryLight: '#f4edfd',
  secondary: '#ff227d',
  accent: '#797bf2',
  success: '#06d6a0',
  info: '#039BE5',
  warning: '#faae42',
  danger: '#FF7273',
  purple: '#8269B2',
  blue: '#37C3FF',
  green: '#93E088',
  yellow: '#FFD66E',
  orange: '#FFA981',
  lightText: '#000',
  fadeGrey: '#ededed'
}; //Switch Layouts (DEMO ONLY)

function switchLayouts() {
  var url = window.location.pathname;
  var newUrl = '';
  var urlPrefix = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("-"));
  urlPrefix = urlPrefix.substr(0, urlPrefix.indexOf('-'));
  $('.layout-switcher').on('click', function () {
    if (urlPrefix == 'admin') {
      newUrl = url.replace('admin', 'webapp');
    } else {
      newUrl = url.replace('webapp', 'admin');
    }

    window.location.href = newUrl;
  });
} //Change demo images

//Set Active Links
function setActivelink() {
  var url = window.location.href;
  var activePage = url;
  $('.sidebar-panel .inner ul li a, .mobile-subsidebar ul li a').each(function () {
    var linkPage = this.href;

    if (activePage == linkPage) {
      $(this).closest("li").addClass("is-active");
      $(this).closest('.has-children').find('ul').slideToggle();
      $(this).closest('.has-children').addClass('active');
    }
  });
  $('.main-sidebar .sidebar-inner ul li a').each(function () {
    var linkPage = this.href;

    if (activePage == linkPage) {
      $(this).closest("li").find('a').addClass("is-selected");
    }
  });
  $('.webapp-subnavbar-inner .center ul li a').each(function () {
    var linkPage = this.href;

    if (activePage == linkPage) {
      $(this).closest("li").addClass("is-active");
      $(this).closest(".tab-content").addClass("is-active").siblings('.tab-content').removeClass('is-active');
      var tabId = $(this).closest('.tab-content').attr('id');
      $(this).closest(".webapp-subnavbar-inner").find('.tabs ul li').removeClass('is-active');
      $('[data-tab=' + tabId + ']').addClass('is-active');
    }
  });
} //Main Sidebar


function initSidebar() {
  $('.huro-hamburger').on("click", function () {
    if ($(this).hasClass('full-push')) {
      var sidebar = $(this).attr('data-sidebar');
      $('.nav-trigger .menu-toggle .icon-box-toggle').toggleClass('active');
      $('#' + sidebar).toggleClass('is-active');
      $('.view-wrapper').toggleClass('is-pushed');

      if ($('.main-sidebar, .sidebar-brand').hasClass('is-bordered')) {
        $('.main-sidebar, .sidebar-brand').removeClass('is-bordered');
      } else {
        $('.main-sidebar, .sidebar-brand').addClass('is-bordered');
      }

      $('body').toggleClass('opened');
    }

    if ($(this).hasClass('push-resize')) {
      var sidebar = $(this).attr('data-sidebar');
      $('.nav-trigger .menu-toggle .icon-box-toggle').toggleClass('active');
      $('#' + sidebar).toggleClass('is-active');
      $('.view-wrapper').toggleClass('is-pushed-full');

      if ($('.main-sidebar, .sidebar-brand').hasClass('is-bordered')) {
        $('.main-sidebar, .sidebar-brand').removeClass('is-bordered');
      } else {
        $('.main-sidebar, .sidebar-brand').addClass('is-bordered');
      }

      $('body').toggleClass('opened');

      if ($(this).hasClass('messages-push')) {
        $('.view-wrapper').toggleClass('is-pushed-messages');
        $('.collapsed-messaging').toggleClass('is-active');
        $('body').toggleClass('is-chat-side-collapsed');
      }
    }

    if ($(this).hasClass('push-search')) {
      var sidebar = $(this).attr('data-sidebar');
      $('.nav-trigger .menu-toggle .icon-box-toggle').toggleClass('active');
      $('#' + sidebar).toggleClass('is-active');
      $('.view-wrapper').toggleClass('is-pushed-search');

      if ($('.main-sidebar, .sidebar-brand').hasClass('is-bordered')) {
        $('.main-sidebar, .sidebar-brand').removeClass('is-bordered');
      } else {
        $('.main-sidebar, .sidebar-brand').addClass('is-bordered');
      }

      $('body').toggleClass('opened');
    }
  }); //Close sidebar

  $('.panel-close').on('click', function () {
    $(this).closest('.sidebar-panel').removeClass('is-active');
    $('.huro-hamburger .icon-box-toggle').removeClass('active');

    if ($('.main-sidebar, .sidebar-brand').hasClass('is-bordered')) {
      $('.main-sidebar, .sidebar-brand').removeClass('is-bordered');
    } else {
      $('.main-sidebar, .sidebar-brand').addClass('is-bordered');
    }

    $('body').toggleClass('opened');
  }); //Sidebar links default behaviour

  $('.main-sidebar ul li a').on('click', function () {
    $('.main-sidebar ul li a').removeClass('is-selected');
    $(this).addClass('is-selected');
  }); //Collapsible submenu items

  $(".has-children .parent-link").on("click", function (i) {
    i.preventDefault();

    if (!$(this).closest('.has-children').hasClass("active")) {
      $(".sidebar-panel .has-children ul, .mobile-subsidebar .has-children ul").slideUp();
      $(this).closest('.has-children').find('ul').slideToggle();
      $(".sidebar-panel .has-children, .mobile-subsidebar .has-children").removeClass("active");
      $(this).closest('.has-children').addClass("active");
    } else {
      $(this).closest('.has-children').find('ul').slideToggle();
      $(".sidebar-panel li, .mobile-subsidebar li").removeClass("active");
    }
  }); //User menu naver position

  $('#user-menu').on('click', function () {
    $('.naver').addClass('from-bottom');
    $('.naver').css({
      'margin-bottom': 64
    });
  });
  $(window).on('scroll', function () {
    var height = $(window).scrollTop();

    if (height > 80) {
      $(".circular-menu").addClass('is-active');
    } else {
      $(".circular-menu").removeClass('is-active active');
    }
  });
} //Close sidebar


function closeSidebarPanel() {
  $('.sidebar-panel.is-active').removeClass('is-active');
  $('.huro-hamburger .icon-box-toggle').removeClass('active');
  $('.view-wrapper').removeClass('is-pushed-full');

  if ($('.main-sidebar, .sidebar-brand').hasClass('is-bordered')) {
    $('.main-sidebar, .sidebar-brand').removeClass('is-bordered');
  } else {
    $('.main-sidebar, .sidebar-brand').addClass('is-bordered');
  }

  $('body').toggleClass('opened');
} //Sidebar Flying Naver


function updateSidebarNaver() {
  var activeItem = $('[data-menu-item]').attr('data-menu-item');
  var mobileActiveItem = $('[data-mobile-item]').attr('data-mobile-item');
  $(activeItem).addClass('is-active');
  $(mobileActiveItem).addClass('is-active');

  if ($('[data-naver-offset]').length) {
    var naverOffset = parseInt($('.view-wrapper').attr('data-naver-offset'));
    $('.naver').removeClass('from-bottom');
    $('.naver').css({
      'margin-top': naverOffset
    });
  } else if ($('[data-naver-offset-bottom]').length) {
    var naverOffsetBottom = parseInt($('.view-wrapper').attr('data-naver-offset-bottom'));
    $('.naver').addClass('from-bottom');
    $('.naver').css({
      'margin-bottom': naverOffsetBottom
    });
  }
} //Webapp Navigation


function initWebapp() {
  //Set page title
  var pageTitle = $('.view-wrapper').attr('data-page-title');
  $('#webapp-page-title').html(pageTitle); //Webapp Navbar

  $(window).on('scroll', function () {
    var height = $(window).scrollTop();

    if (height > 10) {
      $(".webapp-navbar.is-transparent, .webapp-navbar-clean.is-transparent").addClass('is-scrolled');
    } else {
      $(".webapp-navbar.is-transparent, .webapp-navbar-clean.is-transparent").removeClass('is-scrolled');
    }
  }); //Set active navbar menu

  var activeWebappMenu = $('.view-wrapper').attr('data-menu-item');
  // $('.centered-link-toggle').removeClass('is-active');
  $(activeWebappMenu).addClass('is-active'); //Open navbar menu

  $('.webapp-navbar .centered-link-toggle').on('click', function () {
    var menu = $(this).attr('data-menu-id');

    if ($(this).hasClass('is-active') && $('.webapp-subnavbar').hasClass('is-active')) {
      $('.webapp-subnavbar').removeClass('is-active');
      $(".webapp-navbar").removeClass('is-solid');
    } else {
      $('.webapp-subnavbar').addClass('is-active');
      $(".webapp-navbar").addClass('is-solid');
    }

    $('.webapp-navbar .centered-link').removeClass('is-active');
    $(this).addClass('is-active');
    $('.webapp-subnavbar-inner').removeClass('is-active');
    $("#" + menu).addClass('is-active');
  }); //Toggle Search

  $('.webapp-navbar .centered-link-search, #webapp-navbar-search-close').on('click', function () {
    $('#webapp-navbar-menu, #webapp-navbar-search').toggleClass('is-hidden');
    $('#webapp-navbar-search input').focus();
    $('.webapp-subnavbar').removeClass('is-active');
  }); //dropdown webapp navbar submenus

  if ($('.webapp-navbar .category-selector').length) {
    $('.webapp-navbar .category-selector .category-item').on('click', function () {
      var category = $(this).attr('data-category');
      var container = $(this).closest('.dropdown');
      container.find('.mega-menus').removeClass('is-active');
      $('#' + category).addClass('is-active');
      container.find('.content-wrap, .category-selector').toggleClass('is-hidden');
    });
    $('.webapp-navbar .back-button').on('click', function () {
      var container = $(this).closest('.dropdown');
      container.find('.content-wrap, .category-selector').toggleClass('is-hidden');
    });
  }
} //Mobile Navbar


function initMobileNavbar() {
  $(window).on('scroll', function () {
    var height = $(window).scrollTop();

    if (height > 65) {
      $(".mobile-navbar").removeClass('no-shadow');
    } else {
      $(".mobile-navbar").addClass('no-shadow');
    }
  });
} //Mobile Navbar Hamburger


function initMobileNavbarHamburger() {
  if ($('.navbar-burger').length) {
    $('.navbar-burger').on("click", function () {
      $(this).toggleClass('is-active');

      if ($('.mobile-main-sidebar').hasClass('is-active')) {
        $('.mobile-main-sidebar, .mobile-subsidebar').removeClass('is-active');
      } else {
        $('.mobile-main-sidebar, .mobile-subsidebar').addClass('is-active');
      }
    });
  }
} //Init Sidebar on page load


function openSidebar() {
  $('.nav-trigger .menu-toggle .icon-box-toggle').toggleClass('active');
  $('.sidebar-panel').addClass('is-active');
  $('.view-wrapper').addClass('is-pushed-full');
  $('body').addClass('opened');
  $('.main-sidebar, .sidebar-brand').addClass('is-bordered');
} //Stuck form header


function initStuckHeader() {
  if ($('.stuck-header').length) {
    $(window).on('scroll', function () {
      var height = $(window).scrollTop();

      if (height > 80) {
        $(".stuck-header").addClass('is-stuck');
      } else {
        $(".stuck-header").removeClass('is-stuck');
      }
    });
  }
} //Navbar Dropdowns


function initNavbarDropdowns() {
  $('.has-dropdown').on('click', function () {
    $('.has-dropdown').removeClass('is-active');
    $(this).addClass('is-active');
  });
  $(document).on('click', function (e) {
    var target = e.target;

    if (!$(target).is('.has-dropdown .navbar-link') && !$(target).parents().is('.has-dropdown')) {
      $('.has-dropdown').removeClass('is-active');
    }
  });
} //Regular Dropdowns


function initDropdowns() {
  $('.dropdown-trigger').on('click', function () {
    $('.dropdown').removeClass('is-active');
    $(this).addClass('is-active');
  });
  $(document).on('click', function (e) {
    var target = e.target;

    if (!$(target).is('.dropdown img, .kill-drop') && !$(target).parents().is('.dropdown')) {
      $('.dropdown').removeClass('is-active');
    }

    if ($(target).is('.kill-drop')) {
      $('.dropdown').removeClass('is-active');
    }
  });
} //Mobile Dropdowns


function initMobileDropdowns() {
  $('.has-dropdown.is-mobile').on('click', function () {
    $(this).find('.navbar-link').toggleClass('is-active');
    $(this).find('.mobile-dropdown').slideToggle();
  });
} //Adjust dropdowns


function adjustDropdowns() {
  $('.dropdown:not(.user-dropdown)').each(function () {
    var $this = $(this);

    if ($(this).offset().top + $(this).height() >= $(window).height() - 250) {
      $($this).addClass("is-up");
    } else {
      $($this).removeClass("is-up");
    }
  });
  $(window).on('scroll', function () {
    $('.dropdown:not(.user-dropdown)').each(function () {
      var $this = $(this);

      if ($(this).offset().top + $(this).height() >= $(window).height() - 250) {
        $($this).addClass("is-up");
      } else {
        $($this).removeClass("is-up");
      }
    });
  });
} //Launch an alert dialog


function initConfirm(title, message, maximizable, closableByDimmer, okLabel, cancelLabel, callback) {
  alertify.confirm('confirm').set({
    transition: 'fade',
    title: title,
    message: message,
    movable: false,
    maximizable: maximizable,
    closableByDimmer: closableByDimmer,
    labels: {
      ok: okLabel,
      cancel: cancelLabel
    },
    reverseButtons: true,
    'onok': callback
  }).show();
} //Chosen Selects


function initChosenSelects() {
  if ($('.chosen-select-no-single').length) {
    var config = {
      '.chosen-select-no-single': {
        disable_search_threshold: 100,
        width: "100%"
      }
    };

    for (var selector in config) {
      if (config.hasOwnProperty(selector)) {
        $(selector).chosen(config[selector]);
      }
    }
  }
} //Tabs


function initTabs() {
  $('.tabs-inner .tabs li, .vertical-tabs-wrapper .tabs li').on('click', function () {
    var tab_id = $(this).attr('data-tab'); //$(this).closest('.tabs-wrapper').find('> .tabs-inner > .tabs > li.is-active').removeClass('is-active');
    //$(this).addClass('is-active');

    $(this).siblings('li').removeClass('is-active');
    $(this).addClass('is-active');
    $(this).closest('.tabs-wrapper, .vertical-tabs-wrapper').find('.tab-content').removeClass('is-active');
    $("#" + tab_id).addClass('is-active');
  });
  /*$('.tabs-wrapper.is-slider .tabs a').on('click', function () {
      $(this).closest('.tabs-wrapper').find('.tab-naver').toggleClass('is-active');
  })*/
} //H Select


function initHSelect() {
  $('.h-select').on('click', function () {
    $(this).toggleClass('is-active');
  });
  $(document).click(function (e) {
    var target = e.target;

    if (!$(target).is('.h-select') && !$(target).parents().is('.control')) {
      $('.h-select').removeClass('is-active');
    }
  });
  $('.h-select input').on('change', function () {
    var selectedValue = $(this).siblings('.option-meta').find('span').text();
    $(this).closest('.h-select').find('.select-box span').html(selectedValue);
  });
} //Combo Box


function initComboBox() {
  $('.is-combo .combo-box').on('click', function () {
    $(this).toggleClass('is-active');
  });
  $('.combo-box .box-dropdown li').on('click', function (e) {
    var target = e.target; //Get selected item data

    var itemIconClass = $(this).find('.item-icon i').attr('class');
    var itemIcon = $(this).find('.item-icon i');
    var itemIconClass = $(this).find('.item-icon i').attr('class');
    var itemSvgIcon = $(this).find('.item-icon').html();
    var itemName = $(this).find('.item-name').text();
    var iconTemplate = '<i class="' + itemIconClass + '"></i>';
    var template = '';
    console.log(itemSvgIcon);

    if (!$(target).is('.box-dropdown li, body') && !$(target).parents().is('.box-dropdown')) {
      $('.box-dropdown').removeClass('is-active');
    }

    if ($(target).is('body')) {
      $('.box-dropdown').removeClass('is-active');
    } //Handle dropdown item active state toggle


    $(this).siblings('li.is-active').removeClass('is-active');
    $(this).addClass('is-active'); //Update combo box selected value

    if (itemIcon.length) {
      $(this).closest('.combo-box').find('.combo-item i').remove();
      $(this).closest('.combo-box').find('.combo-item svg').remove();
      $(this).closest('.combo-box').find('.combo-item').prepend(iconTemplate);
      $(this).closest('.combo-box').find('.combo-item .selected-item').text(itemName);
    } else {
      $(this).closest('.combo-box').find('.combo-item i').remove();
      $(this).closest('.combo-box').find('.combo-item').prepend(itemSvgIcon);
      $(this).closest('.combo-box').find('.combo-item .selected-item').text(itemName);
    }

    if ($(this).hasClass('data-push')) {
      var deleteIcon = feather.icons.x.toSvg();
      template = "\n            <div class=\"added-spec\">\n                <i class=\"" + itemIconClass + "\"></i>\n                <div class=\"spec-name\">" + itemName + "</div>\n                <div class=\"remove-spec\">\n                    " + deleteIcon + "\n                </div>\n            </div>\n            ";
      $.when($('#quick-specs').append(template)).then(function () {
        //Make the spec boxes expandable when the title is clicked
        $('#quick-specs .added-spec .remove-spec').on('click', function () {
          $(this).closest('.added-spec').remove();
        });
      });
    }
  });
} //Image Combo Box


function initImageComboBox() {
  $('.is-combo .image-combo-box').on('click', function () {
    $(this).toggleClass('is-active');
  });
  $('.image-combo-box .box-dropdown li').on('click', function (e) {
    var target = e.target; //Get selected item data

    var itemPic = $(this).find('.item-icon img').attr('src');
    var itemName = $(this).find('.item-name').text();

    if (!$(target).is('.box-dropdown li, body') && !$(target).parents().is('.box-dropdown')) {
      $('.box-dropdown').removeClass('is-active');
    }

    if ($(target).is('body')) {
      $('.box-dropdown').removeClass('is-active');
    } //Handle dropdown item active state toggle


    $(this).siblings('li.is-active').removeClass('is-active');
    $(this).addClass('is-active'); //Update combo box selected value

    $(this).closest('.image-combo-box').find('.combo-item img').attr('src', itemPic);
    $(this).closest('.image-combo-box').find('.combo-item .selected-item').text(itemName);
  });
} //User combo Box


function initUserComboBox() {
  $('.is-combo .user-combo-box').on('click', function () {
    $(this).toggleClass('is-active');
  });
  $('.user-combo-box .box-dropdown li').on('click', function (e) {
    var target = e.target; //Get selected item data

    var itemPic = $(this).find('.item-icon .avatar').attr('src');
    var itemBadge = $(this).find('.item-icon .badge').attr('src');
    var itemName = $(this).find('.item-name').text();

    if (!$(target).is('.box-dropdown li, body') && !$(target).parents().is('.box-dropdown')) {
      $('.box-dropdown').removeClass('is-active');
    }

    if ($(target).is('body')) {
      $('.box-dropdown').removeClass('is-active');
    } //Handle dropdown item active state toggle


    $(this).siblings('li.is-active').removeClass('is-active');
    $(this).addClass('is-active'); //Update combo box selected value

    $(this).closest('.user-combo-box').find('.combo-item .avatar').attr('src', itemPic);
    $(this).closest('.user-combo-box').find('.combo-item .badge').attr('src', itemBadge);
    $(this).closest('.user-combo-box').find('.combo-item .selected-item').text(itemName);
  });
} //Stacked Combo Box


function initStackedComboBox() {
  $('.is-combo .stacked-combo-box').on('click', function () {
    $(this).toggleClass('is-active');
  });
  $('.stacked-combo-box .box-dropdown li').on('click', function (e) {
    var target = e.target; //Get selected item data

    var itemPic = $(this).find('.item-icon img').attr('src');
    var itemName = $(this).find('.item-name').text();
    var itemRef = $(this).attr('data-skill');
    var initialText = 'Select one or more skills';
    var skillTemplate = "\n            <img id=\"" + itemRef + "\" class=\"is-stacked\" src=\"" + itemPic + "\">\n        ";

    if (!$(target).is('.box-dropdown li, body') && !$(target).parents().is('.box-dropdown')) {
      $('.box-dropdown').removeClass('is-active');
    }

    if ($(target).is('body')) {
      $('.box-dropdown').removeClass('is-active');
    } //Handle dropdown item active state toggle


    $(this).toggleClass('is-active');
    console.log(skillTemplate);

    if ($('.stacked-combo-box li.is-active').length == 0) {
      $('#' + itemRef).remove();
      $('#skill-placeholder').removeClass('is-hidden');
      $(this).closest('.stacked-combo-box').find('.selected-item').text(initialText);
    } else {
      $('#skill-placeholder').addClass('is-hidden');
      $(this).closest('.stacked-combo-box').find('.selected-item').text('');

      if ($('#' + itemRef).length) {
        $('#' + itemRef).remove();
      } else {
        $(this).closest('.stacked-combo-box').find('.combo-item').prepend(skillTemplate);
      }
    }
  });
} //Big Combo Box


function initBigComboBox() {
  $('.big-combo-box').on('click', function () {
    $(this).toggleClass('is-active');
  });
  $('.big-combo-box .box-dropdown li').on('click', function (e) {
    var target = e.target; //Get selected item data

    var itemIcon = $(this).find('.item-icon i').attr('class');
    var itemName = $(this).find('.item-name span:first-child').text();
    var itemDesc = $(this).find('.item-name span:nth-child(2)').text();

    if (!$(target).is('.box-dropdown li, body') && !$(target).parents().is('.box-dropdown')) {
      $('.box-dropdown').removeClass('is-active');
    }

    if ($(target).is('body')) {
      $('.box-dropdown').removeClass('is-active');
    } //Handle dropdown item active state toggle


    $(this).siblings('li.is-active').removeClass('is-active');
    $(this).addClass('is-active'); //Update combo box selected value

    $(this).closest('.big-combo-box').find('.combo-item i').attr('class', itemIcon);
    $(this).closest('.big-combo-box').find('.combo-item .selected-item').text(itemName);
    $(this).closest('.big-combo-box').find('.combo-item .selected-desc').text(itemDesc);
  });
} //Accordion


function initAccordion() {
  var $accor = $('.accordion');
  $accor.each(function () {
    $(this).toggleClass('ui-accordion ui-widget ui-helper-reset');
    $(this).find('h3').addClass('ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all');
    $(this).find('div').addClass('ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom');
    $(this).find("div").hide();
  });
  var $trigger = $accor.find('h3');
  $trigger.on('click', function (e) {
    var location = $(this).parent();

    if ($(this).next().is(':hidden')) {
      var $triggerloc = $('h3', location);
      $triggerloc.removeClass('ui-accordion-header-active ui-state-active ui-corner-top').next().slideUp(300);
      $triggerloc.find('span').removeClass('ui-accordion-icon-active');
      $(this).find('span').addClass('ui-accordion-icon-active');
      $(this).addClass('ui-accordion-header-active ui-state-active ui-corner-top').next().slideDown(300);
    }

    e.preventDefault();
  });
  $(".toggle-container").hide();
  $('.trigger, .trigger.opened').on('click', function (a) {
    $(this).toggleClass('active');
    a.preventDefault();
  });
  $(".trigger").on('click', function () {
    $(this).next(".toggle-container").slideToggle(300);
  });
  $(".trigger.opened").addClass("active").next(".toggle-container").show();
} //Animated Modals


function initAnimatedModals() {
  if ($('.modal-trigger').length) {
    //main variable
    var modalID; //Triggering a modal

    $('.modal-trigger').on("click", function () {
      modalID = $(this).attr('data-modal');
      $('#' + modalID).toggleClass('is-active');
      $('#' + modalID + ' .modal-background').toggleClass('scaleInCircle');
      $('#' + modalID + ' .modal-content').toggleClass('scaleIn');
      $('#' + modalID + ' .modal-close').toggleClass('is-hidden'); //Prevent body from scrolling when scrolling inside modal

      setTimeout(function () {
        $('body').addClass('is-fixed');
      }, 700);
    }); //Closing a modal

    $('.modal-close, .modal-dismiss').on("click", function () {
      $('#' + modalID + ' .modal-background').toggleClass('scaleInCircle');
      $('#' + modalID + ' .modal-content').toggleClass('scaleIn');
      $('#' + modalID + ' .modal-close').toggleClass('is-hidden'); //Restore native body scroll

      $('body').removeClass('is-fixed');
      setTimeout(function () {
        $('.modal.is-active').removeClass('is-active');
      }, 500);
    });
  }
} //Regular Modals


function initHModals() {
  var modalID;

  if ($('.h-modal-trigger').length) {
    $('.h-modal-trigger').on('click', function () {
      modalID = $(this).attr('data-modal');
      $('#' + modalID).toggleClass('is-active');
    });
    $('.h-modal-close').on('click', function () {
      $(this).closest('.modal').removeClass('is-active');
    });
  }
} //Right Panels


function initPanels() {
  var panelId;

  if ($('.right-panel-trigger').length) {
    $('.right-panel-trigger').on('click', function () {
      panelId = $(this).attr('data-panel');
      $('#' + panelId).addClass('is-active');

      if (panelId == 'search-panel') {
        $('.right-panel .search-input').focus();
      }
    });
    $('.panel-overlay, .right-panel .close-panel').on('click', function () {
      $(this).closest('.right-panel-wrapper').removeClass('is-active');
    });
  }
} //Scroll to top


function scrollToTop() {
  document.body.scrollTop = document.documentElement.scrollTop = 0;
} //Small Text Tip


function initSmallTextTip() {
  $('.has-small-text-tip').on('mouseenter', function () {
    var elementWidth = $(this).find('.text-tip-text').width();

    if (elementWidth >= 250) {
      var elementText = $(this).find('.text-tip-text').text();
      var tooltipTemplate = "\n                <div class=\"text-tooltip scaleInTooltip\">\n                    <div class=\"tooltip-content\">\n                        Some tooltip content\n                    </div>\n                </div>\n            ";
      $.when($(this).append(tooltipTemplate)).then(function () {
        $(this).find('.text-tooltip .tooltip-content').html(elementText);
      });
    }
  });
  $('.has-small-text-tip').on('mouseleave', function () {
    $(this).find('.text-tooltip').remove();
  });
} //Text Tip


function initTextTip() {
  $('.has-text-tip').on('mouseenter', function () {
    var elementWidth = $(this).find('.text-tip-text').width();

    if (elementWidth >= 380) {
      var elementText = $(this).find('.text-tip-text').text();
      var tooltipTemplate = "\n                <div class=\"text-tooltip scaleInTooltip\">\n                    <div class=\"tooltip-content\">\n                        Some tooltip content\n                    </div>\n                </div>\n            ";
      $.when($(this).append(tooltipTemplate)).then(function () {
        $(this).find('.text-tooltip .tooltip-content').html(elementText);
      });
    }
  });
  $('.has-text-tip').on('mouseleave', function () {
    $(this).find('.text-tooltip').remove();
  });
} //Medium Text Tip


function initMediumTextTip() {
  $('.has-medium-text-tip').on('mouseenter', function () {
    var elementWidth = $(this).find('.text-tip-text').width();

    if (elementWidth >= 345) {
      var elementText = $(this).find('.text-tip-text').text();
      var tooltipTemplate = "\n                <div class=\"text-tooltip scaleInTooltip\">\n                    <div class=\"tooltip-content\">\n                        Some tooltip content\n                    </div>\n                </div>\n            ";
      $.when($(this).append(tooltipTemplate)).then(function () {
        $(this).find('.text-tooltip .tooltip-content').html(elementText);
      });
    }
  });
  $('.has-medium-text-tip').on('mouseleave', function () {
    $(this).find('.text-tooltip').remove();
  });
} //Toast


function launchToast(title, message, position, timeout) {
  iziToast.show({
    class: 'h-toast',
    icon: icon,
    title: title,
    message: message,
    titleColor: '#fff',
    messageColor: '#fff',
    iconColor: "#fff",
    backgroundColor: '#5d4394',
    progressBarColor: '#444F60',
    position: position,
    transitionIn: 'fadeInUp',
    close: false,
    timeout: timeout,
    zindex: 99999
  });
} //Get Theme


function setThemeToLocalStorage(value) {
  window.localStorage.setItem('theme', value);

  if (value === 'dark') {
    $('body').addClass('is-dark');
  } else {
    $('body').removeClass('is-dark');
  }
} //Dark Mode


function initDarkMode() {
  var theme = window.localStorage.getItem('theme');

  if (!$('.landing-page-wrapper').length) {
    if (theme != null && theme != undefined) {
      setThemeToLocalStorage(theme);

      if (theme === 'dark') {
        $('.dark-mode input').prop('checked', false);
      }
    }
  }

  $('.dark-mode input').on('change', function () {
    if ($(this).prop('checked') === true) {
      $('html, body').removeClass('is-dark');
      $('.theme-image').each(function () {
        var imageUrl = $(this).attr('data-light');
        $(this).attr('src', imageUrl);
      });
      setThemeToLocalStorage('light');
    } else {
      $('html, body').addClass('is-dark');
      $('.theme-image').each(function () {
        var imageUrl = $(this).attr('data-dark');
        $(this).attr('src', imageUrl);
      });
      setThemeToLocalStorage('dark');
    }
  });
} //Animated chackboxes


function initAnimatedCheckboxes() {
  $('.animated-checkbox input').each(function () {
    var $this = $(this);

    if ($(this).closest('.animated-checkbox').hasClass('is-checked')) {
      $(this).closest('.animated-checkbox').addClass('is-checked');
      $this.closest('.animated-checkbox').find('.shadow-circle').addClass('is-opaque');
      setTimeout(function () {
        $this.closest('.animated-checkbox').removeClass('is-unchecked');
      }, 150);
    } else {
      $(this).closest('.animated-checkbox').addClass('is-unchecked').removeClass('is-checked');
      setTimeout(function () {
        $this.closest('.animated-checkbox').find('.shadow-circle').removeClass('is-opaque');
      }, 150);
    }
  });
  $('.animated-checkbox input').on('change', function () {
    var $this = $(this);

    if ($(this).closest('.animated-checkbox').hasClass('is-checked')) {
      $(this).closest('.animated-checkbox').addClass('is-unchecked').removeClass('is-checked');
      setTimeout(function () {
        $this.closest('.animated-checkbox').find('.shadow-circle').removeClass('is-opaque');
      }, 150);
    } else {
      $(this).closest('.animated-checkbox').addClass('is-checked');
      $this.closest('.animated-checkbox').find('.shadow-circle').addClass('is-opaque');
      setTimeout(function () {
        $this.closest('.animated-checkbox').removeClass('is-unchecked');
      }, 150);
    }
  });
} //Init single textfilter


function initTextFilter() {
  if ($('.textFilter-input').length) {
    (function () {
      var defaultText = $('.textFilter-input').val();
      $('.textFilter-input').focus(function (e) {
        if ($(this).val() === defaultText) $(this).val('');
      }).blur(function (e) {
        if ($(this).val() === '') $(this).val(defaultText);
      }).keyup(function (e) {
        var patterns = $(this).val().toLowerCase().split(' ');
        if (!patterns.length) return;
        $('.textFilter-target').hide().filter(function () {
          var matchText = $(this).find('.textFilter-match').text().toLowerCase();

          for (var i = 0; i < patterns.length; i++) {
            if (matchText.indexOf(patterns[i]) === -1) return false;
          }

          return true;
        }).show();
      });
    })();
  }
} //Init reusable search filter used in layout views


function initCustomTextFilter() {
  if ($('.custom-text-filter').length) {
    $('.custom-text-filter').each(function () {
      var filterTarget = $(this).attr('data-filter-target');
      var defaultText = $(this).val();
      $(this).focus(function (e) {
        if ($(this).val() === defaultText) $(this).val('');
      }).blur(function (e) {
        if ($(this).val() === '') $(this).val(defaultText);
      }).keyup(function (e) {
        var patterns = $(this).val().toLowerCase().split(' ');
        if (!patterns.length) return;
        $(filterTarget).hide().filter(function () {
          var matchText = $(this).find('*[data-filter-match]').text().toLowerCase();

          for (var i = 0; i < patterns.length; i++) {
            if (matchText.indexOf(patterns[i]) === -1) return false;
          }

          return true;
        }).show();
        var items = $(filterTarget + ':visible').length;

        if (items === 0) {
          $('*[data-filter-hide]').addClass('is-hidden');
          $('.custom-text-filter-placeholder').removeClass('is-hidden');
        } else {
          $('.custom-text-filter-placeholder').addClass('is-hidden');
          $('*[data-filter-hide]').removeClass('is-hidden');
        }
      });
    });
  }
} //Custom Plyr Players


//Flex Table


function initAdvancedFlexTable() {
  if ($('#advanced-flex-table').length) {
    $('.flex-table .flex-table-header .is-checkbox input').on('change', function () {
      if ($(this).prop('checked') === false) {
        $('.flex-table .flex-table-item .is-checkbox input').prop('checked', false);
      } else {
        $('.flex-table .flex-table-item .is-checkbox input').prop('checked', true);
      }
    });
  }
} //Accordion


function initSingleAccordion() {
  $('.single-accordion .accordion-header').on('click', function () {
    if ($(this).closest('.single-accordion').hasClass('is-exclusive')) {
      if ($(this).hasClass('is-active')) {
        $(this).removeClass('is-active').next('.accordion-content').slideUp();
      } else {
        $(this).closest('.single-accordion').find('.accordion-header').removeClass('is-active');
        $(this).closest('.single-accordion').find('.accordion-content').slideUp();
        $(this).toggleClass('is-active').next('.accordion-content').slideToggle();
      }
    } else {
      $(this).toggleClass('is-active').next('.accordion-content').slideToggle();
    }
  });
} //Collapse


function initCollapse() {
  $('.collapse .collapse-header').on('click', function () {
    $(this).closest('.collapse').toggleClass('is-active').find('.collapse-content').slideToggle('fast');
  });
} //Go back in history


function goBack() {
  window.history.go(-1);
} //Back to top


function initBackToTop() {
  var pxShow = 600;
  var scrollSpeed = 500;
  $(window).on('scroll', function () {
    if ($(window).scrollTop() >= pxShow) {
      $("#backtotop").addClass('visible');
    } else {
      $("#backtotop").removeClass('visible');
    }
  });
  $('#backtotop a').on('click', function () {
    $('html, body').animate({
      scrollTop: 0
    }, scrollSpeed);
    return false;
  });
} //Fake json search demo


function initSearch() {
  $('#webapp-navbar-search-empty').on('click', function () {
    $('.search-input').val('');
    $('.search-results').removeClass('is-active');
  });
  $('.search-input').each(function () {
    $(this).on('keyup', function () {
      var $container = $(this).closest('.control');
      var searchQuery = $(this).val();

      if (searchQuery.length > 0) {
        $('#webapp-navbar-search-empty').removeClass('is-hidden');
      } else {
        $('#webapp-navbar-search-empty').addClass('is-hidden');
      }

      var expression = new RegExp(searchQuery, "i");
      $.getJSON('assets/data/search.json', function (data) {
        $container.find('.search-results .search-result, .search-results .placeholder-wrap').remove();
        $.each(data, function (key, value) {
          if (value.name.search(expression) != -1 || value.position.search(expression) != -1) {
            if (value.pic != null) {
              var template = "\n                                    <a class=\"search-result\">\n                                        <div class=\"h-avatar is-small\">\n                                            <img class=\"" + (value.type === 'user' ? 'avatar' : 'article') + "\" src=\"" + value.pic + "\" alt=\"\">\n                                        </div>\n                                        <div class=\"meta\">\n                                            <span>" + value.name + "</span>\n                                            <span>" + value.position + "</span>\n                                        </div>\n                                    </a>\n                                ";
              $container.find('.search-results').append(template);
            } else {
              var classes = new Array('is-danger', 'is-info', 'is-primary', 'is-success', 'is-warning', 'is-h-purple', 'is-h-blue', 'is-h-green', 'is-h-orange', 'is-h-red', 'is-h-green');
              var length = classes.length;
              var randomClass = classes[Math.floor(Math.random() * length)];
              var template = "\n                                    <a class=\"search-result\">\n                                        <div class=\"h-avatar is-small\">\n                                            <span class=\"avatar is-fake " + randomClass + "\">\n                                                <span>" + value.initials + "</span>\n                                            </span>\n                                        </div>\n                                        <div class=\"meta\">\n                                            <span>" + value.name + "</span>\n                                            <span>" + value.position + "</span>\n                                        </div>\n                                    </a>\n                                ";
              $container.find('.search-results').append(template);
            }
          }
        });

        if ($('.search-result').length === 0) {
          var placeholder = "\n                            <div class=\"placeholder-wrap\">\n                                <div class=\"placeholder-content has-text-centered\">\n                                    <img class=\"light-image\" src=\"assets/img/illustrations/placeholders/search-4.svg\" alt=\"\" />\n                                    <img class=\"dark-image\" src=\"assets/img/illustrations/placeholders/search-4-dark.svg\" alt=\"\" />\n                                    <h3 class=\"dark-inverted\">No Matching Results</h3>\n                                    <p>Sorry, we couldn't find any matching records. Please try different search terms.</p>\n                                </div>\n                            </div>\n                        ";
          $container.find('.search-results').append(placeholder);
        }
      });

      if (searchQuery === '') {
        $container.find('.search-results').removeClass('is-active');
      } else {
        $container.find('.search-results').addClass('is-active');
      }
    });
  });
} //Customize Datatable


function customizeDatatable() {
  $('.datatable-filter-cell').find('.input').wrap("<div class='control has-icon'></div>");
  var searchIcon = "\n        <div class=\"form-icon\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"feather feather-search\"><circle cx=\"11\" cy=\"11\" r=\"8\"></circle><line x1=\"21\" y1=\"21\" x2=\"16.65\" y2=\"16.65\"></line></svg>\n        </div>\n    ";
  $('.datatable-filter-cell').find('.control.has-icon').append(searchIcon);
  $('.datatable-filter-cell').find('select').wrap("<div class='field'><div class='control has-icons-left'><div class='select'></div></div></div>");
  var selectIcon = "\n        <div class=\"icon is-small is-left\">\n            <i class=\"lnil lnil-menu-circle\"></i>\n        </div>\n    ";
  $('.datatable-filter-cell').find('.control.has-icons-left').append(selectIcon);
  $('.datatable-filter-cell').find('select option:first-child').html('Filter by');
  $('.is-datatable tbody td .checkbox input').on('change', function () {
    $(this).closest('tr').toggleClass('is-selected');

    if ($('.is-datatable td .checkbox input:checked').length > 0) {
      $('.field.has-addons').removeClass('is-disabled');
    } else {
      $('.field.has-addons').addClass('is-disabled');
    }
  });
  $('.is-datatable th .checkbox input').on('change', function () {
    if ($(this).prop('checked') === true) {
      $('.is-datatable td .checkbox input').prop('checked', true).trigger('change');
      $('.field.has-addons').removeClass('is-disabled');
    } else {
      $('.is-datatable td .checkbox input').prop('checked', false).trigger('change');
      $('.field.has-addons').addClass('is-disabled');
    }
  });
  $('.pagination li').click(function () {
    $('.pagination li.is-selected').removeClass('is-selected');
    $(this).addClass('is-selected');
  });
} //Tabbed Widget


function initTabbedWidgets() {
  $('.tabbed-widget .tabbed-control').on('click', function () {
    var container = $(this).closest('.tabbed-widget');

    if (!$(this).hasClass('is-active')) {
      $(this).siblings('.tabbed-control').removeClass('is-active');
      $(this).addClass('is-active');
      container.find('.inner-list-wrapper').toggleClass('is-active');
    }
  });
}