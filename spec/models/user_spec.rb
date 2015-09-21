require 'rails_helper'

#RSpec.describe User, type: :model do
describe User do
  let(:user) {User.new }
  subject { user }

  it { expect(user).to respond_to(:name) }
  it { expect(user).to respond_to(:email) }
  it { expect(user).to respond_to(:password) }
end
