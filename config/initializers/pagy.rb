require 'pagy/extras/bootstrap'
require 'pagy/extras/i18n'
require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = 15
Pagy::DEFAULT[:overflow] = :last_page