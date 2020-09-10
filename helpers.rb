require 'capybara/dsl'
require 'waitutil'
require 'pry'

class PageHelpers
  include Capybara::DSL

  def visit_page(page)
    puts "Visit #{page}"
    visit page
  end

  def wait_button(xpath_part= nil)
    puts 'Wait_download_document'
    WaitUtil.wait_for_condition(
      'Wait_download_document',
      timeout_sec: 30,
      delay_sec: 5
    ) { find(:xpath, "//input[contains(@value, 'Конвертировать') and #{xpath_part}(contains(@disabled, 'disabled'))]") }
  end

  def phone_block_click
    find(:css, 'span.item-phone-button-sub-text').click
    sleep 3
  end

  def save_screen
    page.save_screenshot 'screenshot.png'
  end

  def write_phone_txt_file
    puts 'Write phone number to file phone.txt'
    regular_exp = '\d{3}.\d{3}-\d{2}-\d{2}'
    File.open('phone.txt', 'a+') do |f|
      f.puts "8 #{find(:xpath, '//div[contains(@id, "MainContent_PanelOCRResult")]').text.match(/#{regular_exp}/)}"
    end
  end

  def process_img_to_txt
    visit_page('https://www.onlineocr.net/ru/')
    attach_file('files[]', File.absolute_path(Dir.glob('screenshots/*').join), make_visible: true)

    wait_button('not')
    find(:xpath, '//input[@value="Конвертировать"]').click
    wait_button
    write_phone_txt_file
    FileUtils.rm(Dir.glob('screenshots/*'))
  end

  def process_img_to_txt_tesseract
    image_path = Dir.glob('screenshots/*')
    write_phone_txt_file_tesseract(image_path)
  end

  def write_phone_txt_file_tesseract(image_path)
    puts 'Write phone number to file phone.txt'

    phone_number = RTesseract.new(image_path, config_file: 'digits quiet').to_s[0..14]
    File.open('phone.txt', 'a+') { |f| f.puts(phone_number) }
    FileUtils.rm(image_path)
  end
end
