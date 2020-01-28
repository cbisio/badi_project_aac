class City < ApplicationRecord
  has_many :rooms

  validates :name, :case_sensitive => false, length: { minimum: 3, maximum: 80, too_long: I18n.t('name.long', maxchar: 80), too_short: I18n.t('name.short', minchar: 3)}
  validates_uniqueness_of :name, :message=> I18n.t('name.uniqueness')
end
