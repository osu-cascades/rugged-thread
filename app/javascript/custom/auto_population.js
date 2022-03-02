function autofill() {
    var standard_repair = '<%= @standard_repair.to_json %>';
    document.getElementById('#repair_price') = standard_repair.price; 
  };