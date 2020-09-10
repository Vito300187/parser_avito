require './spec_helper'
require_relative 'helpers.rb'

describe 'Parse avito phone' do
  page = PageHelpers.new
  page.visit_page(ENV['AVITO_PAGE'])
  page.phone_block_click
  page.save_screen
  ENV['TESSERACT'] ? page.process_img_to_txt_tesseract : page.process_img_to_txt
end
