const { formSubmitButtonClick } = require("@rails/ujs");

function count (){
  const articleText  = document.getElementById("item-price");
  articleText.addEventListener("keyup", () => {

    const price = articleText.value
    const tax = price*0.1
    const beforePrice = price - tax
    const taxPrice = document.getElementById('add-tax-price');
    const profitPrice = document.getElementById('profit');
    taxPrice.innerHTML = tax;
    profitPrice.innerHTML = beforePrice;
  });
}

window.addEventListener('load', count);