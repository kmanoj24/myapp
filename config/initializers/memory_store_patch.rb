if Rails.cache.instance_of?(ActiveSupport::Cache::MemoryStore)
    class << Rails.cache
      def all_keys
        @data.keys.map(&:to_s)
      end
    end
  end
  