/**
 *
 * # Fastbinder
 *
 * Fast and worry-free dynamic event binding.
 *
 * https://github.com/andrewchilds/fastbinder
 *
 * ## Supported Attributes
 *
 * - data-on-click
 * - data-on-hover
 * - data-on-keyup
 * - data-on-change
 * - data-on-submit
 * - data-on-scroll
 *
 * ## Usage
 *
 * jQuery.fastbinder();
 * jQuery.fastbinder({ hoverDelay: 250 });
 * jQuery.fastbinder.setOptions({ forceExternalLinks: false });
 * jQuery.fastbinder.destroy();
 *
 * ## Attribute Examples
 *
 * <input type="text" data-on-change="MyLibrary.myFunction" />
 * <a href="#" data-on-click="MyLibrary.myFunction">Execute myFunction on click</a>
 *
 */
(function ($) {

  // Utils

  // Faster than jQuery.data
  function data(el, name, val) {
    return attr(el, 'data-' + name, val);
  }

  function attr(el, name, val) {
    if (el && el.jquery) {
      el = el[0];
    }
    if (el && el.getAttribute) {
      if (typeof val !== 'undefined') {
        el.setAttribute(name, val);
      } else {
        var elAttr = el.getAttribute(name);
        return isNaN(elAttr) ? elAttr : parseFloat(elAttr);
      }
    }
  }

  function strToFunction(functionName, context) {
    context = context || window;
    var namespaces = functionName.split('.');
    var func = namespaces.pop();
    for (var i = 0; i < namespaces.length; i++) {
      if (!context[namespaces[i]]) {
        return false;
      }
      context = context[namespaces[i]];
    }
    return context[func];
  }

  function keyPressed(e, key) {
    var keys = {
      'LEFT_CLICK': 1,
      'MIDDLE_CLICK': 2,
      'RIGHT_CLICK': 3,
      'TAB': 9,
      'ENTER': 13,
      'ESCAPE': 27,
      'LEFT_ARROW': 37,
      'UP_ARROW': 38,
      'RIGHT_ARROW': 39,
      'DOWN_ARROW': 40,
      'TILDE': 192
    };

    return e && e.which === keys[key];
  }

  // Handlers

  function fireEventHandler(target, eventType, e) {
    if (target) {
      var handler = data(target, eventType);
      if (handler) {
        handler = strToFunction(handler);
        if (typeof handler === 'function') {
          return handler.call(target[0], e);
        }
      }
    }
  }

  function initClickHandler() {
    $(document.body).on('click.fastbinder', function (e) {
      var target = $(e.target);
      // Handle proper links
      if (target.is('a') && target.attr('href') !== '#' &&
        !data(target, 'on-click')) {
        if ($.fastbinder.options.forceExternalLinks &&
          target.attr('href').toLowerCase().indexOf('http') === 0) {
          target.attr('target', '_blank');
        }
        return;
      }

      target = target.closest('[data-on-click]');
      return fireEventHandler(target, 'on-click', e);
    });
  }

  function initHoverHandler() {
    var timeoutID;
    $(document.body).on('mousemove.fastbinder', function (e) {
      var fn = function () {
        var target = $(e.target).closest('[data-on-hover]');
        fireEventHandler(target, 'on-hover', e);
      };
      if ($.fastbinder.options.hoverDelay > 0) {
        clearTimeout(timeoutID);
        timeoutID = setTimeout(fn, $.fastbinder.options.hoverDelay);
      } else {
        fn();
      }
    });
  }

  function initKeyupHandler() {
    var timeoutID;
    $(window).on('keyup.fastbinder', function (e) {
      var target = $(document.activeElement);
      if (target.is('input, textarea')) {
        if (keyPressed(e, 'ENTER')) {
          fireEventHandler(target, 'on-submit', e);
        } else {
          var fn = function () {
            fireEventHandler(target, 'on-keyup', e);
          };
          if ($.fastbinder.options.keyupDelay > 0) {
            clearTimeout(timeoutID);
            setTimeout(fn, $.fastbinder.options.keyupDelay);
          } else {
            fn();
          }
        }
      }
    });
  }

  function initSubmitHandler() {
    $(window).on('submit.fastbinder', function (e) {
      var target = $(e.target).closest('[data-on-submit]');
      fireEventHandler(target, 'on-submit', e);
      return false;
    });
  }

  function initChangeHandler() {
    $(window).on('change.fastbinder', function (e) {
      var target = $(e.target).closest('[data-on-change]');
      fireEventHandler(target, 'on-change', e);
    });
  }

  function initScrollHandler() {
    var timeoutID;
    $(window).on('scroll.fastbinder', function (e) {
      var fn = function () {
        var target = $(e.target).closest('[data-on-scroll]');
        fireEventHandler(target, 'on-scroll', e);
      };
      if ($.fastbinder.options.scrollDelay) {
        clearTimeout(timeoutID);
        timeoutID = setTimeout(fn, $.fastbinder.options.scrollDelay);
      } else {
        fn();
      }
    });
  }

  // Public API

  $.fastbinder = function (options) {
    $.fastbinder.setOptions(options);
    $.fastbinder.destroy();
    $.fastbinder.init();
  };

  $.fastbinder.defaults = {
    hoverDelay: 50,
    keyupDelay: 50,
    scrollDelay: 50,
    forceExternalLinks: true
  };

  $.fastbinder.setOptions = function (options) {
    $.fastbinder.options = $.extend($.fastbinder.options || $.fastbinder.defaults, options);
  };

  $.fastbinder.destroy = function () {
    $(document.body).off('.fastbinder');
    $(window).off('.fastbinder');
  };

  $.fastbinder.init = function () {
    initClickHandler();
    initHoverHandler();
    initKeyupHandler();
    initSubmitHandler();
    initChangeHandler();
    initScrollHandler();
  };

}(window.jQuery));
