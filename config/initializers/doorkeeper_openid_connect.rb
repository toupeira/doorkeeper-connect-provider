Doorkeeper::OpenidConnect.configure do

  if Rails.env.production?
    issuer 'https://doorkeeper-connect-provider.herokuapp.com/'
  else
    issuer 'http://localhost:3000/'
  end

  jws_private_key File.read(Rails.root.join('config/private.pem'))
  jws_public_key File.read(Rails.root.join('config/public.pem'))

  resource_owner_from_access_token do |access_token|
    # Example implementation:
    User.find_by(id: access_token.resource_owner_id)
  end

  auth_time_from_resource_owner do |resource_owner|
    resource_owner.current_sign_in_at
  end

  reauthenticate_resource_owner do |resource_owner|
    store_location_for resource_owner, request.fullpath
    sign_out resource_owner
    redirect_to new_user_session_url
  end

  subject do |resource_owner|
    # Example implementation:
    resource_owner.id
  end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  # expiration 600

  claims do
    normal_claim :email, &:email
  end
end
