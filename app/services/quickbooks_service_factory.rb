class QuickbooksServiceFactory

  def self.instance(env)
    if env.test?
      QuickbooksMockService.new
    elsif env.development?
      QuickbooksService.new
    elsif env.production?
      QuickbooksService.new
    end
  end

end
