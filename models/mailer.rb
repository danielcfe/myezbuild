class Mailer
  def self.send_lead(name, email, comment, type)
      send_mail :to => ENV['EMAIL_TO'],
        :subject => "Lead from myEZbuild #{name} (#{type})",
        :html_body => report_template(name, email, comment),
        :via => :smtp,
        :via_options =>  via_options
  end

  private

  def self.report_template(name, email, comment)
    haml_template = File.read("views/emails/lead_email.haml")
    Haml::Engine.new(haml_template).render(binding, {name: name, email: email, comment: comment})
  end

  def self.send_mail hash
    Pony.mail hash
  end

  def self.via_options
    {
      :address => 'smtp.gmail.com',
      :port => '587',
      :enable_starttls_auto => true,
      :user_name => ENV['EMAIL_USER_NAME'], 
      :password => ENV['EMAIL_PASSWORD'],
      :authentication => :plain,
      :domain => ENV['EMAIL_DOMAIN']
    }
  end

end
