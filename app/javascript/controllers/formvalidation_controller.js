import { Controller } from "stimulus";

export default class extends Controller {
    submitForm(event) {

        let errors = document.querySelectorAll('.error:not([style="display:none;"]')
        if(errors.length){
            event.preventDefault()
        }
    }

}