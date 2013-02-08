class User < ActiveRecord::Base
  has_many :identities, dependent: :destroy
  attr_accessible :name

  validates_presence_of :name

  def self.create_with_omniauth(auth)
    user = User.new(name: auth['info']['name'])
    user.identities.build(uid: auth['uid'], provider: auth['provider'])
    user.save!
    user
  end

  def link_identity!(auth)
    Identity.find_by_uid_and_provider(auth['uid'], auth['provider']).try(:destroy)
    identities.create(uid: auth['uid'], provider: auth['provider'])
  end

  def linked_identity?(auth)
    identities.find_by_uid_and_provider(auth['uid'], auth['provider'])
  end
end
