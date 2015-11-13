// Auto-activate tooltips and popovers so they work like everything else
// Taken from:
// http://stackoverflow.com/questions/9302667/how-to-get-twitter-bootstrap-jquery-elements-tooltip-popover-etc-working/14761703#14761703
//
// Use as
// <a rel="tooltip" title="My tooltip">Link</a>
// <a data-toggle="popover" data-content="test">Link</a>
// <button data-toggle="tooltip" data-title="My tooltip">Button</button>
$(function () {
    $('body').popover({
      selector: '[data-toggle="popover"]'
                      });
    $('body').tooltip({
      selector: 'a[rel="tooltip"], [data-toggle="tooltip"]'
                      });
});
