RSpec.shared_examples_for 'an authenticated page' do
  it 'redirects to the login page' do
    expect(response).to redirect_to new_user_session_path
  end

  it 'provides a notice to the user' do
    expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
  end
end
