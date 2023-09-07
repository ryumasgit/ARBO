  const action = function() {
    window.location.href = '/reviews';
  }
  const time =  7*1000;
  let timer = setTimeout(action,time);
  
 function stopTimer() {
   clearTimeout(timer);
  }