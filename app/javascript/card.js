document.addEventListener("DOMContentLoaded", function() {
  let bodyElement = document.querySelector('body');
  let publicKey = gon.public_key;

  // デバッグ用ログ
  console.log("Public Key from dataset:", publicKey);

  if (!publicKey) {
    console.error("Public key が設定されていません");
    return;
  }

  const payjp = new Payjp(publicKey); // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');
  
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // デフォルトの送信動作を防ぐ

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        console.error(response.error); // エラーメッセージをコンソールに出力（必要に応じて）
      } else {
        const token = response.id;
        console.log("Generated token:", token);

        // トークンをフォームに追加
        const tokenObj = `<input type="hidden" name="token" value="${token}">`;
        form.insertAdjacentHTML("beforeend", tokenObj);

        // デバッグ用ログ：フォーム送信前にトークンが含まれているか確認
        console.log("Form data before submit:");
        new FormData(form).forEach((value, key) => {
          console.log(`${key}: ${value}`);
        });
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      document.getElementById("charge-form").submit();// フォームの送信を実行
      }
    });
    e.preventDefault();
  });
});
window.addEventListener("turbo:load", function() {
  // turbo:loadイベントが発火したときにDOMContentLoadedイベントを再発火する
  document.dispatchEvent(new Event("DOMContentLoaded"));
});