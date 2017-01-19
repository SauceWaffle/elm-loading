
var _saucewaffle$elm_loading$Native = function() {

    function getOffset(el) {
      el = el.getBoundingClientRect();
      return {
        left: el.left + window.scrollX,
        top: el.top + window.scrollY
      }
    }


    function objStats(obj) {
        var el = document.getElementById(obj.facts.id);

        if (el) {
          var off = getOffset(el);
          var size =
              { height : el.offsetHeight
              , width : el.offsetWidth
              };


          if (el.style.border.width != 0) {
            size.height += el.style.border.width;
            size.width += el.style.border.width;
          }


          var stats =
            { x : off.left
            , y : off.top
            , height: el.clientHeight
            , width: el.clientWidth
            };

          return stats;
        }
    }

    return {
      objStats : objStats
    }

}();
