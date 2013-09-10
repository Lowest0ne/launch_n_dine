def it_has_string( symbol )
  it { should     have_valid( symbol ).when('anything') }
  it { should_not have_valid( symbol ).when( nil, '' ) }
end
