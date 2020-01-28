class Photo < ApplicationRecord
  belongs_to :room

  validates :url, length: { minimum: 5, maximum: 120, too_long: I18n.t('url.long', maxchar: 120), too_short: I18n.t('url.short', minchar: 5)}
  validates_numericality_of :order, greater_than: 0, :message=> I18n.t('order')

end
