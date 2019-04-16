function checkDomain() {
  var x = document.getElementById("username");
   x  = x.split('@'); 
   x = x[1];
  if(x == "syntelinc.com")
    {
	return true;
    }
    else if(x == "atos.net")
    {
	return true;
    }
    else
    {
        alert("Not a valid syntel or atos email");
        return;
    }
}


