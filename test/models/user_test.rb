require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "example1", email:"example1@email.com",
              password: "password1", password_confirmation: "password1")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'a' * 55
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 300 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept all valid emails" do
    valid_addresses = %w[email1@email.com email@hotmail.com a1@gmail.com anything@random.com]
    valid_addresses.each do | address |
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end

  end
  test "email validation should reject invalid emails" do
    invalid_addresses = %w[email@email,com fasdlf@email sdkf.com sadlkfj@sdf+sdf.com]
    invalid_addresses.each do | address |
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "emails should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emails should be saved in lower-case" do
    mixed_case = "example@EmAiL.CoM"
    @user.email = mixed_case
    @user.save
    assert_equal @user.reload.email, mixed_case.downcase
  end

  test "passwords should be nonempty" do
    empty_password = " " * 6
    @user.password = @user.password_confirmation = empty_password
    assert_not @user.valid?
  end

  test "password should be of minimum length" do
    short_password = "a" * 5
    @user.password = @user.password_confirmation = short_password
    assert_not @user.valid?
  end








end
