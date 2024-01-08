// Contact Form
// This script handle informations at submission time

$(function () {
  // Get all data in form and return object
  function getFormData(form) {
    var elements = form.elements;
    var honeypot;

    var fields = Object.keys(elements)
      .filter(function (k) {
        if (elements[k].name === "honeypot") {
          honeypot = elements[k].value;
          return false;
        }
        return true;
      })
      .map(function (k) {
        if (elements[k].name !== undefined) {
          return elements[k].name;
          // special case for Edge's html collection
        } else if (elements[k].length > 0) {
          return elements[k].item(0).name;
        }
      })
      .filter(function (item, pos, self) {
        // filter unique and non empty elements
        return self.indexOf(item) == pos && item;
      });

    var formData = {};
    fields.forEach(function (name) {
      var element = elements[name];

      // singular form elements just have one value
      formData[name] = element.value;

      // when our element has multiple items, get their values
      if (element.length) {
        var data = [];
        for (var i = 0; i < element.length; i++) {
          var item = element.item(i);
          if (item.checked || item.selected) {
            data.push(item.value);
          }
        }
        formData[name] = data.join(", ");
      }
    });

    // add form-specific values into the data
    formData.formDataNameOrder = JSON.stringify(fields);
    formData.formGoogleSheetName = form.dataset.sheet || "responses"; // default sheet name
    formData.formGoogleSendEmail = form.dataset.email || ""; // no email by default

    return { data: formData, honeypot: honeypot };
  }

  // This function handle the submit action and send the POST request
  $(document).on("submit", ".gform", function (event) {
    // Suppress normal submit (we use JQuery)
    event.preventDefault();

    // Store form and data objects
    var formData = getFormData($(this).get(0));
    var data = formData.data;

    // If a honeypot field is filled, assume it was done so by a spam bot.
    if (formData.honeypot) {
      return false;
    }

    // Url encode form data for sending as post data
    var encoded_data = Object.keys(data)
      .map(function (k) {
        return encodeURIComponent(k) + "=" + encodeURIComponent(data[k]);
      })
      .join("&");

    // POST request
    $.ajax({
      url: $(this).attr("action"),
      type: $(this).attr("method"),
      data: encoded_data,
      processData: false,
      success: function () {
        $(".gform").get(0).reset();
        // Uncomment to hide form after submit
        //var formElements = form.querySelector(".form-elements")
        //if (formElements) {
        //  formElements.style.display = "none"; // hide form
        //}
        var successMessage = $("#form_success_message");
        if (successMessage.length) {
          successMessage.removeClass("hidden");
        }
        console.log("POST: success");
      },
      error: function (XMLHttpRequest, textStatus, errorThrown) {
        var failMessage = $("#form_fail_message");
        if (failMessage.length) {
          failMessage.removeClass("hidden");
        }
        console.log("POST: error\n" + errorThrown);
      },
    });
  });

  $(document).ajaxStart(function () {
    // Show spinner
    $("#form_spinner").removeClass("hidden");
  });

  $(document).ajaxStop(function () {
    // Hide spinner
    $("#form_spinner").addClass("hidden");
  });
});
