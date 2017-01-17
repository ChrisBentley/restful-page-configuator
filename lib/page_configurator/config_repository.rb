module PageConfigurator
  class ConfigRepository
    def self.all
      db
    end

    def self.search(id)
      db[id]
    end

    def self.store(id, config)
      db[id] = config
    end

    def self.remove(id)
      db.delete(id)
    end

    def self.db
      @db ||= {}
    end

    def self.initialize
      @db = {}
    end
  end
end
