document.addEventListener("DOMContentLoaded", () => {
    const LoginForm = document.querySelector("#LoginForm");
    const SignUpForm = document.querySelector("#SignupForm");
    const AdminLoginForm = document.querySelector("#AdminLoginForm");

    /*SWITCHING BETWEEN USER LOGIN SIGNUP FORMS*/
    document.querySelector('#linkSignup').addEventListener('click', e => {
        e.preventDefault();
        LoginForm.classList.add('form--hidden');
        SignUpForm.classList.remove('form--hidden');
    })
    
    document.querySelector("#linkLogin").addEventListener("click", e => {
        e.preventDefault();
        LoginForm.classList.remove("form--hidden");
        SignUpForm.classList.add("form--hidden");
    });

    /*sWITCHING BETWEEN ADMIN USER LOGIN FORMS*/
    document.querySelector('#user-to-admin-switch_btn').addEventListener('click', e=> {
        e.preventDefault();
        LoginForm.classList.add('form--hidden');
        AdminLoginForm.classList.remove('form--hidden')
    })

    document.querySelector('#admin-to-user-switch_btn').addEventListener('click', e => {
        e.preventDefault();
        LoginForm.classList.remove('form--hidden');
        AdminLoginForm.classList.add('form--hidden');
    })
});


