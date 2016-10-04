Doorkeeper::OpenidConnect.configure do

  jws_private_key File.read(Rails.root.join('config/private.pem'))
  jws_public_key File.read(Rails.root.join('config/public.pem'))

  resource_owner_from_access_token do |access_token|
    # Example implementation:
    User.find_by(id: access_token.resource_owner_id)
  end

  if Rails.env.production?
    issuer 'https://doorkeeper-connect-provider.herokuapp.com/'
  else
    issuer 'http://localhost:3000/'
  end

  subject do |resource_owner|
    # Example implementation:
    resource_owner.id
  end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  # expiration 600

  # claims do
  #   claim :_foo_ do |resource_owner|
  #     resource_owner.foo
  #   end

  #   claim :_bar_ do |resource_owner|
  #     resource_owner.bar
  #   end
  # end
end
