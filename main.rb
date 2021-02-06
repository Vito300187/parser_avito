# frozen_string_literal: true

require_relative 'spec_helper'

page = PageHelpers.new
page.visit_page(ENV['AVITO_PAGE'])
page.process_phone_recognition
