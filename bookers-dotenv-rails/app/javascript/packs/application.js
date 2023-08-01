// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// require("@rails/ujs").start() // This is redundant
// require("turbolinks").start() // This is redundant
// require("@rails/activestorage").start() // This is redundant
// require("channels") // This is redundant

// You seem to use Webpack, so don't use sprockets //= require
// Instead you might need to install and import jQuery and jQuery UJS
// npm install jquery @rails/jquery-ujs
// import $ from 'jquery'
// global.$ = jQuery
// import "@rails/jquery-ujs"