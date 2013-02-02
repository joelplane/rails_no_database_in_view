module RailsNoDatabaseInView
  class DatabaseAccessFromViewError < StandardError

    def initialize error
      @error = error
    end

    def message
      "A database call was made from the view.\n" \
      "The database had been temporarily disable while rendering the view so we could catch situations like this.\n" \
      "\nOriginal error:\n" \
      "#{@error.message} (#{@error.class})"
    end

  end
end
