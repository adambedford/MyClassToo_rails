class Authentication < ActiveRecord::Base
  belongs_to :user

  attr_accessible :provider, :token, :uid

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end
end
