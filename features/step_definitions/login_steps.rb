
Given /^I am not logged in$/ do
  UserSession.find.try(:destroy)
  visit root_path
end

When /^I enter an invalid user name and password$/ do
  fill_in("user_session_login", :with=>"junk")
  fill_in("user_session_password", :with=>"junk")
  click_button("SIGN IN")
end

Given /^I am the registered user (.+)$/ do |login|
  params = {
    "login"=> login,
    "zip" => '18103',
    "email" => login +"@" + login + ".com",
    "password"=>"password",
    "password_confirmation"=>"password"
  }
  @user = User.create(params)  
end

When /^I login with valid credentials$/ do
  fill_in('user_session_login', :with => @user.login)
  fill_in('user_session_password', :with => "password")
  click_button("SIGN IN")
end

Then /^I should be on ([^\"]*)$/ do |page_name|
  response.request.path.should == path_to(page_name)
end

Given /^I am on the login page$/ do
  visit '/user_sessions/new'
end

Then /^I should see "(.+)"$/ do |arg1|
  page.should have_content(arg1)
end

When /^I visit the site$/ do
  visit root_path
end
