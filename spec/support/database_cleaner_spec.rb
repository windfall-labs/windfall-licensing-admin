RSpec.configure do |config|
  Rails.application.eager_load!
  ## DB CLEANER
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner[:active_record, { :connection => :licensing_test }]
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner[:active_record, { :connection => :product_control_test }]
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner[:active_record, { :connection => :licensing_test }]
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner[:active_record, { :connection => :product_control_test }]
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner[:active_record, { :connection => :licensing_test }]
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner[:active_record, { :connection => :product_control_test }]
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner[:active_record, { :connection => :licensing_test }]
    DatabaseCleaner.start
    DatabaseCleaner[:active_record, { :connection => :product_control_test }]
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner[:active_record, { :connection => :licensing_test }]
    DatabaseCleaner.clean
    DatabaseCleaner[:active_record, { :connection => :product_control_test }]
    DatabaseCleaner.clean
  end
end
