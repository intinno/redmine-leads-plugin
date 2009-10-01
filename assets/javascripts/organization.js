function appendOrgId(element, value) {
  id = $('belongs_to').innerHTML + '_org_id';
  $(id).value = value.down('.org-id').innerHTML;
}
function showNewOrg(belongsTo){
  $(belongsTo + '_org_id').disable();
  $('existing-org').hide();
  $('new-org').show();
  $$('.new-org input').each(function(elem){elem.enable();});
}
function showExistingOrg(belongsTo){
  $(belongsTo + '_org_id').enable();
  $('existing-org').show();
  $('new-org').hide();
  $$('.new-org input').each(function(elem){elem.disable();});
}
