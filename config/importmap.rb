# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "stimulus-rails-nested-form" # @4.1.0
pin "stimulus-lightbox" # @3.2.0
pin "lightgallery" # @2.7.2
pin "stimulus-carousel" # @5.0.1
pin "dom7" # @4.0.6
pin "ssr-window" # @4.0.2
pin "swiper/bundle", to: "swiper--bundle.js" # @8.4.7
pin "swiper" # @11.0.6
pin "cropperjs" # @1.6.1
pin "@stimulus-components/popover", to: "@stimulus-components--popover.js" # @7.0.0
