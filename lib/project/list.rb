module Project
  class List
    attr_reader :id

    def initialize(id = nil)
      @id = id || generate_id
    end

    def items
      Project.redis.hgetall(key)
    end

    def add_item(value)
      field = generate_id
      Project.redis.hset(key, field, value)
      { id: field, name: value }
    end

    def remove_item(field)
      Project.redis.hdel(key, field)
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