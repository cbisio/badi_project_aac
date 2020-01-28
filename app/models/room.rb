class Room < ApplicationRecord
  belongs_to :user
  belongs_to :city
  has_many :photos
  has_and_belongs_to_many :extras

  validates :name, length: { minimum: 5, maximum: 80, too_long: I18n.t('name.long', maxchar: 80), too_short: I18n.t('name.short', minchar: 5)}
  validates :address, length: { minimum: 10, maximum: 200, too_long: I18n.t('address.long', maxchar: 200), too_short: I18n.t('address.short', minchar: 10)}
  validates :price, :numericality => { :greater_than => 10, :less_than => 10000, :message=> I18n.t('price')}
  validates :latitude, :numericality => { :greater_than => -90, :less_than => 90, :message=> I18n.t('latitude')}
  validates :longitude, :numericality => { :greater_than => -180, :less_than => 180, :message=> I18n.t('longitude')}
  validates :currency, :inclusion => {:in => ['€', '$'], :message=> I18n.t('currency')}

end
