/**
 * Examples from https://deanhume.com/home/blogpost/lazy-loading-images-using-intersection-observer/10163
 * GitHub repo: https://github.com/deanhume/lazy-observer-load
 *
 * @author Dean Hume
 * @copyright Dean Hume
 */
(function () {
  var config = {
    // If the image gets within 50px in the Y axis, start the download.
    rootMargin: '50px 0px',
    threshold: 0.01
  };

  /**
   * Lazy load all images
   */
  function lazyloadImages() {
    var images = document.querySelectorAll('.tb-lazy-image');
    [].slice.call(images).forEach(function (image) {
      if (image.className.indexOf('tb-lazy-image--handled') > -1) {
        return;
      }

      if (!('IntersectionObserver' in window)) {
        preloadImage(image);
      } else {
        observer.observe(image);
      }
    });
  }

  /**
   * Fetchs the image for the given URL
   * @param {string} src
   * @param {string} srcset
   * @param {object} callback
   */
  function fetchImage(src, srcset, callback) {
    var image = new Image();
    image.src = src;
    if (srcset) {
      image.srcset = srcset;
    }
    image.onload = callback.resolve;
    image.onerror = callback.reject;
  }

  /**
   * Preloads the image
   * @param {object} image
   */
  function preloadImage(image) {
    var src = image.getAttribute('data-src');
    var srcset = image.getAttribute('data-srcset');
    if (!src) {
      return;
    }

    return fetchImage(src, srcset, {
      resolve: function () {
        applyImage(image, src, srcset);
      },
      reject: null
    });
  }

  /**
   * Apply the image
   * @param {object} img
   * @param {string} src
   * @param {string} srcset
   */
  function applyImage(img, src, srcset) {
    // Prevent this from being lazy loaded a second time.
    img.className += ' tb-lazy-image--handled';
    img.src = src;
    if (srcset) {
      img.srcset = srcset;
    }
    img.className += ' tb-lazy-fade-in';
    img.removeAttribute('data-src');
    img.removeAttribute('data-srcset');
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

  var observer = new IntersectionObserver(onIntersection, config);

  lazyloadImages();
  setInterval(lazyloadImages, 500);
}());
