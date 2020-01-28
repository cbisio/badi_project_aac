class User < ApplicationRecord
  has_many :rooms
  validates :birth_date, presence: true, :message=> I18n.t('birth_date')
  validates :gender, :inclusion => {:in => ['Male', 'Female', 'Other'], :message=> I18n.t('gender')}
  validates :name, length: { minimum: 3, maximum: 80, too_long: I18n.t('name.long', maxchar: 80), too_short: I18n.t('name.short', minchar: 3) }
  validates :about, length: { minimum: 5, maximum: 200, too_long: I18n.t('about.long', maxchar: 80), too_short: I18n.t('about.short', minchar: 5)}
end
