require 'spec_helper'

describe User do

  it_has_string(:first_name)
  it_has_string(:last_name)

  it { should     have_valid(:role).when( *User.valid_roles ) }
  it { should_not have_valid(:role).when( nil, '', 'anythingelse', 'drivera', 'adriver' ) }

end
