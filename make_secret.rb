# This file provides secret key generation
# The keys are stored in RAILS_ROOT/.secret_keys.json
# Ensure that this file is ignored by git
#
# Whenever a passwordy looing string is found in the rails app:
#  1) add a key/value pair to the secret key hash
#  2) reference this file and method in the file you found it in
#  3) delete the .secret_key.json file so that it will be updated
#
# Checkout config/initializers/secret_token.rb for an example
#
# I know that there are two within the devise config, so they included already

require 'securerandom'
require 'json'

def secure_token key
  token_file = Rails.root.join('.secret_keys.json')
  if File.exist?(token_file)
    # Use the existing token.
    JSON.parse(File.read(token_file), symbolize_names: true)[key]
  else
    # Generate a new token and store it in token_file.
    secret_hash = {
      core_key_base: SecureRandom.hex(64),
      devise_core:  SecureRandom.hex(64),
      devise_pepper: SecureRandom.hex(64),
    }
    File.write(token_file, secret_hash.to_json)
    secret_hash[key]
  end
end
