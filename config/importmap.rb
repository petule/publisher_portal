# Pin npm packages by running ./bin/importmap

pin "application"
pin "main", to: "custom/main.js"
#pin "moment", to: "custom/moment-with-locales.min.js"
pin "moment", to: "https://cdn.jsdelivr.net/npm/moment@2.29.4/dist/moment.js"

pin "chart", to: "custom/chart.js"
pin "chart_sample", to: "custom/chart.sample.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
