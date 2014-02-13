module Collections
  class ClubCollection < Collection

    module CountryScope
      def items
        if params[:view] == "own"
          super.where("vinks.user_id = ?", @user.id).uniq
        elsif params[:view] == "all"
          super
        elsif params[:view] == "latest"
          super
        else
          if params[:country].blank?
            country = Country.where(country: "England").first
            super.where(country_id: country)
          else
            super.where(country_id: params[:country])
          end
        end
      end
    end

    module Ordering
      def items
        if params[:view] == "own" or params[:view] == "latest"
          super.order("vinks.vink_date DESC")
        else
          super.order("name")
        end
      end
    end

    attr_reader :ability, :params

    def initialize(ability, params, user)
      @ability = ability
      @params  = params
      @user = user
      extend Authorisation, CountryScope, Ordering
    end

    def items
      Club.includes(:vinks).includes(:country).page(params[:page])
    end

    def paginated
      extend Pagination
      self
    end
  end
end