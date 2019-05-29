function checkDomain() {
        var x = document.getElementById("username").value;
        x = x.toLowerCase();
        x = x.split('@'); 
        x = x[1];
        if(x === "syntelinc.com")
        {
            return true;
        }
        else if(x === "atos.net")
        {
            return true;
        }
        else
        {
            event.preventDefault();
        }
}

