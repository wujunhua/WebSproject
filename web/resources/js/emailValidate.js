function checkDomain() {
  var x = document.getElementById("username");
   x = x.toLowerCase();
   x = x.split('@'); 
   x = x[1];
  if(x === "syntelinc.com")
    {
        alert("You are syntel");
        return true;
    }
    else if(x === "atos.net")
    {
        alert("you are atos");
        return true;
    }
    else
    {
        alert("Not a valid syntel or atos email");
        return false;
    }
    
    
}


