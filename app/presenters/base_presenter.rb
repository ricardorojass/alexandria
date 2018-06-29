class BasePresenter
  # Metaprogramming
  CLASS_ATTRIBUTES = {
    build_with: :build_attributes,
    related_to: :relations,
    sort_by: :sort_attributes,
    filter_by: :filter_attributes
  }

  CLASS_ATTRIBUTES.each { |k, v| instance_variable_set("@#{v}", []) }
  # The above line do the next lines
  # @relations = []
  # @sort_attributes = []
  # @filter_attributes = []
  # @build_attributes = []

  # Open the door to class methods
  class << self
    # Define an accessor for the class level instance # variable we created above
    attr_accessor *CLASS_ATTRIBUTES.values

    # Create the actual class method that will
    # be used in the subclasses
    # We use the splash operation '*' to get all # the arguments passed in an array
    CLASS_ATTRIBUTES.each do |k, v|
      define_method k do |*args|
        instance_variable_set("@#{v}", args.map(&:to_s))
      end
    end

  end


  attr_accessor :object, :params, :data

  def initialize(object, params, options = {})
    @object = object
    @params = params
    @options = options
    @data = HashWithIndifferentAccess.new
  end

  def as_json(*)
    @data
  end

end