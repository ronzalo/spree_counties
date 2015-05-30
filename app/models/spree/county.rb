class Spree::County < ActiveRecord::Base
  belongs_to :state
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
