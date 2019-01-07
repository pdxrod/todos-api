require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  # create test user
  let(:token) { create(:token, token: SecureRandom.uuid.gsub( '-', '' ) ) }
  let!(:user) { create(:user, token_id: token.id) }
   # set headers for Token
  let(:headers) { { 'auth_token' => token_generator(user.id) } }
  let(:invalid_headers) { { 'auth_token' => nil } }

  describe "#authorize_request" do
    context "when auth token is passed" do
      before { allow(request).to receive(:headers).and_return(headers) }

      # private method authorize_request returns current user
      it "sets the current user" do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context "when auth token is not passed" do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it "raises MissingToken error" do
        expect { subject.instance_eval { authorize_request } }.
          to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end
