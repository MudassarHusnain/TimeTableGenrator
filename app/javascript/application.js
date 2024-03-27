// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as jquery from "jquery"
import "semantic-ui"
//= require jquery
//= require popper
//= require bootstrap

$(document).on('turbo:load', function() {
    console.log('loaded turbo links')
    $('.ui.selection.dropdown').dropdown({
        onChange: function(value, text, $selectedItem) {
            $('#role_input').val(value); // Update the value of the hidden input field
        }
    });
});

