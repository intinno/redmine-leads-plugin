function appendOrgId(element, value) {
  if (value == null) { return }
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
function toggleOrg(){
  if($('org_state').value == ''){
    $('org-container').toggle();
    $('org_state').value = 'cancel'
    $$('.new-org input').each(function(elem){elem.disable();});
    $$('.existing-org input').each(function(elem){elem.disable();});
  }else{
    $('org-container').toggle();
    $('org_state').value=''
    $$('.new-org input').each(function(elem){elem.enable();});
    $$('.existing-org input').each(function(elem){elem.enable();});
  }
}

