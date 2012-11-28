module Project
  class List
    attr_reader :id

    def initialize(id = nil)
      @id = id || generate_id
    end

    def items
      Project.redis.smembers(key)
    end

    def add_item(name)
      Project.redis.sadd(key, name)
    end

    def remove_item(name)
      Project.redis.srem(key, name)
    end

    def key
      "list:#{id}"
    end

    def to_s
      id.to_s
    end

    private

      def generate_id
        SecureRandom.hex(3)
      end
  end
end