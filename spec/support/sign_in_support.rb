module SignInSupport
  def sign_in(user)
    visit root_path
    expect(page).to have_content('Login')
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on("Login")
    expect(current_path).to eq root_path
  end
end
