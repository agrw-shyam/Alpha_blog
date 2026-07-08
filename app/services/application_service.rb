class ApplicationService
  # This class method allows us to run `MyService.call` instead of `MyService.new.call`
  def self.call(*args, &block)
    new(*args, &block).call
  end
end