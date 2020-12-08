// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ajaxError(function(event, request) {
    var msg = request.getResponseHeader('X-Message');
    if (msg) alert(msg);
});

/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function toggleCardDropdown(id) {
    document.getElementById("dropdown_"+id).classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
    if (!(event.target.matches('.user_card_black') || event.target.matches('.user_card_red'))) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        var i;
        for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
}

$(document).ready(function(){
    $('.dropdown-submenu a.test').on("click", function(e){
        $(this).next('ul').toggle();
        e.stopPropagation();
        e.preventDefault();
    });
});

function pass() {
    let valid = true;
    if (document.getElementById('signupPassword').value.length > 7) {
        document.getElementById('length').innerHTML = '&#9989;'
        document.getElementById('lengthtext').style.color = "green";

    }
    else {
        document.getElementById('length').innerHTML = '&#10060;'
        document.getElementById('lengthtext').style.color = "black";
        valid = false;
    }
    if(/[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test(document.getElementById('signupPassword').value)){
        document.getElementById('special').innerHTML = '&#9989;'
        document.getElementById('specialtext').style.color = "green";
    }
    else{
        document.getElementById('special').innerHTML = '&#10060;'
        document.getElementById('specialtext').style.color = "black";
        valid = false;
    }
    if(/\d/.test(document.getElementById('signupPassword').value)){
        document.getElementById('number').innerHTML = '&#9989;'
        document.getElementById('numbertext').style.color = "green";

    }
    else{
        document.getElementById('number').innerHTML = '&#10060;'
        document.getElementById('numbertext').style.color = "black";
        valid = false;
    }
    if(valid){
        document.getElementById('signupPassword').style.color = "green";
    }
    else{
        document.getElementById('signupPassword').style.color = "red";
    }
}

function check_pass() {
    if (document.getElementById('signupPassword').value ==
        document.getElementById('signuppasswordConfirmation').value) {
        document.getElementById('match').innerHTML = '&#9989;'
        document.getElementById('matchtext').style.color = "green";
        document.getElementById('signuppasswordConfirmation').style.color = "green";
        check_blank();
    } else {
        document.getElementById('signuppasswordConfirmation').style.color = "red";
        document.getElementById('match').innerHTML = '&#10060;'
        document.getElementById('matchtext').style.color = "black";
    }
}

function check_blank() {
    if (document.getElementById('signupPassword').value.length == 0 ||
        document.getElementById('signuppasswordConfirmation').value.length == 0 ||
        document.getElementById('signupUser').value.length == 0 ||
        document.getElementById('signupEmail').value.length == 0) {
        document.getElementById('signupCreate').disabled = true;
    } else {
        document.getElementById('signupCreate').disabled = false;
    }
}

function check_email() {
    /* Regex pulled from https://www.w3resource.com/javascript/form/email-validation.php */
    if (document.getElementById('signupEmail').value.length == 0) {
        document.getElementById('signupCreate').disabled = true;
        document.getElementById('valid_email').innerHTML = '&#10060;'
        document.getElementById('valid_email_text').style.color = "red";
    }
    else if (/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(document.getElementById('signupEmail').value)) {
        document.getElementById('signupCreate').disabled = false;
        document.getElementById('valid_email').innerHTML = '&#9989;'
        document.getElementById('valid_email_text').style.color = "green";
        check_blank();
    } else {
        document.getElementById('signupCreate').disabled = true;
        document.getElementById('valid_email').innerHTML = '&#10060;'
        document.getElementById('valid_email_text').style.color = "red";
    }
}

function check_username() {
    if (document.getElementById('signupUser').value.length == 0) {
        document.getElementById('signupCreate').disabled = true;
    }
    else {
        check_blank();
    }
}

