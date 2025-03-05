# frozen_string_literal: true

namespace :db do
  desc 'Rebuild database'
  task :rebuild, [] => :environment do
    raise 'Not allowed to run on production' if Rails.env.production?

    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end
