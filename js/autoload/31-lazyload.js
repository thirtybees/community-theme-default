(function () {
  function initLozad() {
    if (!('lozad' in window)) {
      setTimeout(initLozad, 100);

      return;
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
     * @param {object} elem
     */
    function preloadImage(elem) {
      // If this IMG or SOURCE is part of a PICTURE, make sure to check all childNodes at once
      var image = elem;
      if (elem.parentNode.tagName === 'PICTURE') {
        image = elem.parentNode;
      }

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

    var observer = lozad('.tb-lazy-image, picture.tb-lazy-image img, picture.tb-lazy-image source', {
      load: function (el) {
        preloadImage(el);
      }
    });

    setInterval(function () {
      observer.observe();
    }, 500);
  }

  initLozad();
}());
