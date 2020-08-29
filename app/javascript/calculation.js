function calculation(){
  const keyup = document.getElementById("item-price");
  console.log(keyup)
  keyup.addEventListener('keyup', function(){
    const input_message = document.getElementById("item-price").value;
    if (input_message >= 300 && input_message <= 9999999){
      document.getElementById("add-tax-price").innerHTML = parseInt((input_message * 0.1), 10);
      document.getElementById("profit").innerHTML = parseInt(input_message - (input_message * 0.1), 10);
  }});
};
window.addEventListener("load", calculation);