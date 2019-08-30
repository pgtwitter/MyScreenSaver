setInterval(function() {
    splatStack.push(parseInt(Math.random() * 20) + 5);
}, 5000);
const btn = (document.getElementsByClassName('close-button'))[0];
var event = new MouseEvent('click', {
    bubbles: true,
    cancelable: true
});
btn.dispatchEvent(event);
