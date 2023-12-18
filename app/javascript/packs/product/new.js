document.addEventListener("DOMContentLoaded", function () {
  const checkboxes = document.querySelectorAll(
    'input[type="checkbox"][name="product[tag_ids][]"]'
  );

  checkboxes.forEach(function (checkbox) {
    checkbox.addEventListener("change", function () {
      if (this.checked) {
        const currentTagId = this.value;

        checkboxes.forEach(function (otherCheckbox) {
          if (otherCheckbox.value !== currentTagId) {
            otherCheckbox.checked = false;
          }
        });
      }
    });
  });
});
