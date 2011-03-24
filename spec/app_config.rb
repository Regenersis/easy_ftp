class AppConfig
  @@app_config = YAML::load(ERB.new((IO.read(File.join(File.dirname(__FILE__), "app_config.yml")))).result)["test"]

  def self.method_missing(sym, *args, &block)
    @@app_config[sym.to_s]
  end
end
