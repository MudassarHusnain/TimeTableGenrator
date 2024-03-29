// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as jquery from "jquery"
import "semantic-ui"
//= require jquery
//= require popper
//= require bootstrap
//= require select2_locale_"any possible language"
$(document).on('turbo:load', function() {
    console.log('loaded turbo links')
    $('.ui.selection.dropdown').dropdown({
        onChange: function(value, text, $selectedItem) {
            $('#role_input').val(value); // Update the value of the hidden input field
        }
    });
});

$(document).ready(function() {
    $('.ui.search.selection.dropdown').dropdown();
});

// JavaScript to handle department selection
$(document).on('change', '#department-dropdown select', function() {
    var departmentId = $(this).val();
    console.log('Selected department ID:', departmentId); // Check if departmentId is logged correctly
    if (departmentId) {
        $.ajax({
            url: '/teachers',
            method: 'GET',
            data: { department_id: departmentId },
            success: function(response) {
                $('#teacher-dropdown select').empty(); // Clear previous options
                $.each(response.teachers, function(index, teacher) {
                    $('#teacher-dropdown select').append($('<option>', {
                        value: teacher.id,
                        text: teacher.name.capitalize()
                    }));
                });
            },
            error: function(xhr, status, error) {
                console.error('Error fetching teachers:', error);
            }
        });
    } else {
        $('#teacher-dropdown select').empty(); // Clear teacher dropdown if no department selected
    }
});

