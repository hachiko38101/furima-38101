function culc (){
    const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const itemPrice = document.getElementById("item-price").value;
    const addTaxPrice  = document.getElementById("add-tax-price");
    const profit  = document.getElementById("profit");

    const addTaxPriceNum = parseInt( itemPrice * 0.1 ,10 );
    const profitNum = parseInt( itemPrice * 0.9 , 10 );

    profit.innerHTML = profitNum;
    addTaxPrice.innerHTML = addTaxPriceNum;
  });
};

window.addEventListener('load', culc);