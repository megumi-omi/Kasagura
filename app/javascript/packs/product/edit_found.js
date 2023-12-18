document.addEventListener("DOMContentLoaded", function () {
  const productCheckboxes = document.querySelectorAll(".single-checkbox");

  productCheckboxes.forEach(function (checkbox) {
    checkbox.addEventListener("change", function () {
      const productId = this.id.split("_")[1];
      const checkboxesForProduct = document.querySelectorAll(
        `input[name^="product[${productId}]"][name$="[tag_id][]"]`
      );

      checkboxesForProduct.forEach(function (otherCheckbox) {
        if (otherCheckbox !== checkbox) {
          otherCheckbox.checked = false;
        }
      });
    });
  });
});
