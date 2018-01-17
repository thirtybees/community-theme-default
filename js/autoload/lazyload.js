/**
 * Examples from https://deanhume.com/home/blogpost/lazy-loading-images-using-intersection-observer/10163
 * GitHub repo: https://github.com/deanhume/lazy-observer-load
 *
 * @author Dean Hume
 * @copyright Dean Hume
 */
(function () {
  /**
   * Fetchs the image for the given URL
   * @param {string} url
   * @param {object} callback
   */
  function fetchImage(url, callback) {
    const image = new Image();
    image.src = url;
    image.onload = callback.resolve;
    image.onerror = callback.reject;
  }

  /**
   * Preloads the image
   * @param {object} image
   */
  function preloadImage(image) {
    const src = image.getAttribute('data-src');
    if (!src) {
      return;
    }

    return fetchImage(src, {
      resolve: function () {
        applyImage(image, src);
      },
      reject: null
    });
  }

  /**
   * Load all of the images immediately
   * @param {NodeListOf<Element>} images
   */
  function loadImagesImmediately(images) {
    // foreach() is not supported in IE
    [].slice.call(images).forEach(function (image) {
      preloadImage(image);
    });
  }

  /**
   * Apply the image
   * @param {object} img
   * @param {string} src
   */
  function applyImage(img, src) {
    // Prevent this from being lazy loaded a second time.
    img.className += (' tb-lazy-image--handled');
    img.src = src;
    img.className += ' lazy-fade-in';
  }


  function onIntersection(entries) {
    // Loop through the entries
    entries.forEach(function (entry) {
      // Are we in viewport?
      if (entry.intersectionRatio > 0) {
        // Stop watching and load the image
        observer.unobserve(entry.target);
        preloadImage(entry.target);
      }
    });
  }

  var images = document.querySelectorAll('.tb-lazy-image');
  var config = {
    // If the image gets within 50px in the Y axis, start the download.
    rootMargin: '50px 0px',
    threshold: 0.01
  };

  var imageCount = images.length;
  var observer;
  if (!('IntersectionObserver' in window)) {
    [].slice.call(images).forEach(function (image) {
      preloadImage(image);
    });
  } else {
    // It is supported, load the images
    observer = new IntersectionObserver(onIntersection, config);
    [].slice.call(images).forEach(function (image) {
      if (image.className.indexOf('tb-lazy-image--handled') > -1) {
        return;
      }

      observer.observe(image);
    });
  }
}());
