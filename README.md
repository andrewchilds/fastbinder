# Fastbinder

Fast and worry-free dynamic event binding.

Add and remove DOM elements dynamically without any additional event binding/unbinding steps. The only bound elements are `window` and `document.body`. Requires jQuery.

Currently the following attributes are supported:

- `data-on-click`
- `data-on-hover`
- `data-on-keyup`
- `data-on-change`
- `data-on-submit`
- `data-on-scroll`

## Install

```js
bower install fastbinder
```

```js
npm install fastbinder
```

## Usage

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

## Examples

```html
<!-- Change Handler -->
<input type="text" data-on-change="MyLibrary.myChangeHandler" />

<!-- Click Handler -->
<a href="#" data-on-click="MyLibrary.myClickHandler">Execute myFunction on click</a>

<!-- Scroll Handler -->
<div data-on-hover="MyLibrary.myHoverHandler"></a>

<!-- Scroll Handler -->
<div data-on-scroll="MyLibrary.myScrollHandler"></a>

<!-- Form submit handler -->
<form data-on-submit="MyLibrary.mySubmitHandler">
  <input type="text" />
  <input type="submit" />
</form>
```

## Running the Test Suite

First, install bower and npm dependencies:

```sh
npm install
bower install
```

```sh
npm test
```
