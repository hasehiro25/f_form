# frozen_string_literal: true

shared_context "ログインしている" do |e|
  let(:user) { create :activated_user }

  before do
    post "/login", params: { user: { email: user.email, password: "hogehoge" } }
  end
end
