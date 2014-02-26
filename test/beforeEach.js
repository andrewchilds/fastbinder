var fixture = function (html) {
  $('#fixture').remove();
  $('<div id="fixture"></div>').html(html).appendTo('body');
};

var MyLib = {
  onClick: function () { },
  onScroll: function () { },
  onSubmit: function () { },
  onHover: function () { },
  onChange: function () { },
  onKeyup: function () { }
};

beforeEach(function () {
  $.fastbinder($.fastbinder.defaults);
});
