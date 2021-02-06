# frozen_string_literal: true

require_relative '../spec_helper'

class PageHelpers
  include Capybara::DSL

  attr_accessor :phone_number

  def initialize
    @phone_block_click = 'span.item-phone-button-sub-text'
    @exception_format_number = 'Recognition failed, phone number is less than 15 characters long'
    @phone_number = 0
  end

  def visit_page(page)
    puts "Visit #{page}"
    visit page
    show_phone_block
    save_screen_page
  end

  def show_phone_block
    find(:css, @phone_block_click).click; sleep 3
  end

  def save_screen_page
    page.save_screenshot('screenshot.png')
  end

  def write_phone_txt_file(phone_number)
    puts 'Write phone number to file phone.txt'

    File.open('phone.txt', 'a+') { |f| f.puts(phone_number) }
    FileUtils.rm(screenshots_folder_files)

    puts "Phone number -> #{phone_number}"; phone_number
  end

  def process_phone_recognition
    puts 'Process recognition'

    phone_number = RTesseract.new(
      screenshots_folder_files, config_file: 'digits quiet'
    ).to_s.strip[0..14]; self.phone_number = phone_number

    check_format_number
    write_phone_txt_file(phone_number)
  end

  def check_format_number
    size_phone_number = phone_number.size
    alphabet_phone_number = phone_number.match(/[A-Za-z]+/).to_s

    unless size_phone_number.eql?(15) && alphabet_phone_number.empty?
      raise(@exception_format_number)
    end
  end
end
