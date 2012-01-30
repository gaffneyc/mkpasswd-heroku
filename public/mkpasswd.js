window.addEventListener("load", function() {
  if(window.getSelection) {
    var salt = document.getElementById("salt");

    salt.addEventListener("click", function() {
      window.getSelection().selectAllChildren(salt);
    });
  }
}, false);
