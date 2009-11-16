class LeadMailer < Mailer

  def contact_add(contact)
    lead = contact.lead
    recipients lead_mails(lead)
    subject "[INTINNO CRM] (New Contact added) #{contact.name}"
    body :contact => contact, :lead => lead,
         :lead_url => url_for(:controller => 'leads', :action => 'show', :id => lead.id)
  end

  def contact_edit(contact)
    lead = contact.lead
    recipients lead_mails(lead)
    subject "[INTINNO CRM] (New Contact added) #{contact.name}"
    body :contact => contact, :lead => lead,
         :lead_url => url_for(:controller => 'leads', :action => 'show', :id => lead.id)
  end

  def note_add(note)
    lead = note.lead
    recipients lead_mails(lead)
    subject "[INTINNO CRM] (New Note added) in Lead to org: #{lead.org.name}"
    body :note => note, :lead => lead,
         :lead_url => url_for(:controller => 'leads', :action => 'show', :id => lead.id)
  end

  def note_edit(note)
    lead = note.lead
    recipients lead_mails(lead)
    subject "[INTINNO CRM] Note in Lead to org: #{lead.org.name} has been changed"
    body :note => note, :lead => lead,
         :lead_url => url_for(:controller => 'leads', :action => 'show', :id => lead.id)
  end

  def lead_add(lead)
    recipients lead_mails(lead)
    subject "[INTINNO CRM] New Lead added for org: #{lead.org.name}"
    body :lead => lead, :lead_url => url_for(:controller => 'leads', :action => 'show', :id => lead.id)
  end

  def lead_edit(lead)
    recipients lead_mails(lead)
    subject "[INTINNO CRM] Lead for org: #{lead.org.name} changed"
    body :lead => lead, :lead_url => url_for(:controller => 'leads', :action => 'show', :id => lead.id)
  end

  private

    def lead_mails(lead)
      (lead.watcher_recipients + [lead.author.mail] - [User.current.mail])
    end
end
