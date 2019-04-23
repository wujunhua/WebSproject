function validate()
{
    document.getElementById("emailValidation").innerHTML = "";
    document.getElementById("endDateValidation").innerHTML = "";
    //check email
    var email = document.getElementById("insEmail").value;
    email = email.toLowerCase();
    email = email.split('@'); 
    email = email[1];  
    if(!(email === "syntelinc.com" || email === "atos.net"))
    {    
       document.getElementById("emailValidation").innerHTML = "Not a valid Atos or Syntel email";
       document.getElementById("insEmail").value = "";
       return; 
    }
    
   
    
    //check date
    var startDate = document.getElementById("startDate").value;
    var endDate = document.getElementById("endDate").value;
    //checking to see if the end date is infront of the start date
    if ((Date.parse(endDate) <= Date.parse(startDate))) {
        document.getElementById("endDateValidation").innerHTML = "End date should be greater than Start date";
        document.getElementById("endDate").value = "";
        document.getElementById("startDate").value = "";
        return;
    }
        
    //checking to see if the the start and end date are atleast 5 days apart
    var diff =  Math.floor(
    (
        Date.parse(endDate.replace(/-/g,'\/')
    ) - Date.parse(startDate.replace(/-/g,'\/')
    )               
    ) / 86400000);
    Math.abs(diff);
    if(diff < 5)
    {
        document.getElementById("endDateValidation").innerHTML = "Start and End date should be atleast 5 days apart";
        document.getElementById("startDate").value="";
        document.getElementById("endDate").value="";
        return;
    }
       
        
    //check to see if end date is not in future
    var today = new Date();
    var date_from = document.getElementById("endDate").value;
    date_from = new Date(date_from);
    if(today < date_from)
    {
        document.getElementById("endDateValidation").innerHTML = "You cannot select a future date for end date.";
        document.getElementById("startDate").value="";
        document.getElementById("endDate").value="";
        return;
    }
        
    //check to see if start date is not in future
    var today = new Date();
    var date_from = document.getElementById("startDate").value;
    date_from = new Date(date_from);
    if(today <= date_from)
    {
        document.getElementById("endDateValidation").innerHTML = "You cannot select a future date or todays date for start date.";
        document.getElementById("startDate").value="";
        document.getElementById("endDate").value="";
        return;
    }
    
    document.getElementById("actualButton").click();

}




