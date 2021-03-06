function ListShowView(locator) {
  this.element = $(locator);
  var dialog = new CreateBillDialog("#dialog-bills-form");
  var self = this;
  dialog.form.on('ajax:success', function(e, bill) {
    self.element.find('.bills').append(bill.html);
    self.refreshStats(bill.total.amount_cents);
  });
  
  $( "#create-bill" ).click(function() {
    dialog.open();
  });
}

ListShowView.prototype.refreshStats = function(amount) {
  var totalAmountSpan = $('.owe-me');
  var totalAmount = totalAmountSpan[0];
  var newTotal = addBill(amount, $(totalAmount).text().slice(1));
  return $('.owe-me').text('$'+newTotal);
}
