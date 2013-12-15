module SimpleActivity
  class Rule

    # Get a set of rules for specific target, action, and type.
    # The type is normally "cache". It can also be other things once
    # needed in external libs.
    #
    # @param target [String] model class name as string. e.g. "Article"
    #
    # @param type [String] the rule type, default as "cache". or
    #   other types defined by third parties
    #
    # @return set of rule when matched. Returns nil when unmatching
    def self.get_rules_set(target, type='_cache')
      all_rules.try(:[], target).try(:[], type)
    end

    private

    def self.all_rules
      @@_all_rules ||= load_rules
    end

    # @return rules or blank array
    def self.load_rules
      File.open("#{Rails.root}/app/models/activity/rules.yml") do |rules|
        YAML.load rules || []
      end
    end
  end
end
