module Spree
  Address.class_eval do
    Spree::PermittedAttributes.address_attributes << :county_id
    Spree::PermittedAttributes.address_attributes << :county_name

    before_validation :ensure_state_country_dependency
    before_validation :ensure_county_state_dependency

    belongs_to :county, class_name: "Spree::County"
    validate :county_validate

    def require_county?
      false
    end

    private
      def county_validate
        # Skip state validation without state
        return if state.blank?
        return if !require_county?

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

        # ensure county_name belongs to state without counties, or that it matches a predefined state name
        if county_name.present?
          if state.counties.present?
            counties = state.counties.find_all_by_name(county_name)

            if counties.size == 1
              self.county = counties.first
              self.county_name = nil
            else
              errors.add(:state, :invalid)
            end
          end
        end

        # ensure at least one county field is populated
        errors.add :county, :blank if county.blank? && county_name.blank?
      end

      # ensure associated state belongs to country
      def ensure_state_country_dependency
        unless Spree::State.where(country_id: self.country_id).exists?(id: self.state_id)
          self.state_id = nil
        end
      end

      # ensure associated county belongs to state
      def ensure_county_state_dependency
        unless Spree::County.where(state_id: self.state_id).exists?(id: self.county_id)
          self.county_id = nil
        end
      end
  end
end
