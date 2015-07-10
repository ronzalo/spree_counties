class Spree::County < ActiveRecord::Base
  delegate_belongs_to :state, :country
  has_many :addresses, dependent: :nullify
  validates :name, presence: true
  Spree::Ability.register_ability(CountyAbility)

  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end
