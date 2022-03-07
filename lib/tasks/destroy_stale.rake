namespace :transactions do
  desc "Deleting transactions older than an hour (cron job)"
  task destroy_stale: :environment do
    Transaction.where('updated_at < ?', Time.current - 1.hour).find_in_batches(batch_size: 100) do |transactions|
      transactions.each { |transaction| transaction.destroy }
    end
  end
end
