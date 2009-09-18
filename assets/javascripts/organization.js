function showNewOrgForm() {
  $('existing-org').addClassName("nodisplay");
  $('new-org').removeClassName("nodisplay");
}

function hideNewOrgForm() {
  $('existing-org').removeClassName("nodisplay");
  $('new-org').addClassName("nodisplay");
}
