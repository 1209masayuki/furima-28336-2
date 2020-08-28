const pay = () => {
  const PAY = process.env.PAYJP_PUBLIC_KEY
  Payjp.setPublicKey(PAY);
  
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("buyer_purchase[number]"),
      cvc: formData.get("buyer_purchase[cvc]"),
      exp_month: formData.get("buyer_purchase[exp_month]"),
      exp_year: `20${formData.get("buyer_purchase[exp_year]")}`,
    };
    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);

        document.getElementById("number").removeAttribute("name");
        document.getElementById("cvc").removeAttribute("name");
        document.getElementById("exp_month").removeAttribute("name");
        document.getElementById("exp_year").removeAttribute("name");
        
        document.getElementById("charge-form").submit();
        document.getElementById("charge-form").reset();
      } else {
      }
      form.commit.disabled = false;
    });
  });
};
window.addEventListener("load", pay);
