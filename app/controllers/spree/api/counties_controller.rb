module Spree
  module Api
    class CountiesController < Spree::Api::BaseController
      skip_before_filter :set_expiry
      skip_before_filter :check_for_user_or_api_key
      skip_before_filter :authenticate_user

      def index
        @counties = scope.ransack(params[:q]).result.
                    includes(:state).order('name ASC')

        if params[:page] || params[:per_page]
          @counties = @counties.page(params[:page]).per(params[:per_page])
        end

        county = @counties.last
        if stale?(county)
          respond_with(@counties)
        end
      end

      def show
        @county = scope.find(params[:id])
        respond_with(@county)
      end

      private
        def scope
          if params[:state_id]
            @state = Spree::State.accessible_by(current_ability, :read).find(params[:state_id])
            return @state.counties.accessible_by(current_ability, :read)
          else
            return Spree::County.accessible_by(current_ability, :read)
          end
        end
    end
  end
end
