config_file = Rails.root.join('config', 'config.yml')
CONFIG = YAML.load_file(config_file)[Rails.env]