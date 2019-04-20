function validate()
{
    checkDomain();
    checkDate();
    
    function checkDomain() {
        var email = document.getElementById("insEmail").value;
        email = email.toLowerCase();
        email = email.split('@'); 
        email = email[1];
        if(email === "syntelinc.com")
        {
            return true;
        }
        else if(email === "atos.net")
        {
            return true;
        }
        else
        {
            alert("Not a valid atos or syntel email");
            event.preventDefault();
        }
    }
    
    function checkDate()
    {
        $("#endDate").change(function () {
        var startDate = document.getElementById("startDate").value;
        var endDate = document.getElementById("endDate").value;

        if ((Date.parse(endDate) <= Date.parse(startDate))) {
            alert("End date should be greater than Start date");
            document.getElementById("endDate").value = "";
        }
        });
    }
    
}


