import { Controller } from "stimulus";

export default class extends Controller {

    static targets = ["error"]

    connect() {
        this.errorTarget.style.display = 'none'
    }

    validateEmail(event) {
        let email = event.target.value
        if (!email.length){ return email }

        if(!email.endsWith(event.target.dataset.emaildomain)) {
            this.errorTarget.innerHTML = `Email must end with ${event.target.dataset.emaildomain}`
            this.errorTarget.style.display = 'block'
        }else{
            this.errorTarget.innerHTML = ''
            this.errorTarget.style.display = 'none'
        }
    }

    submitForm(event) {

        let errors = document.querySelectorAll('.error:not([style="display: none;"]')
        if(errors.length){
            event.preventDefault()
        }
    }

}