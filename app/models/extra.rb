class Extra < ApplicationRecord
  has_and_belongs_to_many :rooms

  validates :name,:case_sensitive => false, presence: true, length: { minimum: 2, maximum: 160, too_long: I18n.t('name.long', maxchar: 160), too_short: I18n.t('name.short', minchar: 2)}
  validates_uniqueness_of :name, :message=> I18n.t('name.uniqueness')

end
