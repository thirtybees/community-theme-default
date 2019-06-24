# Mobile Responsive Community Theme <small> by</small>
![thirty bees logo](docs/img/thirty-bees-dark.png "thirty bees logo")

**Powered By**
----
<img src="docs/img/HTML5_Logo.png" width="75" height="75" alt="HTML5"><img src="docs/img/CSS3_logo_and_wordmark.svg.png" width="55" height="75" alt="CSS3"><img src="docs/img/Javascript-shield.png" width="79" height="79" alt="Javascript"><img src="docs/img/json-ld-logo.png" width="75" height="75" alt="json+ld"><img src="docs/img/wai-aaa.png" width="75" height="75" alt="Level Triple-A conformance, W3C WAI Web Content Accessibility Guidelines 2.0"><img src="docs/img/semanticweb.png" width="75" height="75" alt="W3C Semantic Web"> <img src="docs/img/jquery.png" width="75" height="75" alt="jQuery"> <img src="docs/img/smarty-logo.png" width="75" height="75" alt="Smarty Template Engine"> <img src="docs/img/bootstrap.png" width="75" height="75" alt="Twitter Bootstrap 3.0">

## Requirements
This mobile responsive community theme runs on thirty bees shopping cart. Read the main [**software requirements**](https://github.com/thirtybees/thirtybees#requirements "thirty bees shopping cart requirements") for this shopping cart.

## Building

This theme works as-is on thirty bees, all built files are committed to the repository.

CSS files shouldn't get edited directly, but their Sass counterpart in `sass/` instead. After doing so, CSS gets compiled from that. For contributions, please create commits including both, source file changes together with their build results.

### Setting up the build environment
```
npm install
```
### Building CSS from Sass
```
npm run compile-css
```
### Building JavaScript
```
npm run format-js
```

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md)
