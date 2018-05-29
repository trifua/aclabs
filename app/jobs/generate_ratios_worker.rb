class GenerateRatiosWorker
  @queue = :generate_ratios
  def self.perform
    puts 'Samir Listen to my calls'

    Currency.where(default: false).each do |currency|
      Ratio.create(currency_id: currency.id, ratio: rand(0..1000))
    end
  rescue StandardError => e
    puts e.message
  end
end
