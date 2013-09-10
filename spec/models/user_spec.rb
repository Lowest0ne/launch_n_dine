require 'spec_helper'

describe User do

  it_has_string(:first_name)
  it_has_string(:last_name)
  it_has_string(:role)

end
