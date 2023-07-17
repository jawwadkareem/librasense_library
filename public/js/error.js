document.getElementById("login-signup_btn").addEventListener('click',function(e){
    e.preventDefault();
    checkData();
});
var username  = document.getElementById('username');
var password  = document.getElementById('password');
function checkData(){
    var usernameval = username.value.trim();
    var passval = password.value.trim();
    // alert(usernameval)
    if(usernameval ==''){
        setError(username,"username can not be blank")
    }
    else{
        setSuccess(username)
    }
    if(passval ==''){
        setError(password,"password can not be blank")
    }
    else{
        setSuccess(password)
    }
}

function setError(u,msg){
    var parentBox = u.parentElement;
    parentBox.className="modal-input-group error";
    var span = parentBox.querySelector("span");
    span.innerText=msg;
}
function setSuccess(u){
    var parentBox = u.parentElement;
    parentBox.className="modal-input-group";
    var span = parentBox.querySelector("span");
    span.innerText="";
}