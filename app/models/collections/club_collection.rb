module Collections
  class ClubCollection < Collection

    module ViewScope
      def items
        if params[:view] == "own"
          super.where("vinks.user_id = ?", @user.id).uniq
        elsif params[:view] == "all"
          super
        elsif params[:view] == "latest"
          super.order("vinks.created_at DESC")
        else
          super
        end
      end
    end

    module CountryScope
      def items
        if params[:country].present?
          super.where(country_id: params[:country])
        else
          super
        end
      end
    end

    module LeagueScope
      def items
        if params[:league].present?
          super.where(league_id: params[:league])
        else
          super
        end
      end
    end

    module LetterScope
      def items
        if params[:letter].present?
          super.starts_with(params[:letter])
        else
          super
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
      extend ViewScope, CountryScope, LeagueScope, LetterScope, Ordering
    end

    def items
      Club.includes(:vinks).includes(:country)
    end

    def paginated
      extend Pagination
      self
    end
  end
end
