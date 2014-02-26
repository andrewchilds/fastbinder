# Fastbinder

Fast and worry-free dynamic event binding.

Provides support for the following `data-` attributes:

- `data-on-click`
- `data-on-hover`
- `data-on-keyup`
- `data-on-change`
- `data-on-submit`
- `data-on-scroll`

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
<input type="text" data-on-change="MyLibrary.myChangeHandler" />
<a href="#" data-on-click="MyLibrary.myClickHandler">Execute myFunction on click</a>
<div data-on-scroll="MyLibrary.myScrollHandler"></a>
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
