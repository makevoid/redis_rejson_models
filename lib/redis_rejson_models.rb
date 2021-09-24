require_relative "env"

module RedisRejsonModels
  # low level API
  class RJ
    def self.configure(redis:)
      @@redis = redis
    end

    def self.redis
      @@redis
    end

    def self.[](key)
      # redis.json_get key
      redis.json_get key, Rejson::Path.root_path
    end

    def self.[]=(key, val)
      # redis.json_set key, val
      redis.json_set key, Rejson::Path.root_path, val
    end
  end

  module RedisRejsonModelLib
    INFLECTOR = Dry::Inflector.new

    def all
      1.upto(count).map do |entry_id|
        get entry_id
      end
    end

    def count
      (RJ["#{resource}:count"] || 0).to_i
    end

    def get(id)
      data = RJ["#{resource}:#{id}"]
      return unless data
      new data
    end

    def get_attr(id, attr)
      key = "#{resource}:#{id}"
      data = RJ.redis.json_get key, ".name"
      return NilValue.new unless data
      data
    end

    def create(attrs)
      id = incr
      attrs.merge! id: id
      obj = new attrs
      RJ["#{resource}:#{id}"] = obj.attributes
      obj
    end

    def update(id, attrs)
      resource = get id
      resource.update attrs
    end

    def resource
      INFLECTOR.pluralize model_name
    end

    private

    # TODO: use incr
    def incr
      RJ["#{resource}:count"] = count + 1
    end

    def model_name
      name.downcase
    end
  end

  module RedisRejsonModelMixin
    def update(attrs_new)
      raise "Can't update a resource without an `id`" unless id
      klass = self.class
      model = klass.get id
      attrs = model.attributes
      attrs.merge! attrs_new
      obj = klass.new attrs
      RJ["#{self.class.resource}:#{id}"] = obj.attributes
      obj
    end

    def save
      klass = self.class
      attrs = attributes
      id = attrs[:id]
      unless id
        entry_id = klass.send :incr
        attrs.merge! "id" => entry_id
        id = entry_id
      end

      RJ["#{self.class.resource}:#{id}"] = attrs
      self.id = id
      self
    end
  end
end
