// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "main"
import "moment";
import "chart";

window.moment = moment;

console.log(moment().format("YYYY-MM-DD HH:mm:ss"));
//import "chart"
import "chart_sample"
import "@hotwired/turbo-rails"
import "controllers"
