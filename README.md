This parser for avito site, which can recognize phone number.
For running script with TESSERACT required TESSERACT `brew install tesseract`  


Run script:  
`TESSERACT=true` - for run script with tesseract. You can disable it and run with capybara.   
`AVITO_PAGE='url page'` - required is url.  
`ruby main.rb` - main command for run script.  

Command for example - `TESSERACT=true AVITO_PAGE='full url' ruby main.rb`
