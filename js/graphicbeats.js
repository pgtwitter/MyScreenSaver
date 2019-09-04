const aFIFO= [];
setInterval(function(){
    if (isLoading) return;
    if (aFIFO.length < 20) {
        const obj= {which: parseInt(random(97, 97+26))};
        aFIFO.push(obj);
        if (random()<0.1) for(let i= 0;i < random(3); i++) aFIFO.push(obj);
    }
    const obj= aFIFO.shift();
    if (!obj) return;
    window.dispatchEvent(new KeyboardEvent('keydown', obj));
    window.dispatchEvent(new KeyboardEvent('keypress', obj));
    window.dispatchEvent(new KeyboardEvent('keyup', obj));

    masterVolume(0);
}, 500);
