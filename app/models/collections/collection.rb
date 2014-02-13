module Collections
  class Collection
    module Authorisation
      def items
        super.accessible_by(ability)
      end
    end

    module Ordering
      def items
        if has_custom_ordering?
          super.except(:order).order(ordering_sql)
        else
          super
        end
      end

      private

      def has_custom_ordering?
        order_key.present?
      end

      def ordering_sql
        if order_key.index(",")
          keys = order_key.split(",")
          "#{keys[0]} #{order_dir}, #{keys[1]} #{order_dir}"
        else
          "#{order_key} #{order_dir}"
        end
      end

      def order_key
        params[:order_key]
      end

      def order_dir
        params[:order_dir] =~ /\Adesc\Z/i ? 'desc' : 'asc'
      end
    end

    module Pagination
      def items
        super.page(params[:page])
      end
    end

    module Search
      def query
        @query
      end

      def items
        @query = super.search(params[:q])
        if params[:search].blank?
          @query.result
        else
          super.search_for(params[:search])
        end
      end
    end

  end
end