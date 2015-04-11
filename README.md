# Fastbinder

![Build Status](https://travis-ci.org/andrewchilds/fastbinder.png?branch=master)

Fast, simple, leak-free event binding for your views.

Add and remove thousands of DOM elements dynamically without worrying about any additional event binding/unbinding. The only bound elements are `window` and `document.body`.

The following attributes are supported:

- `data-on-blur`
- `data-on-click`
- `data-on-change`
- `data-on-focus`
- `data-on-hover`
- `data-on-keydown`
- `data-on-keyup`
- `data-on-mousedown`
- `data-on-mouseup`
- `data-on-scroll`
- `data-on-submit`

### Install

```sh
bower install fastbinder
```

```sh
npm install fastbinder
```

### Usage

```js
// Initialize
jQuery.fastbinder();

// Initialize with options
jQuery.fastbinder({ hoverDelay: 250 });

// Set options later on:
jQuery.fastbinder.setOptions({ forceExternalLinks: false });

// Tear down:
jQuery.fastbinder.destroy();

// Example handler function:
MyLibrary.myKeyupHandler = function (e) {
  // The jQuery event object is passed in:
  window.console.log(e, e.which);

  // `this` is bound to the DOMElement:
  var val = $(this).val();
  window.console.log(val);
};
```

```html
<!-- Change Handler -->
<input type="text" data-on-change="MyLibrary.myChangeHandler" />

<!-- Click Handler -->
<a href="#" data-on-click="MyLibrary.myClickHandler">Execute myFunction on click</a>

<!-- Hover Handler -->
<div data-on-hover="MyLibrary.myHoverHandler"></a>

<!-- Scroll Handler -->
<div data-on-scroll="MyLibrary.myScrollHandler"></a>

<!-- Form submit handler -->
<form data-on-submit="MyLibrary.mySubmitHandler">
  <input type="text" data-on-keyup="MyLibrary.myKeyupHandler" />
  <input type="submit" />
</form>
```

```js

```

### Setting a Controller Scope

By using the `data-controller` attribute on either a parent element or the element itself, you can namespace a template block to a particular controller. For example, changing this input would execute the `MyLibrary.myController.change` function:

```html
<div data-controller="MyLibrary.myController">
  <input type="text" data-on-change="change" />
</div>
```

You can also define an implied controller prefix:

```js
$.fastbinder({
  controllerPrefix: 'App.Controller.',
});
```

```html
<div data-controller="Things">
  <button data-on-click="clickHandler">Will execute App.Controller.Things.clickHandler</button>
</div>
```

Controller scopes can be nested, or overridden using a fully-qualified function name:

```html
<div data-controller="Cars">
  <button data-on-click="clickHandler">Will execute Cars.clickHandler</button>
  <div data-controller="Boats">
    <button data-on-click="clickHandler">Will execute Boats.clickHandler</button>
    <button data-on-click="Planes.clickHandler">Will execute Planes.clickHandler</button>
  </div>
</div>
```

### Adding and Extending Bindings

For example, to add support for touch events:

```js
jQuery.fastbinder.on({ name: 'touchstart', attribute: 'on-touchstart' });
jQuery.fastbinder.on({ name: 'touchend', attribute: 'on-touchend' });
```

Or to support both mouse and touch events with a single attribute:

```js
jQuery.fastbinder.on({ name: 'mousedown touchstart', attribute: 'on-mousedown' });
jQuery.fastbinder.on({ name: 'mouseup touchend', attribute: 'on-mouseup' });
```

### Running the Tests

First, install bower and npm dependencies:

```sh
npm install
bower install
```

```sh
npm test
```
