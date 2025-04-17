CONFIG = YAML.safe_load(File.read(Rails.root.join("config/config.yml")), permitted_classes: [Symbol], aliases: true)[Rails.env].freeze
