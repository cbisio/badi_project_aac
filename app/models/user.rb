class User < ApplicationRecord
  has_many :rooms

  validates :birth_date, presence: true, :message=> I18n.t('birth_date')
  validates :gender, :inclusion => {:in => ['Male', 'Female', 'Other'], :message=> I18n.t('gender')}
  validates :name, length: { minimum: 3, maximum: 80, too_long: I18n.t('name.long', maxchar: 80), too_short: I18n.t('name.short', minchar: 3) }
  
end
