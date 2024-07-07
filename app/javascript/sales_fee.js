window.addEventListener('turbo:load', () => {
  console.log("OK");
  // 金額を入力した数値をpriceInputという変数に格納する
  const priceInput = document.getElementById("item-price");

  // priceInputがnullである場合は何もしない
  if (!priceInput) {
    return;
  }

  // priceInputがnullでないとき
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    // 入力された金額をもとに販売手数料と利益を計算する
    const tax = Math.floor(inputValue * 0.1);
    const profit = inputValue - tax;

    // 結果をHTMLに反映する
    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  });
});