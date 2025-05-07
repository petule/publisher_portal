module SeriesServices
  class Creator
    prepend SimpleCommand

    attr_reader :create_params
    def initialize(create_params)
      @create_params = create_params
    end

    def call
      series = Series.new(create_params)
      unless series.save
        copy_errors(series, :series)
      end
      series
    rescue StandardError => e
      errors.add(:base, e.message)
    end

    private

    def copy_errors(model, key)
      model.errors.full_messages.each { |msg| errors.add(key, msg) }
    end
  end
end
