# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  privacy    :string           not null
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string           not null
#

class Goal < ActiveRecord::Base

  validates :user_id, :privacy, :content, presence: true
  validate :valid_privacy_setting, :valid_status

  belongs_to :user

  def valid_privacy_setting
    unless ['private', 'public'].include?(self.privacy)
      errors.add(:privacy, "Must be public or private")
    end
  end

  def valid_status
    unless ['complete', 'incomplete'].include?(self.status)
      errors.add(:status, "Must be complete or incomplete")
    end
  end
end
