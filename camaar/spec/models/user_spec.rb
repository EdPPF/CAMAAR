require 'rails_helper'

RSpec.describe User, type: :model do
  it "é uma user valida" do
    user = build(:user)
    expect(user).to  be_valid
  end
  it "nao é uma user valida, pois nao tem email" do
    user = build(:user, email:nil)
    expect(user).to_not  be_valid
  end
  it "nao é uma user valida, pois nao tem matricula" do
    user = build(:user, matricula:nil)
    expect(user).to_not  be_valid
  end
  it "nao é uma user valida, pois nao tem curso" do
    user = build(:user, curso:nil)
    expect(user).to_not  be_valid
  end
  it "nao é uma user valida, pois nao tem nome" do
    user = build(:user, nome:nil)
    expect(user).to_not  be_valid
  end
  it "nao é uma user valida, pois nao tem formação" do
    user = build(:user, formacao:nil)
    expect(user).to_not  be_valid
  end
  it "nao é uma user valida, pois nao tem ocupação" do
    user = build(:user, ocupacao:nil)
    expect(user).to_not  be_valid
  end
end
