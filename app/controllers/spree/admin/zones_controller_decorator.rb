module Spree
  module Admin
    ZonesController.class_eval do
      protected
        def load_data
          @countries = Country.order(:name)
          @states = State.order(:name)
          @counties = County.order(:name)
          @zones = Zone.order(:name)
        end
    end
  end
end
