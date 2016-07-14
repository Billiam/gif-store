export default {
  init() {
    this.bind()
  },
  bind() {
    $(document).on('click', 'a[data-submit=parent]', function (event) {
      var $target = $(this)

      if ($target.length > 0) {
        var message = $target.data('confirm');
        if (message === null || confirm(message)) {
          $target.parent().submit();
        }
        event.preventDefault();
        return false;
      }
    });
  }
}
