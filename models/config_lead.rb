class ConfigLead

  def self.setup
    [
      {name: :name, type: String, html_type: 'name',placeholder: "Name"},
      {name: :type, type: String, html_type: 'hidden',placeholder: ""},
      {name: :email, type: String, html_type: 'email',placeholder: "example@yourdomain.com"},
      {name: :comment, type: String, html_type: 'textarea',placeholder: "Your Comments"}
    ]
  end

  def self.validates
    lambda {  }
  end

end