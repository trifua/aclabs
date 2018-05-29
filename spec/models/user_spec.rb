require 'rails_helper'

RSpec.describe User, type: :model do
 it "should validate the name" do
   user=User.new
   expect(user.valid?).to be false
   expect(user.errors[:name]).to eq ["can't be blank"]
 end

  it "should validate uniqueness of the name" do
    user=User.new(name:'Adrian', password:'123')
    user.save
    expect(user.valid?).to be true
    user2=User.new(name:'Adrian',password:'321')
    user2.save
    expect(user2.valid?).to be false
    expect(user2.errors[:name]).to eq ["has already been taken"]

  end
end
