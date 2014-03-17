# Fastbinder

![Build Status](https://travis-ci.org/andrewchilds/fastbinder.png?branch=master)

Fast and worry-free dynamic event binding.

Add and remove DOM elements dynamically without any additional event binding/unbinding steps. The only bound elements are `window` and `document.body`. Requires jQuery.

Currently the following attributes are supported:

- `data-on-click`
- `data-on-hover`
- `data-on-keyup`
- `data-on-change`
- `data-on-submit`
- `data-on-scroll`

### Install

```js
bower install fastbinder
```

```js
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
```

### Examples

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
  <input type="text" />
  <input type="submit" />
</form>
```

### Controller Scope

By using the `data-controller` attribute on either a parent element or the element itself, you can namespace a template block to a particular controller. For example, changing this input would execute the `MyLibrary.myController.change` function:

```html
<div data-controller="MyLibrary.myController">
  <input type="text" data-on-change="change" />
</div>
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
