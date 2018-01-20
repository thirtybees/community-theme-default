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
    if (src) {
      image.src = src;
    }
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
    if (image.tagName === 'PICTURE') {
      // This picture contains several SOURCEs and IMGs
      [].slice.call(image.childNodes).forEach(function (childNode) {
        if (['IMG', 'SOURCE'].indexOf(childNode.tagName) < 0) {
          return;
        }

        var src = childNode.getAttribute('data-src');
        var srcset = childNode.getAttribute('data-srcset');
        if (!src && !srcset) {
          return;
        }

        applyImage(childNode, src, srcset);
      });

      image.className += ' tb-lazy-image--handled';
    } else {
      var src = image.getAttribute('data-src');
      var srcset = image.getAttribute('data-srcset');
      if (!src && !srcset) {
        return;
      }
    }

    fetchImage(src, srcset, {
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
    img.removeAttribute('data-src');
    img.removeAttribute('data-srcset');
    if (src) {
      img.setAttribute('src', src);
    }
    if (srcset) {
      img.setAttribute('srcset', srcset);
    }
    img.className += ' tb-lazy-fade-in';

    if ('picturefill' in window) {
      picturefill({
        elements: [img]
      });
    }
  }

  function onIntersection(entries) {
    // Loop through the entries
    entries.forEach(function (entry) {
      console.log(entry);
      // Are we in viewport?
      if (entry.isIntersecting) {
        // Stop watching and load the image
        observer.unobserve(entry.target);
        preloadImage(entry.target);
      }
    });
  }

  if ('IntersectionObserver' in window) {
    var observer = new IntersectionObserver(onIntersection, config);
  }

  lazyloadImages();
  setInterval(lazyloadImages, 500);
}());