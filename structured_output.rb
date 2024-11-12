require_relative 'shared/colorize'
require 'openai'
OpenAI.configure { |config| config.access_token = ENV.fetch('OPENAI_API_KEY') }

html = "<div class=\"ui-pdp-container__row ui-pdp-component-list pr-16 pl-16\"><div class=\"ui-pdp-container__col col-2 ui-vip-core-container--short-description ui-vip-core-container--column__right\"><div class=\"ui-pdp-container__row ui-pdp-container__row--header\" id=\"header\"><div class=\"ui-pdp-header\"><div class=\"ui-pdp-header__subtitle\"><span class=\"ui-pdp-subtitle\">2016 | 72.000 km \u00B7 Publicado hace 19 d\u00EDas<\/span><\/div><div class=\"ui-pdp-header__title-container\"><h1 class=\"ui-pdp-title\">Mini Cooper Clubman Cooper S Clubman<\/h1><form class=\"ui-pdp-bookmark ui-pdp-bookmark__link-bookmark\" method=\"post\" action=\"\/p\/MLU645836833\/bookmark\/remove\/MLU645836833\"><input type=\"hidden\" name=\"_csrf\" value=\"\"><button class=\"ui-pdp-bookmark__link-bookmark\" role=\"switch\" type=\"submit\" aria-checked=\"true\"><svg class=\"ui-pdp-icon ui-pdp-icon--bookmark ui-pdp-bookmark__icon-bookmark\" xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"22\" height=\"20\" viewBox=\"0 0 22 20\"><g fill-rule=\"evenodd\"><use href=\"#bookmark\"><\/use><\/g><\/svg><svg class=\"ui-pdp-icon ui-pdp-icon--bookmark ui-pdp-bookmark__icon-bookmark-fill ui-pdp-bookmark__icon-bookmark-fill--active\" xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"22\" height=\"20\" viewBox=\"0 0 22 20\"><g fill-rule=\"evenodd\"><use href=\"#bookmark\"><\/use><\/g><\/svg><small class=\"ui-pdp-bookmark__label\"><span class=\"andes-visually-hidden\">Quitar de favoritos<\/span><\/small><\/button><\/form><\/div><div class=\"ui-pdp-seller-validated\"><p class=\"ui-pdp-color--GRAY ui-pdp-size--XSMALL ui-pdp-family--REGULAR ui-pdp-seller-validated__title\">Concesionaria con <a data-testid=\"action\" target=\"_self\" href=\"#seller_profile\">identidad verificada<\/a><svg class=\"ui-pdp-icon ui-pdp-seller-validated__icon\" xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"14\" height=\"14\" viewBox=\"0 0 14 14\"><use href=\"#verified_small\"><\/use><\/svg><\/p><\/div><\/div><\/div><div class=\"ui-pdp-container__row ui-pdp-container__row--price\" id=\"price\"><div class=\"ui-pdp-price mt-16 ui-pdp-price--size-large\"><div class=\"ui-pdp-price__main-container\"><div class=\"ui-pdp-price__second-line\"><span data-testid=\"price-part\"><span class=\"andes-money-amount ui-pdp-price__part andes-money-amount--cents-superscript andes-money-amount--compact\" style=\"font-size:36px\" itemprop=\"offers\" itemscope=\"\" itemtype=\"http:\/\/schema.org\/Offer\" role=\"img\" aria-label=\"31990 d\u00F3lares\" aria-roledescription=\"Precio\"><meta itemprop=\"price\" content=\"31990\"><span class=\"andes-money-amount__currency-symbol\" itemprop=\"priceCurrency\" aria-hidden=\"true\">US$<\/span><span class=\"andes-money-amount__fraction\" aria-hidden=\"true\">31.990<\/span><\/span><\/span><\/div><\/div><\/div><\/div><div class=\"ui-pdp-container__row ui-pdp-container__row--sales-terms-short-description\" id=\"sales_terms_short_description\"><\/div><div class=\"ui-pdp-container__row ui-pdp-container__row--grouped-main-actions\" id=\"grouped_main_actions\"><div class=\"ui-pdp-container-actions\"><form class=\"ui-pdp-actions\" method=\"get\"><input type=\"hidden\" name=\"_csrf\" value=\"IyNS50Gx-d3YDxw7B1un8lM04c6R1UXMW5vY\"><div class=\"ui-pdp-actions__container\"><div class=\"ui-pdp-action-container-request-modal\"><button type=\"secondary\" class=\"andes-button ui-vip-modal-request-button andes-button--large andes-button--quiet\" id=\":R2llcum9im:\"><span class=\"andes-button__content\">Preguntar<\/span><\/button><\/div><button type=\"secondary\" class=\"andes-button ui-vip-action-contact-info andes-button--large andes-button--quiet\" id=\":R2plcum9im:\"><span class=\"andes-button__content\"><svg class=\"ui-pdp-icon ui-pdp-icon--whatsapp ui-pdp-color--BLUE\" xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"16\" height=\"16\" viewBox=\"0 0 16 16\"><use href=\"#whatsapp\"><\/use><\/svg>WhatsApp<\/span><\/button><input type=\"hidden\" name=\"quantity\" value=\"1\"><\/div><\/form><div class=\"ui-pdp-recaptcha-v3\"><\/div><\/div><\/div><div class=\"ui-pdp-container__row ui-pdp-container__row--report-problem\" id=\"report_problem\"><div class=\"ui-pdp-report-problem__property-link\"><span class=\"ui-pdp-color--GRAY ui-pdp-size--XSMALL ui-pdp-family--REGULAR\">\u00BFTuviste un problema con la publicaci\u00F3n? <a href=\"https:\/\/www.mercadolibre.com.uy\/noindex\/denounce?item_id=MLU645836833&amp;element_type=ITM\" target=\"_blank\" class=\"ui-pdp-media__action\">Av\u00EDsanos.<\/a><\/span><\/div><\/div><div class=\"ui-pdp-container__row ui-pdp-container__row--grouped-share-bookmark\" id=\"grouped_share_bookmark\"><div class=\"ui-vpp-grouped-share-bookmark-wishlist desktop\" id=\"gift-registry\"><button type=\"button\" class=\"ui-pdp-add-to-list__link\"><span><span class=\"ui-pdp-add-to-list__link--label\">Agregar a una lista<\/span><\/span><span class=\"ui-pdp-add-to-list__link--chevron\"><svg aria-hidden=\"true\" width=\"20\" height=\"20\" viewBox=\"0 0 20 20\" fill=\"#3483FA\"><path d=\"M8.27686 4.34644L7.42834 5.19496L12.224 9.99059L7.42334 14.7912L8.27187 15.6397L13.921 9.99059L8.27686 4.34644Z\" fill=\"#3483FA\"><\/path><\/svg><\/span><\/button><\/div><\/div><\/div><\/div>"

response = OpenAI::Client.new.chat(
  parameters: {
    model: 'gpt-4o',
    messages: [
      { role: 'system', content: 'You are scraper expert. Extract the price, title, year and kilometers from the given HTML.' },
      { role: 'user', content: html }
    ],
    temperature: 0.1,
    response_format: {
      type: "json_schema",
      json_schema: {
        name: "scraper_response",
        strict: true,
        schema: {
          type: "object",
          properties: {
            title: { type: 'string' },
            price: { type: 'string' },
            year: { type: 'integer' },
            kilometers: { type: 'string' }
          },
          required: ['price', 'title', 'year', 'kilometers'],
          additionalProperties: false
        }
      }
    }
  }
)
puts 'Structured output results:'.light_blue
puts response.dig('choices', 0, 'message', 'content')
