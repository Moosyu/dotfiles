function playSound(url) {
    const audio = new Audio(url);
    audio.play();
}
function search() {
    search_term = document.getElementById('search_box').value;
    window.location.href = "https://www.google.com/search?q=" + encodeURI(search_term);
                
    return false;
}

window.addEventListener("load", () => {
    clock();
    function clock() {
        var today = new Date();
        var hours = today.getHours();
        var minutes = today.getMinutes();
        if (minutes < 10) {
            var minute = "0" + minutes;
        }
        else {
            var minute = minutes
        }
        var time = hours + ":" + minute;
    
      document.getElementById("time").innerHTML = time;
      setTimeout(clock, 60000);
    }
  });
  