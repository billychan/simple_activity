module SimpleActivity
  class Rule

    # Get a set of rules for specific target, action, and type.
    # The type is normally "cache". It can also be other things once
    # needed in external libs.
    #
    # @param target [String] model class name as string. e.g. "Article"
    #
    # @param rules_set [String]  the specific set to get. Default nil
    # - get all rules.
    #
    # @return set of rule when matched. Returns nil when unmatching
    def self.get_rules(target_type, rules_set=nil)
      rules = all_rules.try(:[], target_type)
      rules_set ? rules.try(:[], rules_set) : rules
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
