'use strict'

require 'ndx-server'
.config
  database: 'db'
  tables: ['users']
  localStorage: './data'
  anonymousUser: true
.start()
