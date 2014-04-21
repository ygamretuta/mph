# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  sash_id                :integer
#  level                  :integer          default(0)
#  provider               :string(255)
#  uid                    :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

class User < ActiveRecord::Base
  rolify
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable,
         :omniauth_providers => [:facebook]


  has_many :items, :dependent => :destroy
  has_many :purchase_transactions, class_name:'Transaction', foreign_key: :buyer_id, :dependent => :destroy

  validates_presence_of :username
  validates :username,
            uniqueness:{case_sensitive:false},
            format: { with: /\A[a-zA-Z0-9_]+\Z/ }

  attr_accessor :login

  after_create :assign_default_role

  # override parent method to allow to searching for email or username
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', {value:login.downcase}]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_facebook_oauth(auth)
    user = User.where(provider:auth.provider, uid:auth.uid).first
    unless user
      user = User.new(username:auth.info.name.delete(' ').downcase,
        uid: auth.uid,
        provider: auth.provider,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  private

  def assign_default_role
    add_role(:muggle) if self.roles.blank?
  end
end
