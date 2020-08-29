function request() {
  const submit = document.getElementById("request-submit");
  submit.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("request-form"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/requests", true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      }
      const request = XHR.response.request;
      const request_date = XHR.response.request_date;
      const request_person = XHR.response.request_person;
      const list = document.getElementById("requested-add");
      const formText = document.getElementById("request-input");
      const HTML = `
        <ul class="requested-piece">
          <li class="requested-date">
            ${request_date} by ${request_person}
          </li>
          <li class="requested-word">
            ${request.request_word}
          </li>
        </ul>`;
      list.insertAdjacentHTML("afterend", HTML);
      formText.value = "";
    };
    e.preventDefault();
  });
 }
 window.addEventListener("load", request);