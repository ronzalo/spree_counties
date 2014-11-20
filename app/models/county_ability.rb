class CountyAbility
  include CanCan::Ability

  def initialize(user)
    user ||= Spree::User.new
    unless user.has_spree_role? 'admin'
      can [:index, :read], Spree::County
    end
  end
end
