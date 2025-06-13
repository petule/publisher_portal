# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "trix", to: "custom/trix.js"
pin "slimselect", to: "custom/slimselect.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "sortablejs", to: "custom/sortable.complete.esm.js"
#pin "chartjs", to: "custom/chart.esm.js"
#pin "chart.js", to: "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.esm.min.js", preload: true
pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.esm.js", preload: true
