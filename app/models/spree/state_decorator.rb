Spree::State.class_eval do
  has_many :counties, -> { order('name ASC') }, dependent: :destroy
end