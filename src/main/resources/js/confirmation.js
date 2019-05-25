
let currentUrlText = window.location.href;
let currentUrl = new URL(currentUrlText);

let searchBy = currentUrl.searchParams.get("col"); // name, email, classID

// emails are being filtered by class ID, only possible if a class was just created
if(searchBy === "classID") {
    displayAlertWithID("classSuccessAlert");
}

function displayAlertWithID(id) {
    
    let alert = document.getElementById(id); // grab the non-displaying alert box
    
    alert.classList.remove("d-none"); // add the alert back into the page
    alert.classList.add("show"); // Bootstrap "show" class makes the alert visible
}