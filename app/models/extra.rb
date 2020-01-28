class Extra < ApplicationRecord
  has_and_belongs_to_many :rooms
  validates :name, length: { minimum: 3, maximum: 160, too_long: I18n.t('name.long', maxchar: 160), too_short: I18n.t('name.short', minchar: 3)}
end
