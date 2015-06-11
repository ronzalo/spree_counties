module Spree
  Address.class_eval do
    belongs_to :county, class_name: "Spree::County"
    Spree::PermittedAttributes.address_attributes << :county_id
    Spree::PermittedAttributes.address_attributes << :county_name
    validate :county_validate, if: :require_county?

    def require_county?
      false
    end

    def county_validate
      return if state.blank?

      # ensure associated county belongs to state
      if county.present?
        if county.state == state
          self.county_name = nil #not required as we have a valid county and state combo
        else
          if county_name.present?
            self.county = nil
          else
            errors.add(:county, :invalid)
          end
        end
      end

      # ensure at least one county field is populated
      errors.add :county, :blank if county.blank? && county_name.blank?
    end
  end
end